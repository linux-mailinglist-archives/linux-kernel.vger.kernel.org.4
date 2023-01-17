Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112D66D52C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjAQDuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjAQDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12E227A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673927387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tq8BWi7KIMXK19sTfFEOHzGCHbw3j+yt4nwzlz7Cvoc=;
        b=dYKtc0ph2+IQw29dI1QR2keVO8rJAia7hkB7v10J6o+Kn7H0Z5UXzROAWVWspmeGrwU3eo
        6ZNJWw3CHy1h5jB6Auu+NqneVPBTo148oY/jlkTaA9BCRdnCWnMaWYhYHFjj+C+uzmXZLc
        sX2qQFcaJeTlqUaR4YuhfNFx7UTTrOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-upN5m9UrNDW622U8L_BpjQ-1; Mon, 16 Jan 2023 22:49:41 -0500
X-MC-Unique: upN5m9UrNDW622U8L_BpjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA8EA101A52E;
        Tue, 17 Jan 2023 03:49:40 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D146A14171B8;
        Tue, 17 Jan 2023 03:49:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] arm64/kdump: add code comments for crashkernel reservation cases
Date:   Tue, 17 Jan 2023 11:49:21 +0800
Message-Id: <20230117034921.185150-3-bhe@redhat.com>
In-Reply-To: <20230117034921.185150-1-bhe@redhat.com>
References: <20230117034921.185150-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help understand codes on crashkernel reservations on arm64.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 26a05af2bfa8..f88ad17cb20d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -177,6 +177,10 @@ static void __init reserve_crashkernel(void)
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       search_base, crash_max);
 	if (!crash_base) {
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
 		if (fixed_base) {
 			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
 				search_base, crash_max);
@@ -188,6 +192,11 @@ static void __init reserve_crashkernel(void)
 		 * high memory, the minimum required low memory will be
 		 * reserved later.
 		 */
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
 		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
@@ -195,6 +204,10 @@ static void __init reserve_crashkernel(void)
 			goto retry;
 		}
 
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was for
+		 * high memory, fall back to low memory.
+		 */
 		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
 			crash_max = CRASH_ADDR_LOW_MAX;
 			search_base = 0;
-- 
2.34.1

