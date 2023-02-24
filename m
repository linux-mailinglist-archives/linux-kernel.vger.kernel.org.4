Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA226A14BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBXCAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:00:19 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1D1CADC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:00:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VcLwzdB_1677203996;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VcLwzdB_1677203996)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 10:00:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] drm/gma500: Clean up some inconsistent indenting
Date:   Fri, 24 Feb 2023 09:59:54 +0800
Message-Id: <20230224015954.68974-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/gpu/drm/gma500/cdv_device.c:218 cdv_errata() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4126
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Change the subject.

 drivers/gpu/drm/gma500/cdv_device.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 3e83299113e3..1349ea787ae7 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -78,7 +78,8 @@ static u32 cdv_get_max_backlight(struct drm_device *dev)
 	if (max == 0) {
 		DRM_DEBUG_KMS("LVDS Panel PWM value is 0!\n");
 		/* i915 does this, I believe which means that we should not
-		 * smash PWM control as firmware will take control of it. */
+		 * smash PWM control as firmware will take control of it.
+		 */
 		return 1;
 	}
 
@@ -149,6 +150,7 @@ static inline u32 CDV_MSG_READ32(int domain, uint port, uint offset)
 	int mcr = (0x10<<24) | (port << 16) | (offset << 8);
 	uint32_t ret_val = 0;
 	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
+
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_read_config_dword(pci_root, 0xD4, &ret_val);
 	pci_dev_put(pci_root);
@@ -160,6 +162,7 @@ static inline void CDV_MSG_WRITE32(int domain, uint port, uint offset,
 {
 	int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
 	struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
+
 	pci_write_config_dword(pci_root, 0xD4, value);
 	pci_write_config_dword(pci_root, 0xD0, mcr);
 	pci_dev_put(pci_root);
@@ -180,10 +183,8 @@ static void cdv_init_pm(struct drm_device *dev)
 	int domain = pci_domain_nr(pdev->bus);
 	int i;
 
-	dev_priv->apm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
-							PSB_APMBA) & 0xFFFF;
-	dev_priv->ospm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
-							PSB_OSPMBA) & 0xFFFF;
+	dev_priv->apm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT, PSB_APMBA) & 0xFFFF;
+	dev_priv->ospm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT, PSB_OSPMBA) & 0xFFFF;
 
 	/* Power status */
 	pwr_cnt = inl(dev_priv->apm_base + PSB_APM_CMD);
@@ -196,6 +197,7 @@ static void cdv_init_pm(struct drm_device *dev)
 	/* Wait for the GPU power */
 	for (i = 0; i < 5; i++) {
 		u32 pwr_sts = inl(dev_priv->apm_base + PSB_APM_STS);
+
 		if ((pwr_sts & PSB_PWRGT_GFX_MASK) == 0)
 			return;
 		udelay(10);
@@ -215,7 +217,7 @@ static void cdv_errata(struct drm_device *dev)
 	 *	Bonus Launch to work around the issue, by degrading
 	 *	performance.
 	 */
-	 CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
+	CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
 }
 
 /**
@@ -401,20 +403,22 @@ static int cdv_power_up(struct drm_device *dev)
 
 static void cdv_hotplug_work_func(struct work_struct *work)
 {
-        struct drm_psb_private *dev_priv = container_of(work, struct drm_psb_private,
+	struct drm_psb_private *dev_priv = container_of(work, struct drm_psb_private,
 							hotplug_work);
 	struct drm_device *dev = &dev_priv->dev;
 
-        /* Just fire off a uevent and let userspace tell us what to do */
-        drm_helper_hpd_irq_event(dev);
+	/* Just fire off a uevent and let userspace tell us what to do */
+	drm_helper_hpd_irq_event(dev);
 }
 
 /* The core driver has received a hotplug IRQ. We are in IRQ context
-   so extract the needed information and kick off queued processing */
+ * so extract the needed information and kick off queued processing
+ */
 
 static int cdv_hotplug_event(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
+
 	schedule_work(&dev_priv->hotplug_work);
 	REG_WRITE(PORT_HOTPLUG_STAT, REG_READ(PORT_HOTPLUG_STAT));
 	return 1;
@@ -424,6 +428,7 @@ static void cdv_hotplug_enable(struct drm_device *dev, bool on)
 {
 	if (on) {
 		u32 hotplug = REG_READ(PORT_HOTPLUG_EN);
+
 		hotplug |= HDMIB_HOTPLUG_INT_EN | HDMIC_HOTPLUG_INT_EN |
 			   HDMID_HOTPLUG_INT_EN | CRT_HOTPLUG_INT_EN;
 		REG_WRITE(PORT_HOTPLUG_EN, hotplug);
@@ -549,6 +554,7 @@ static const struct psb_offset cdv_regmap[2] = {
 static int cdv_chip_setup(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
+
 	INIT_WORK(&dev_priv->hotplug_work, cdv_hotplug_work_func);
 
 	dev_priv->use_msi = true;
-- 
2.20.1.7.g153144c

