Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69CF5F3EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJDIo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJDIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:44:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669953DF34
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:44:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD48F1F909;
        Tue,  4 Oct 2022 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664873059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnOBG7dPJJxOFbSXECzEyNs/pZFtg7J3uSYUDX0hJuc=;
        b=DVk72WoqFGUhkClh0eikyDJjWI1vrwOAqEGWlI6G7eiI8jfg0qNJyRN+eacKsCWbQbv6G4
        bkzMEiTdxHzdA++LqakKAWU8Nd8qVtje9HF5nf/uMJtJLiPN4I5rWRQd2WZzoVeG+xr7WS
        +hmgaRSunDvSY21mr96NQwNnMLa17S0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66731139D2;
        Tue,  4 Oct 2022 08:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3f3BF2PyO2OpVwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:44:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 1/3] xen/pv: allow pmu msr accesses to cause GP
Date:   Tue,  4 Oct 2022 10:43:33 +0200
Message-Id: <20221004084335.2838-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004084335.2838-1-jgross@suse.com>
References: <20221004084335.2838-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today pmu_msr_read() and pmu_msr_write() fall back to the safe variants
of read/write MSR in case the MSR access isn't emulated via Xen. Allow
the caller to select the potentially faulting variant by passing NULL
for the error pointer.

Restructure the code to make it more readable.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- do some restructuring (Jan Beulich, Boris Ostrovsky)
---
 arch/x86/xen/pmu.c | 61 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 21ecbe754cb2..501b6f872d96 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -131,6 +131,9 @@ static inline uint32_t get_fam15h_addr(u32 addr)
 
 static inline bool is_amd_pmu_msr(unsigned int msr)
 {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return false;
+
 	if ((msr >= MSR_F15H_PERF_CTL &&
 	     msr < MSR_F15H_PERF_CTR + (amd_num_counters * 2)) ||
 	    (msr >= MSR_K7_EVNTSEL0 &&
@@ -144,6 +147,9 @@ static int is_intel_pmu_msr(u32 msr_index, int *type, int *index)
 {
 	u32 msr_index_pmc;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
 	switch (msr_index) {
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 	case MSR_IA32_DS_AREA:
@@ -292,46 +298,45 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		if (is_amd_pmu_msr(msr)) {
-			if (!xen_amd_pmu_emulate(msr, val, 1))
-				*val = native_read_msr_safe(msr, err);
-			return true;
-		}
-	} else {
-		int type, index;
+	int type, index;
+	bool emulated;
 
-		if (is_intel_pmu_msr(msr, &type, &index)) {
-			if (!xen_intel_pmu_emulate(msr, val, type, index, 1))
-				*val = native_read_msr_safe(msr, err);
-			return true;
-		}
+	if (is_amd_pmu_msr(msr))
+		emulated = xen_amd_pmu_emulate(msr, val, 1);
+	else if (is_intel_pmu_msr(msr, &type, &index))
+		emulated = xen_intel_pmu_emulate(msr, val, type, index, 1);
+	else
+		return false;
+
+	if (!emulated) {
+		*val = err ? native_read_msr_safe(msr, err)
+			   : native_read_msr(msr);
 	}
 
-	return false;
+	return true;
 }
 
 bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
+	int type, index;
+	bool emulated;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		if (is_amd_pmu_msr(msr)) {
-			if (!xen_amd_pmu_emulate(msr, &val, 0))
-				*err = native_write_msr_safe(msr, low, high);
-			return true;
-		}
-	} else {
-		int type, index;
+	if (is_amd_pmu_msr(msr))
+		emulated = xen_amd_pmu_emulate(msr, &val, 0);
+	else if (is_intel_pmu_msr(msr, &type, &index))
+		emulated = xen_intel_pmu_emulate(msr, &val, type, index, 0);
+	else
+		return false;
 
-		if (is_intel_pmu_msr(msr, &type, &index)) {
-			if (!xen_intel_pmu_emulate(msr, &val, type, index, 0))
-				*err = native_write_msr_safe(msr, low, high);
-			return true;
-		}
+	if (!emulated) {
+		if (err)
+			*err = native_write_msr_safe(msr, low, high);
+		else
+			native_write_msr(msr, low, high);
 	}
 
-	return false;
+	return true;
 }
 
 static unsigned long long xen_amd_read_pmc(int counter)
-- 
2.35.3

