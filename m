Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DA69531B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjBMVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBMVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:35:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF21E1DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:35:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52eb75aeecdso132053577b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdJ1tp5BiJDNMQ/GqapnjMVMjw8EnE0csiFC8jjJC2g=;
        b=V2+l6S9gRQygVGZUYe2NQVc+BEkwO1tf//aHZaqJaL3ggrS1OqOqBYFcAc8wqnBP66
         Q2kgejB92NzRa020Ysx4Bw/uzGW4Riob0CdFI7GlTritQSNTE0AoYB7Si/dy7483pSDk
         tDpBqJg3EgsY4dpa36qtoyjRncfuy1NPeTsUKo9viC+eFT4gLEJnC/t1lXA9jnqwhwui
         AsLZIk1jCHuAdUNg/LH3puvP93GudCrUEJu/rADnaRUVfGe1cKLCJvGtXqAjZBKAI/l8
         V9DMIZgPPi+fgqghdQHRFz2HfFeGe9nn8QvldpWW+eFVv9cu/7MFuf4+S4mseH++IgB5
         Kmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdJ1tp5BiJDNMQ/GqapnjMVMjw8EnE0csiFC8jjJC2g=;
        b=6Kq6TbcQuZOBCTTLUod6Rf4yQjhndWQ/ixNcZz87F/7ZGGeplPf+IxXKOoaZhmiEGP
         NiGRAm9M32e1nG2/JFX63qwiOW0IF9UgBmEi6WBaVKPPHAsa55KqsEXJJHzpjXbmov1M
         3wCBHccau4T+2VT3AdibQIAIlMZhPNSKm7HBGFGPsukLLO7Poe3Orqkc1vDWt+POD4hD
         kiwSp3crg6rxjJn6V2szaEvZ2MNSf3j8dCUGW1zpUMo8EJFsTFCbB+9ehzVEAZm0Qyrh
         alWppqfdorlKT1/lxnYenfo2X+HM7OSbBvTJ7X1KxfGdsKHFbrQP73dnrqOdt16JzcNU
         NiVQ==
X-Gm-Message-State: AO0yUKX1KgG5I5pXRUJUyotZJgLTT+XtXZaxlZkqXGWmtcYZz2WAnV1j
        gTjQMZL36BsaYpembdswQHA1aE5TvdI48yoL
X-Google-Smtp-Source: AK7set/HyoEf9l5BGdwVOVkiiAUolD7hmC4qPLzSRYdjMWQNdQVGPD9teOVoWC4bkjYoyvnoQShpLOyegrh1CiRf
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a81:5f83:0:b0:502:2e7:f7be with SMTP id
 t125-20020a815f83000000b0050202e7f7bemr3401127ywb.30.1676324126092; Mon, 13
 Feb 2023 13:35:26 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:35:21 -0500
In-Reply-To: <lkp@intel.com>
Mime-Version: 1.0
References: <lkp@intel.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213213521.747253-1-zenghuchen@google.com>
Subject: [PATCH v2] i3c: update dw-i3c-master i3c_clk_cfg function
From:   Jack Chen <zenghuchen@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Replace max with max_t.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302140331.EVRBei1L-lkp@intel.com/

Tested: tested with an i3c sensor and captured with a logic analyzer.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
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
2.39.1.581.gbfd45094c4-goog

