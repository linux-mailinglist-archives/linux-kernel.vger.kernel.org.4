Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6764D1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLNVdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLNVda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CB389DD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671053564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=FUzpeAfgvzVz/5w9XcHGMTUv81BEJmGgs/I3fDj9iOo=;
        b=hpol03xLZCt+E84I8MRrLSBhxvLk4I3aGUiWKkePJhxHlNKMiGfbzqjILW2WOkfSKLSomV
        M+KcIH2djdNopkySX9+rpa8QbK1bl7tAPhTtpIxq2ZG9baiHZTJBG2H1iHvTCoYpvddeTe
        SV1XVKlbGv64tpciH/oS7PCM0laISPY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-IoSSDzglOjKf0WznFZ0RgQ-1; Wed, 14 Dec 2022 16:32:42 -0500
X-MC-Unique: IoSSDzglOjKf0WznFZ0RgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E70C6280BCA2;
        Wed, 14 Dec 2022 21:32:41 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F8F940C2064;
        Wed, 14 Dec 2022 21:32:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Define _GNU_SOURCE for a declaration of strptime
Date:   Wed, 14 Dec 2022 22:32:39 +0100
Message-ID: <87fsdhllhk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for compatibility with future C compilers which reject
implicit function declarations by default.  Without _GNU_SOURCE (or a
similar feature test macro), <time.h> does not declare the strptime
function, and compilation can fail.

---
 Make.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Make.rules b/Make.rules
index 903a5a4..d4de1ef 100644
--- a/Make.rules
+++ b/Make.rules
@@ -14,7 +14,7 @@ else
 $(error unknown architecture $(ARCH))
 endif
 INCDIR	   = -I$(TOPDIR)include/ -I/usr/include/efi -I/usr/include/efi/$(ARCH) -I/usr/include/efi/protocol
-CPPFLAGS   = -DCONFIG_$(ARCH)
+CPPFLAGS   = -DCONFIG_$(ARCH) -D_GNU_SOURCE
 CFLAGS	   = -O2 -g $(ARCH3264) -fpic -Wall -fshort-wchar -fno-strict-aliasing -fno-merge-constants -fno-stack-protector -ffreestanding -fno-stack-check
 LDFLAGS	   = -nostdlib
 CRTOBJ		= crt0-efi-$(ARCH).o

Related to:

  <https://fedoraproject.org/wiki/Changes/PortingToModernC>
  <https://fedoraproject.org/wiki/Toolchain/PortingToModernC>

