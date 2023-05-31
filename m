Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7D1718173
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjEaNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjEaNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:23:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85C188
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f3a873476bso6519816e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539374; x=1688131374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tol9A9dtGHcljHA66FOclMfTsKdcHJMB2d8cTDTmgAo=;
        b=e8Y3CLw/f/V4tCjLk1sQ6W6ZugdpMnijFSP/xU/Zw4cfrLClvUO5rS1mwdooroa7HP
         aYZhKvFzszVsXp0/L0XXYUmeYzsSDa413Tjwq9pAcjFzZXw/0wmncxulUAvxbICTvO99
         qMC7AG9eQm84UQOXechsyf0gDG28MU9tgLrrxlVqF6+1IpIaTxs3Be/n4cKpIHwi7BMm
         V4qPwqlWmoU+/IZ0YaIT5Tzba1mEFsxCWOyJmh6ZYsi91KEg6y3cSrQ7auLzCQK6bGgR
         4lAFndm8NkPFAOejA7MbLy9bt3WJU1QPuJhhnrSJEHVFC3Lfez8pfD1VGveB0kK1wXIw
         xaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539374; x=1688131374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tol9A9dtGHcljHA66FOclMfTsKdcHJMB2d8cTDTmgAo=;
        b=M2zJ+ys2xnAHfD5BDneot9K7Y1dgqp6Q1NddPi8GgDTWafu8AwDgoyi8T1g5uoS+DE
         ZBNJwNAjxs3ZVxpSHkXC4455db4oae2UsgOQ7Jqpi2Py+FvJHgYtlUtEICLcRgbFgdaz
         0MG6UkNGX9jL/qRi2HLfDbSz8nOTQRAvr+C19v3bbZLTcOlbul8moq09ATGKGf6Drt/J
         ushmqptnhWb1eGzVZBoUubbPKdG9wVYzPiIKyGL6MlIqVDMD2ySsvVphnpS1tYm4LlDc
         QGcOup0DDXKZsOjHTe95Idw9sstfqttwhVgw7HqzJyhMr//uXtYk9tmjt3SpptntICE1
         N6uA==
X-Gm-Message-State: AC+VfDzh7hX5gGR+v0rjsxxqLv6hdphfGvEEAWVvQcganHzntCLRx3xH
        swwkau1lQwAa8rPOb+PzFyPE/g==
X-Google-Smtp-Source: ACHHUZ4wr1et8fG1AVns6Kla1jezuM1cYJt+yFsgoC5YdDjgAGfzwcT0T/8h6i/9aWAnZ6p2cMA5dg==
X-Received: by 2002:a19:ac45:0:b0:4f3:b1e6:4b46 with SMTP id r5-20020a19ac45000000b004f3b1e64b46mr2632154lfc.12.1685539373825;
        Wed, 31 May 2023 06:22:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w8-20020ac24428000000b004eb0c51780bsm720138lfl.29.2023.05.31.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:22:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 31 May 2023 15:22:40 +0200
Subject: [PATCH 6/8] arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-topic-rsc-v1-6-b4a985f57b8b@linaro.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685539362; l=956;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Ji2UGqd5wvE0QH520QUaPwq9VzlZOXRjNLOcK3RP5/U=;
 b=7BHvx2rPgpUf4NGxNs3Ob3YsDzbMYUXZaXhT4iudfbPuf7mxO1f4JTGjJOz4Djv+l7lVa47md
 ups4U6P+9cuASntmk4hnty2tNaFVYB7hiRjRBwJqPR3fS/DrU543Qi8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Fixes: c83545d95376 ("arm64: dts: sdm845: Add rpmh-rsc node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 950305aad44d..707550ef4990 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5138,6 +5138,7 @@ apps_rsc: rsc@179c0000 {
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";

-- 
2.40.1

