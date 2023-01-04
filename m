Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343C65DCF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbjADTiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbjADTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:38:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935BF6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:38:04 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d123so18536154iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MPPt/dyVshtWf52UcUhQEVxijzuMl9HV7p2elEFMTA=;
        b=eqyxZvYHjCwXvkgKa7v/M2xonvPpGUy+2+iDHMfQ0Vd/SGkzHa/FjfzGzMOXjw1oaI
         UV2uXLgoEScquxsx4YSoTmgeU6uvwCkI8vX0xcG2JXHLe3561OIVYkTnmVaGCKg7Nlwf
         U1I5zSGA6GMaLJ34l0NGLsrS2LuhmV54zIIwqgQURKPPstnQJBWkgYTXCxMcB9UA4QUD
         ZI5+rWRDs679zytNwskCX96BDlwd35q4kt9PTYaLLOxLac9IfO44tCDDSRUa0pCsK7oB
         +OKQgZCb4v4ZSjfet/AxTyp/Wpc3JqUpfPGvAqK9dgIMMKD2GD6vgr9ZPFzzqjmw6kfF
         YRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MPPt/dyVshtWf52UcUhQEVxijzuMl9HV7p2elEFMTA=;
        b=2oeiOpn0+h/GKLh7jtD6BNXvy+kd9u0wUTNkD9ink9r5j4xp8JK58TAbvcLd7phfos
         ByiDgkFRYYOpDlvx/wvjV4QVKtnc9dIuPHE/Uqf0TC/+MsQmKgSIKpDrT/xRGVUSL1U5
         dl5CaddGXg2wTfEPmW2QW2BO3i+U+yfDLWMMFoPiNs8JMey8AqrPLEE+NejjkWlHyH3Y
         aMXQQ/HL4jZVhNjWnPhXrb+NYN2W9uQa7p9ZXn5EP43D08NH8vz6vhnEKj20vOk2I0XK
         v87v+xX3a+XScj6eSTEl9SxV4QSzhjDJ+LPRJHO8iBW3AyhryAEL5+Z2FVGKEx5OquHU
         6jxw==
X-Gm-Message-State: AFqh2kqi93a4W759LQLFVmCJ70hiovPFcCQjWNgVZlgNpw3i4QtDSTbj
        kmEE2ODQtZEqd3SjEDF14voubA==
X-Google-Smtp-Source: AMrXdXvRQe6tLuzyEXgWa5gnD+XHrVmicUvEHRJwC5iLhskJSu7LVljP8rCXm9PXEJm0e9L9vRLVJQ==
X-Received: by 2002:a6b:6d15:0:b0:6df:5a5d:5e8b with SMTP id a21-20020a6b6d15000000b006df5a5d5e8bmr38148629iod.9.1672861084157;
        Wed, 04 Jan 2023 11:38:04 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id h13-20020a056602130d00b006cab79c4214sm6972498iov.46.2023.01.04.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:38:03 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Luca Weiss <luca.weiss@fairphone.com>, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA
Date:   Wed,  4 Jan 2023 13:37:59 -0600
Message-Id: <20230104193759.3286014-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104193759.3286014-1-elder@linaro.org>
References: <20230104193759.3286014-1-elder@linaro.org>
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

From: Luca Weiss <luca.weiss@fairphone.com>

IPA is used for mobile data. Enable it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index c456e9594ea5b..6f9e59bf43a00 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -362,6 +362,13 @@ haptics@5a {
 	};
 };
 
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&pil_ipa_fw_mem>;
+	firmware-name = "qcom/sm7225/fairphone4/ipa_fws.mdt";
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
-- 
2.34.1

