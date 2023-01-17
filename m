Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAC66D52B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjAQDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjAQDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD923106
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673927378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKf0pfjvYxPkjbdKZXYck8pY3VTnEaZbMJ46YyM2HTg=;
        b=OSAAvxPM1H5kZyfrebopvU0/mI9/cwdvMw7Czi5zankb4AXwDXTUj0xXPaukKvBr0PNhZb
        BQhigRws67z9sm/3aL0sJwSzm+YPDDoRuUCzPCY8AiNFjpfw+u/AG+W7eYm9clqDvW3vgC
        mdFB+3Jv+C4gl6Ul6Mb4zLq/6YFZ2GA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-0KrDAEoOOSGLbtIy3AN8Hg-1; Mon, 16 Jan 2023 22:49:35 -0500
X-MC-Unique: 0KrDAEoOOSGLbtIy3AN8Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D407802BF3;
        Tue, 17 Jan 2023 03:49:35 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A08321415108;
        Tue, 17 Jan 2023 03:49:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        wangkefeng.wang@huawei.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Tue, 17 Jan 2023 11:49:20 +0800
Message-Id: <20230117034921.185150-2-bhe@redhat.com>
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

On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
suitable memory region up down. If the 'xM' of crashkernel high memory
is reserved from high memory successfully, it will try to reserve
crashkernel low memory later accoringly. Otherwise, it will try to search
low memory area for the 'xM' suitable region.

While we observed an unexpected case where a reserved region crosses the
high and low meomry boundary. E.g on a system with 4G as low memory end,
user added the kernel parameters like: 'crashkernel=512M,high', it could
finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
This looks very strange because we have two low memory regions
[4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
why that happened.

Here, for crashkernel=xM,high, search the high memory for the suitable
region above the high and low memory boundary. If failed, try reserving
the suitable region below the boundary. Like this, the crashkernel high
region will only exist in high memory, and crashkernel low region only
exists in low memory. The reservation behaviour for crashkernel=,high is
clearer and simpler.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..26a05af2bfa8 100644
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
@@ -166,31 +169,44 @@ static void __init reserve_crashkernel(void)
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
+		if (fixed_base) {
+			pr_warn("cannot reserve crashkernel region [0x%llx-0x%llx]\n",
+				search_base, crash_max);
+			return;
+		}
+
 		/*
 		 * If the first attempt was for low memory, fall back to
 		 * high memory, the minimum required low memory will be
 		 * reserved later.
 		 */
-		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
 			crash_max = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 			goto retry;
 		}
 
+		if (high && (crash_max == CRASH_ADDR_HIGH_MAX)) {
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

