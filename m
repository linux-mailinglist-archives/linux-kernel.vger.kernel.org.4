Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E9702420
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjEOGIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjEOGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A430DD
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684130593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WArNoC6uSt8maUFT7n6H0H1hJWsPEQmI39XIRXJdkyU=;
        b=TixGiILMA5SvjIglFPZDcop4+99CnTGufsC1HXAsRjukUINVdz0bVAdnoaUdLrgzLmVe9C
        AqPXobqbC2wFp7ALo6K/HNwxq1pcE6axfmw2IybxCkDwc07FufEulX6MNMOBFc8N7op/oL
        +F85S8WqnbJw3D9PZ2vHNTQVHtZOAas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-59zbIiHkPuaB0hNwovmpWA-1; Mon, 15 May 2023 02:03:12 -0400
X-MC-Unique: 59zbIiHkPuaB0hNwovmpWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D08185A588;
        Mon, 15 May 2023 06:03:11 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 161AA483EC2;
        Mon, 15 May 2023 06:03:06 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Mon, 15 May 2023 14:02:58 +0800
Message-Id: <20230515060259.830662-2-bhe@redhat.com>
In-Reply-To: <20230515060259.830662-1-bhe@redhat.com>
References: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Note: RPi4 has different zone ranges than normal memory. Its DMA zone is
0~1G, and DMA32 zone is 1G~4G if CONFIG_ZONE_DMA|DMA32 are enabled by
default. The low memory end is 1G in order to validate all devices, high
memory starts at 1G memory. However, for being consistent with normla
arm64 system, its low memory end is still 1G, while reserving crashkernel
high memory from 4G if crashkernel=size,high specified. This will remove
confusion.

With above change applied, summary of arm64 crashkernel reservation range:
1)
RPi4(zone DMA:0~1G; DMA32:1G~4G):
 crashkernel=size
  0~1G: low memory | 1G~top: high memory

 crashkernel=size,high
  0~1G: low memory | 4G~top: high memory

2)
Other normal system:
 crashkernel=size
 crashkernel=size,high
  0~4G: low memory | 4G~top: high memory

3)
Systems w/o zone DMA|DMA32
 crashkernel=size
 crashkernel=size,high
  0~top: low memory

Signed-off-by: Baoquan He <bhe@redhat.com>

arm64: kdump: fix warning reported by static checker
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 66e70ca47680..c28c2c8483cc 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -69,6 +69,7 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
+#define CRASH_HIGH_SEARCH_BASE		SZ_4G
 
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 
@@ -101,12 +102,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  */
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
-	unsigned long long crash_low_size = 0;
+	unsigned long long crash_low_size = 0, search_base = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
-	int ret;
 	bool fixed_base = false;
+	bool high = false;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -129,7 +131,9 @@ static void __init reserve_crashkernel(void)
 		else if (ret)
 			return;
 
+		search_base = CRASH_HIGH_SEARCH_BASE;
 		crash_max = CRASH_ADDR_HIGH_MAX;
+		high = true;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
 		return;
@@ -140,31 +144,51 @@ static void __init reserve_crashkernel(void)
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

