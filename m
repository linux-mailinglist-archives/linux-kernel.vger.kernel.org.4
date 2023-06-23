Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA973B479
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjFWKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFWKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CDA10F1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so678113f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514666; x=1690106666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=dLurroqnBfuZlrXTJOSO1ec8tkOeNMC7/5FOt5gGsGnx23ekrR748s6VoPpqzDKbl3
         vWDMKD0wmLDtvfzCrlozDHyfcJeiN5yr+038ii6HY3l6YuEJqjShtFub/I0GFcC4U4Rr
         6CXXMUTEGhm5w0hGK/fuJUOwY8YbXrOC+taP5VC3tIqIKij5+05rpXvb9eTReVJw0FN7
         X5RfuLo8m7WYea1CwT8CcQCrZwdD0/O7CJK0yTqZsz8AGv7j/3DVE2f8OmP5261eyp3g
         qmxa+PUTNAd68WMx25arfe7WHqgX23/QkOhrMBYsMnNWRm/KUMynJUcWHz9jmRSH8taH
         xUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514666; x=1690106666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=cgIl2YjzdIxPvUXkmOf8YsboMoMkOwr69W7IxvP/fTcfRgpMMfIFy0FSQHzRrYJUv+
         P7z0/bCGQNDs493WCYqnv0Qf5yYsyL60MOny/IP3I4zkx4AaAUJYjMxw01iWUTj/5zOT
         SX53mn245HYpM7nOw9Mjh+Hn8tKvzkADtxgneZZXiZHS5V+bM18uoW+oZGetHmNBe6CW
         +bRYqcdNMFnohRfpYsRXV5SJ/D2Z0g6Hz051otNO+ap///+wxVzjXzPxc1SOvki3pYZL
         8kZc61XK4Qhkmgv74tvQxxV4H43j8oaaUkrVfQqZtBv2miYdxNcq6tNHksunTGeo4+gb
         EYZQ==
X-Gm-Message-State: AC+VfDxAR25dyeklMSoNTfEFy+l51cwjPW8aZxeqnmUuc46aU+/XmwMu
        NLI/CoWgYFGRz8Zrd9f0+SZzDw==
X-Google-Smtp-Source: ACHHUZ4qSPzss8jYv0izBVyPiiYbfcs2GaupcDqzwF7GJoL6obvzFc7cSfwPYlFhIi3eERWkxmjvhA==
X-Received: by 2002:a5d:568a:0:b0:30a:eac8:e5c1 with SMTP id f10-20020a5d568a000000b0030aeac8e5c1mr20824466wrv.6.1687514665831;
        Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
Date:   Fri, 23 Jun 2023 12:04:10 +0200
Message-Id: <20230623100417.93592-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink the code in dwmac-generic by using the new stmmac_pltfr_exit()
helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index b7fc79864e8c..dabf05601221 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -58,8 +58,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 	return 0;
 
 err_exit:
-	if (plat_dat->exit)
-		plat_dat->exit(pdev, plat_dat->bsp_priv);
+	stmmac_pltfr_exit(pdev, plat_dat);
 err_remove_config_dt:
 	if (pdev->dev.of_node)
 		stmmac_remove_config_dt(pdev, plat_dat);
-- 
2.39.2

