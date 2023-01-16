Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03EB66D1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAPWvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjAPWuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A02687B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673909368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3I07n4JhggZibp9UZt6eI9Gvo7L5j67HJTyql4fmwRU=;
        b=e0Ee7Km6LsmSZZgC9UqgghOm4t3MCQcWT7Q0bE+b4nBwvR3oLLtwp/vtsTQN/wmV0j7UBc
        RRvA7WQrAMMSqxoC40PabUEPryWyIVRejyua0itXWg0kuM73l0c4grYq2ZAGiH34DONrmv
        xnZ8H+2mLtAQ12I06uoCaJP0jBJUtTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-Ac0rAA2IOH-pcSqUg0Wx_Q-1; Mon, 16 Jan 2023 17:49:24 -0500
X-MC-Unique: Ac0rAA2IOH-pcSqUg0Wx_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 796B2183B3C0;
        Mon, 16 Jan 2023 22:49:24 +0000 (UTC)
Received: from redhat.com (ovpn-116-89.gru2.redhat.com [10.97.116.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0F4A492B00;
        Mon, 16 Jan 2023 22:49:23 +0000 (UTC)
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, jforbes@redhat.com,
        dzickus@redhat.com, scweaver@redhat.com
Subject: [PATCH] tools/vm: allow users to provide additional cflags/ldflags
Date:   Mon, 16 Jan 2023 19:49:21 -0300
Message-Id: <20230116224921.4106324-1-herton@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there is no way to provide additional cflags/ldflags when
building tools/vm binaries. And using eg. make CFLAGS=<options> will
override the CFLAGS being set in the Makefile, making the build fail
since it requires the include of the ../lib dir (for libapi).

This change then allows you to specify:
CFLAGS=<options> LDFLAGS=<options> make V=1 -C tools/vm

And the options will be correctly appended as can be seen from the
make output.

Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 tools/vm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/Makefile b/tools/vm/Makefile
index 9860622cbb15..6c1da51f4177 100644
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -8,8 +8,8 @@ TARGETS=page-types slabinfo page_owner_sort
 LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
 
-CFLAGS = -Wall -Wextra -I../lib/
-LDFLAGS = $(LIBS)
+CFLAGS += -Wall -Wextra -I../lib/
+LDFLAGS += $(LIBS)
 
 all: $(TARGETS)
 
-- 
2.38.1

