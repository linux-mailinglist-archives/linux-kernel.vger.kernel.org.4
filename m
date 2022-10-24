Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5700609C45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJXIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJXIP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29B33A09
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT64JPjijrBa4KylaT1nTk9WXXduaxRTtCv2wVwy4QE=;
        b=AUMR4H9IEcg/RzzXZM8nxu/B7wkhJjeznn89DdTZJlcfQcqZS96Yd/mqfMPZrmpCBDxC4y
        ma2PO5zcvYKT/8IwWamm4M6hnPh6Tlx+NmaI+0IyfEcBlbLtYS06zwxYVYfX57NKH+TK07
        WZHORlxn96te9g6rnuYqld+OAM/nusc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-mSfA_UKmOI6tRH5XBi0jPw-1; Mon, 24 Oct 2022 04:14:48 -0400
X-MC-Unique: mSfA_UKmOI6tRH5XBi0jPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADB4B3C10144;
        Mon, 24 Oct 2022 08:14:46 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 493A840C6F9F;
        Mon, 24 Oct 2022 08:14:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/8] mm/percpu: remove unused pcpu_map_extend_chunks
Date:   Mon, 24 Oct 2022 16:14:28 +0800
Message-Id: <20221024081435.204970-2-bhe@redhat.com>
In-Reply-To: <20221024081435.204970-1-bhe@redhat.com>
References: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 40064aeca35c ("percpu: replace area map allocator with
bitmap"), it is unneeded.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 27697b2429c2..26d8cd2ca323 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -174,9 +174,6 @@ static DEFINE_MUTEX(pcpu_alloc_mutex);	/* chunk create/destroy, [de]pop, map ext
 
 struct list_head *pcpu_chunk_lists __ro_after_init; /* chunk list slots */
 
-/* chunks which need their map areas extended, protected by pcpu_lock */
-static LIST_HEAD(pcpu_map_extend_chunks);
-
 /*
  * The number of empty populated pages, protected by pcpu_lock.
  * The reserved chunk doesn't contribute to the count.
-- 
2.34.1

