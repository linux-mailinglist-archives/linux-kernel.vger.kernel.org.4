Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAF5EF5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiI2NCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiI2NBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:01:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83934161CFB;
        Thu, 29 Sep 2022 06:01:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h7so2062786wru.10;
        Thu, 29 Sep 2022 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QKIpHGs3LeinzeIaUGKa0ICPFZL+uew+WBou+/qEEMs=;
        b=AgFahVNBMPAdTt6Hji1RhoPcnR8MCGZgvz/2UE5Q1CTjXVo9CW0ak/uSx1R+Vq8LPI
         U6nGupIT3g1fujwOUBuemHE58YZu1E5MiLno/O/luh9m6dchtkEs62VjfDkZkPxImpQA
         t3sDG+ehBpLP3dFCgjV6xQP4qBUYtyfshdD8TVIkwAD9om7bLf7WSEghDLkQ/L7diKJ1
         FlGMrf6Q1kFxxEen86Qbwl+o5C+b2T31ZgQ1bDX51wzN6PbMuKltWkFJzQFr7U4esERu
         sFe7Y3tiwEuE+2Vh2+uoJvCbR72J69DxTNPMuukHXoVFQr5x+LCQg0dtMPRiWgK8Hchp
         HWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QKIpHGs3LeinzeIaUGKa0ICPFZL+uew+WBou+/qEEMs=;
        b=ObDIcc2y5pWVqHIxyrRc703fyuwoS9Xai4xk47GLLkk+L9ul8xJU/0C7S1YjZoKAeH
         UHhUAMeBeBFtlvZCZ1mLvRlxd5RgJcS7f8NouFAtLDeCfvAgSwOLjGHSVz9hX+MNesSQ
         b/bWowHj//pI1O6VBFQjPLnUfBVvL0GtZTxUu/heV3/BXUm7bA1NtdnnPwzkVz35swmE
         /U1BQqHdGhn1vrhXCF0vdQopiC1PoT5pfT7t9tA2YnIH9pLchSn9NmrqyOW968QSiSGw
         D80BuKf5zvgTBqJw20y2sn8mz+tT1zsXSijoAOqA3YeADDfYF4mByN5556DAWllWAUZR
         lEcA==
X-Gm-Message-State: ACrzQf1VtYJSuyxcYVaFI4JWTDQDNUezp2KgtrYfs4KMoUmZlkArtiYP
        tihJzX/1lIooyeA601lVKag=
X-Google-Smtp-Source: AMsMyM5vXaXH5fZ3dIbmRJWeClvpwWiO6Y9sSQYzNl6JW42LcFYRMSzFHH58H6hdJJTPcWhcyowbbQ==
X-Received: by 2002:a05:6000:1051:b0:228:e1a0:7221 with SMTP id c17-20020a056000105100b00228e1a07221mr2213671wrx.165.1664456508569;
        Thu, 29 Sep 2022 06:01:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d4a0d000000b0021e43b4edf0sm6555454wrq.20.2022.09.29.06.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:01:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: phy-mtk-dp: make array driving_params static const
Date:   Thu, 29 Sep 2022 14:01:47 +0100
Message-Id: <20220929130147.97375-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array driving_params on the stack but instead
make it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 31266e7ca324..232fd3f1ff1b 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -85,7 +85,7 @@ struct mtk_dp_phy {
 static int mtk_dp_phy_init(struct phy *phy)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
-	u32 driving_params[] = {
+	static const u32 driving_params[] = {
 		DRIVING_PARAM_3_DEFAULT,
 		DRIVING_PARAM_4_DEFAULT,
 		DRIVING_PARAM_5_DEFAULT,
-- 
2.37.1

