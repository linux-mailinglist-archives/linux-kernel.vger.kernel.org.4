Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CE60C21A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJYDMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJYDL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B3264A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666667514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHhKtOeyUECAlor2iEgXFgtH6f72JWi4N4xTwfFo+LI=;
        b=BNnCITz/W0mT4Vusru7PQb9crfep0YA4YDUJ8mA7kZ/FTwBOM1Bd6QA5WFe70QkWPHiFHv
        gu7EIbnu9RbKDhHggpefKOE1U8FyxiNfwtggT4xd+fuQYvWVkm4lr5zQmTqX5UwAVTMB2K
        J8eQO5XFAK0jtBtLiXk4ofOAAoOOqMg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-ZflSR3d1M_S-pprjMWXF1A-1; Mon, 24 Oct 2022 23:11:50 -0400
X-MC-Unique: ZflSR3d1M_S-pprjMWXF1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB2E61C068C3;
        Tue, 25 Oct 2022 03:11:49 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04FC617582;
        Tue, 25 Oct 2022 03:11:48 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:11:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH v2 2/8] mm/percpu: use list_first_entry_or_null in
 pcpu_reclaim_populated()
Message-ID: <Y1dT8RNzV5zSYKq+@MiWiFi-R3L-srv>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-3-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To replace list_empty()/list_first_entry() pair to simplify code.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
v1->v2:
- Add parentheses around assignment in the while condition. This mutes
  the lkp warning.

 mm/percpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 26d8cd2ca323..841bb93aaae6 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2143,9 +2143,9 @@ static void pcpu_reclaim_populated(void)
 	 * other accessor is the free path which only returns area back to the
 	 * allocator not touching the populated bitmap.
 	 */
-	while (!list_empty(&pcpu_chunk_lists[pcpu_to_depopulate_slot])) {
-		chunk = list_first_entry(&pcpu_chunk_lists[pcpu_to_depopulate_slot],
-					 struct pcpu_chunk, list);
+	while ((chunk = list_first_entry_or_null(
+			&pcpu_chunk_lists[pcpu_to_depopulate_slot],
+			struct pcpu_chunk, list))) {
 		WARN_ON(chunk->immutable);
 
 		/*
-- 
2.34.1

