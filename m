Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF160D8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJZBVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJZBVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:21:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDEBEAC7;
        Tue, 25 Oct 2022 18:21:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so23910357wrb.13;
        Tue, 25 Oct 2022 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jz/vuqprTwlUswHT+3fQYYY63+kBW8BHUTRfhG1llY=;
        b=OEHYEg101oDjbITmOmTAHCNj0HRcHTCchvZtotNvvAIhVbZcPmVW/KSnXx0nok+IA8
         0x41O6RspdRnfAk9Jd9SzJ/8M0ynlVLiIuTvhFHYXMDqAbfxQ19IOP9tcIjnpDirGYr3
         RxpAOISRff7tE7cONcw9LnOHTs6dDW4aLO4EWXSyezqt3IvHLwo8iCBK6hWcl1dpQbUK
         ON80L9eSKMhst+TCRbONpecScmVzu8ypsYJNLpGOOP5+3x9ahfQzrkWR6siieXMdesMH
         pWy4K1cJJDr9xM1Jl6DLS1eACGtNVgVwSzFm2Xb/56+O/1Y0I1hhpbLh/R9Bs279eC96
         F6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Jz/vuqprTwlUswHT+3fQYYY63+kBW8BHUTRfhG1llY=;
        b=xXeynXrVkuiWzjTJZOWwRy7KsDDpA5qm2NYm+h9SpLq/NyupW1iUC9LCkh719pTEBl
         bNj0YoTWKDEcMutugYJ7hVxuNXNvfqtzdSHZ+eDnBOBCxh68tVNUCKUfM5s0iDgLzmd2
         fPW6zVrp/kwB9tzbEJW5i/OElnFiVmuKDWRQnPW9gsBKKJISVu5T/Kv5rSEstMe7V4l9
         2waFS9gG1yV4UHF0MHMTFdopBikTTw/QXqrHrGPYyW17QZtD2ZJ0YGrFw0AsWwDW/gMs
         i2G+N0ISX68iCGSbEaSp1ZZtDLtoKs8dOfsgGV6TfcQ6kzC4NsULblnqE7jOmkMiU5WD
         YkpQ==
X-Gm-Message-State: ACrzQf1rDwNISq/4giRyxPyFLFVgUyPjqQNSWqKfj6CZXcfLUfoJbI4y
        Hs+6PZz1zV6UudMhmzl0/uY=
X-Google-Smtp-Source: AMsMyM7TjQyEarJdQUz8kJ3bvQ8YOCO0mEm8pAH+q3zaxkAWblq2ftveFlDSnFSHssFKJ7+5Jqv7qw==
X-Received: by 2002:a5d:6d0b:0:b0:232:bd2e:1bf2 with SMTP id e11-20020a5d6d0b000000b00232bd2e1bf2mr27339228wrq.534.1666747287415;
        Tue, 25 Oct 2022 18:21:27 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c7702000000b003c6bd12ac27sm394456wmi.37.2022.10.25.18.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:21:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: rzg2l: Fix typo
Date:   Wed, 26 Oct 2022 02:21:23 +0100
Message-Id: <20221026012123.159790-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix typo pll5_mux_dsi_div_params -> mux_dsi_div_params

Fixes the below warning (make W=1):

drivers/clk/renesas/rzg2l-cpg.c:115: warning: Function parameter or member 'mux_dsi_div_params' not described in 'rzg2l_cpg_priv'

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index be4868fa3971..dfd676310ce9 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -95,7 +95,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
- * @pll5_mux_dsi_div_params: pll5 mux and dsi div parameters
+ * @mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
 	struct reset_controller_dev rcdev;

base-commit: 888a358164525a701121192f504433de6c7a281b
-- 
2.25.1

