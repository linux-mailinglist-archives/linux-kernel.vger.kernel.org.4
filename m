Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E015EAB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiIZPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiIZPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:32:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D754F185
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:19:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26E0A1F461;
        Mon, 26 Sep 2022 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664201939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2HK44ajp1lbC5d5j3eVVMNpf685PGwbChjA5LVUn8U=;
        b=ri7oOJT3IepK3v9cmd+MT8FhkKA76sA90fa4F+C13EL0MykPKpTmwIbx9q/WgvfWRSURNr
        V9zK8rJK98uspTICV60Ydt/PN3znvEIiAdXmfC6Q8OOFBd3GZEYxdNsivznfEPDS0O6ZB2
        5+es+r5FUNJU+VLRINnrUt5B2l0xrmU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFCE7139BD;
        Mon, 26 Sep 2022 14:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L1Z8MdK0MWORBgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 26 Sep 2022 14:18:58 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] xen/pv: allow pmu msr accesses to cause GP
Date:   Mon, 26 Sep 2022 16:18:47 +0200
Message-Id: <20220926141849.21805-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220926141849.21805-1-jgross@suse.com>
References: <20220926141849.21805-1-jgross@suse.com>
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

Remove one level of indentation by restructuring the code a little bit.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/pmu.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 21ecbe754cb2..34b4144f6041 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -293,22 +293,24 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		if (is_amd_pmu_msr(msr)) {
-			if (!xen_amd_pmu_emulate(msr, val, 1))
-				*val = native_read_msr_safe(msr, err);
-			return true;
+		if (!is_amd_pmu_msr(msr))
+			return false;
+		if (!xen_amd_pmu_emulate(msr, val, 1)) {
+			*val = err ? native_read_msr_safe(msr, err)
+				   : native_read_msr(msr);
 		}
+		return true;
 	} else {
 		int type, index;
 
-		if (is_intel_pmu_msr(msr, &type, &index)) {
-			if (!xen_intel_pmu_emulate(msr, val, type, index, 1))
-				*val = native_read_msr_safe(msr, err);
-			return true;
+		if (!is_intel_pmu_msr(msr, &type, &index))
+			return false;
+		if (!xen_intel_pmu_emulate(msr, val, type, index, 1)) {
+			*val = err ? native_read_msr_safe(msr, err)
+				   : native_read_msr(msr);
 		}
+		return true;
 	}
-
-	return false;
 }
 
 bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
@@ -316,22 +318,28 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 	uint64_t val = ((uint64_t)high << 32) | low;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		if (is_amd_pmu_msr(msr)) {
-			if (!xen_amd_pmu_emulate(msr, &val, 0))
+		if (!is_amd_pmu_msr(msr))
+			return false;
+		if (!xen_amd_pmu_emulate(msr, &val, 0)) {
+			if (err)
 				*err = native_write_msr_safe(msr, low, high);
-			return true;
+			else
+				native_write_msr(msr, low, high);
 		}
+		return true;
 	} else {
 		int type, index;
 
-		if (is_intel_pmu_msr(msr, &type, &index)) {
-			if (!xen_intel_pmu_emulate(msr, &val, type, index, 0))
+		if (!is_intel_pmu_msr(msr, &type, &index))
+			return false;
+		if (!xen_intel_pmu_emulate(msr, &val, type, index, 0)) {
+			if (err)
 				*err = native_write_msr_safe(msr, low, high);
-			return true;
+			else
+				native_write_msr(msr, low, high);
 		}
+		return true;
 	}
-
-	return false;
 }
 
 static unsigned long long xen_amd_read_pmc(int counter)
-- 
2.35.3

