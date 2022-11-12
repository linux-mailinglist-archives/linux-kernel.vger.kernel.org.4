Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5162688E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiKLJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiKLJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:36:33 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2015.outbound.protection.outlook.com [40.92.99.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08B2140D8;
        Sat, 12 Nov 2022 01:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaJi+AD+N5mdk6vbDbxOunbYgUjCB9+L0znoaaub64b4z3gYFAVLavo+wK4+4ryOH/tEjEJV04i4H5eU0f/zYicBDsHkKcR5yMSdDPGgpagQV1Xm3rcSIrA6LbVBEezclbvdo94miVt5aYC9IOoBImS5BtCrpY5jZryD82KXITFy5VE71m5vSxL/oSAOD12HMcs7aIhoBacwRNMW3ZxbhBPliCuKWuN7taZ4Wx2vb1TjR2i4/XMEEr7q9+CdV7ZwiXZwojAhG+dnPyR3UymXzPhKq5i9UhdxC/w6sGOXUqpHuPgvUzehhVh1CITyLm77umrrknmcoNBU5qGSmQzQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56W8+yP1+uBs4/iQWkgFZfNs9RmCiATEb5m7JdluOqA=;
 b=hFuuMCjR41gkBp8g8qXLzYKKpdIUOk+erhWAFRrS9lUl6r7br6o8MOB23e5LzmXjaxvrk7oANEzPbgcR4pOxvfb2gPSZygvuLoAMOCDNZMWrhR4QT2DoMKA1henzH1+IvEqjQHzYfSVF2ensDyOwqdM0Ubi9hd1PU1kNajKZOw33SpK7ilcxIpAlxDb7BgYpe7rVBywdnDNWLPWN741Mx6Fa2VgIY6Zaih7khJl3COnID/itn2mmd/NWKtxuuWT+NQWFyQVBLYF8F2m3Qtw95wqjbvwtFkzRlKJA01PVbYZ81ETld4jE+1ontJHcKPeBRglWXV1OF0bn6c9VGmK5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56W8+yP1+uBs4/iQWkgFZfNs9RmCiATEb5m7JdluOqA=;
 b=HMKAglMJaIESjeFlOItAcXQL50a219hxdhRXlBvhHyo32EthoiP9h/E49xzqJfn3jRAH6IImNpt5NtaEq615Dwnmb3O9Iv518nv5brHvhZXw0L+T6es+92HxqxoGcVoEqGbTpraogL9QTYuD+D1ZA9tN0ypFE7eT1Dkciz4vglEYX2vsexqxZhobNhiNGTenKl7c7VhwHyGRKeJS4QtT3gmSZdCjJQ3wFOGTuO5If0FFluxeob411fkgIrY9HcxOlBQzigjBz9DbqO7ecOT0VwM+JXaLLhNchEZYvSDcWWMkNeIuWWFZZAv16kuq9eZ5oEiBEVeWnvEd6wYRZZjHsg==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB1804.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sat, 12 Nov
 2022 09:36:24 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a4b2:fdc1:89cd:25d2]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a4b2:fdc1:89cd:25d2%8]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 09:36:24 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     u.kleine-koenig@pengutronix.de, dvhart@infradead.org,
        andy@infradead.org, lenb@kernel.org, arnd@arndb.de,
        peterhuewe@gmx.de, kys@microsoft.com, kronos.it@gmail.com,
        dmitry.torokhov@gmail.com, bleung@chromium.org,
        sujith.thomas@intel.com, vithampi@vmware.com, lee@kernel.org,
        wim@linux-watchdog.org, jgross@suse.com, davem@davemloft.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] ACPI: make remove callback of ACPI driver void
Date:   Sat, 12 Nov 2022 17:36:08 +0800
Message-ID: <TYCP286MB2323FC50982CDE13B8C458CFCA039@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bEw7pVfVA9Nz8axjrEYNX2CZQSMaV/Ie]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221112093608.794927-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB1804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6fd2d5-cb02-48a0-c703-08dac4915d1f
X-MS-Exchange-SLBlob-MailProps: PHS9e/w+tWIe8jyQ3ATCYRJQOB1vq8/KL6T2byjvWAu7ot98c7m/zyc+QP6EhyOOVeHFkOsMxWsTf8u5riQt6Kmg0rQ/540Cx0wOprzHU/V4GTVx5ZXuVvQRZhuOFSQKXYkBSJkVVTBzJLTLOAXQ9nxxbW+pSbxn6cwOW7E4Dkp3jVP43MLe0sCiPAX0JkriIltaLfc1DuKdV0b3+2BVvcy077DWEZj+N70uVehuWP1XGTpqdzU6b4r656fU+NHLxiyvCTVuwcqcKWuCHnH6LvJU/7dVu7pa+H8uGZttILHexqJoe5VIygQ37H/cYxpqNCOsVpagq4h3RXkTKNWVPSA+zIMc3l3qfSIUNmotWdJJdFp2s90VsWKYCjDwqR+3990oIGBv/1/EGWbpeVlk34yJQ6DAykXib4EOwOgeheNPGi5Ef3Ii8s5GTQ/4j0Mtn5ikF+rN7LBq6vIZyDAJfPie6At9kCA/rOCg9apJHdVTshLlklssE0QiB1Fqh2sLAa4yYOPhm0qNvG71RZBEv2jIBz4mBPhaDWdkfN7F8Njp3CDxmv6UXzhAIFsKRjAbx3SNnj1JfjpKBML3gwMmtr9qRJC7d/o9ixG1MKeVP7PPuJEXb7BUO0S4uIlSRVxeUYNK86Em9DIGIeUb0nqxftnpCZWZ811+6fIRp25rTu3Sxt9rhG5QlRj/3gWqi8/XQ97TfBLcWoDZL9+3edEMkQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whm5Evsg+cGoilsS2bfb7IS37ufHwaC/6xha/4MYDb4es8bdx83TeKizLtIzogk389jSTpX40tSZSA9sYre5VjyAiCPzzmnHgMPswI11ckc8oK/SpnXnnBZTZ4HS2W4fEQW21B/ev68tsbcMGnsurrAPXgIlFG4vmUxcs6/q2FlvUNcZYkt/4E/qsRcBkfEciYOEvHm/zcXvt4NZXam6fl/aKA92Ij4Pq/gIveT/lVu7L4rEf/87VrBk6K+vFGaVwRATiqDEJ0aeSFd9gL8ME88I5M/LkWhx5jIBU5Vb5ot+hi3CoKIsU6n4QB2a6Udu/9yyLc6hedwQA2nhtvy9FHFw0G73CDgPxQY0m6w3NL6Zk/6VtUndgkVjOvSePojV2ORF0oELmfYs5Exm0RZ43RbIrLLTy82rvLJrZntpIpDpyhu5dGUD0Q8gruJgcagHavBTGcxdi8pNpMsttxN2oPHe/C1EW/vPxpT2vjGEADisKfHKF0Ck4utcxVrEG3dpU2N7uHo/dOo6bBbqo/JWtmngr9FGvvpJpFeR57nPJ/b6DwH/R8olNkQsDvpY00Jizvcb+/1way8LHjPapXwEvZeeZAihUrR8pkLXjEsmaoGQJumm2y3jt1Xs2zNqgWRgCsrXWtbTtk/ErVqX6KVyJn7cBSzTzM8PCryTsq3RGkyRH4oVewnc+x9TX1eFGGUX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VvK5MXU0c33HW809b8EbtQV4haTnCZcCz8jd+xaQEvqY9ReILx87llqPl+7?=
 =?us-ascii?Q?1r38NB5ysCMqLk1aIBrbXeAsylCfGW1kum0/mWRn+0vZ/ePSCR1VHdzH6X3b?=
 =?us-ascii?Q?Ont11cvnwFY7SNL9Gx4Oe/AdLJ8QYKb7IcwQL4kzFds/uwu8hEz6+Zc/fHQj?=
 =?us-ascii?Q?wiT/V2/6m+JhaHWmsWN8Wzj+m2v3ZiBmFRH7GrgtKmY55zBWbmtVNKfXycFQ?=
 =?us-ascii?Q?US06yzVGBhJzUfCMcBXrUty/GUlJW2VPtK6glWWsLLmEiuT3hI3ft8pzYmHW?=
 =?us-ascii?Q?YlHEhwCH5NVdXTBkZ+Qp2X3FgoL6XMIsynVkyyc6RJkTHMLb+hvuh4ILR3o5?=
 =?us-ascii?Q?o72kdT/QG6BcKJYn3wimjqam4KCaiYvGGXm6zCai54JI5Y/WpYRaDxTtnglf?=
 =?us-ascii?Q?x04NlUePNPNM+sTWYtXf7bHTI7szdDT8xsHxAaxgjWxgmZcQu5rc2Iy+iLbm?=
 =?us-ascii?Q?JBqcTccc6ZZy6YN6NP0N8gkxoyJU8jlyk9BdFaVdztlZPSP7c9MmeakCssty?=
 =?us-ascii?Q?qDjHNGfbbM3B0E626fZ8/7PaPYgAvG8p4M+DkjrLvjCiOk2y+fddSPLGZi5U?=
 =?us-ascii?Q?7MDE83AU6c2r9tE4OdRkgqsBAbd5ts6Y17s49lOxkI7FDX6XWxZ856OIrYjj?=
 =?us-ascii?Q?SE+eSL2CyXO8n+DB2DNfxwhuD18WBbXl5mNMKSE1uWGFzJALH8YJJZd3so0P?=
 =?us-ascii?Q?hTrDt5RpVPrRSwJ3KRxRJH0N4mQqQKNApcaD+LUtMoPGLtx1NF9mpKQ+pZCx?=
 =?us-ascii?Q?YrDfC6vbnBryruO6VFCBrJzY2yuaQvCbJ/Uh3VTjlLH8TCdC5v+faBLiGEZZ?=
 =?us-ascii?Q?xbRH5hjiB9oELybmY1KfUqB5FAWtuTbQWVf3Iw5PocaK6/qjQWixEOi+4Uml?=
 =?us-ascii?Q?XELMUMSwjgBMIkSnj3127Jq5+LxBJ2el5VSfUMtcABh4eJMIYW73BSLqborl?=
 =?us-ascii?Q?ymDmXXBtCdhJe/XWzFIDbpdxCucAHK56IiSLRI4jM1dfV6VRzpHj8HNggVmU?=
 =?us-ascii?Q?oOreBLbl+Br1EMpQevaEymBkJ34ljDZ6B0n22IEP5bYABkCcrf2l/9rsMEoa?=
 =?us-ascii?Q?8XQTtbBe0vKlPKBCeKBERTJUNbm+CN9bm5bDmQb9v1K7qWMvNhsHCM2w1HoN?=
 =?us-ascii?Q?XGIGMvjaC6W2HsXIzw9Ws/uSe68LEdf/wsjEP2KSUbYisFcS6oionYbd0Zi0?=
 =?us-ascii?Q?NR62Yh72/rbk+HyJtxoaXLHow7ZDb2MLSKeWvapguyBnaMlkCgy9QQJvCYXE?=
 =?us-ascii?Q?F7PZQnISPOgCWI2BRGImMItxJ/Hhib2aK16hjUMAxA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6fd2d5-cb02-48a0-c703-08dac4915d1f
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 09:36:24.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bus-based driver, device removal is implemented as:
1 device_remove()->
2   bus->remove()->
3     driver->remove()

Driver core needs no inform from callee(bus driver) about the
result of remove callback. In that case, commit fc7a6209d571
("bus: Make remove callback return void") forces bus_type::remove
be void-returned.

Now we have the situation that both 1 & 2 of calling chain are
void-returned, so it does not make much sense for 3(driver->remove)
to return non-void to its caller.

So the basic idea behind this change is making remove() callback of
any bus-based driver to be void-returned.

This change, for itself, is for device drivers based on acpi-bus.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 arch/ia64/hp/common/aml_nfw.c                 |  4 ++--
 arch/x86/platform/olpc/olpc-xo15-sci.c        |  3 +--
 drivers/acpi/ac.c                             |  8 +++-----
 drivers/acpi/acpi_pad.c                       |  3 +--
 drivers/acpi/acpi_video.c                     |  8 +++-----
 drivers/acpi/battery.c                        |  5 ++---
 drivers/acpi/button.c                         |  5 ++---
 drivers/acpi/ec.c                             |  5 ++---
 drivers/acpi/hed.c                            |  3 +--
 drivers/acpi/nfit/core.c                      |  3 +--
 drivers/acpi/sbs.c                            |  9 ++++-----
 drivers/acpi/sbshc.c                          |  7 +++----
 drivers/acpi/thermal.c                        |  7 +++----
 drivers/acpi/tiny-power-button.c              | 10 +++++++---
 drivers/char/sonypi.c                         |  3 +--
 drivers/char/tpm/tpm_crb.c                    |  4 +---
 drivers/hv/vmbus_drv.c                        |  4 +---
 drivers/hwmon/acpi_power_meter.c              |  5 ++---
 drivers/hwmon/asus_atk0110.c                  |  6 ++----
 drivers/input/misc/atlas_btns.c               |  4 +---
 drivers/net/fjes/fjes_main.c                  |  4 +---
 .../platform/chrome/chromeos_privacy_screen.c |  3 +--
 drivers/platform/chrome/wilco_ec/event.c      |  4 +---
 drivers/platform/surface/surfacepro3_button.c |  3 +--
 drivers/platform/x86/asus-laptop.c            |  3 +--
 drivers/platform/x86/asus-wireless.c          |  3 +--
 drivers/platform/x86/classmate-laptop.c       | 20 +++++++++----------
 drivers/platform/x86/dell/dell-rbtn.c         |  6 ++----
 drivers/platform/x86/eeepc-laptop.c           |  3 +--
 drivers/platform/x86/fujitsu-laptop.c         |  4 +---
 drivers/platform/x86/fujitsu-tablet.c         |  3 +--
 drivers/platform/x86/intel/rst.c              |  4 +---
 drivers/platform/x86/lg-laptop.c              |  4 +---
 drivers/platform/x86/panasonic-laptop.c       |  8 +++-----
 drivers/platform/x86/sony-laptop.c            |  9 +++------
 drivers/platform/x86/system76_acpi.c          |  4 +---
 drivers/platform/x86/topstar-laptop.c         |  3 +--
 drivers/platform/x86/toshiba_acpi.c           |  4 +---
 drivers/platform/x86/toshiba_bluetooth.c      |  6 +++---
 drivers/platform/x86/toshiba_haps.c           |  4 +---
 drivers/platform/x86/wireless-hotkey.c        |  3 +--
 drivers/platform/x86/xo15-ebook.c             |  3 +--
 drivers/ptp/ptp_vmw.c                         |  3 +--
 drivers/thermal/intel/intel_menlow.c          |  8 +++-----
 drivers/video/backlight/apple_bl.c            |  3 +--
 drivers/watchdog/ni903x_wdt.c                 |  4 +---
 drivers/xen/xen-acpi-pad.c                    |  3 +--
 include/acpi/acpi_bus.h                       |  2 +-
 48 files changed, 88 insertions(+), 149 deletions(-)

diff --git a/arch/ia64/hp/common/aml_nfw.c b/arch/ia64/hp/common/aml_nfw.c
index 684667ade525..901df49461a0 100644
--- a/arch/ia64/hp/common/aml_nfw.c
+++ b/arch/ia64/hp/common/aml_nfw.c
@@ -187,9 +187,9 @@ static int aml_nfw_add(struct acpi_device *device)
 	return aml_nfw_add_global_handler();
 }
 
-static int aml_nfw_remove(struct acpi_device *device)
+static void aml_nfw_remove(struct acpi_device *device)
 {
-	return aml_nfw_remove_global_handler();
+	aml_nfw_remove_global_handler();
 }
 
 static const struct acpi_device_id aml_nfw_ids[] = {
diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 994a229cb79f..68244a3422d1 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -183,13 +183,12 @@ static int xo15_sci_add(struct acpi_device *device)
 	return r;
 }
 
-static int xo15_sci_remove(struct acpi_device *device)
+static void xo15_sci_remove(struct acpi_device *device)
 {
 	acpi_disable_gpe(NULL, xo15_sci_gpe);
 	acpi_remove_gpe_handler(NULL, xo15_sci_gpe, xo15_sci_gpe_handler);
 	cancel_work_sync(&sci_work);
 	sysfs_remove_file(&device->dev.kobj, &lid_wake_on_close_attr.attr);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index bb9fe7984b1a..1ace70b831cd 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -33,7 +33,7 @@ MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
 static int acpi_ac_add(struct acpi_device *device);
-static int acpi_ac_remove(struct acpi_device *device);
+static void acpi_ac_remove(struct acpi_device *device);
 static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id ac_device_ids[] = {
@@ -288,12 +288,12 @@ static int acpi_ac_resume(struct device *dev)
 #define acpi_ac_resume NULL
 #endif
 
-static int acpi_ac_remove(struct acpi_device *device)
+static void acpi_ac_remove(struct acpi_device *device)
 {
 	struct acpi_ac *ac = NULL;
 
 	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+		return;
 
 	ac = acpi_driver_data(device);
 
@@ -301,8 +301,6 @@ static int acpi_ac_remove(struct acpi_device *device)
 	unregister_acpi_notifier(&ac->battery_nb);
 
 	kfree(ac);
-
-	return 0;
 }
 
 static int __init acpi_ac_init(void)
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index ec0e22a1e25d..edbb28faee2a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -449,7 +449,7 @@ static int acpi_pad_add(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_pad_remove(struct acpi_device *device)
+static void acpi_pad_remove(struct acpi_device *device)
 {
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
@@ -458,7 +458,6 @@ static int acpi_pad_remove(struct acpi_device *device)
 	acpi_remove_notify_handler(device->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
 	acpi_pad_remove_sysfs(device);
-	return 0;
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 32953646caeb..30d8fd03fec7 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -86,7 +86,7 @@ static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_add(struct acpi_device *device);
-static int acpi_video_bus_remove(struct acpi_device *device);
+static void acpi_video_bus_remove(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
 static void acpi_video_bus_register_backlight_work(struct work_struct *ignored);
 static DECLARE_DELAYED_WORK(video_bus_register_backlight_work,
@@ -2067,13 +2067,13 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	return error;
 }
 
-static int acpi_video_bus_remove(struct acpi_device *device)
+static void acpi_video_bus_remove(struct acpi_device *device)
 {
 	struct acpi_video_bus *video = NULL;
 
 
 	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+		return;
 
 	video = acpi_driver_data(device);
 
@@ -2087,8 +2087,6 @@ static int acpi_video_bus_remove(struct acpi_device *device)
 
 	kfree(video->attached_array);
 	kfree(video);
-
-	return 0;
 }
 
 static void acpi_video_bus_register_backlight_work(struct work_struct *ignored)
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 306513fec1e1..28b0d1d6e225 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1208,12 +1208,12 @@ static int acpi_battery_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_battery_remove(struct acpi_device *device)
+static void acpi_battery_remove(struct acpi_device *device)
 {
 	struct acpi_battery *battery = NULL;
 
 	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+		return;
 	device_init_wakeup(&device->dev, 0);
 	battery = acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
@@ -1221,7 +1221,6 @@ static int acpi_battery_remove(struct acpi_device *device)
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
 	kfree(battery);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1f9b9a4c38c7..475e1eddfa3b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -125,7 +125,7 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 };
 
 static int acpi_button_add(struct acpi_device *device);
-static int acpi_button_remove(struct acpi_device *device);
+static void acpi_button_remove(struct acpi_device *device);
 static void acpi_button_notify(struct acpi_device *device, u32 event);
 
 #ifdef CONFIG_PM_SLEEP
@@ -580,14 +580,13 @@ static int acpi_button_add(struct acpi_device *device)
 	return error;
 }
 
-static int acpi_button_remove(struct acpi_device *device)
+static void acpi_button_remove(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
-	return 0;
 }
 
 static int param_set_lid_init_state(const char *val,
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9b42628cf21b..b8afee1e8d01 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1663,12 +1663,12 @@ static int acpi_ec_add(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_ec_remove(struct acpi_device *device)
+static void acpi_ec_remove(struct acpi_device *device)
 {
 	struct acpi_ec *ec;
 
 	if (!device)
-		return -EINVAL;
+		return;
 
 	ec = acpi_driver_data(device);
 	release_region(ec->data_addr, 1);
@@ -1678,7 +1678,6 @@ static int acpi_ec_remove(struct acpi_device *device)
 		ec_remove_handlers(ec);
 		acpi_ec_free(ec);
 	}
-	return 0;
 }
 
 static acpi_status
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 60a2939cde6c..78d44e3fe129 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -56,10 +56,9 @@ static int acpi_hed_add(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_hed_remove(struct acpi_device *device)
+static void acpi_hed_remove(struct acpi_device *device)
 {
 	hed_handle = NULL;
-	return 0;
 }
 
 static struct acpi_driver acpi_hed_driver = {
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae5f4acf2675..f1cc5ec6a3b6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3371,10 +3371,9 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
 }
 
-static int acpi_nfit_remove(struct acpi_device *adev)
+static void acpi_nfit_remove(struct acpi_device *adev)
 {
 	/* see acpi_nfit_unregister */
-	return 0;
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index e6a01a8df1b8..e90752d4f488 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -96,7 +96,7 @@ struct acpi_sbs {
 
 #define to_acpi_sbs(x) power_supply_get_drvdata(x)
 
-static int acpi_sbs_remove(struct acpi_device *device);
+static void acpi_sbs_remove(struct acpi_device *device);
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
 static inline int battery_scale(int log)
@@ -664,16 +664,16 @@ static int acpi_sbs_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_sbs_remove(struct acpi_device *device)
+static void acpi_sbs_remove(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs;
 	int id;
 
 	if (!device)
-		return -EINVAL;
+		return;
 	sbs = acpi_driver_data(device);
 	if (!sbs)
-		return -EINVAL;
+		return;
 	mutex_lock(&sbs->lock);
 	acpi_smbus_unregister_callback(sbs->hc);
 	for (id = 0; id < MAX_SBS_BAT; ++id)
@@ -682,7 +682,6 @@ static int acpi_sbs_remove(struct acpi_device *device)
 	mutex_unlock(&sbs->lock);
 	mutex_destroy(&sbs->lock);
 	kfree(sbs);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 340e0b61587e..16f2daaa2c45 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -30,7 +30,7 @@ struct acpi_smb_hc {
 };
 
 static int acpi_smbus_hc_add(struct acpi_device *device);
-static int acpi_smbus_hc_remove(struct acpi_device *device);
+static void acpi_smbus_hc_remove(struct acpi_device *device);
 
 static const struct acpi_device_id sbs_device_ids[] = {
 	{"ACPI0001", 0},
@@ -280,19 +280,18 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 
 extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
 
-static int acpi_smbus_hc_remove(struct acpi_device *device)
+static void acpi_smbus_hc_remove(struct acpi_device *device)
 {
 	struct acpi_smb_hc *hc;
 
 	if (!device)
-		return -EINVAL;
+		return;
 
 	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	acpi_os_wait_events_complete();
 	kfree(hc);
 	device->driver_data = NULL;
-	return 0;
 }
 
 module_acpi_driver(acpi_smb_hc_driver);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 40b07057983e..0c4bdef4d09c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 static struct workqueue_struct *acpi_thermal_pm_queue;
 
 static int acpi_thermal_add(struct acpi_device *device);
-static int acpi_thermal_remove(struct acpi_device *device);
+static void acpi_thermal_remove(struct acpi_device *device);
 static void acpi_thermal_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id  thermal_device_ids[] = {
@@ -1059,19 +1059,18 @@ static int acpi_thermal_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_thermal_remove(struct acpi_device *device)
+static void acpi_thermal_remove(struct acpi_device *device)
 {
 	struct acpi_thermal *tz;
 
 	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+		return;
 
 	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
 	acpi_thermal_unregister_thermal_zone(tz);
 	kfree(tz);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index a19f0e4e69f7..598f548b21f3 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -19,11 +19,15 @@ static const struct acpi_device_id tiny_power_button_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
 
-static int acpi_noop_add_remove(struct acpi_device *device)
+static int acpi_noop_add(struct acpi_device *device)
 {
 	return 0;
 }
 
+static void acpi_noop_remove(struct acpi_device *device)
+{
+}
+
 static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
 {
 	kill_cad_pid(power_signal, 1);
@@ -34,8 +38,8 @@ static struct acpi_driver acpi_tiny_power_button_driver = {
 	.class = "tiny-power-button",
 	.ids = tiny_power_button_device_ids,
 	.ops = {
-		.add = acpi_noop_add_remove,
-		.remove = acpi_noop_add_remove,
+		.add = acpi_noop_add,
+		.remove = acpi_noop_remove,
 		.notify = acpi_tiny_power_button_notify,
 	},
 };
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 27e301a6bb7a..9211531689b2 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1123,10 +1123,9 @@ static int sonypi_acpi_add(struct acpi_device *device)
 	return 0;
 }
 
-static int sonypi_acpi_remove(struct acpi_device *device)
+static void sonypi_acpi_remove(struct acpi_device *device)
 {
 	sonypi_acpi_device = NULL;
-	return 0;
 }
 
 static const struct acpi_device_id sonypi_device_ids[] = {
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 18606651d1aa..17d92f466db5 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -713,14 +713,12 @@ static int crb_acpi_add(struct acpi_device *device)
 	return tpm_chip_register(chip);
 }
 
-static int crb_acpi_remove(struct acpi_device *device)
+static void crb_acpi_remove(struct acpi_device *device)
 {
 	struct device *dev = &device->dev;
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 
 	tpm_chip_unregister(chip);
-
-	return 0;
 }
 
 static const struct dev_pm_ops crb_pm = {
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b2e413bf19c..d9d898ed5920 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2239,7 +2239,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 	return AE_OK;
 }
 
-static int vmbus_acpi_remove(struct acpi_device *device)
+static void vmbus_acpi_remove(struct acpi_device *device)
 {
 	struct resource *cur_res;
 	struct resource *next_res;
@@ -2256,8 +2256,6 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 			kfree(cur_res);
 		}
 	}
-
-	return 0;
 }
 
 static void vmbus_reserve_fb(void)
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 0962c12eba5a..fa28d447f0df 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -910,12 +910,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	return res;
 }
 
-static int acpi_power_meter_remove(struct acpi_device *device)
+static void acpi_power_meter_remove(struct acpi_device *device)
 {
 	struct acpi_power_meter_resource *resource;
 
 	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+		return;
 
 	resource = acpi_driver_data(device);
 	hwmon_device_unregister(resource->hwmon_dev);
@@ -924,7 +924,6 @@ static int acpi_power_meter_remove(struct acpi_device *device)
 	free_capabilities(resource);
 
 	kfree(resource);
-	return 0;
 }
 
 static int acpi_power_meter_resume(struct device *dev)
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index ff64a39d56de..d778a2aaefec 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -187,7 +187,7 @@ struct atk_acpi_input_buf {
 };
 
 static int atk_add(struct acpi_device *device);
-static int atk_remove(struct acpi_device *device);
+static void atk_remove(struct acpi_device *device);
 static void atk_print_sensor(struct atk_data *data, union acpi_object *obj);
 static int atk_read_value(struct atk_sensor_data *sensor, u64 *value);
 
@@ -1344,7 +1344,7 @@ static int atk_add(struct acpi_device *device)
 	return err;
 }
 
-static int atk_remove(struct acpi_device *device)
+static void atk_remove(struct acpi_device *device)
 {
 	struct atk_data *data = device->driver_data;
 	dev_dbg(&device->dev, "removing...\n");
@@ -1359,8 +1359,6 @@ static int atk_remove(struct acpi_device *device)
 		if (atk_ec_ctl(data, 0))
 			dev_err(&device->dev, "Failed to disable EC\n");
 	}
-
-	return 0;
 }
 
 static int __init atk0110_init(void)
diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 0e77c40e1966..3c9bbd04e143 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -106,7 +106,7 @@ static int atlas_acpi_button_add(struct acpi_device *device)
 	return err;
 }
 
-static int atlas_acpi_button_remove(struct acpi_device *device)
+static void atlas_acpi_button_remove(struct acpi_device *device)
 {
 	acpi_status status;
 
@@ -116,8 +116,6 @@ static int atlas_acpi_button_remove(struct acpi_device *device)
 		pr_err("error removing addr spc handler\n");
 
 	input_unregister_device(input_dev);
-
-	return 0;
 }
 
 static const struct acpi_device_id atlas_device_ids[] = {
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 1eff202f6a1f..2513be6d4e11 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -145,14 +145,12 @@ static int fjes_acpi_add(struct acpi_device *device)
 	return 0;
 }
 
-static int fjes_acpi_remove(struct acpi_device *device)
+static void fjes_acpi_remove(struct acpi_device *device)
 {
 	struct platform_device *plat_dev;
 
 	plat_dev = (struct platform_device *)acpi_driver_data(device);
 	platform_device_unregister(plat_dev);
-
-	return 0;
 }
 
 static struct acpi_driver fjes_acpi_driver = {
diff --git a/drivers/platform/chrome/chromeos_privacy_screen.c b/drivers/platform/chrome/chromeos_privacy_screen.c
index 77e9f5ee8e33..bb74ddf9af4a 100644
--- a/drivers/platform/chrome/chromeos_privacy_screen.c
+++ b/drivers/platform/chrome/chromeos_privacy_screen.c
@@ -123,12 +123,11 @@ static int chromeos_privacy_screen_add(struct acpi_device *adev)
 	return 0;
 }
 
-static int chromeos_privacy_screen_remove(struct acpi_device *adev)
+static void chromeos_privacy_screen_remove(struct acpi_device *adev)
 {
 	struct drm_privacy_screen *drm_privacy_screen =	acpi_driver_data(adev);
 
 	drm_privacy_screen_unregister(drm_privacy_screen);
-	return 0;
 }
 
 static const struct acpi_device_id chromeos_privacy_screen_device_ids[] = {
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 32e400590be5..69ceead8cdaa 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -500,15 +500,13 @@ static int event_device_add(struct acpi_device *adev)
 	return error;
 }
 
-static int event_device_remove(struct acpi_device *adev)
+static void event_device_remove(struct acpi_device *adev)
 {
 	struct event_device_data *dev_data = adev->driver_data;
 
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 	ida_simple_remove(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
-
-	return 0;
 }
 
 static const struct acpi_device_id event_acpi_ids[] = {
diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 242fb690dcaf..2755601f979c 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -239,13 +239,12 @@ static int surface_button_add(struct acpi_device *device)
 	return error;
 }
 
-static int surface_button_remove(struct acpi_device *device)
+static void surface_button_remove(struct acpi_device *device)
 {
 	struct surface_button *button = acpi_driver_data(device);
 
 	input_unregister_device(button->input);
 	kfree(button);
-	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(surface_button_pm,
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 47b2f8bb6fb5..761029f39314 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1901,7 +1901,7 @@ static int asus_acpi_add(struct acpi_device *device)
 	return result;
 }
 
-static int asus_acpi_remove(struct acpi_device *device)
+static void asus_acpi_remove(struct acpi_device *device)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
@@ -1914,7 +1914,6 @@ static int asus_acpi_remove(struct acpi_device *device)
 
 	kfree(asus->name);
 	kfree(asus);
-	return 0;
 }
 
 static const struct acpi_device_id asus_device_ids[] = {
diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index d3e7171928e5..abf01e00b799 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -175,7 +175,7 @@ static int asus_wireless_add(struct acpi_device *adev)
 	return err;
 }
 
-static int asus_wireless_remove(struct acpi_device *adev)
+static void asus_wireless_remove(struct acpi_device *adev)
 {
 	struct asus_wireless_data *data = acpi_driver_data(adev);
 
@@ -183,7 +183,6 @@ static int asus_wireless_remove(struct acpi_device *adev)
 		devm_led_classdev_unregister(&adev->dev, &data->led);
 		destroy_workqueue(data->wq);
 	}
-	return 0;
 }
 
 static struct acpi_driver asus_wireless_driver = {
diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 9309ab5792cb..8b6a14611859 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -418,11 +418,11 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	return error;
 }
 
-static int cmpc_accel_remove_v4(struct acpi_device *acpi)
+static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
-	return cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(acpi);
 }
 
 static SIMPLE_DEV_PM_OPS(cmpc_accel_pm, cmpc_accel_suspend_v4,
@@ -648,10 +648,10 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	return error;
 }
 
-static int cmpc_accel_remove(struct acpi_device *acpi)
+static void cmpc_accel_remove(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
-	return cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(acpi);
 }
 
 static const struct acpi_device_id cmpc_accel_device_ids[] = {
@@ -727,9 +727,9 @@ static int cmpc_tablet_add(struct acpi_device *acpi)
 					   cmpc_tablet_idev_init);
 }
 
-static int cmpc_tablet_remove(struct acpi_device *acpi)
+static void cmpc_tablet_remove(struct acpi_device *acpi)
 {
-	return cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(acpi);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -974,7 +974,7 @@ static int cmpc_ipml_add(struct acpi_device *acpi)
 	return retval;
 }
 
-static int cmpc_ipml_remove(struct acpi_device *acpi)
+static void cmpc_ipml_remove(struct acpi_device *acpi)
 {
 	struct ipml200_dev *ipml;
 
@@ -988,8 +988,6 @@ static int cmpc_ipml_remove(struct acpi_device *acpi)
 	}
 
 	kfree(ipml);
-
-	return 0;
 }
 
 static const struct acpi_device_id cmpc_ipml_device_ids[] = {
@@ -1055,9 +1053,9 @@ static int cmpc_keys_add(struct acpi_device *acpi)
 					   cmpc_keys_idev_init);
 }
 
-static int cmpc_keys_remove(struct acpi_device *acpi)
+static void cmpc_keys_remove(struct acpi_device *acpi)
 {
-	return cmpc_remove_acpi_notify_device(acpi);
+	cmpc_remove_acpi_notify_device(acpi);
 }
 
 static const struct acpi_device_id cmpc_keys_device_ids[] = {
diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index a89fad47ff13..aa0e6c907494 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -206,7 +206,7 @@ static void rbtn_input_event(struct rbtn_data *rbtn_data)
  */
 
 static int rbtn_add(struct acpi_device *device);
-static int rbtn_remove(struct acpi_device *device);
+static void rbtn_remove(struct acpi_device *device);
 static void rbtn_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id rbtn_ids[] = {
@@ -426,7 +426,7 @@ static int rbtn_add(struct acpi_device *device)
 
 }
 
-static int rbtn_remove(struct acpi_device *device)
+static void rbtn_remove(struct acpi_device *device)
 {
 	struct rbtn_data *rbtn_data = device->driver_data;
 
@@ -443,8 +443,6 @@ static int rbtn_remove(struct acpi_device *device)
 
 	rbtn_acquire(device, false);
 	device->driver_data = NULL;
-
-	return 0;
 }
 
 static void rbtn_notify(struct acpi_device *device, u32 event)
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index a388a28b6f2a..62b71e8e3567 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1440,7 +1440,7 @@ static int eeepc_acpi_add(struct acpi_device *device)
 	return result;
 }
 
-static int eeepc_acpi_remove(struct acpi_device *device)
+static void eeepc_acpi_remove(struct acpi_device *device)
 {
 	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 
@@ -1451,7 +1451,6 @@ static int eeepc_acpi_remove(struct acpi_device *device)
 	eeepc_platform_exit(eeepc);
 
 	kfree(eeepc);
-	return 0;
 }
 
 
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index b543d117b12c..085e044e888e 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -847,15 +847,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_fujitsu_laptop_remove(struct acpi_device *device)
+static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
-
-	return 0;
 }
 
 static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 7fb7fe5eb55a..17f08ce7552d 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -484,12 +484,11 @@ static int acpi_fujitsu_add(struct acpi_device *adev)
 	return 0;
 }
 
-static int acpi_fujitsu_remove(struct acpi_device *adev)
+static void acpi_fujitsu_remove(struct acpi_device *adev)
 {
 	free_irq(fujitsu.irq, fujitsu_interrupt);
 	release_region(fujitsu.io_base, fujitsu.io_length);
 	input_fujitsu_remove();
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index 3b81cb896fed..35814a7707af 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -113,12 +113,10 @@ static int irst_add(struct acpi_device *acpi)
 	return error;
 }
 
-static int irst_remove(struct acpi_device *acpi)
+static void irst_remove(struct acpi_device *acpi)
 {
 	device_remove_file(&acpi->dev, &irst_wakeup_attr);
 	device_remove_file(&acpi->dev, &irst_timeout_attr);
-
-	return 0;
 }
 
 static const struct acpi_device_id irst_ids[] = {
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 332868b140ed..1452110d36ad 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -761,7 +761,7 @@ static int acpi_add(struct acpi_device *device)
 	return ret;
 }
 
-static int acpi_remove(struct acpi_device *device)
+static void acpi_remove(struct acpi_device *device)
 {
 	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
 
@@ -773,8 +773,6 @@ static int acpi_remove(struct acpi_device *device)
 	platform_device_unregister(pf_device);
 	pf_device = NULL;
 	platform_driver_unregister(&pf_driver);
-
-	return 0;
 }
 
 static const struct acpi_device_id device_ids[] = {
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index ad3083f9946d..cf845ee1c7b1 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -183,7 +183,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
 
 static int acpi_pcc_hotkey_add(struct acpi_device *device);
-static int acpi_pcc_hotkey_remove(struct acpi_device *device);
+static void acpi_pcc_hotkey_remove(struct acpi_device *device);
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id pcc_device_ids[] = {
@@ -1065,12 +1065,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	return result;
 }
 
-static int acpi_pcc_hotkey_remove(struct acpi_device *device)
+static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 {
 	struct pcc_acpi *pcc = acpi_driver_data(device);
 
 	if (!device || !pcc)
-		return -EINVAL;
+		return;
 
 	i8042_remove_filter(panasonic_i8042_filter);
 
@@ -1088,8 +1088,6 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
 
 	kfree(pcc->sinf);
 	kfree(pcc);
-
-	return 0;
 }
 
 module_acpi_driver(acpi_pcc_driver);
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 765fcaba4d12..a19aac70252f 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -3263,7 +3263,7 @@ static int sony_nc_add(struct acpi_device *device)
 	return result;
 }
 
-static int sony_nc_remove(struct acpi_device *device)
+static void sony_nc_remove(struct acpi_device *device)
 {
 	struct sony_nc_value *item;
 
@@ -3280,8 +3280,6 @@ static int sony_nc_remove(struct acpi_device *device)
 	sony_pf_remove();
 	sony_laptop_remove_input();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
-
-	return 0;
 }
 
 static const struct acpi_device_id sony_device_ids[] = {
@@ -4630,14 +4628,14 @@ static irqreturn_t sony_pic_irq(int irq, void *dev_id)
  *  ACPI driver
  *
  *****************/
-static int sony_pic_remove(struct acpi_device *device)
+static void sony_pic_remove(struct acpi_device *device)
 {
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
 
 	if (sony_pic_disable(device)) {
 		pr_err("Couldn't disable device\n");
-		return -ENXIO;
+		return;
 	}
 
 	free_irq(spic_dev.cur_irq->irq.interrupts[0], &spic_dev);
@@ -4667,7 +4665,6 @@ static int sony_pic_remove(struct acpi_device *device)
 	spic_dev.cur_irq = NULL;
 
 	dprintk(SONY_PIC_DRIVER_NAME " removed.\n");
-	return 0;
 }
 
 static int sony_pic_add(struct acpi_device *device)
diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 958df41ad509..52d94d8b1f25 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -744,7 +744,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 }
 
 // Remove a System76 ACPI device
-static int system76_remove(struct acpi_device *acpi_dev)
+static void system76_remove(struct acpi_device *acpi_dev)
 {
 	struct system76_data *data;
 
@@ -760,8 +760,6 @@ static int system76_remove(struct acpi_device *acpi_dev)
 	devm_led_classdev_unregister(&acpi_dev->dev, &data->kb_led);
 
 	system76_get(data, "FINI");
-
-	return 0;
 }
 
 static struct acpi_driver system76_driver = {
diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 6d18fbf8762b..20df1ebefc30 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -332,7 +332,7 @@ static int topstar_acpi_add(struct acpi_device *device)
 	return err;
 }
 
-static int topstar_acpi_remove(struct acpi_device *device)
+static void topstar_acpi_remove(struct acpi_device *device)
 {
 	struct topstar_laptop *topstar = acpi_driver_data(device);
 
@@ -344,7 +344,6 @@ static int topstar_acpi_remove(struct acpi_device *device)
 	topstar_acpi_exit(topstar);
 
 	kfree(topstar);
-	return 0;
 }
 
 static const struct acpi_device_id topstar_device_ids[] = {
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 160abd3b3af8..ce6a735b1abd 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3186,7 +3186,7 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 	pr_cont("\n");
 }
 
-static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
+static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
 
@@ -3234,8 +3234,6 @@ static int toshiba_acpi_remove(struct acpi_device *acpi_dev)
 		toshiba_acpi = NULL;
 
 	kfree(dev);
-
-	return 0;
 }
 
 static const char *find_hci_method(acpi_handle handle)
diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index 57a5dc60c58a..d8f81962a240 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -36,7 +36,7 @@ struct toshiba_bluetooth_dev {
 };
 
 static int toshiba_bt_rfkill_add(struct acpi_device *device);
-static int toshiba_bt_rfkill_remove(struct acpi_device *device);
+static void toshiba_bt_rfkill_remove(struct acpi_device *device);
 static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id bt_device_ids[] = {
@@ -279,7 +279,7 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	return result;
 }
 
-static int toshiba_bt_rfkill_remove(struct acpi_device *device)
+static void toshiba_bt_rfkill_remove(struct acpi_device *device)
 {
 	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
 
@@ -291,7 +291,7 @@ static int toshiba_bt_rfkill_remove(struct acpi_device *device)
 
 	kfree(bt_dev);
 
-	return toshiba_bluetooth_disable(device->handle);
+	toshiba_bluetooth_disable(device->handle);
 }
 
 module_acpi_driver(toshiba_bt_rfkill_driver);
diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index 49e84095bb01..8c9f76286b08 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -138,14 +138,12 @@ static void toshiba_haps_notify(struct acpi_device *device, u32 event)
 					event, 0);
 }
 
-static int toshiba_haps_remove(struct acpi_device *device)
+static void toshiba_haps_remove(struct acpi_device *device)
 {
 	sysfs_remove_group(&device->dev.kobj, &haps_attr_group);
 
 	if (toshiba_haps)
 		toshiba_haps = NULL;
-
-	return 0;
 }
 
 /* Helper function */
diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 11c60a273446..c64d9f084404 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -83,10 +83,9 @@ static int wl_add(struct acpi_device *device)
 	return err;
 }
 
-static int wl_remove(struct acpi_device *device)
+static void wl_remove(struct acpi_device *device)
 {
 	wireless_input_destroy();
-	return 0;
 }
 
 static struct acpi_driver wl_driver = {
diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 97440462aa25..391f7ea4431e 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -143,13 +143,12 @@ static int ebook_switch_add(struct acpi_device *device)
 	return error;
 }
 
-static int ebook_switch_remove(struct acpi_device *device)
+static void ebook_switch_remove(struct acpi_device *device)
 {
 	struct ebook_switch *button = acpi_driver_data(device);
 
 	input_unregister_device(button->input);
 	kfree(button);
-	return 0;
 }
 
 static struct acpi_driver xo15_ebook_driver = {
diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 5dca26e14bdc..0dcbabd1533d 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -101,10 +101,9 @@ static int ptp_vmw_acpi_add(struct acpi_device *device)
 	return 0;
 }
 
-static int ptp_vmw_acpi_remove(struct acpi_device *device)
+static void ptp_vmw_acpi_remove(struct acpi_device *device)
 {
 	ptp_clock_unregister(ptp_vmw_clock);
-	return 0;
 }
 
 static const struct acpi_device_id ptp_vmw_acpi_device_ids[] = {
diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 101d7e791a13..3f885b08a490 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -179,22 +179,20 @@ static int intel_menlow_memory_add(struct acpi_device *device)
 
 }
 
-static int intel_menlow_memory_remove(struct acpi_device *device)
+static void intel_menlow_memory_remove(struct acpi_device *device)
 {
 	struct thermal_cooling_device *cdev;
 
 	if (!device)
-		return -EINVAL;
+		return;
 
 	cdev = acpi_driver_data(device);
 	if (!cdev)
-		return -EINVAL;
+		return;
 
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&cdev->device.kobj, "device");
 	thermal_cooling_device_unregister(cdev);
-
-	return 0;
 }
 
 static const struct acpi_device_id intel_menlow_memory_ids[] = {
diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index c0d9339cff87..e9e7acb577bf 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -193,13 +193,12 @@ static int apple_bl_add(struct acpi_device *dev)
 	return 0;
 }
 
-static int apple_bl_remove(struct acpi_device *dev)
+static void apple_bl_remove(struct acpi_device *dev)
 {
 	backlight_device_unregister(apple_backlight_device);
 
 	release_region(hw_data->iostart, hw_data->iolen);
 	hw_data = NULL;
-	return 0;
 }
 
 static const struct acpi_device_id apple_bl_ids[] = {
diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
index 4cebad324b20..045bb72d9a43 100644
--- a/drivers/watchdog/ni903x_wdt.c
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -224,14 +224,12 @@ static int ni903x_acpi_add(struct acpi_device *device)
 	return 0;
 }
 
-static int ni903x_acpi_remove(struct acpi_device *device)
+static void ni903x_acpi_remove(struct acpi_device *device)
 {
 	struct ni903x_wdt *wdt = acpi_driver_data(device);
 
 	ni903x_wdd_stop(&wdt->wdd);
 	watchdog_unregister_device(&wdt->wdd);
-
-	return 0;
 }
 
 static const struct acpi_device_id ni903x_device_ids[] = {
diff --git a/drivers/xen/xen-acpi-pad.c b/drivers/xen/xen-acpi-pad.c
index ccd8012020f1..ede69a5278d3 100644
--- a/drivers/xen/xen-acpi-pad.c
+++ b/drivers/xen/xen-acpi-pad.c
@@ -122,7 +122,7 @@ static int acpi_pad_add(struct acpi_device *device)
 	return 0;
 }
 
-static int acpi_pad_remove(struct acpi_device *device)
+static void acpi_pad_remove(struct acpi_device *device)
 {
 	mutex_lock(&xen_cpu_lock);
 	xen_acpi_pad_idle_cpus(0);
@@ -130,7 +130,6 @@ static int acpi_pad_remove(struct acpi_device *device)
 
 	acpi_remove_notify_handler(device->handle,
 		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
-	return 0;
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c09d72986968..cd3b75e08ec3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -149,7 +149,7 @@ struct acpi_hotplug_context {
  */
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
-typedef int (*acpi_op_remove) (struct acpi_device * device);
+typedef void (*acpi_op_remove) (struct acpi_device *device);
 typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
 
 struct acpi_device_ops {
-- 
2.25.1

