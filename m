Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBB7073F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEQVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEQVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:19:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBC7AA0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d139e0d67so11369b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358302; x=1686950302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF+7RIYO2NHXGA6P5+vCgbOZX4fdEtvPnQSZuYHbKNI=;
        b=ww4ish6tk4YHTz2au/iHbJFIyrXvLDXsq8IWHUekpRD0/FCDdPLFHU5fzmlorGRTLD
         XW2tpFrTSLlBQABfRh9xJx6UGXTS2hP3jUzCWj+k/LYt3Mgxixpjn3cqcK838Did/9WV
         rfooWUwHGQwUV3N62VtvZ37mnmiWAa0DK/bQpTg9dMC2/ojWDo7WVtKnZuUlNeOjxN7R
         jdxIF+XbnPR304UpWoUsXz5IjHqz7hlkv41Kv4aBd8/FOtphgtBy5LFybgE06CxBJtsG
         0daUnChB+/MVFy6k7ZHqJsjo3M0cSYsNjJjbmFXnSZgZN2sXTD0xVrB4vqGaeQJuevT+
         9GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358302; x=1686950302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF+7RIYO2NHXGA6P5+vCgbOZX4fdEtvPnQSZuYHbKNI=;
        b=deJNBoG1IyHKWZLuUuhriZGpacdCmx7YfWAEtmpZXE2DM1/0pl5XAjqkYDEYo9VcI1
         vsqSLJA3old+e4UQ2+fB3brHSQfiv1kekmNvZ8QsfOxeMEXtdLy5CMp2+sV7d0NnKoXr
         qUnFu4Mbt17cBNcF2BbCdGtDzN/MKrXdWyvUdcn5RFH2n3uOmvM5PzZ1N3sLE9WGSBed
         xDwADnN8paIIEuuVcUkwDKBvrqbSaCaWX+BO7fkHkmuCKGwJgklwDct3gf8gKe9s5WpX
         vqKcoEcjDSLczCz4GRhpOC5ZRfGoLL2M+HfguIA/opy+YHhHXoHhTcY3yiuZPG+ahOJj
         RoNQ==
X-Gm-Message-State: AC+VfDzFYmHqJsQ5N8yqfE7N7OvzuAp6eRTH5+Lp+FHxmXQfwXC8MKuJ
        zcFO/WsrLEJFqiQ8TZdUtN8/Ow==
X-Google-Smtp-Source: ACHHUZ4l/I0VpnhhBMLrBn7uwuEZNrxShjfe+DfG2+bGSu3lNggX7kQ+10Sv+Y4Qiph6nD7QsMFCPQ==
X-Received: by 2002:a05:6a00:15cd:b0:646:5f98:6bb4 with SMTP id o13-20020a056a0015cd00b006465f986bb4mr1412622pfu.33.1684358302552;
        Wed, 17 May 2023 14:18:22 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:7a51:340a:a439:1b87])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79052000000b0064cb6206463sm4359210pfo.85.2023.05.17.14.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:18:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v6 3/6] usb: misc: eud: Fix indentation issues
Date:   Thu, 18 May 2023 02:47:53 +0530
Message-Id: <20230517211756.2483552-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of indentation issues in EUD driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/usb/misc/qcom_eud.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index b7f13df00764..74f2aeaccdcb 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -22,10 +22,10 @@
 #define EUD_REG_VBUS_INT_CLR	0x0080
 #define EUD_REG_CSR_EUD_EN	0x1014
 #define EUD_REG_SW_ATTACH_DET	0x1018
-#define EUD_REG_EUD_EN2        0x0000
+#define EUD_REG_EUD_EN2		0x0000
 
 #define EUD_ENABLE		BIT(0)
-#define EUD_INT_PET_EUD	BIT(0)
+#define EUD_INT_PET_EUD		BIT(0)
 #define EUD_INT_VBUS		BIT(2)
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
-- 
2.38.1

