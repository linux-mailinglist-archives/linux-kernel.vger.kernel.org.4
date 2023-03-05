Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128DE6AAEA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 09:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCEIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 03:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCEIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:55:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767BBBBC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 00:55:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678006499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wQlfYTWGzajnBLlhaP5w0Kcuu9Ra/5gFHNb4rmjs6GM=;
        b=fOI9hhgTZH94QbR0rksh/OagP+XS75+yykrwZ6ujObFpSqmJkoJGBQJWAdedf8yfQs++94
        F125m+esWZiU8cNsBveTcQAbcdOXDPChLIn3SCKDlIWQf/rN/1rVXxQ0QHj2U3A8ezmw/j
        33g7to7CbCar+8bKNLJTS6BUTIao4JadRQrP+9lzKaWbTFMU3adtJnHxubRcOaMSYwIrPK
        3uQ7XsqtZPVupHx21NnZjRYaUAsvDUga8dTXniP74JA9ORXLncdD3gd1Qc1usXyJ61nGxH
        IBdFSMq+NgyECSYW7yeVW5C/wkGFBGd8m4EDav7sMC2EySfjL/KzaOufFDi5fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678006499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wQlfYTWGzajnBLlhaP5w0Kcuu9Ra/5gFHNb4rmjs6GM=;
        b=ywh7Ao+xhCheOn/JtNOlrbPGB7xd4xlI7R2tSX2UeCjmn/OO3Iu6R7DLdT76oTgOZYFrsp
        Jgfd5ckvncmLo3DQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.3-rc1
References: <167800644191.309766.5757985605946414576.tglx@xen13>
Message-ID: <167800644337.309766.13683413258889415288.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Mar 2023 09:54:58 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-=
03-05

up to:  dd093fb08e8f: virt/sev-guest: Return -EIO if certificate buffer is no=
t large enough


A small set of updates for x86:

 - Return -EIO instead of success when the certificate buffer for SEV
   guests is not large enough.

 - Allow STIPB to be enabled with legacy IBSR. Legacy IBRS is cleared on
   return to userspace for performance reasons, but the leaves user space
   vulnerable to cross-thread attacks which STIBP prevents. Update the
   documentation accordingly.

Thanks,

	tglx

------------------>
KP Singh (2):
      x86/speculation: Allow enabling STIBP with legacy IBRS
      Documentation/hw-vuln: Document the interaction between IBRS and STIBP

Tom Lendacky (1):
      virt/sev-guest: Return -EIO if certificate buffer is not large enough


 Documentation/admin-guide/hw-vuln/spectre.rst | 21 ++++++++++++++++-----
 arch/x86/kernel/cpu/bugs.c                    | 25 ++++++++++++++++++-------
 drivers/virt/coco/sev-guest/sev-guest.c       | 20 +++++++++++++++++---
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/ad=
min-guide/hw-vuln/spectre.rst
index 3fe6511c5405..4d186f599d90 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -479,8 +479,16 @@ Spectre variant 2
    On Intel Skylake-era systems the mitigation covers most, but not all,
    cases. See :ref:`[3] <spec_ref3>` for more details.
=20
-   On CPUs with hardware mitigation for Spectre variant 2 (e.g. Enhanced
-   IBRS on x86), retpoline is automatically disabled at run time.
+   On CPUs with hardware mitigation for Spectre variant 2 (e.g. IBRS
+   or enhanced IBRS on x86), retpoline is automatically disabled at run time.
+
+   Systems which support enhanced IBRS (eIBRS) enable IBRS protection once at
+   boot, by setting the IBRS bit, and they're automatically protected against
+   Spectre v2 variant attacks, including cross-thread branch target injectio=
ns
+   on SMT systems (STIBP). In other words, eIBRS enables STIBP too.
+
+   Legacy IBRS systems clear the IBRS bit on exit to userspace and
+   therefore explicitly enable STIBP for that
=20
    The retpoline mitigation is turned on by default on vulnerable
    CPUs. It can be forced on or off by the administrator
@@ -504,9 +512,12 @@ Spectre variant 2
    For Spectre variant 2 mitigation, individual user programs
    can be compiled with return trampolines for indirect branches.
    This protects them from consuming poisoned entries in the branch
-   target buffer left by malicious software.  Alternatively, the
-   programs can disable their indirect branch speculation via prctl()
-   (See :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
+   target buffer left by malicious software.
+
+   On legacy IBRS systems, at return to userspace, implicit STIBP is disabled
+   because the kernel clears the IBRS bit. In this case, the userspace progr=
ams
+   can disable indirect branch speculation via prctl() (See
+   :ref:`Documentation/userspace-api/spec_ctrl.rst <set_spec_ctrl>`).
    On x86, this will turn on STIBP to guard against attacks from the
    sibling thread when the user program is running, and use IBPB to
    flush the branch target buffer when switching to/from the program.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cf81848b72f4..f9d060e71c3e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1133,14 +1133,18 @@ spectre_v2_parse_user_cmdline(void)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
=20
-static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
+static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
 {
-	return mode =3D=3D SPECTRE_V2_IBRS ||
-	       mode =3D=3D SPECTRE_V2_EIBRS ||
+	return mode =3D=3D SPECTRE_V2_EIBRS ||
 	       mode =3D=3D SPECTRE_V2_EIBRS_RETPOLINE ||
 	       mode =3D=3D SPECTRE_V2_EIBRS_LFENCE;
 }
=20
+static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
+{
+	return spectre_v2_in_eibrs_mode(mode) || mode =3D=3D SPECTRE_V2_IBRS;
+}
+
 static void __init
 spectre_v2_user_select_mitigation(void)
 {
@@ -1203,12 +1207,19 @@ spectre_v2_user_select_mitigation(void)
 	}
=20
 	/*
-	 * If no STIBP, IBRS or enhanced IBRS is enabled, or SMT impossible,
-	 * STIBP is not required.
+	 * If no STIBP, enhanced IBRS is enabled, or SMT impossible, STIBP
+	 * is not required.
+	 *
+	 * Enhanced IBRS also protects against cross-thread branch target
+	 * injection in user-mode as the IBRS bit remains always set which
+	 * implicitly enables cross-thread protections.  However, in legacy IBRS
+	 * mode, the IBRS bit is set only on kernel entry and cleared on return
+	 * to userspace. This disables the implicit cross-thread protection,
+	 * so allow for STIBP to be selected in that case.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
-	    spectre_v2_in_ibrs_mode(spectre_v2_enabled))
+	    spectre_v2_in_eibrs_mode(spectre_v2_enabled))
 		return;
=20
 	/*
@@ -2340,7 +2351,7 @@ static ssize_t mmio_stale_data_show_state(char *buf)
=20
 static char *stibp_state(void)
 {
-	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled))
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
 		return "";
=20
 	switch (spectre_v2_user_stibp) {
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-=
guest/sev-guest.c
index 4ec4174e05a3..7b4e9009f335 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *sn=
p_dev, u64 exit_code, in
 		snp_dev->input.data_npages =3D certs_npages;
 	}
=20
+	/*
+	 * Increment the message sequence number. There is no harm in doing
+	 * this now because decryption uses the value stored in the response
+	 * structure and any failure will wipe the VMPCK, preventing further
+	 * use anyway.
+	 */
+	snp_inc_msg_seqno(snp_dev);
+
 	if (fw_err)
 		*fw_err =3D err;
=20
+	/*
+	 * If an extended guest request was issued and the supplied certificate
+	 * buffer was not large enough, a standard guest request was issued to
+	 * prevent IV reuse. If the standard request was successful, return -EIO
+	 * back to the caller as would have originally been returned.
+	 */
+	if (!rc && err =3D=3D SNP_GUEST_REQ_INVALID_LEN)
+		return -EIO;
+
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
@@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp=
_dev, u64 exit_code, in
 		goto disable_vmpck;
 	}
=20
-	/* Increment to new message sequence after payload decryption was successfu=
l. */
-	snp_inc_msg_seqno(snp_dev);
-
 	return 0;
=20
 disable_vmpck:

