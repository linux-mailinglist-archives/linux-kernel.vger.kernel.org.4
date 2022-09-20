Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82565BE4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiITLmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E274BA3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so2264852pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=24eJhxzPFfKXUwOZKOTRmoYXZNNfpL+aRtWSIcJA8uw=;
        b=Xe/mLl+ylNGdFdiviFC3iqKG4YggC/bpamn+R5OuBr+rEewpMweGd9RWgesWYiNKKq
         DV/aB/0HC/XuiKuVj483yQoNSwdMAzDaFIhT3r8fJOC6+AZ2tukFFKMSXgXBnsJMvzrt
         XGwgDE7N4QsAXnAIp47FYjmku7cBupvgDlW9vwr6zk/ZB9CnSgJ/WJIeIKwSo5L2m10b
         qIrf/g4cTHuLvqCyrX58WheTER+qsKEQVf1J+8gTqHfttG6Dl3SWabrWY9f5xAQcZqfb
         4kvW5pKJkxN1huZ+uViUZJa2i4ltsOuskgxBDpRvzFptk/x4vnS2BHo1pNPCDyJxL2j5
         kuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=24eJhxzPFfKXUwOZKOTRmoYXZNNfpL+aRtWSIcJA8uw=;
        b=1IKYrz8Fw1bOmfH0iLNsupNTYt4zOWPl5O6tYcEPcPJ0E2Js95nrYxQj6H2Rk3+1p5
         Jn3/vuDP03FnMP3etm9TWMFfAXVisid1t6HIkIF3rb0hKkTwuu1DMXBoOYWTgw53fFNx
         Bd8tDt1GBtuUMjtHdxgTovcTTxQkBXjKUnzMe+Pz5xmuvDtYLbKA1u0f/DGMTHBOK7Bv
         ilIAHixHqj4QEbpe01qTeffMnYf72BjNvcsk62CngxTWaY9Mwv75bJoTdxd6yiDJvqxC
         IOKeqqvyXCNbihM+jLM/0x9+xRr11fpf/O/r4zTSEz07AP5eA+SpnoDj9lwHMp7OGADY
         MNSA==
X-Gm-Message-State: ACrzQf0sJ43IhRVfvLxt1koOVz1TWRS52KKZ1bErjWm+xrlnQbFYBkgs
        PLZ+WC1kWQsEQroehUujpDcDFw==
X-Google-Smtp-Source: AMsMyM4lgKA4KDnGlwop2eDvfZyX0HcQJj8xFPEpIdTSpOtMPvThWvag/f1sRsoijw8khQVuHGBgDw==
X-Received: by 2002:aa7:958e:0:b0:54a:792d:bce4 with SMTP id z14-20020aa7958e000000b0054a792dbce4mr22712441pfj.25.1663674094508;
        Tue, 20 Sep 2022 04:41:34 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 6/9] crypto: qce: core: Add new compatibles for qce crypto driver
Date:   Tue, 20 Sep 2022 17:10:48 +0530
Message-Id: <20220920114051.1116441-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we decided to use soc specific compatibles for describing
the qce crypto IP nodes in the device-trees, adapt the driver
now to handle the same.

Keep the old deprecated compatible strings still in the driver,
to ensure backward compatibility.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: herbert@gondor.apana.org.au
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 63be06df5519..99ed540611ab 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -291,8 +291,17 @@ static int qce_crypto_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
+	/* Following two entries are deprecated (kept only for backward compatibility) */
 	{ .compatible = "qcom,crypto-v5.1", },
 	{ .compatible = "qcom,crypto-v5.4", },
+	/* Add compatible strings as per updated dt-bindings, here: */
+	{ .compatible = "qcom,ipq4019-qce", },
+	{ .compatible = "qcom,ipq6018-qce", },
+	{ .compatible = "qcom,ipq8074-qce", },
+	{ .compatible = "qcom,msm8996-qce", },
+	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8150-qce", },
+	{ .compatible = "qcom,sm8250-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.37.1

