Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8964604BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJSPmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiJSPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:41:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C861D73DB;
        Wed, 19 Oct 2022 08:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE80B8208E;
        Wed, 19 Oct 2022 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5239C433C1;
        Wed, 19 Oct 2022 15:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193796;
        bh=TDF8oIAMEbi4CFvjgKI3qLPQ+Vabvk3nCCH3fyp15aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPxiRxJKjZ2K8MR+MgSruYrNZ0qKnTPjjy2ci9kg54tHTaFmXFkQ58o3qEpo2DVBq
         H7WR5nVl5j/iUON1V3J+w8kNQaqHPqTNdNLsyi8+8G9nI2Nan3E01iGv7IVfeE0ud8
         JGH/Bv9DOvI0ViVaMNiAvz+pwbpKiCxPxf2jBHO4lys1XUhVQlWMtbXGNZR5uQ54IL
         rMFaf9YZlrSf0stNIPICtSbrIxhbMY7AmyKhcnF40Sn3XehWWj1MOU8kE5NOWCXYqK
         U7WshuOQ+2gmSL5FW5FHmyVyF/SUomGo8GLAs1N165yo8rtmamU3BYP/73nlUP6mUo
         lDCJLx28OatBg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org
Subject: [PATCH 08/14] rtc: remove davinci rtc driver
Date:   Wed, 19 Oct 2022 17:29:34 +0200
Message-Id: <20221019152947.3857217-9-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The Davinci dm365 SoC support was removed, so the rtc driver
has no remaining users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig       |  10 -
 drivers/rtc/Makefile      |   1 -
 drivers/rtc/rtc-davinci.c | 512 --------------------------------------
 3 files changed, 523 deletions(-)
 delete mode 100644 drivers/rtc/rtc-davinci.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 35298c651730..ab9a1f814119 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1345,16 +1345,6 @@ config RTC_DRV_ASM9260
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-asm9260.
 
-config RTC_DRV_DAVINCI
-	tristate "TI DaVinci RTC"
-	depends on ARCH_DAVINCI_DM365 || COMPILE_TEST
-	help
-	  If you say yes here you get support for the RTC on the
-	  DaVinci platforms (DM365).
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-davinci.
-
 config RTC_DRV_DIGICOLOR
 	tristate "Conexant Digicolor RTC"
 	depends on ARCH_DIGICOLOR || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index c2d474985919..d3c042dcbc73 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
 obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
 obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
 obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
-obj-$(CONFIG_RTC_DRV_DAVINCI)	+= rtc-davinci.o
 obj-$(CONFIG_RTC_DRV_DIGICOLOR)	+= rtc-digicolor.o
 obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
 obj-$(CONFIG_RTC_DRV_DS1286)	+= rtc-ds1286.o
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
deleted file mode 100644
index 6bef0f2353da..000000000000
--- a/drivers/rtc/rtc-davinci.c
+++ /dev/null
@@ -1,512 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DaVinci Power Management and Real Time Clock Driver for TI platforms
- *
- * Copyright (C) 2009 Texas Instruments, Inc
- *
- * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-/*
- * The DaVinci RTC is a simple RTC with the following
- * Sec: 0 - 59 : BCD count
- * Min: 0 - 59 : BCD count
- * Hour: 0 - 23 : BCD count
- * Day: 0 - 0x7FFF(32767) : Binary count ( Over 89 years )
- */
-
-/* PRTC interface registers */
-#define DAVINCI_PRTCIF_PID		0x00
-#define PRTCIF_CTLR			0x04
-#define PRTCIF_LDATA			0x08
-#define PRTCIF_UDATA			0x0C
-#define PRTCIF_INTEN			0x10
-#define PRTCIF_INTFLG			0x14
-
-/* PRTCIF_CTLR bit fields */
-#define PRTCIF_CTLR_BUSY		BIT(31)
-#define PRTCIF_CTLR_SIZE		BIT(25)
-#define PRTCIF_CTLR_DIR			BIT(24)
-#define PRTCIF_CTLR_BENU_MSB		BIT(23)
-#define PRTCIF_CTLR_BENU_3RD_BYTE	BIT(22)
-#define PRTCIF_CTLR_BENU_2ND_BYTE	BIT(21)
-#define PRTCIF_CTLR_BENU_LSB		BIT(20)
-#define PRTCIF_CTLR_BENU_MASK		(0x00F00000)
-#define PRTCIF_CTLR_BENL_MSB		BIT(19)
-#define PRTCIF_CTLR_BENL_3RD_BYTE	BIT(18)
-#define PRTCIF_CTLR_BENL_2ND_BYTE	BIT(17)
-#define PRTCIF_CTLR_BENL_LSB		BIT(16)
-#define PRTCIF_CTLR_BENL_MASK		(0x000F0000)
-
-/* PRTCIF_INTEN bit fields */
-#define PRTCIF_INTEN_RTCSS		BIT(1)
-#define PRTCIF_INTEN_RTCIF		BIT(0)
-#define PRTCIF_INTEN_MASK		(PRTCIF_INTEN_RTCSS \
-					| PRTCIF_INTEN_RTCIF)
-
-/* PRTCIF_INTFLG bit fields */
-#define PRTCIF_INTFLG_RTCSS		BIT(1)
-#define PRTCIF_INTFLG_RTCIF		BIT(0)
-#define PRTCIF_INTFLG_MASK		(PRTCIF_INTFLG_RTCSS \
-					| PRTCIF_INTFLG_RTCIF)
-
-/* PRTC subsystem registers */
-#define PRTCSS_RTC_INTC_EXTENA1		(0x0C)
-#define PRTCSS_RTC_CTRL			(0x10)
-#define PRTCSS_RTC_WDT			(0x11)
-#define PRTCSS_RTC_TMR0			(0x12)
-#define PRTCSS_RTC_TMR1			(0x13)
-#define PRTCSS_RTC_CCTRL		(0x14)
-#define PRTCSS_RTC_SEC			(0x15)
-#define PRTCSS_RTC_MIN			(0x16)
-#define PRTCSS_RTC_HOUR			(0x17)
-#define PRTCSS_RTC_DAY0			(0x18)
-#define PRTCSS_RTC_DAY1			(0x19)
-#define PRTCSS_RTC_AMIN			(0x1A)
-#define PRTCSS_RTC_AHOUR		(0x1B)
-#define PRTCSS_RTC_ADAY0		(0x1C)
-#define PRTCSS_RTC_ADAY1		(0x1D)
-#define PRTCSS_RTC_CLKC_CNT		(0x20)
-
-/* PRTCSS_RTC_INTC_EXTENA1 */
-#define PRTCSS_RTC_INTC_EXTENA1_MASK	(0x07)
-
-/* PRTCSS_RTC_CTRL bit fields */
-#define PRTCSS_RTC_CTRL_WDTBUS		BIT(7)
-#define PRTCSS_RTC_CTRL_WEN		BIT(6)
-#define PRTCSS_RTC_CTRL_WDRT		BIT(5)
-#define PRTCSS_RTC_CTRL_WDTFLG		BIT(4)
-#define PRTCSS_RTC_CTRL_TE		BIT(3)
-#define PRTCSS_RTC_CTRL_TIEN		BIT(2)
-#define PRTCSS_RTC_CTRL_TMRFLG		BIT(1)
-#define PRTCSS_RTC_CTRL_TMMD		BIT(0)
-
-/* PRTCSS_RTC_CCTRL bit fields */
-#define PRTCSS_RTC_CCTRL_CALBUSY	BIT(7)
-#define PRTCSS_RTC_CCTRL_DAEN		BIT(5)
-#define PRTCSS_RTC_CCTRL_HAEN		BIT(4)
-#define PRTCSS_RTC_CCTRL_MAEN		BIT(3)
-#define PRTCSS_RTC_CCTRL_ALMFLG		BIT(2)
-#define PRTCSS_RTC_CCTRL_AIEN		BIT(1)
-#define PRTCSS_RTC_CCTRL_CAEN		BIT(0)
-
-static DEFINE_SPINLOCK(davinci_rtc_lock);
-
-struct davinci_rtc {
-	struct rtc_device		*rtc;
-	void __iomem			*base;
-	int				irq;
-};
-
-static inline void rtcif_write(struct davinci_rtc *davinci_rtc,
-			       u32 val, u32 addr)
-{
-	writel(val, davinci_rtc->base + addr);
-}
-
-static inline u32 rtcif_read(struct davinci_rtc *davinci_rtc, u32 addr)
-{
-	return readl(davinci_rtc->base + addr);
-}
-
-static inline void rtcif_wait(struct davinci_rtc *davinci_rtc)
-{
-	while (rtcif_read(davinci_rtc, PRTCIF_CTLR) & PRTCIF_CTLR_BUSY)
-		cpu_relax();
-}
-
-static inline void rtcss_write(struct davinci_rtc *davinci_rtc,
-			       unsigned long val, u8 addr)
-{
-	rtcif_wait(davinci_rtc);
-
-	rtcif_write(davinci_rtc, PRTCIF_CTLR_BENL_LSB | addr, PRTCIF_CTLR);
-	rtcif_write(davinci_rtc, val, PRTCIF_LDATA);
-
-	rtcif_wait(davinci_rtc);
-}
-
-static inline u8 rtcss_read(struct davinci_rtc *davinci_rtc, u8 addr)
-{
-	rtcif_wait(davinci_rtc);
-
-	rtcif_write(davinci_rtc, PRTCIF_CTLR_DIR | PRTCIF_CTLR_BENL_LSB | addr,
-		    PRTCIF_CTLR);
-
-	rtcif_wait(davinci_rtc);
-
-	return rtcif_read(davinci_rtc, PRTCIF_LDATA);
-}
-
-static inline void davinci_rtcss_calendar_wait(struct davinci_rtc *davinci_rtc)
-{
-	while (rtcss_read(davinci_rtc, PRTCSS_RTC_CCTRL) &
-	       PRTCSS_RTC_CCTRL_CALBUSY)
-		cpu_relax();
-}
-
-static irqreturn_t davinci_rtc_interrupt(int irq, void *class_dev)
-{
-	struct davinci_rtc *davinci_rtc = class_dev;
-	unsigned long events = 0;
-	u32 irq_flg;
-	u8 alm_irq, tmr_irq;
-	u8 rtc_ctrl, rtc_cctrl;
-	int ret = IRQ_NONE;
-
-	irq_flg = rtcif_read(davinci_rtc, PRTCIF_INTFLG) &
-		  PRTCIF_INTFLG_RTCSS;
-
-	alm_irq = rtcss_read(davinci_rtc, PRTCSS_RTC_CCTRL) &
-		  PRTCSS_RTC_CCTRL_ALMFLG;
-
-	tmr_irq = rtcss_read(davinci_rtc, PRTCSS_RTC_CTRL) &
-		  PRTCSS_RTC_CTRL_TMRFLG;
-
-	if (irq_flg) {
-		if (alm_irq) {
-			events |= RTC_IRQF | RTC_AF;
-			rtc_cctrl = rtcss_read(davinci_rtc, PRTCSS_RTC_CCTRL);
-			rtc_cctrl |=  PRTCSS_RTC_CCTRL_ALMFLG;
-			rtcss_write(davinci_rtc, rtc_cctrl, PRTCSS_RTC_CCTRL);
-		} else if (tmr_irq) {
-			events |= RTC_IRQF | RTC_PF;
-			rtc_ctrl = rtcss_read(davinci_rtc, PRTCSS_RTC_CTRL);
-			rtc_ctrl |=  PRTCSS_RTC_CTRL_TMRFLG;
-			rtcss_write(davinci_rtc, rtc_ctrl, PRTCSS_RTC_CTRL);
-		}
-
-		rtcif_write(davinci_rtc, PRTCIF_INTFLG_RTCSS,
-				    PRTCIF_INTFLG);
-		rtc_update_irq(davinci_rtc->rtc, 1, events);
-
-		ret = IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
-static int
-davinci_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	u8 rtc_ctrl;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	rtc_ctrl = rtcss_read(davinci_rtc, PRTCSS_RTC_CTRL);
-
-	switch (cmd) {
-	case RTC_WIE_ON:
-		rtc_ctrl |= PRTCSS_RTC_CTRL_WEN | PRTCSS_RTC_CTRL_WDTFLG;
-		break;
-	case RTC_WIE_OFF:
-		rtc_ctrl &= ~PRTCSS_RTC_CTRL_WEN;
-		break;
-	default:
-		ret = -ENOIOCTLCMD;
-	}
-
-	rtcss_write(davinci_rtc, rtc_ctrl, PRTCSS_RTC_CTRL);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-
-	return ret;
-}
-
-static void convertfromdays(u16 days, struct rtc_time *tm)
-{
-	int tmp_days, year, mon;
-
-	for (year = 2000;; year++) {
-		tmp_days = rtc_year_days(1, 12, year);
-		if (days >= tmp_days)
-			days -= tmp_days;
-		else {
-			for (mon = 0;; mon++) {
-				tmp_days = rtc_month_days(mon, year);
-				if (days >= tmp_days) {
-					days -= tmp_days;
-				} else {
-					tm->tm_year = year - 1900;
-					tm->tm_mon = mon;
-					tm->tm_mday = days + 1;
-					break;
-				}
-			}
-			break;
-		}
-	}
-}
-
-static void convert2days(u16 *days, struct rtc_time *tm)
-{
-	int i;
-	*days = 0;
-
-	for (i = 2000; i < 1900 + tm->tm_year; i++)
-		*days += rtc_year_days(1, 12, i);
-
-	*days += rtc_year_days(tm->tm_mday, tm->tm_mon, 1900 + tm->tm_year);
-}
-
-static int davinci_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	u16 days = 0;
-	u8 day0, day1;
-	unsigned long flags;
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	tm->tm_sec = bcd2bin(rtcss_read(davinci_rtc, PRTCSS_RTC_SEC));
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	tm->tm_min = bcd2bin(rtcss_read(davinci_rtc, PRTCSS_RTC_MIN));
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	tm->tm_hour = bcd2bin(rtcss_read(davinci_rtc, PRTCSS_RTC_HOUR));
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	day0 = rtcss_read(davinci_rtc, PRTCSS_RTC_DAY0);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	day1 = rtcss_read(davinci_rtc, PRTCSS_RTC_DAY1);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-
-	days |= day1;
-	days <<= 8;
-	days |= day0;
-
-	convertfromdays(days, tm);
-
-	return 0;
-}
-
-static int davinci_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	u16 days;
-	u8 rtc_cctrl;
-	unsigned long flags;
-
-	convert2days(&days, tm);
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, bin2bcd(tm->tm_sec), PRTCSS_RTC_SEC);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, bin2bcd(tm->tm_min), PRTCSS_RTC_MIN);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, bin2bcd(tm->tm_hour), PRTCSS_RTC_HOUR);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, days & 0xFF, PRTCSS_RTC_DAY0);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, (days & 0xFF00) >> 8, PRTCSS_RTC_DAY1);
-
-	rtc_cctrl = rtcss_read(davinci_rtc, PRTCSS_RTC_CCTRL);
-	rtc_cctrl |= PRTCSS_RTC_CCTRL_CAEN;
-	rtcss_write(davinci_rtc, rtc_cctrl, PRTCSS_RTC_CCTRL);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-
-	return 0;
-}
-
-static int davinci_rtc_alarm_irq_enable(struct device *dev,
-					unsigned int enabled)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	unsigned long flags;
-	u8 rtc_cctrl = rtcss_read(davinci_rtc, PRTCSS_RTC_CCTRL);
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	if (enabled)
-		rtc_cctrl |= PRTCSS_RTC_CCTRL_DAEN |
-			     PRTCSS_RTC_CCTRL_HAEN |
-			     PRTCSS_RTC_CCTRL_MAEN |
-			     PRTCSS_RTC_CCTRL_ALMFLG |
-			     PRTCSS_RTC_CCTRL_AIEN;
-	else
-		rtc_cctrl &= ~PRTCSS_RTC_CCTRL_AIEN;
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, rtc_cctrl, PRTCSS_RTC_CCTRL);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-
-	return 0;
-}
-
-static int davinci_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	u16 days = 0;
-	u8 day0, day1;
-	unsigned long flags;
-
-	alm->time.tm_sec = 0;
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	alm->time.tm_min = bcd2bin(rtcss_read(davinci_rtc, PRTCSS_RTC_AMIN));
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	alm->time.tm_hour = bcd2bin(rtcss_read(davinci_rtc, PRTCSS_RTC_AHOUR));
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	day0 = rtcss_read(davinci_rtc, PRTCSS_RTC_ADAY0);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	day1 = rtcss_read(davinci_rtc, PRTCSS_RTC_ADAY1);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-	days |= day1;
-	days <<= 8;
-	days |= day0;
-
-	convertfromdays(days, &alm->time);
-
-	alm->pending = !!(rtcss_read(davinci_rtc,
-			  PRTCSS_RTC_CCTRL) &
-			PRTCSS_RTC_CCTRL_AIEN);
-	alm->enabled = alm->pending && device_may_wakeup(dev);
-
-	return 0;
-}
-
-static int davinci_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	struct davinci_rtc *davinci_rtc = dev_get_drvdata(dev);
-	unsigned long flags;
-	u16 days;
-
-	convert2days(&days, &alm->time);
-
-	spin_lock_irqsave(&davinci_rtc_lock, flags);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, bin2bcd(alm->time.tm_min), PRTCSS_RTC_AMIN);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, bin2bcd(alm->time.tm_hour), PRTCSS_RTC_AHOUR);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, days & 0xFF, PRTCSS_RTC_ADAY0);
-
-	davinci_rtcss_calendar_wait(davinci_rtc);
-	rtcss_write(davinci_rtc, (days & 0xFF00) >> 8, PRTCSS_RTC_ADAY1);
-
-	spin_unlock_irqrestore(&davinci_rtc_lock, flags);
-
-	return 0;
-}
-
-static const struct rtc_class_ops davinci_rtc_ops = {
-	.ioctl			= davinci_rtc_ioctl,
-	.read_time		= davinci_rtc_read_time,
-	.set_time		= davinci_rtc_set_time,
-	.alarm_irq_enable	= davinci_rtc_alarm_irq_enable,
-	.read_alarm		= davinci_rtc_read_alarm,
-	.set_alarm		= davinci_rtc_set_alarm,
-};
-
-static int __init davinci_rtc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct davinci_rtc *davinci_rtc;
-	int ret = 0;
-
-	davinci_rtc = devm_kzalloc(&pdev->dev, sizeof(struct davinci_rtc), GFP_KERNEL);
-	if (!davinci_rtc)
-		return -ENOMEM;
-
-	davinci_rtc->irq = platform_get_irq(pdev, 0);
-	if (davinci_rtc->irq < 0)
-		return davinci_rtc->irq;
-
-	davinci_rtc->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(davinci_rtc->base))
-		return PTR_ERR(davinci_rtc->base);
-
-	platform_set_drvdata(pdev, davinci_rtc);
-
-	davinci_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(davinci_rtc->rtc))
-		return PTR_ERR(davinci_rtc->rtc);
-
-	davinci_rtc->rtc->ops = &davinci_rtc_ops;
-	davinci_rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	davinci_rtc->rtc->range_max = RTC_TIMESTAMP_BEGIN_2000 + (1 << 16) * 86400ULL - 1;
-
-	rtcif_write(davinci_rtc, PRTCIF_INTFLG_RTCSS, PRTCIF_INTFLG);
-	rtcif_write(davinci_rtc, 0, PRTCIF_INTEN);
-	rtcss_write(davinci_rtc, 0, PRTCSS_RTC_INTC_EXTENA1);
-
-	rtcss_write(davinci_rtc, 0, PRTCSS_RTC_CTRL);
-	rtcss_write(davinci_rtc, 0, PRTCSS_RTC_CCTRL);
-
-	ret = devm_request_irq(dev, davinci_rtc->irq, davinci_rtc_interrupt,
-			  0, "davinci_rtc", davinci_rtc);
-	if (ret < 0) {
-		dev_err(dev, "unable to register davinci RTC interrupt\n");
-		return ret;
-	}
-
-	/* Enable interrupts */
-	rtcif_write(davinci_rtc, PRTCIF_INTEN_RTCSS, PRTCIF_INTEN);
-	rtcss_write(davinci_rtc, PRTCSS_RTC_INTC_EXTENA1_MASK,
-			    PRTCSS_RTC_INTC_EXTENA1);
-
-	rtcss_write(davinci_rtc, PRTCSS_RTC_CCTRL_CAEN, PRTCSS_RTC_CCTRL);
-
-	device_init_wakeup(&pdev->dev, 0);
-
-	return devm_rtc_register_device(davinci_rtc->rtc);
-}
-
-static int __exit davinci_rtc_remove(struct platform_device *pdev)
-{
-	struct davinci_rtc *davinci_rtc = platform_get_drvdata(pdev);
-
-	device_init_wakeup(&pdev->dev, 0);
-
-	rtcif_write(davinci_rtc, 0, PRTCIF_INTEN);
-
-	return 0;
-}
-
-static struct platform_driver davinci_rtc_driver = {
-	.remove		= __exit_p(davinci_rtc_remove),
-	.driver		= {
-		.name = "rtc_davinci",
-	},
-};
-
-module_platform_driver_probe(davinci_rtc_driver, davinci_rtc_probe);
-
-MODULE_AUTHOR("Miguel Aguilar <miguel.aguilar@ridgerun.com>");
-MODULE_DESCRIPTION("Texas Instruments DaVinci PRTC Driver");
-MODULE_LICENSE("GPL");
-- 
2.29.2

