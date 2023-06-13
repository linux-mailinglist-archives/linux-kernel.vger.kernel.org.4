Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4512572E531
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbjFMOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbjFMODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:03:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13F02105
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51879487e18so956531a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665012; x=1689257012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=JWFrVCzyLFy6CqPFmqqcXfRWl/ZeOmY5cAPxItitCG2GSxUYodXCoIkvJp5mVCPmmu
         SgjN48AopiP0g+o1PXNPG/iDxVgiFf0RY7H3UD/i79TL1cHXtabZwHznOuN699NmW4jP
         ai3/SBOa2DRoF6COQXHCwYy5kQUVWV4LN6DZR0LmVxFwx9suEqRFy7WCBYzH5GAbekIV
         ZClivZunzCVkjpPjJ6ipzbL29xa0Oyb0WkiSCAmv4LNOrn3gIGvJ1g6KHjsay6CdvJNj
         9V5z3NPmHYGqm/ZL0bSIqyFb8S/x7PmIik8JfnpwLoVnf8EwvGonu4wgjed1lmYKedUj
         APDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665012; x=1689257012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=EkNWaK+BInTUP27Bk137kaI0j6dlFoQrIl/u7Mc8Ti5cp5HcX5nomaydjoU34yEKBo
         vVuNr5mpg+KQRonT4L/XRw1d3y8Yo0jk8H8GXvghQhE86N60H20duUiZNjROwh8p5Vdk
         7+jDySBr5JIR5rRy2Xd+7HvBru543PHfwWhMSD+R57+HPpHs+S0BKLuo/yd92mGTQA01
         cyXRGBYXPgLUaUFg5FaYEHNIAZcKMU4YaX+mynmGh+pmgMFVuM5+ZANsv8Rz6Bc2Ymw9
         Vzp4nywjUSmnCcfYgsvY1s8N+i+20VlaKbPhYg/D/AbjOLHd7CpBb3+unwxVpi45dAgC
         jeBQ==
X-Gm-Message-State: AC+VfDx3k43xD0xNr3+IaQkgNk1Sos3jKN3hrdZ7mRZwewqKhPOKYqMK
        sTodDMxza6PgHUrW0LuokIfbsbZRh8TgCCZhRHU=
X-Google-Smtp-Source: ACHHUZ7aKpFKuiZWnq2Ux5sIXUigwaKgfMGsH6NF903Bat0KexP0k974tF3Z6crgiEpYTpBS5/Ei5w==
X-Received: by 2002:a05:651c:117:b0:2b1:bd37:e7e1 with SMTP id a23-20020a05651c011700b002b1bd37e7e1mr4850383ljb.32.1686664991733;
        Tue, 13 Jun 2023 07:03:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:02 +0200
Subject: [PATCH v4 02/22] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-2-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XHE1WQYZzaLo+c3xD4ALM/GRb1VwY7GuxNqpdL0mBnk=;
 b=0hu2uLKM1PKnDIKpu/TRmCfDjaloa6VaYIarEIKVnJ6/AzAc22Wjp6IAZQP9iZX+VdG/ATjf4
 SW+4bjBHbRJCKeF4inUFUocAzhieblB734hHD8cQHgVjsJSJbqEF9e6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a preprocessor define to indicate the number of RPM contexts/states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 2990f425fdef..e468f94fa323 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -6,6 +6,7 @@ struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE        0
 #define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_STATE_NUM		2
 
 /*
  * Constants used for addressing resources in the RPM.

-- 
2.41.0

