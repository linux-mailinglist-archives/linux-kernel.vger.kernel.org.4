Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9906FF2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbjEKNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbjEKNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:33:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97F9EE6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:32:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso4969766f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683811959; x=1686403959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UFGhB83ROP440y4JzZ2DWi4wx7mDPzfDrtis1oh0Uc=;
        b=j61F2EZHIzVROnVnEJ5dWEjJ++EssalrBvY6bt/WB/zE+mHTfRUUC/bBLbEd7+yPl6
         RX8i5zBHeuDrZGi+bAPCxS1N991+YDw3bs5Zy6SAnO/xM/UudkTyW4UgDraICDPSf0/I
         RECDKvfIjuag395gnx5RBeyaOahlsldWTVmNJrb5bFCd2AFM8Qf9VbXRqbeqTfRbpPAa
         1CeZH70bHm/Pbt2PyULvdqvNP2tnNQ2ufDY8zlryLlFsHPdx1AzWPUJJ3QSnFUSYgRjk
         2lMw0iTxLG9t0Cbw7IhYC2ioUqEjinWoW4QCUgSMcDQNnMe5Dpl/5VMizBghngXbBcU2
         I5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683811959; x=1686403959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UFGhB83ROP440y4JzZ2DWi4wx7mDPzfDrtis1oh0Uc=;
        b=Fl87ZYWLolm1kUWH+dppw6BYd/HdadRR9dgvl1IOw+f4p1+xqqVd7du2lbZibsOwei
         GdVRPgHXALZoVhn6Cj36ivtu0E2qxxXDJ9gsAujJohGAbhMDmXbKPHF/NKb8KPk5HfJK
         YoS5NwgemKl4uYOxhHw93MstlL4FSASF+0Y8jhnTfMHfFrQ8v39eiANa94Nq6GV4cCb7
         RpL5Lx1dPOFvPtiiiJe0PTjxN96kiFpO3evO/xdw4hvDhuHWpMlC8XEf2jtygCEOQkyH
         D0IGTNL55r1vAUUMskGub8ZhuejajOqk4kXyKBi9o8j4PTqI3Jc+oQmaKwKN6ieMMzJB
         q+KA==
X-Gm-Message-State: AC+VfDzVuwWC7+jz6hrBe9NRpKCyEF1uOIXgesKASkpZJJ1clIHXOEmO
        Hau9EL8BnPfJsVMe5VaU8Aei1g==
X-Google-Smtp-Source: ACHHUZ5ETDXp0nRcAzcgFbv4kgG4x2FThcMMysyf2EOpF2sHVg9H4CuAY5NsAJC60miMV3Ro02gxAw==
X-Received: by 2002:adf:e690:0:b0:2e8:b9bb:f969 with SMTP id r16-20020adfe690000000b002e8b9bbf969mr15481747wrm.0.1683811958720;
        Thu, 11 May 2023 06:32:38 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80f3:ef71:25ff:df82:9cc9])
        by smtp.gmail.com with ESMTPSA id a15-20020adff7cf000000b002f6176cc6desm20479025wrq.110.2023.05.11.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:32:38 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
Date:   Thu, 11 May 2023 15:32:26 +0200
Message-Id: <20230511133226.913600-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The given operations are inverted for the wrong registers which makes
multiple of the mt8365 hardware units unusable. In my setup at least usb
did not work.

Fixed by swapping the operations with the inverted ones.

Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 6b4e193f648d..6d785ec5754d 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -583,15 +583,15 @@ static const struct mtk_gate_regs top2_cg_regs = {
 
 #define GATE_TOP0(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &top0_cg_regs,		\
-		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
+		 _shift, &mtk_clk_gate_ops_no_setclr)
 
 #define GATE_TOP1(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &top1_cg_regs,		\
-		 _shift, &mtk_clk_gate_ops_no_setclr)
+		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 #define GATE_TOP2(_id, _name, _parent, _shift)			\
 	GATE_MTK(_id, _name, _parent, &top2_cg_regs,		\
-		 _shift, &mtk_clk_gate_ops_no_setclr)
+		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate top_clk_gates[] = {
 	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
-- 
2.40.1

