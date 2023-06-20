Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40A73759C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFTUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFTUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367C7198B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-987a977f62aso439617866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291423; x=1689883423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdVTCfsNXg8LTZXPz14qnscmv5nY+vHAf2QvMbjoj+U=;
        b=dYh/ldYpizW6Z+iNpo3MHB9LyNkpT+eBNFkvnRQ7X50qonDZ/hWNU/0sdFVbfBrgIE
         A4ZzuFYjTsj6E8hBiotwpP/h0UhVuE/kPMoz/A4G7hGszgqjMx6gypDfkAwoqcoavtnb
         ANnVLw2qNDkDS+f9N1NLyqyXzWgJmLYQCyq+afq/YUKYEEfuZ5SaoCO2x0oL9uzz5vnq
         l37GIILvK/MgV4xEIbpX2t+eqQzT8bEP7srhMF4JNDMXx2rBni+uzd0gG38gtY7llmtF
         2g6y7ONtZaIh5sQjPcoXtq+xPMfKY0GoRYSwOtiD81J4IN1dD/CeEV/hcu4TDS3Aiwxj
         19zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291423; x=1689883423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdVTCfsNXg8LTZXPz14qnscmv5nY+vHAf2QvMbjoj+U=;
        b=eDDuI1Mzm9nYEzQYZ3LGR4UwzwfERLqdLpZY91XXdPWnMxu4nw4tbFXFFognRwS6ke
         mqivO5Typ76n4fL1lIxQ30hB0XilWDt+TDBIlxrAT4Y8hcYODtaWcyWZfOoyo5tuGNZl
         JSWr1ndI+WacoipUPxiizNoaQeeZFQTeQmoAK+agFv8KCGOlqCjo+YO0faJA0CJGxg90
         QqtA3FnuI09GoWq5hp09X+uHS7hmulGbVJlG1wfpEOODX1yeu1nKsEbMedFRzO07tfWu
         zTrFapBjlMaph0Z77wc6uQkcdFnvunuQrCXIlJCaAvgSd/fcsx+/BxSOtjFttLcBsoDQ
         Dk1g==
X-Gm-Message-State: AC+VfDxrkAnmBhT9vpL/qYjuKliqdloVScnQFlfGFAfWGEBycROVTA0S
        z0SFinajUWr0S9uwrjDHB58=
X-Google-Smtp-Source: ACHHUZ5yPacE9C0ARwl9HK/paFV9JWBK0cBi0fi1mAjRDH5XBR77G0hzb5ZHCgGX5/o1iwejmzfDEA==
X-Received: by 2002:a17:907:9814:b0:973:afe2:a01 with SMTP id ji20-20020a170907981400b00973afe20a01mr12341325ejc.75.1687291423271;
        Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:05 +0200
Subject: [PATCH RFC v4 12/13] regulator: da9063: let the core handle the
 monitors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-12-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The monitors of the da9063 must be disabled while the respective
regulator is disabled. Use the new property '.mon_disable_reg_disabled'
to activate the handling in the core.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 071b368f154f..0e28ed15ebc3 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -1055,6 +1055,10 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				return ret;
 		}
 
+		/* da9063 requires disabled monitors while reg is disabled. */
+		regl->desc.mon_disable_reg_disabled = REGULATOR_MONITOR_OVER_VOLTAGE |
+						      REGULATOR_MONITOR_UNDER_VOLTAGE;
+
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);
 		if (IS_ERR(regl->rdev)) {

-- 
2.34.1

