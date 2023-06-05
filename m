Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FC7228AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjFEOUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjFEOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046C10FB;
        Mon,  5 Jun 2023 07:14:44 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVgxaiIKvFP0oHomVY1t2np/+ULxBfnbtlCnIwdpbWU=;
        b=FGmH2R7cPw5zRKQMa6NHEmPvtC5TtxPpukqwbV4Cb1ja7l+OvC52Hqz9PH+HRuUVuytA/T
        kDXJVNZsNYn/3S0L9zBSnqtkSlWSg9T+FLflLB/MGaNPTBq8q5/nTd+POlzGMUFCD6ST6Y
        Tuf3dBoiwRWbiUMI46Pt9TPjGpfmfb4yGL7emT+mk8T0vPGHLi8v+zW2D73fDOexR31L1r
        I+ru1MVWCtBNodFDqHMj6/q1ciON6sYmG/3uIus3FGEru3QUCNO5MK6utO/3RFcJ0MOq4V
        yuPFoWjzGAJ7JW2YnfeTPeL5qNAbKUgjkt6SAJpKAZo0fZhs4rgTpfrvWHFkGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVgxaiIKvFP0oHomVY1t2np/+ULxBfnbtlCnIwdpbWU=;
        b=TlyNvPAZgDfstRqPBtmT0Kt2rQbiGO3YS4ENC3cjSwxCZjsSYJNDVA9IhIap9Ilx/LHnIU
        GVej7GEK+QUcsDDQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/MCE/AMD, EDAC/mce_amd: Decode UMC_V2 ECC errors
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515113537.1052146-3-muralimk@amd.com>
References: <20230515113537.1052146-3-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <168597448218.404.15334027157988488803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c35977b00fa76ce5f3fe9afdb9cffda970c943d5
Gitweb:        https://git.kernel.org/tip/c35977b00fa76ce5f3fe9afdb9cffda970c943d5
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:34 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:27:11 +02:00

x86/MCE/AMD, EDAC/mce_amd: Decode UMC_V2 ECC errors

The MI200 (Aldebaran) series of devices introduced a new SMCA bank type
for Unified Memory Controllers. The MCE subsystem already has support
for this new type. The MCE decoder module will decode the common MCA
error information for the new bank type, but it will not pass the
information to the AMD64 EDAC module for detailed memory error decoding.

Have the MCE decoder module recognize the new bank type as an SMCA UMC
memory error and pass the MCA information to AMD64 EDAC.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-3-muralimk@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 6 ++++--
 drivers/edac/mce_amd.c        | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0b971f9..5e74610 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -715,11 +715,13 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 
 bool amd_mce_is_memory_error(struct mce *m)
 {
+	enum smca_bank_types bank_type;
 	/* ErrCodeExt[20:16] */
 	u8 xec = (m->status >> 16) & 0x1f;
 
+	bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	if (mce_flags.smca)
-		return smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC && xec == 0x0;
+		return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1050,7 +1052,7 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	if (b && bank_type == SMCA_UMC) {
+	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
 		return NULL;
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63f..9215c06 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1186,7 +1186,8 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
+	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
+	    xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(topology_die_id(m->extcpu), m);
 }
 
