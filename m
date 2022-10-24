Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14929609C44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJXIQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJXIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9F43313
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBzRuKDFM+71l7c7xLrT1+dLyWIbjD2WVMOLNE3ePAk=;
        b=MnHAroaTc6RrPXwsH+QgEgbPO/IJ4eawdOfFKdlWRoCGChSg7ldSANu9OvDV1a4FRfIBMb
        /4RuK75ADJukCxSS94O85pzOPrWX0aYWUUOi49Z+RrVGvSS5ZNWSqSdAtSXEJYLUzwtTfb
        CeqvxxJjhMwyfN4tQ2L61PHS0YmxfdQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-SP0uFmoMOeuzBev62VLccA-1; Mon, 24 Oct 2022 04:14:55 -0400
X-MC-Unique: SP0uFmoMOeuzBev62VLccA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94E3D1C05132;
        Mon, 24 Oct 2022 08:14:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F37140C6F75;
        Mon, 24 Oct 2022 08:14:51 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/8] mm/percpu: Update the code comment when creating new chunk
Date:   Mon, 24 Oct 2022 16:14:30 +0800
Message-Id: <20221024081435.204970-4-bhe@redhat.com>
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

The lock pcpu_alloc_mutex taking code has been moved to the beginning of
pcpu_allo() if it's non atomic allocation. So the code comment above
above pcpu_create_chunk() callsite need be updated.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a3fde4ac03a4..a8121302a79c 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1817,16 +1817,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
-	/*
-	 * No space left.  Create a new chunk.  We don't want multiple
-	 * tasks to create chunks simultaneously.  Serialize and create iff
-	 * there's still no empty chunk after grabbing the mutex.
-	 */
 	if (is_atomic) {
 		err = "atomic alloc failed, no space left";
 		goto fail;
 	}
 
+	/* No space left.  Create a new chunk. */
 	if (list_empty(&pcpu_chunk_lists[pcpu_free_slot])) {
 		chunk = pcpu_create_chunk(pcpu_gfp);
 		if (!chunk) {
-- 
2.34.1

