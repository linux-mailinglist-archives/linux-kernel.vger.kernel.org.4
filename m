Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9E609C49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJXIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJXIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488E5D0E5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMCNuRuv+p/VyO8f2sd5NbLS+a0poTkVGW4v1nMo8cA=;
        b=OAPboD57Tw1rxbkMuw+eIV0yL0zgiwyjnlV8QHB36bErKTWz0F35lQku2BqYHhNgONu31Y
        AC8azW8mSlwIE40Ung+p5XebdtrfJTdsOj1vkPahj2zdvn8ygnZYd9DWkAIH5Eyu+sl8rU
        XsiAy8dGPY/Bi5ajijHvENAtUy4sJVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-oh6QCyUQPPSLXucDD99q_w-1; Mon, 24 Oct 2022 04:15:04 -0400
X-MC-Unique: oh6QCyUQPPSLXucDD99q_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4611181DA23;
        Mon, 24 Oct 2022 08:15:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4C4640C6F9F;
        Mon, 24 Oct 2022 08:14:59 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 5/8] mm/percpu: replace the goto with break
Date:   Mon, 24 Oct 2022 16:14:32 +0800
Message-Id: <20221024081435.204970-6-bhe@redhat.com>
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

In function pcpu_reclaim_populated(), the line of goto jumping is
unnecessary since the label 'end_chunk' is near the end of the for
loop, use break instead.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 09e407338573..954abf916c7d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2167,7 +2167,7 @@ static void pcpu_reclaim_populated(void)
 			/* reintegrate chunk to prevent atomic alloc failures */
 			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
 				reintegrate = true;
-				goto end_chunk;
+				break;
 			}
 
 			/*
@@ -2203,7 +2203,6 @@ static void pcpu_reclaim_populated(void)
 			end = -1;
 		}
 
-end_chunk:
 		/* batch tlb flush per chunk to amortize cost */
 		if (freed_page_start < freed_page_end) {
 			spin_unlock_irq(&pcpu_lock);
-- 
2.34.1

