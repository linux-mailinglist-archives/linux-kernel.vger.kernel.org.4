Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523E6699876
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBPPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBPPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:11:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69C86B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:11:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5339cd92124so7718457b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qqMGnRjZj67H+uo/a7kB+5tYajP931OKisC+PcDlIto=;
        b=H+7jbbNtNvxP239FK+id+MguHSSyGo2wTrvtY9DDS0YNvTi2vK1PYnwq4u0t2aUz27
         VuZALewfZHlf7Iw22G+iTM/KiJZ3/MvkLEp/ANWkO7KkWLCAKjMgaoDFR3P+dEefVYiw
         LRx4EA4DIlnY2NRgdUoDo4+Q0lyxd0jZct5acbtithq61ldynvyN4Fg4IrGT84wzaPbZ
         xh9+ci6UuhPoL6KjcwwToZjI2Zu1j6DJeqHIUtkAJ0m5unNIy3PT//8dsLnkkZJ/0J9c
         3EUKBtYX8JzHkrp+ZEevQeb6O5PHhpJfZ3SmzF8PlAugTnwiVgyQuP8xN7qiJ9rFYzeD
         ePDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqMGnRjZj67H+uo/a7kB+5tYajP931OKisC+PcDlIto=;
        b=mOeLse/Kg5bLdlx2l0c7roQP0hBrt6ZX93mdWTEoFUEswQwkRqFkTRMAgbfp2LE1mu
         oITlP7pvm9rxqm6sLej9h7WkVY6vxzifdwLFCVEzs9TYBCY1yHERsT1g/BB0K3fW1eYn
         hyXKZx/X2J6nbR5DXfDmj1s2Miesln3vvi2nbXEPmfFWuclhEIzf0sMeEdFWpKLccLM9
         eYvtDB4Y9uYDhhnB9SBcqvp0YknS/6gpdbrG707M36hRcVtO8Ggi3/IZkC+CbhE1Hvej
         4XmC5adSnhjetStnHQC2SOstiaI225p42/ox9gsKNc/laTazjCFVZ1udD5oGWRYbqm+b
         Zk5Q==
X-Gm-Message-State: AO0yUKU1TS2/9LEboiStBuCQ7AhQRGMcRfJ54FNlTSZF4qIEuq3ubHFC
        0I9ZCuAk2QE3CPigQX4X+ylPqHdqPGka1oM9
X-Google-Smtp-Source: AK7set9X88/pH1hQHbIhksYYJvB721b36NsXG60z78UMXCaavH1Nz2n8Mx60CJfndOiBASHbzp6vqRzikm6KKLh0
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a81:ac60:0:b0:52e:bb8a:1cc4 with SMTP
 id z32-20020a81ac60000000b0052ebb8a1cc4mr8ywj.6.1676560260836; Thu, 16 Feb
 2023 07:11:00 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:10:57 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230216151057.293764-1-zenghuchen@google.com>
Subject: [PATCH v3] i3c: update dw-i3c-master i3c_clk_cfg function
From:   Jack Chen <zenghuchen@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus-speed could be default(12.5MHz) or defined by users in dts.
Dw-i3c-master should not hard-code the initial speed to be
I3C_BUS_TYP_I3C_SCL_RATE (12.5MHz)
And because of Synopsys's I3C controller limit (hcnt/lcnt register
length) and core-clk provided, there is a limit to bus speed, too.
For example, when core-clk is 250 MHz, the bus speed cannot be
lowered below 1MHz.

Tested: tested with an i3c sensor and captured with a logic analyzer.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
[v3]
- change the target tree to be i3c/next
[v2]
- replace max with max_t

 drivers/i3c/master/dw-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 51a8608203de..48954d3e6571 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -531,7 +531,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
-	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
+	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
 
@@ -541,7 +541,8 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
 		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
 
-	lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
+	lcnt = max_t(u8,
+		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
-- 
2.39.2.637.g21b0678d19-goog

