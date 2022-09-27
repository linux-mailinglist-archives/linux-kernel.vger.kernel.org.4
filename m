Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485FC5ECE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiI0UbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiI0UbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:31:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D145D10D;
        Tue, 27 Sep 2022 13:31:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so7582967wml.5;
        Tue, 27 Sep 2022 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=00ysRaGn1+uuyHYovWFc2fyLe0FbaGvnUPiX3NT3tOA=;
        b=TjLSgJWhGwsrJaAPS7yq8DC0NokO9BLyPxdHH06ZYl0OYHGNjvZdlaVV3wW/nNoogw
         UVYsgCwXNhJ5h2FppVzrkvjoJ6rvnm0KepoF+39urwKffslISnGJRYzPwKV45UqyXmSt
         g3ywbj1uQM9pvp0J8mWafYulHKtmNR35VYcwi3y47VcrMTzHwYrK5zpMpSgBA86i7n8z
         pshJJaAsQb3aMAve0eGkiT+60pbyTvgrDPhLJQxpTeHDejkXUB3zNJmT5TGfw1gZkM15
         qEZraDB2PTKGde8MWlky1SNrIf/5/AjEOrw4j7h/ZrxdLgotQt8pwZbc8R5mHHWpYFgp
         yXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=00ysRaGn1+uuyHYovWFc2fyLe0FbaGvnUPiX3NT3tOA=;
        b=XfPlrrEjOzbjBOL+z1RhYqo6uOgsnMeKvftwpo961Wi6Lf5/ANDqopqZWc4hffuYei
         k0yAkJvsU1L0aTi7g7ZD+8HMXwIglz7DC3PVYq1bk8idrgSMa8uxNZxGJMUvsFOCzo13
         knj+lx2Lze5FU4GMbSqfXMkEk7CjW2yEKhDgYofVWpcKDiR/UcDIotEhDzEv6ZfkLMI7
         w3Umca6Y3fXp9taEqsu97U94LTDNHbLnyiFXVhw1PbftrQt0pkE6/EuGpRSDIVfNnvTn
         /HaeUpZ8b23D02XhcdYBTVnAdJiNCCmppkdk6IR+JTYC8g2PRV70PjsGjZrxQuLogDgK
         Kngw==
X-Gm-Message-State: ACrzQf3DTWSBl+gv4Jw/JWUg9ti8xRB/VJ0WWvm58AfXRLF1y4MiOzBM
        ecZ16o7U6YrJ4vS8MmRFNCI=
X-Google-Smtp-Source: AMsMyM6xpLDtZWn/yUglFmRLH7kW4iJBnk5wv7CWXhDdwAB77dhKg2SrFlZC6ayrrn4FAE29B2gu2g==
X-Received: by 2002:a05:600c:3ba0:b0:3b4:8ad0:6c with SMTP id n32-20020a05600c3ba000b003b48ad0006cmr4038012wms.186.1664310665923;
        Tue, 27 Sep 2022 13:31:05 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:c6a:3c62:baf6:511c])
        by smtp.gmail.com with ESMTPSA id ck16-20020a5d5e90000000b0022cc4b7861fsm754830wrb.97.2022.09.27.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:31:05 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 2/2] clk: renesas: r9a07g044: Mark CRU_SYSCLK and CRU_VCLK as no PM
Date:   Tue, 27 Sep 2022 21:30:44 +0100
Message-Id: <20220927203044.751611-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
sequence for the CRU block hence use DEF_NO_PM() to set the no_pm flag.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 6935441f7504..31b1437c57e4 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -252,9 +252,9 @@ static const struct {
 					0x558, 1),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2),
-		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
+		DEF_NO_PM("cru_sysclk",	R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
 					0x564, 0),
-		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
+		DEF_NO_PM("cru_vclk",	R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
 					0x564, 1),
 		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
 					0x564, 2),
-- 
2.25.1

