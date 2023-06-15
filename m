Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4773188F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjFOMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbjFOMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C11FE4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8cc042e2bso15896575e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831282; x=1689423282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbBN5UFZLskttS3+DKY7OChoCqIyyvgczJBfknfqHmY=;
        b=yvPYPB3/twNXwbLjMkJlnuJoOjP5vKUi0hMqRQ30Acy5+J9og3U2sPSx6dJAxPrOvO
         yOKH22lW9kKY07Axj1CuBzXevI7YaVgHFszXRmRqPkXZuDNFtFDIvpvtDSo7Z+ZQlU8y
         pHCs8MbJXDYQUKc3lZSyZC9pSbArUeGi7/mLipar8SrNY11ypiQp3Dgqub2ZlbCEOsGU
         Wq2dm/NvjX4fI0lGSNhZXbZ4goMsq/OSyWhUsILsFcaBoLcjfOzIQizkZeCY9+fFxbpn
         qLtLxdBV7G3/Alw0/iyf2L7o0OIItEpvMGXdiA+TIgCWbfKRf+N8X9enbhmYCovsvoZD
         uAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831282; x=1689423282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbBN5UFZLskttS3+DKY7OChoCqIyyvgczJBfknfqHmY=;
        b=F50LHxdDrhrM6G/MhPJ2DqDJzQl+zoSgeha1SirEI62PBD28Bx8QA5yAg0Ld6rEjw3
         wObCv4tNvsH4t5Rg9ySB4X+oUOZhHc4BgR7FaVnD62mjKs0FSYEN4VG46Ffv/rbUhWsu
         IJPhP/+Lq2OvBG0vCrGkIonGb7RoDx6T8kHKrjJoPNqGL1sjsV37kviAeCnjSMjjxhB/
         71/loABL5jgZnMyRejIPX8wenqF1o0ic9eQmVQuNcEEVfBQdboSJIBfL20E7KkJ6omNV
         p7v18nYyAAHg/fRJEbbv+buhXHd1UNELwa6at8imgBrjEC4G8mNjsiPw+7Ez/IyYyII7
         elLA==
X-Gm-Message-State: AC+VfDyu01NLF0B3e2ZMpJJUSrKPuYmr2/fQXNNLYYMTKIdHwxLpvLI1
        UF+bgTPojgKW2qcG54xhWoeFhw==
X-Google-Smtp-Source: ACHHUZ50gkojbsxcYhy0Y9KFQ/3/buCtu4HBZ5N7JDVSu5XZvtC4ZCRBtmSSx5JTV5aSJVa9J+ssDA==
X-Received: by 2002:a05:600c:2204:b0:3f6:be1:b8d9 with SMTP id z4-20020a05600c220400b003f60be1b8d9mr12600756wml.6.1686831282249;
        Thu, 15 Jun 2023 05:14:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH v2 07/23] net: stmmac: dwmac-qcom-ethqos: tweak the order of local variables
Date:   Thu, 15 Jun 2023 14:14:03 +0200
Message-Id: <20230615121419.175862-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make sure we follow the reverse-xmas tree convention.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 16e856861558..28d2514a8795 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -594,9 +594,9 @@ static void ethqos_clks_disable(void *data)
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct ethqos_emac_driver_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
-	const struct ethqos_emac_driver_data *data;
 	struct qcom_ethqos *ethqos;
 	int ret;
 
-- 
2.39.2

