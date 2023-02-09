Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDEF69085E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBIMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBIMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:55 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6A31E3A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:09:17 -0800 (PST)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 9 Feb 2023
 19:54:11 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] perf/amlogic: Fix config1/config2 parsing issue
Date:   Thu, 9 Feb 2023 19:54:01 +0800
Message-ID: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3th argument of for_each_set_bit is incorrect, fix them.

Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index b84346dbac2c..0b24dee1ed3c 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -156,10 +156,14 @@ static int meson_ddr_perf_event_add(struct perf_event *event, int flags)
 	u64 config2 = event->attr.config2;
 	int i;
 
-	for_each_set_bit(i, (const unsigned long *)&config1, sizeof(config1))
+	for_each_set_bit(i,
+			 (const unsigned long *)&config1,
+			 BITS_PER_TYPE(config1))
 		meson_ddr_set_axi_filter(event, i);
 
-	for_each_set_bit(i, (const unsigned long *)&config2, sizeof(config2))
+	for_each_set_bit(i,
+			 (const unsigned long *)&config2,
+			 BITS_PER_TYPE(config2))
 		meson_ddr_set_axi_filter(event, i + 64);
 
 	if (flags & PERF_EF_START)

base-commit: e8a709dc2a9156f223ec953ae70a919e87ad7e9a
-- 
2.25.1

