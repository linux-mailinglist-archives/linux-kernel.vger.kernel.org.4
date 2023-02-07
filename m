Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C868D3A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBGKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBGKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A52BF1D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so5819328wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twoMo+snKLyTyhll4ov9NELo28s6TRSl8cLJ4VzcUYw=;
        b=wy/qYABqKXmwErhcZsOXJxsCWk0gxkBr69YwnXvqVBa7xvaLu2vk9+uD2YGmy4terv
         qlaz8JQsFUCP2Nv1mWTSOoLkTJa9otWxX9UO3zElLy4MKQXO40jPw5CR9wzvQ4w/8Szx
         EF7a2ZX/bIojTc6za6VwuTeEw2DZyD4FMwVJZ+QOC3CPQODf9SeNsXZallozU7u5Vo6V
         FKYtMDNCxog+1JjZkF/ksQN04Pe5R4EEiXGkQe/B1mSTxGA4UjKRU8wlptbKkgkDt+z5
         OyXvVskcDOn76WAaUgZUFvy1poidnuXe5REdt24VWDhWKBtixy207oxY0ur0kdFHEqwx
         TKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twoMo+snKLyTyhll4ov9NELo28s6TRSl8cLJ4VzcUYw=;
        b=CtHQyTkc3vP7LbrlSaQj/XCigNFQE0Wfn6U6M7OsScZ1/GWklSV9619YjW/6Fj/pvU
         I9+iv41WPSTCXHGPqgfPFRhSMZQpQMSfejC7n1qDUUeTBfMqOy/sq2KJ0R4O8/8+ojZY
         xDLxZmCnJnFacDr3gXMhDEdVPruQYPji8AHVjwyn007vdjxBQfsPnI1TgmSXjsd8eLbU
         j2eQ+vxJKsNrDonOw8uruLdmlSHQYU3g+oQgxR2JMVs86QGZ6F41b8ni9ReESeWtOWr5
         qRhp+kqlf9rdnGSTkcvRiVj6xB6vE1L2c2/LBfGe7r+NeeK0pMaM4jTVtC3LI0crD2QO
         /RbQ==
X-Gm-Message-State: AO0yUKVl/+DQtkKqFTYowH+73nvtNSReb6tsHj9DLOLbWhuEga1p56ji
        ghw4wS02gN/i+sGoqdiAISmdsA==
X-Google-Smtp-Source: AK7set+YGufmhxpoZbZATMNZzBpxN5lrxVqkdaISzzwU6B6UpdsincA84CC9xJeu7YWQZ6LSQz3CGQ==
X-Received: by 2002:a5d:438f:0:b0:2c3:e56c:aae1 with SMTP id i15-20020a5d438f000000b002c3e56caae1mr2620768wrq.0.1675764455787;
        Tue, 07 Feb 2023 02:07:35 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:274f:8489:6db8:7d33])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm5283173wrc.13.2023.02.07.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:07:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] soc: qcom: socinfo: add support for SA8775P
Date:   Tue,  7 Feb 2023 11:07:30 +0100
Message-Id: <20230207100730.218725-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230207100730.218725-1-brgl@bgdev.pl>
References: <20230207100730.218725-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add SocInfo support for SA8775P.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 3b970a80f3aa..c5208aa99125 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -419,6 +419,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(SC8280XP) },
+	{ qcom_board_id(SA8775P) },
 	{ qcom_board_id(IPQ6005) },
 	{ qcom_board_id(QRB5165) },
 	{ qcom_board_id(SM8450) },
-- 
2.37.2

