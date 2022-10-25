Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A560CC17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiJYMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJYMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B518BE26
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:42:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so20074960wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZM0T9VAIhDH8MlN6WTNKMHChs2UsyWeC4jS+W4xqgE=;
        b=KKMGuE4/SZ26vZUsXFESU9bVBmQJ/U9oz2QjLdmDj6petr7Z0fUlZubuhdLhvEHci5
         NKRFIbeUyziptVGfh3p/uVfPCIQyrHUuKO5Qlc2RR/bNaUvRQHI6pnNX9R4FEBl6PjYD
         6mWRvQQIfpy7O/C5VnXdugs6rY/7p+VQPqmphCuqAVwJpcPGG5PqRqrPO5Zhh1yeaNJy
         9wnklj2raQkZPW+/B0fbHfSxoPtdzucnF3Fn58vb2YsvsXViLeErmNpBsxvYCy25J9Ur
         glBOkXDAOSNthoVwGPXzCa5jRxghjJ4x7toQbOtgT1kjjHVrzNMFVACINvHPlyhT1NOJ
         JevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZM0T9VAIhDH8MlN6WTNKMHChs2UsyWeC4jS+W4xqgE=;
        b=Ep1/vpeBinjC3Wd5sNB2cVsw7CMSLczNyL3KftZ5qEc+CysB8SLuanmB3mpHs22Ibc
         bTrAfG5wmBN5dx+ZfjmujgcbpvIzDvbwnjRjwmrPqXu+0C6ano0El7Al2FB9iEz19IjR
         tEJlnYbXeSGsHbV7sX0yRiSVDi6ory/6XD3ze8AX/1CJeKJGRWtqbziqf4s9v9DZScWr
         MgmJJx2ubWLkOV6ZvdbDNPbvIefAm9D65sGQ5Q3neiIQFGOHWrHntHelub07NNSYZcxt
         ObY5MqZIDI5FHK8ay/daH280ryYtKGTThCyTzqW9lGYDaKa17Q+tpwtorY28+L6OLEjx
         L/og==
X-Gm-Message-State: ACrzQf09xc+Dfet7tmunRyf4N/OvhExoU7dr/6TfGx5lSQPcPklZPtHi
        r23TaJzoER1jZW0eSURdCAE=
X-Google-Smtp-Source: AMsMyM7qGiPSr6jS0SrVQrVe6ZNaIcaZ3Pzpjqm4tGdeQk37enhjvFMn62fA5LjFriOIMhSj/XcqVA==
X-Received: by 2002:a1c:ed0b:0:b0:3c1:d16e:a827 with SMTP id l11-20020a1ced0b000000b003c1d16ea827mr25702572wmh.127.1666701723192;
        Tue, 25 Oct 2022 05:42:03 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm11250664wmb.47.2022.10.25.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:42:02 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: rockchip: i2s_tdm: Add support for RK3588
Date:   Tue, 25 Oct 2022 14:41:32 +0200
Message-Id: <20221025124132.399729-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
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

This adds support for the RK3588 SoC to the I2S/TDM driver.
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 917f17107891..08b90ec5cc80 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -1318,6 +1318,7 @@ static const struct of_device_id rockchip_i2s_tdm_match[] = {
 	{ .compatible = "rockchip,rk1808-i2s-tdm", .data = &rk1808_i2s_soc_data },
 	{ .compatible = "rockchip,rk3308-i2s-tdm", .data = &rk3308_i2s_soc_data },
 	{ .compatible = "rockchip,rk3568-i2s-tdm", .data = &rk3568_i2s_soc_data },
+	{ .compatible = "rockchip,rk3588-i2s-tdm" },
 	{ .compatible = "rockchip,rv1126-i2s-tdm", .data = &rv1126_i2s_soc_data },
 	{},
 };
@@ -1556,7 +1557,7 @@ static int rockchip_i2s_tdm_probe(struct platform_device *pdev)
 	i2s_tdm->dev = &pdev->dev;
 
 	of_id = of_match_device(rockchip_i2s_tdm_match, &pdev->dev);
-	if (!of_id || !of_id->data)
+	if (!of_id)
 		return -EINVAL;
 
 	spin_lock_init(&i2s_tdm->lock);
-- 
2.38.1

