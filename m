Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC711716E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjE3Tvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjE3Tvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:51:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6029107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so35676435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685476297; x=1688068297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41wTT110P1GAe0L+S4OKXh20Gfqxsl4liUxJPQgofw=;
        b=tEmQmpa44HZ/kv6vTlX8wyeO/afOACS5eUcBQq2VJB/P9Q3YypdEbY6cnBK/8GN8bX
         6TsjtwoSjliRb37xd9swXOthPTRt9HZjkIJlh1VXVkepdyiVC/hXUaN+Ax1Dsis4Vq7V
         n1a3Ci1olvT0RHTiDJm+AN67H+F/igCZP2S/93Y/BNs8fB3gf+aMy+64mZ29DqDqgEKb
         bTPewOBAxf4FvdW6S6/7Vs4npnOP1Jrla9Ok/PybMioQuJweLF/Lpr2vOVo3mKidb+gk
         Awkwi/vYduXHg0boGmaAzO2yMYJNQ3bvkPhA0OUU8HmGJXnqprqRCbIP5j2aQBQeHqHr
         fWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476297; x=1688068297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z41wTT110P1GAe0L+S4OKXh20Gfqxsl4liUxJPQgofw=;
        b=htF6BQlM6K2G9bvhI3bqtBfzElHAf3aVU8uk3FVIZ7e18oW2n9bC7cVPGReUc344WH
         xNXlfPzBSQWzqFGvlgLYJ79I+4kcJqMos2qiCSi8kH9u7H4j3zox/8ADsd+/NW6dNQnD
         nAAqD0/+fjV38vVH6kteEMwwsDoVpSpEvQpSr1Pcm8XgdVVbumClyUZWS+WsLRyzHfBq
         /DhX6J3eRW1DPPzZYGMWF1Rd6nk71tWWE/YDweufvhwA59Ja2ar5LIkv90KiKGNjRmPH
         ta5FYyvAiVMZno0Q9dTM7D0ZcYv12zez7kbpschGt+8muCmj0OGuS0SyknHcbUpdEXRK
         3+OQ==
X-Gm-Message-State: AC+VfDxW8djeqsNm6ooAS4YB5riH0FSYIi+1JzuvYmg0Qhg0EaSapFkH
        mPPh7r/C68CEByNQaTYvxRaeTg==
X-Google-Smtp-Source: ACHHUZ4ld9edihUQyCtHl6jda9XcQZmLvXT+gVCe4WVzk5SUgm2lOiWkYBStVyWeeuO0aIpiTxtF6A==
X-Received: by 2002:a5d:4050:0:b0:309:49e6:9047 with SMTP id w16-20020a5d4050000000b0030949e69047mr2494496wrp.16.1685476297465;
        Tue, 30 May 2023 12:51:37 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b003078cd719ffsm4271545wrj.95.2023.05.30.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:51:37 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v4 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
Date:   Tue, 30 May 2023 21:51:29 +0200
Message-ID: <20230530195132.2286163-3-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230530195132.2286163-1-bero@baylibre.com>
References: <20230530195132.2286163-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add suspend and resume support to LVTS driver.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884b..5ea8a9d569ea6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1169,6 +1169,38 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int lvts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct lvts_domain *lvts_td;
+	int i;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+
+	clk_disable_unprepare(lvts_td->clk);
+
+	return 0;
+}
+
+static int lvts_resume(struct platform_device *pdev)
+{
+	struct lvts_domain *lvts_td;
+	int i, ret;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	ret = clk_prepare_enable(lvts_td->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
+
+	return 0;
+}
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1268,6 +1300,8 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
 static struct platform_driver lvts_driver = {
 	.probe = lvts_probe,
 	.remove = lvts_remove,
+	.suspend = lvts_suspend,
+	.resume = lvts_resume,
 	.driver = {
 		.name = "mtk-lvts-thermal",
 		.of_match_table = lvts_of_match,
-- 
2.41.0.rc2

