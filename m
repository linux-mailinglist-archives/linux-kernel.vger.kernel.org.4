Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0B71388C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjE1HxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjE1HxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F8DC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:53:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685260381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=v4UXo/fgV3E0dyr7pIliCTMcFAkKtetVRqme41igh8U=;
        b=2/jiMvcarS5W9+HwZQ2vyDnd0xga3Qjd3bMFff+z8Kx9yWpbFh8r9khVvy1b5/3oOQQNQW
        tlkfh8flrAo4IbfMZg8516yoPfGro7+G/VA0JB+P1aCUszi+dtQ7Y4KhI78bDDxbPOz2+k
        5+9T2Ii2GqCwLW+Ff9k+gOur6SOnXxmRdhXLnfUISzQ1VJxWUQg1FPjwx0nrhN/3JdkEum
        xzfN6lROdXur1pE7Ne8ozxaKTFMnRX/BO8uQxpGNseuQzSibl/aFWXt0lUlOkpjyJZTLpT
        CGhRghqkWi5IuZNKn/SLcCrD7Arh92EM0fl7+vfU6EGD9jR8ogH3z1rRJyfG9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685260381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=v4UXo/fgV3E0dyr7pIliCTMcFAkKtetVRqme41igh8U=;
        b=Wa5uc+9hXLiNNDLvDt+VCiOfC7KQHMtQftmQyb80CCxD7nR7YT7Nvq0Eols8uqp8yUFpVJ
        Jf7GF/zEcgm/kNDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 6.4-rc4
References: <168526035526.3457722.14103350194452732675.tglx@xen13>
Message-ID: <168526035979.3457722.10299010241065106864.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 May 2023 09:53:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023=
-05-28

up to:  38776cc45eb7: perf/x86/uncore: Correct the number of CHAs on SPR


A small set of perf fixes:

 - Make the CHA discovery based on MSR readout to work around broken
   discovery tables in some SPR firmwares.

 - Prevent saving PEBS configuration which has software bits set that
   cause a crash when restored into the relevant MSR.

Thanks,

	tglx

------------------>
Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on SPR

Like Xu (1):
      perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when using gues=
t PEBS


 arch/x86/events/intel/core.c         |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 070cc4ef2672..89b9c1cebb61 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_ms=
rs(int *nr, void *data)
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		arr[(*nr)++] =3D (struct perf_guest_switch_msr){
 			.msr =3D MSR_PEBS_DATA_CFG,
-			.host =3D cpuc->pebs_data_cfg,
+			.host =3D cpuc->active_pebs_data_cfg,
 			.guest =3D kvm_pmu->pebs_data_cfg,
 		};
 	}
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index fa9b209a11fa..d49e90dc04a4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6150,6 +6150,7 @@ static struct intel_uncore_type spr_uncore_mdf =3D {
 };
=20
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
+#define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
 #define UNCORE_SPR_UPI				8
@@ -6460,12 +6461,22 @@ static int uncore_type_max_boxes(struct intel_uncore_=
type **types,
 	return max + 1;
 }
=20
+#define SPR_MSR_UNC_CBO_CONFIG		0x2FFE
+
 void spr_uncore_cpu_init(void)
 {
+	struct intel_uncore_type *type;
+	u64 num_cbo;
+
 	uncore_msr_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
 						spr_msr_uncores);
=20
+	type =3D uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
+	if (type) {
+		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
+		type->num_boxes =3D num_cbo;
+	}
 	spr_uncore_iio_free_running.num_boxes =3D uncore_type_max_boxes(uncore_msr_=
uncores, UNCORE_SPR_IIO);
 }
=20

