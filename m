Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589D76AB896
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCFImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCFIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F91B21A20
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678092097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ia/TpNw+FdzgwNfhvXboS3FJRvVhJBlZ4xIsegJQs4Q=;
        b=K6rnxCxAZGmzOwG3Vg6yrBpK1MnTsgZBB6Da/p93CKcFebz0M8eUDP12/2LmhL/X9DOT1h
        KNKUjeOngRD2WWYgkMYihqsrOv/M66hbsrycLR3S7Ecr3OeJM6rwhwSL6IqtTf+wSm2RSA
        5z2fHZ+esWr7YMaDSNTsWfx2+f2wlzQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-RlTEIn2QMOWwRFP8UZOh-w-1; Mon, 06 Mar 2023 03:41:34 -0500
X-MC-Unique: RlTEIn2QMOWwRFP8UZOh-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04742185A7A4;
        Mon,  6 Mar 2023 08:41:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F7D440C1106;
        Mon,  6 Mar 2023 08:41:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Mon,  6 Mar 2023 16:41:24 +0800
Message-Id: <20230306084124.300584-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
suitable memory region top down. If the 'xM' of crashkernel high memory
is reserved from high memory successfully, it will try to reserve
crashkernel low memory later accoringly. Otherwise, it will try to search
low memory area for the 'xM' suitable region. Please see the details in
Documentation/admin-guide/kernel-parameters.txt.

While we observed an unexpected case where a reserved region crosses the
high and low meomry boundary. E.g on a system with 4G as low memory end,
user added the kernel parameters like: 'crashkernel=512M,high', it could
finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
The crashkernel high region crossing low and high memory boudary will bring
issues:

1) For crashkernel=x,high, if getting crashkernel high region across
low and high memory boundary, then user will see two memory regions in
low memory, and one memory region in high memory. The two crashkernel
low memory regions are confusing as shown in above example.

2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
and y <= 128M, when crashkernel high region crosses low and high memory
boundary and the part of crashkernel high reservation below boundary is
bigger than y, the expected crahskernel low reservation will be skipped.
But the expected crashkernel high reservation is shrank and could not
satisfy user space requirement.

3) The crossing boundary behaviour of crahskernel high reservation is
different than x86 arch. On x86_64, the low memory end is 4G fixedly,
and the memory near 4G is reserved by system, e.g for mapping firmware,
pci mapping, so the crashkernel reservation crossing boundary never happens.
From distros point of view, this brings inconsistency and confusion. Users
need to dig into x86 and arm64 system details to find out why.

For kernel itself, the impact of issue 3) could be slight. While issue
1) and 2) cause actual impact because it brings obscure semantics and
behaviour to crashkernel=,high reservation.

Here, for crashkernel=xM,high, search the high memory for the suitable
region only in high memory. If failed, try reserving the suitable
region only in low memory. Like this, the crashkernel high region will
only exist in high memory, and crashkernel low region only exists in low
memory. The reservation behaviour for crashkernel=,high is clearer and
simpler.

Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
system, or 4G if other normal systems.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
Change history:
v3->v4:
 - Change pr_info() to pr_warn() when fixed allocation failed. Leizhen
   pointed out this and suggested changing.
v2->v3:
 - Rephrase patch log to clarify the current crashkernel high
   reservation could cross the high and low memory boundary, but not
   4G boundary only, because RPi4 of arm64 has high and low memory
   boudary as 1G. The v3 patch log could mislead people that the RPi4
   also use 4G as high,low memory boundary.
v1->v2:
 - Fold patch 2 of v1 into patch 1 for better reviewing.
 - Update patch log to add more details.

 arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..307763f97549 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
-	unsigned long long crash_low_size = 0;
+	unsigned long long crash_base, crash_size, search_base;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	unsigned long long crash_low_size = 0;
 	char *cmdline = boot_command_line;
-	int ret;
 	bool fixed_base = false;
+	bool high = false;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
+		search_base = CRASH_ADDR_LOW_MAX;
 		crash_max = CRASH_ADDR_HIGH_MAX;
+		high = true;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
 		return;
@@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
 	/* User specifies base address explicitly. */
 	if (crash_base) {
 		fixed_base = true;
+		search_base = crash_base;
 		crash_max = crash_base + crash_size;
 	}
 
 retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
+					       search_base, crash_max);
 	if (!crash_base) {
 		/*
-		 * If the first attempt was for low memory, fall back to
-		 * high memory, the minimum required low memory will be
-		 * reserved later.
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
 		 */
-		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+		if (fixed_base) {
+			pr_warn("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
+		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}
 
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was
+		 * for high memory, fall back to low memory.
+		 */
+		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
+			crash_max = CRASH_ADDR_LOW_MAX;
+			search_base = 0;
+			goto retry;
+		}
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
-	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
+	     reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
-- 
2.34.1

