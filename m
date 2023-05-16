Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC99970454E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjEPG1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjEPG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:27:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33271BD9;
        Mon, 15 May 2023 23:27:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaef97652fso94723305ad.0;
        Mon, 15 May 2023 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218444; x=1686810444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDJU7d4CldRrZbTj5Wu/ESDtc5CL1I9TeYQbHB2PtSM=;
        b=RYul+8KFV0YsDXiizxVd7ZTOSng23EQbwCPvT2UomqojgwgtelJY1Xds4rf+hkU2N6
         3d4Cl6B0k+HX7J53pV+zFKnsQUjyHAc3okBFF/zihacBDbjt4xJmJtjvwsxuMr56kOa8
         QflmeCjOTwv2VCC8rW24shyRS9YHDEuUMeF0yIsjD6ZckzusiBfBCPtt8A9lOmgApjVn
         1G6blP85CBIkaE8sAak7N6PNoKS6CsDWA9dKnf3hrPb5XIM5qD/nKBUp2NpxeyEPGbEI
         AY0cXp2N6h85vI3DA6nr1orgTkCv7L9lu+4QA7c3sACCJ4Be+dRSs0+tmpSJiaI5HiYc
         492A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218444; x=1686810444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDJU7d4CldRrZbTj5Wu/ESDtc5CL1I9TeYQbHB2PtSM=;
        b=KnCmLYwO4VlevQq3/8khd1hUJScDm4vTpNmtQzLgDJhv+IcYEmDjNskpnjKi9aOZ7y
         5RN1/XskWA3FTlrBsy3DVl02O9ZDGY7EjCPwnVzPn9sFukyG2i0+ancpF7Tt8Do+oQM1
         HVWFMCuSMV0Vh3lvjzei0dAmAzM6KNHEodAcZASENFUY7ci9kvas8dUkFjQPBgCFYvNJ
         S4QMJZbHZh6+RPUSYZR1Z5Z99R3/9sDlfjNj+Rc7UAQIyxX6yMSUavu6EyNlwyRXNqQa
         wMVpXCn4CfyXwg809iUT/7gE4lWNPI5ukhiZ6ZuuKK5jQPpnvL2ZZh/WlZYATTzrHQrX
         SE+Q==
X-Gm-Message-State: AC+VfDyQHvuIr7pQfgnNDKC2DlzG2VN8JeiRTU++wHesofaGclgnj+30
        qFWCp2m8SJ1Ie7R76hBdXAE=
X-Google-Smtp-Source: ACHHUZ4+6x7bslUpOA2kbWjjyhXhO5nDmcecsqWTE7TLBI3nXL3l9PBKUvKQuHAGP+ZbjbSwhjs5Ig==
X-Received: by 2002:a17:903:230e:b0:1ad:164:74ee with SMTP id d14-20020a170903230e00b001ad016474eemr26560319plh.15.1684218444120;
        Mon, 15 May 2023 23:27:24 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001aaea7bdaa7sm14579710plx.50.2023.05.15.23.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:27:23 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [RESEND,PATCH 3/3] arm64: dts: qcom: sm8250-xiaomi-elish: remove redundant empty line
Date:   Tue, 16 May 2023 14:26:57 +0800
Message-Id: <20230516062657.28616-3-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230516062657.28616-1-lujianhua000@gmail.com>
References: <20230516062657.28616-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a redundant empty line introduced by
  commit 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")

Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 8af6a0120a50..eaac00085894 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -504,7 +504,6 @@ panel_in_1: endpoint {
 					remote-endpoint = <&dsi1_out>;
 				};
 			};
-
 		};
 	};
 };
-- 
2.39.3

