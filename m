Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF576947EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMOX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBMOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:23:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739841BADC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:23:42 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527501b56ffso126329317b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rf82oeWSzSebi3IHp7/wkO0XHFRaK53Tm2VM8FWyfpg=;
        b=qzJ7QTEAVcRVLK5NckA901iN36ArQHM4M0Sq0IzXirHuWnll0LaM8ErpVF/2D3kD48
         MBEimYFNhTy0BzEgguDsVSzlCAp03NYKleXUiPbtSqHsem1cypMtFXnC4+e7JVoXbF2D
         PdFSMH57wCqcpHqmCObRE5xeLUAASLW3HCfo8QsjqCLdraydB8MBbfesVi8zWMf2hQYz
         lmWla0gmawYxttmLG4NBSyAglLSM0YWpkp7+QZV+DS/RSuHb7im79VxsY+MiBGdcdB0C
         sCPWI6jWIv5+956hymM9hgniFnQ1VvUADG3rRK019YyqRoNdbi+dxNHmj/LS9MtblGKJ
         JJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rf82oeWSzSebi3IHp7/wkO0XHFRaK53Tm2VM8FWyfpg=;
        b=s6MHWjS8RPlB2ddm54e9Z9AhrKmPvtnspfQYH0z4oUZ5pbi4wk4SneFVscdhKByEMv
         q2fN1gO3dFBZdmRu9y4l9+/4YOMk9X+NdGlRonZTm/fExK0GXLRm8jeb+bGEWDq69Wtg
         5pQ2JUizxbgAqnLJnGV+Rgztq4p7XVjXLUnziY8MNRDuDC3QhYgL2Fpv6UVeLdtqCoUK
         BjJiY+rxlRe9k5Cpx2sIUCeJMl4TiAfmf6SXGp5EBSRk/xc2Vf221P0/F+sD1SwyVs3z
         40hvT4HL038dCh1t8d5yh85U/fcFYz0OBlT8BkupOADxY/MQzlPTz3/LDB3ZTdnfkgfm
         hLjA==
X-Gm-Message-State: AO0yUKVPPfBhp2Z17/W3IVUtiE7MK91Or5yWvJXx1qIvSiZ01zJdWlNl
        CCxQS0VGnga+KXYz9NrpNhPYk9fyfVyvh/TZ
X-Google-Smtp-Source: AK7set8FmsJJMsM5suVqjMsUc0r7FwqRyr9mNaESFAoJVdgM6RFzvANx7m43zjLLnU3Cxl5lTmho9BneqJUQ/ynK
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a81:4b91:0:b0:52e:d81f:1763 with SMTP
 id y139-20020a814b91000000b0052ed81f1763mr13ywa.9.1676298221058; Mon, 13 Feb
 2023 06:23:41 -0800 (PST)
Date:   Mon, 13 Feb 2023 09:23:36 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213142336.192875-1-zenghuchen@google.com>
Subject: [PATCH] i3c: update dw-i3c-master i3c_clk_cfg function
From:   Jack Chen <zenghuchen@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>
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

Tested: tested with an i3c sensor and captured with a logic analyzer.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 51a8608203de..13309dde1518 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -531,7 +531,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
-	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_TYP_I3C_SCL_RATE) - hcnt;
+	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
 
@@ -541,7 +541,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_I2C_SLAVE_PRESENT))
 		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
 
-	lcnt = DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period);
+	lcnt = max(DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
-- 
2.39.1.581.gbfd45094c4-goog

