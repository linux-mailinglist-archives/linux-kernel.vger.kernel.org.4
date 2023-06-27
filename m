Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3067773FD50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjF0OBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0OBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:01:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58DA1718;
        Tue, 27 Jun 2023 07:01:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e34ab99fso3775259f8f.1;
        Tue, 27 Jun 2023 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687874507; x=1690466507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zslKG4Gk1yPo9JIikeXogtJtSLjxkyiGcUPYRj5BTfw=;
        b=rz40dLBeIyXIxQR9OjydRBjFPSIrm8NsTyXSUaNc2WqObEgL9sgbVKGBFZ8D0CBuS1
         RRIjbhMHUHc1FeFMNd3V8vIKQEsMn11zkGzS17SexLp+6vggrOnUxkMRGMAVISM/3+bN
         JxOM7SN/n8VzoVZSa/PFdXDYf5AllrRjoUNN7XsG4EVJ8gTkB3fHx2CEjKCzXDjpDLYs
         xnefsaBrS58olv7UMlX5BhzRRnXTzpsUnbeWn/Qh9n8vTvol+TahrvNaLP6c1LxQHB48
         vBgPqHEEg2lgNHTi8reWG4hGRvJC9Lwz7ZETwPJPnvtYXHb5+MTfwRBd0zqg0pKP8BTo
         aXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874507; x=1690466507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zslKG4Gk1yPo9JIikeXogtJtSLjxkyiGcUPYRj5BTfw=;
        b=BQr35zMrExNrfPXeZqujJhJZtZQon8YDOFD/Gd099oZfCPvxm38J8yrCQ2vOi2tW/7
         D1IHo4gvROmf43v0stRScoquFCw0heEd+fe2L4dlUGLNbfZD9mDhvMiq+v0k8auf5NRo
         lDQTXjNm1jK2MT6ssNgxmmM6t4Sj4iy35fvRx+ThSQZ3mAKydxC+VHH6jO21gAS1tlXa
         fRwVuQdXXOqZ1QQhciCjnvaHDiXsf7YPu6WLWnO4ZDfbMpKNYkch9pe8M4A9h0qnFEja
         nhf29BFiQxgaXmLQ4Am7pP/0K0ib4X2VLtpSwpA1Jcv5YukdINTlK+5QdgAlAFQSL4SH
         AbOg==
X-Gm-Message-State: AC+VfDxyJfNHqB7hCivOFa9HRZywx28KJdCGJp9V9clcSK+osRlwCeVW
        z7xGTbBlEVhd/k+RKxUH7gk=
X-Google-Smtp-Source: ACHHUZ7UQAUjF7ILXHovRzkVTKMyTkmk0UxBvDmZXSNKj1sJhniuMIVpC8dYcEz3H7MffUKlhcX+qA==
X-Received: by 2002:a5d:4fd2:0:b0:313:f0e3:2fdc with SMTP id h18-20020a5d4fd2000000b00313f0e32fdcmr4803225wrw.2.1687874506931;
        Tue, 27 Jun 2023 07:01:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b00313e8dc7facsm8734663wrt.116.2023.06.27.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:01:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: lmk04832: clkout: make read-only const arrays static
Date:   Tue, 27 Jun 2023 15:01:45 +0100
Message-Id: <20230627140145.729609-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the arrays on the stack, instead make them static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index e22ac93e0c2f..21b425d8a1b7 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -369,7 +369,7 @@ static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
 					      unsigned long prate)
 {
 	struct lmk04832 *lmk = container_of(hw, struct lmk04832, vco);
-	const unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
+	static const unsigned int pll2_p[] = {8, 2, 2, 3, 4, 5, 6, 7};
 	unsigned int pll2_n, p, pll2_r;
 	unsigned int pll2_misc;
 	unsigned long vco_rate;
@@ -631,7 +631,7 @@ static int lmk04832_register_vco(struct lmk04832 *lmk)
 
 static int lmk04832_clkout_set_ddly(struct lmk04832 *lmk, int id)
 {
-	const int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
+	static const int dclk_div_adj[] = {0, 0, -2, -2, 0, 3, -1, 0};
 	unsigned int sclkx_y_ddly = 10;
 	unsigned int dclkx_y_ddly;
 	unsigned int dclkx_y_div;
-- 
2.39.2

