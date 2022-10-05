Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8555F530D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJELD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJELDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:03:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2963733CA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80DCF1F8AB;
        Wed,  5 Oct 2022 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664967796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgtM+cfFBEjh9AiQx5LN2dKosLbrkZH1H9ph//hZGgs=;
        b=XqHIoGAWRFHVdku3EPpUHfUMz4kPcAG//ZNU/RgZ8UGEc0lXY4f4KuiUN58CNeQ28xRRj2
        yE+jiMVJjcy27h6BEoB2gHLncmekAggN/qUczrNNTTi4JT9K77SkKU57gy2XB7ej85tEKa
        sfiuzAlrj9Jmht9AWUG8RvUqUyVFZLc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3070713345;
        Wed,  5 Oct 2022 11:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d+WECnRkPWPuQgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 05 Oct 2022 11:03:16 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v3 2/4] xen/pv: fix vendor checks for pmu emulation
Date:   Wed,  5 Oct 2022 13:03:00 +0200
Message-Id: <20221005110302.13455-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221005110302.13455-1-jgross@suse.com>
References: <20221005110302.13455-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU vendor checks for pmu emulation are rather limited today, as
the assumption seems to be that only Intel and AMD are existing and/or
supported vendors.

Fix that by handling Centaur and Zhaoxin CPUs the same way as Intel,
and Hygon the same way as AMD.

While at it fix the return type of is_intel_pmu_msr().

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 arch/x86/xen/pmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 0f98cb1077e3..68aff1382872 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -131,7 +131,8 @@ static inline uint32_t get_fam15h_addr(u32 addr)
 
 static inline bool is_amd_pmu_msr(unsigned int msr)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
 	if ((msr >= MSR_F15H_PERF_CTL &&
@@ -143,11 +144,13 @@ static inline bool is_amd_pmu_msr(unsigned int msr)
 	return false;
 }
 
-static int is_intel_pmu_msr(u32 msr_index, int *type, int *index)
+static bool is_intel_pmu_msr(u32 msr_index, int *type, int *index)
 {
 	u32 msr_index_pmc;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return false;
 
 	switch (msr_index) {
-- 
2.35.3

