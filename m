Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C455749C47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGFMou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjGFMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9431BE3;
        Thu,  6 Jul 2023 05:44:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e39784a85so349407666b.1;
        Thu, 06 Jul 2023 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647435; x=1691239435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpUyabRflIUlGBtrTxyGcNkzTyYZM7yVhSIDAooxAH8=;
        b=IirKIMiKlVAMoq6Wi7784z2k7wDNDzNlbWwa0llBPDA6FheHB/6RYSuKQQHlv3Li91
         p3Ug0PlQxTrmxJTqGimWvVFDMFiy7+Rv/+6jcREur9TQsgjc80hUXdDTbMaLbgahg5Rq
         c02B92ZB+4KKeoaxczSv2lrWbGuE5Gyt2WZI8rgMexEvv7DrRbCsszJne69sKuTrwWME
         wIKW+c53wrQMYF+Q+KFmzCE55AvD8y2vpBwMmcoWLQeNZtG7T5kLNn/EKCJt2sVBqtlR
         fIKvDDsYXLwRUrNJmkSkbiNDwhRFyxuQabrlaaddA6uiFpzAHqfnYXR475hpFDCAYJqh
         hyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647435; x=1691239435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpUyabRflIUlGBtrTxyGcNkzTyYZM7yVhSIDAooxAH8=;
        b=HNuFHA15oaBFTnMcwepZ70XwdMatLh49EhxIOJ7juD2QF9r1E30gsaVVrtnZL/tTgI
         qg66v044zFs2uwvIpLyZvarcVoQQJRWMOmnwxqKE2FAKMOJA9Q3YlXhZdtjJKm1KV7mD
         OagbG7Y1UEoUpXc2HxYj3yD1dlFDYv98Ef6pIa7bbm//tTFE9EOuD5MCceXY5GM27pjy
         cBhPr33706YRgezbmeWOTpkfxBVUJrxmqOGzBjOWSlv/DWmsYRaSpW6XsLSisdKi5OVa
         qmnQZxvxzMw3wg24FISl3ZCygXQF5+HRPIRNx/AJJOXQFxayPrcN56hwggPrystVOP7E
         gn2g==
X-Gm-Message-State: ABy/qLb+ozXgkYxUXjQQh6QFdR02xE7nbAooguDvOYhfIpJxh+hs6tK2
        chv9UF2TTctx1QRIVwtp7eY=
X-Google-Smtp-Source: APBJJlFoODgCXbBVvmHU5Iq7k+lss/vfPaUqCTGdvq1YFGM244eTcKQlIwGIboJF0977yJp5kYJw+Q==
X-Received: by 2002:a17:907:6285:b0:978:2b56:d76e with SMTP id nd5-20020a170907628500b009782b56d76emr4647638ejc.12.1688647435225;
        Thu, 06 Jul 2023 05:43:55 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:54 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 4/7] soc: qcom: socinfo: Add SoC ID for SM7125
Date:   Thu,  6 Jul 2023 14:40:23 +0200
Message-ID: <20230706124339.134272-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
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

Add the SoC ID entry for Qualcomm SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..785b88e2da54 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -371,6 +371,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA429W) },
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(QCM2290) },
+	{ qcom_board_id(SM7125) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(IPQ5010) },
 	{ qcom_board_id(IPQ5018) },
-- 
2.41.0

