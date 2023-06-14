Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AF730064
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245130AbjFNNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbjFNNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:47:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0979C;
        Wed, 14 Jun 2023 06:47:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f6170b1486so8222858e87.0;
        Wed, 14 Jun 2023 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750459; x=1689342459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h+z4uDldJRuHAQNBIGKgEmmlz9MuMHPn+kemKGwt4o=;
        b=NV6U/46wOqvbETuuDc2B5J7cREHQvqtsHn/Gl2LqCiFM3NYlnAwA4rAto71zHzKhu2
         NiBppu9ths7SHIKxXdFe7rH3DstHLCjSk++pwqMD+97icRlfA4KoctTkHUezEOwbCtNe
         sIdN6qN9cFqBTgCVuZzfr9SpuZSC6zBpMO6vBf5tsYV4C3NZfdhXkXL3mWdLzequDY/t
         7lcSntLgJOjG0B/jyXf4C3g1TQGzH45uhB3ALDVjKwGfHF1KgqeD7hrWlSo0jnI89vgq
         ehihl7cMOelYqBTULhJfD/RuFKupSZEFfs/UtENghCSu+jNJP3NgAaq6OnXxP4cdrUoZ
         hVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750459; x=1689342459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h+z4uDldJRuHAQNBIGKgEmmlz9MuMHPn+kemKGwt4o=;
        b=apA9zN12W+qTkz09bBWZnpL6vLqAHkdZRixHGPe8BL0nvJrA2vzT5vakP5I/7rIa5Q
         Vp8IG02YFRp4U3hP2S056Mlw/vG1wVoT7AbPMABy6fVyI+3gvcMCR6cpPd2djw9MTcSd
         ndnR7qAzB+3RYYEJM73sO5AeJVD6zk4UFe3dzma4kqY+gai/z47PZjohnvNo5Dy0nPNk
         bIV8J69DoUF3fJ9KsgMzCV9BmCOp/YGsskIVr6d6R8Bpqz3vlA3P4tOKPXgEnB/VCmWo
         gIl/THmmNN8JvxWGzxN6xL/93N/S/F4BhKOZ4ua5nJ2ie53mdf9yoN3STjfFoAXps8ZI
         1foA==
X-Gm-Message-State: AC+VfDwlL6T8JJkP7yRRKINHDLOqgKJ7caPkdZH8WPHuuOta+kz0/7uG
        ULs0IjAjIYdSHEJMpR+8Dxw=
X-Google-Smtp-Source: ACHHUZ4AvO7fbBSkugYy6V6uYfcWLiOtnOexV1qOvHCEncWRG5f+43gSvrYfcCb5PD8/UFb07yhsAw==
X-Received: by 2002:a19:5007:0:b0:4f7:6462:e036 with SMTP id e7-20020a195007000000b004f76462e036mr817204lfb.11.1686750458754;
        Wed, 14 Jun 2023 06:47:38 -0700 (PDT)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651204c500b004f3787d8006sm2164185lfq.128.2023.06.14.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:47:38 -0700 (PDT)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     a1ba.omarov@gmail.com, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: rk3568: Add PLL rate for 101MHz
Date:   Wed, 14 Jun 2023 16:47:16 +0300
Message-Id: <20230614134716.1055862-1-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This patch adds PLL setting for not so common resolution as 1920x720-50.00,
which can be set using 2500 horizontal signals and 808 vertical.

Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
---
 drivers/clk/rockchip/clk-rk3568.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index f85902e2590c..5dae960af4ce 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -79,6 +79,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 	RK3036_PLL_RATE(135000000, 2, 45, 4, 1, 1, 0),
 	RK3036_PLL_RATE(119000000, 3, 119, 4, 2, 1, 0),
 	RK3036_PLL_RATE(108000000, 2, 45, 5, 1, 1, 0),
+	RK3036_PLL_RATE(101000000, 1, 101, 6, 4, 1, 0),
 	RK3036_PLL_RATE(100000000, 1, 150, 6, 6, 1, 0),
 	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
 	RK3036_PLL_RATE(78750000, 1, 96, 6, 4, 1, 0),
-- 
2.34.1

