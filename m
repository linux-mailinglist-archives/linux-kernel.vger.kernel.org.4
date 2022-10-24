Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425DD609C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJXIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiJXIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E85EDE0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhNjNie8t1+sw/Ww+09Nk0F1+B4cpGUlQfgZx8SKUOg=;
        b=fBbqTS4YDCDaKJjwxT6EfG/P+FLvYMvsTzpp5jGEPECZXzP7PWoo4kNrLrmJWQn7cuGtSL
        Q2tMnbvoRKcgs8UZa1SJUCv3zTfhoTwlf7Fii8udPLFOKSreK6QC7l0Z+xf0SXex+eesyW
        yxB2QWoWiQa85OmDzmk1z9TtejTzoNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298--o0yKi-_O3u9wnEwYSAFNQ-1; Mon, 24 Oct 2022 04:15:12 -0400
X-MC-Unique: -o0yKi-_O3u9wnEwYSAFNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF3285A5B6;
        Mon, 24 Oct 2022 08:15:11 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F9D40C6F9F;
        Mon, 24 Oct 2022 08:15:07 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 7/8] mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
Date:   Mon, 24 Oct 2022 16:14:34 +0800
Message-Id: <20221024081435.204970-8-bhe@redhat.com>
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
bitmap"), there's no place to use PERCPU_DYNAMIC_EARLY_SLOTS. So
clean it up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/percpu.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index f1ec5ad1351c..70bc17db00a6 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -37,11 +37,10 @@
 /*
  * Percpu allocator can serve percpu allocations before slab is
  * initialized which allows slab to depend on the percpu allocator.
- * The following two parameters decide how much resource to
- * preallocate for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or
- * larger than PERCPU_DYNAMIC_EARLY_SIZE.
+ * The following parameter decide how much resource to preallocate
+ * for this.  Keep PERCPU_DYNAMIC_RESERVE equal to or larger than
+ * PERCPU_DYNAMIC_EARLY_SIZE.
  */
-#define PERCPU_DYNAMIC_EARLY_SLOTS	128
 #define PERCPU_DYNAMIC_EARLY_SIZE	(12 << 10)
 
 /*
-- 
2.34.1

