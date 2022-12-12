Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2264A44A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLLPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiLLPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:38:19 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C62411D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:38:17 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v11so127625ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iAhpTfZ04ROFz10upiIHf9tboLksTxs4Ru4C440Ewbw=;
        b=V7q60X8GscAqcMeOBd6CNh5YtlHBuBO7eA2oIl9AIR1+v+3q9rp8X3cLigfPH6xUlK
         kBG7T/9+ssbl+vgSn2rRqUA26IZQV1Ab5tkSvLk0Q6iLAkdEDCHBA/uHO4LhgmL/Y9JC
         PqjC7BPX1l98SlFPVzA+O+isbU3Dv0EpqHGdKv6Uy15kf8+oDSu9/cnzDVhokAQesAuR
         lPHgBpVNA+XwLLfNbA9/5hzR/dE9/yryFjRn0XVV7CtDW9dWVtnjdf56gX8/wuF1T4oV
         ELno2/9yXuGUMfnpjKQgrEz3lKGHtUH2K/mnDGrqP02pwPShk9BhY5VxHkAyHCrRibxL
         xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAhpTfZ04ROFz10upiIHf9tboLksTxs4Ru4C440Ewbw=;
        b=nJPXfuTwB4//JX9z6p+lAkZgyd6AYr0S3lF79aCtKqzeDiqZ8bziOBsjfY9M4L0sDq
         ytJmSZaiJAP+t9K5Yu4Lrn1IjyWsME2xS6+AFNMoKL5os/RCS5wkFrI+O3HC9wpK9LjI
         yY1n21ZBZmruOqLB3bxbEVAXSUozjzid9vSX6RPQk0ffyn7eKJvZmYUiMFCqhP5UIWx0
         VCpBgPp8PJ01/xyeDH1FEHK/qGRO38E4/zSQ0MNyoIF3bH883BrdRj7TJEwWd8d3QWJT
         UG0WeDXPiNW/uGnbYH5M8H/q1xGjjEBZSD1Sa9/iJZg/QXzYYcWb/lcLOf2K6JHQMand
         oRlw==
X-Gm-Message-State: ANoB5plVBNbdP2zoe1LTSHWuHosdH6kZGykVkDz4Wblh6Je+PYsgcqVX
        IkH2JQaYgvXeRl0983DO7LmSkgcLZO+wNzo1+N3uYSvL2bGe
X-Google-Smtp-Source: AA0mqf6agSgLtFoSoqJYlcUvLw8VaD0jSWmjQIS7xdGeuaZmLCwbl/1uHNDB0Y8azvk995qPDpkTggfr0FYF0wqdI6w=
X-Received: by 2002:a05:651c:19ab:b0:276:66a4:47c3 with SMTP id
 bx43-20020a05651c19ab00b0027666a447c3mr24671035ljb.49.1670859495603; Mon, 12
 Dec 2022 07:38:15 -0800 (PST)
MIME-Version: 1.0
From:   "Seija K." <doremylover123@gmail.com>
Date:   Mon, 12 Dec 2022 10:38:04 -0500
Message-ID: <CAA42iKzOVLuSOSi=TaJiGDFt+Hrnm7f-hyc6qq2MV4kP=xKR0w@mail.gmail.com>
Subject: drivers: correct parameters passed to strncmp
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 599072f16ad675aaf6c1f87ca5be129725ce2728
Author: Seija Kijin <doremylover123@gmail.com>
Date: Sun Dec 11 22:01:46 2022 -0500

drivers: correct parameters passed to strncmp
Many times when strncmp is called with the intent of ignoring the NULL
terminator, the null terminator is accidentally included in that
comparison, which in practice is just an strcmp with extra steps.
Subtract from the places where the intent seems to be to do a
comparison without the NULL terminator.
Signed-off-by: Seija Kijin <doremylover123@gmail.com>

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index db672cf19a51..883f3078e233 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -94,12 +94,12 @@ static int __init sr_init_by_name(const char
*name, const char *voltdm)
struct omap_volt_data *volt_data;
static int i;
- if (!strncmp(name, "smartreflex_mpu_iva", 20) ||
- !strncmp(name, "smartreflex_mpu", 16))
+ if (!strncmp(name, "smartreflex_mpu_iva", 19) ||
+ !strncmp(name, "smartreflex_mpu", 15))
sr_data = &omap_sr_pdata[OMAP_SR_MPU];
- else if (!strncmp(name, "smartreflex_core", 17))
+ else if (!strncmp(name, "smartreflex_core", 16))
sr_data = &omap_sr_pdata[OMAP_SR_CORE];
- else if (!strncmp(name, "smartreflex_iva", 16))
+ else if (!strncmp(name, "smartreflex_iva", 15))
sr_data = &omap_sr_pdata[OMAP_SR_IVA];
if (!sr_data) {
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..f25f97d73edc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4330,7 +4330,7 @@ static int __init amd64_edac_init(void)
int i;
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (!x86_match_cpu(amd64_cpuids))
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a22ea053f8e1..da3f02b97352 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -757,7 +757,7 @@ static int __init i10nm_init(void)
edac_dbg(2, "\n");
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index a07bbfd075d0..1ccb38dac56b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1272,7 +1272,7 @@ static int __init igen6_init(void)
edac_dbg(2, "\n");
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -ENODEV;
edac_op_state = EDAC_OPSTATE_NMI;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index a20b299f1202..e7fa4deb6b57 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1529,7 +1529,7 @@ static int __init pnd2_init(void)
edac_dbg(2, "\n");
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 8e39370fdb5c..4834c02fd241 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3635,7 +3635,7 @@ static int __init sbridge_init(void)
edac_dbg(2, "\n");
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 7e2762f62eec..adea8ff23f85 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -654,7 +654,7 @@ static int __init skx_init(void)
edac_dbg(2, "\n");
owner = edac_get_owner();
- if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+ if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
return -EBUSY;
if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/media/pci/bt8xx/bttv-cards.c
b/drivers/media/pci/bt8xx/bttv-cards.c
index c2b5ab287dd7..c24cc2f46d2f 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -2968,7 +2968,7 @@ static void identify_by_eeprom(struct bttv *btv,
unsigned char eeprom_data[256])
if (0 == strncmp(eeprom_data,"GET MM20xPCTV",13))
type = BTTV_BOARD_MODTEC_205;
- else if (0 == strncmp(eeprom_data+20,"Picolo",7))
+ else if (0 == strncmp(eeprom_data + 20, "Picolo", 6))
type = BTTV_BOARD_EURESYS_PICOLO;
else if (eeprom_data[0] == 0x84 && eeprom_data[2]== 0)
type = BTTV_BOARD_HAUPPAUGE; /* old bt848 */
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c
b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 98793b2ac2c7..795c44656ab3 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -912,7 +912,7 @@ liquidio_probe(struct pci_dev *pdev, const struct
pci_device_id __maybe_unused *
static bool fw_type_is_auto(void)
{
return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
- sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
+ sizeof(LIO_FW_NAME_TYPE_AUTO) - 1) == 0;
}
/**
diff --git a/drivers/staging/nvec/nvec_power.c
b/drivers/staging/nvec/nvec_power.c
index b1ef196e1cfe..3ed9e06e32de 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -207,7 +207,7 @@ static int nvec_power_bat_notifier(struct
notifier_block *nb,
* This differs a little from the spec fill in more if you find
* some.
*/
- if (!strncmp(power->bat_type, "Li", 30))
+ if (!strncmp(power->bat_type, "Li", 2))
power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_LION;
else
power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
