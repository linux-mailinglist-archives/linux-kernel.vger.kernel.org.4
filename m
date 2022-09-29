Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063E25EFD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiI2Svi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiI2Svb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:51:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3F13D850;
        Thu, 29 Sep 2022 11:51:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36so1570921wmb.0;
        Thu, 29 Sep 2022 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5mnSpNIFACpxpGOfOqdDk93rUyldB4P9QmLL2da/TPo=;
        b=oGc3wjTZu6wmTA+cw8D+q0x34E0YHhLhGKzuvtMi7oi2Bp2Wh84WEoOI7BT7EuH/3g
         NoZZpDTj6ZFP2DU9petRudB83qoI7cwxVC+VvAJUKCaST/wJcZWMNYh3DpzrSE5FrxcD
         sZ5Ba2rHJfRGk65L012XY4EWX5EvvvIeoAiUPKzfPSCX66Spy58dNSQmh7dfD40VLmbu
         1lmRVyYkf8RpvUOv7ma+gO+2pRNnP86sgPxgh1bp+ooylgBfd/xznqoMdcUciuFV7f4u
         i/3BDUfFbBMC3RU/txuiDdvxklmCOzuEsHfH3YqjG5Nj+A4wG99LwxQyExAdDuH2HF67
         Lc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5mnSpNIFACpxpGOfOqdDk93rUyldB4P9QmLL2da/TPo=;
        b=NEdyfydnAZyPV5Mk4B5qt68bAtq+3HNXKusgTlqOZNlggEH4jXVmeh2zEpJtruxfh1
         GfrwvUr8nsdbOUahgwlL6yWLhJ/ckHitjsiJRWsLJPHxuQewOSQoFg6DdbXo7AT6q+CQ
         pD0zIc2GGfEg8NpEkgAYx/cWRWEZu+g8jJHepCDtrsgTPd+gwGAysEwUF/IUmmLJt3Yc
         EhYGbuAEuux3b9PoO+JLc/Ux+hiQoFG7Qr9+dlJs4VedT3KtrOAuguylceONHeIrLciq
         uvDGvPKklsXmmoiOQ2GBJZ3niW5JMhYWDQtGN93UXI1dPikDNmRz/VQ0f9/ysTTXICAI
         YE4g==
X-Gm-Message-State: ACrzQf39MrJPr3Fb7yhEy42RQlXY+bgdHIhduwTnruhnX95E24ltvHZG
        T3zFJ5OdpvU/J4+PV9lF3LE=
X-Google-Smtp-Source: AMsMyM72mwMadxTBk3RTkmN1xiaiFRnrdjH221pc62cKh9RDauFV11wBW6Uxvvm5BIWD+hdTkdFO4g==
X-Received: by 2002:a7b:c450:0:b0:3b4:fb1a:325d with SMTP id l16-20020a7bc450000000b003b4fb1a325dmr3512527wmi.138.1664477489154;
        Thu, 29 Sep 2022 11:51:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9174:aca4:83d8:90fd])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d43ca000000b00228aea99efcsm167301wrr.14.2022.09.29.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:51:28 -0700 (PDT)
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
Subject: [PATCH 2/2] clk: renesas: r9a07g044: Mark CRU_SYSCLK and CRU_VCLK as no PM
Date:   Thu, 29 Sep 2022 19:51:19 +0100
Message-Id: <20220929185119.335273-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
RFC->v1
* No change
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

