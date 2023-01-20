Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13D675585
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjATNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjATNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:18:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADCC41EB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:14:55 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ss4so13785577ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2axkO0jltwzlj2edHmm0m8ykLK/H8pKwFqLtIcLUF4=;
        b=FtbwFXXoIuMD8AKvtNShjyzUjVMbKQT4bzUsLP5ez7QfmNmOiFV2LlqDXbzY0oAUNq
         qlJg0Bz10QrKUypF06uLEj5+KXUv9itHcV5pAgdEPVtEAINswQaDwZJzoIAeCKVgPHEm
         iIbepClLsO0YwexllhSmJ5BBD/Jqtf4gG4l9hbkz+LyqKy6DenpC0pKsmfnNh8lVt2NZ
         JR2q8krQvhivMXRkiFEVOglZ0deWLgnYQN+7ZfSM5m6KlCj6eCUZxNQtx16FY6Mm5yF2
         cscGIiKNK/zol1hikoqh2MsZqsjKiNbFa0aNb2txI43FpWiZmqCu/a8FuzudbgHQ92rW
         lBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2axkO0jltwzlj2edHmm0m8ykLK/H8pKwFqLtIcLUF4=;
        b=tWt70Wrfd/VeHNugq8LVazmbjZx6iNYemg9IUBKQ6FeoswiFrpYrvHm2IYA3jtzG1V
         hFl/F3BE77TGMc9ANRKpSOrjZYwqwWVFzgwflwf7BB52wcqXKu7ox3xBBgmyDEsmHZTT
         jejPhnnpOzGkypTF8hpRjj/Yby7r1eKodKqqTEx+6re3gEIXlKIEsaj/aEQ4o/LsIvIy
         cgkZ0G4WDJja64wgAZjNpQh7RL+gi8Dpi1qeY3R8JwT74Uq5V8pbY77t6p+xNK3+hAeZ
         ZbIlt3YSd06IgbXDnvUfeQZ4pjn39TDEl26uwuGSuLP1y4lHENvp6cmvLYyvP63IBBbE
         3oHg==
X-Gm-Message-State: AFqh2ko6/q2AWxJJHH3CpUXe55DOddqAH1bm8twr/jwOpTA3HLUUUbkY
        XbZnPdHszGtLnBOvHMmK7vOVVw==
X-Google-Smtp-Source: AMrXdXuNj7H7WV/FgoO6xkTJ3TK+NZyaRSNePNvZZway2ahmyVQdBgmsY5nhwdolCyRMGfSuAuWG8g==
X-Received: by 2002:a17:906:1c81:b0:86f:d1c4:ed08 with SMTP id g1-20020a1709061c8100b0086fd1c4ed08mr13855278ejh.69.1674220494108;
        Fri, 20 Jan 2023 05:14:54 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709061be100b0086f40238403sm8063276ejg.223.2023.01.20.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 05:14:53 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 20 Jan 2023 14:13:47 +0100
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable CCI
 busses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221213-sm6350-cci-v2-4-15c2c14c34bb@fairphone.com>
References: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
In-Reply-To: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12-dev-78462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the CCI busses that have cameras connected to them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index f0e7ae630e0c..ed0cb70849d3 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -363,6 +363,26 @@ vreg_bob: bob {
 	};
 };
 
+&cci0 {
+	status = "okay";
+};
+
+&cci0_i2c0 {
+	/* IMX582 @ 0x1a */
+};
+
+&cci0_i2c1 {
+	/* IMX582 @ 0x1a */
+};
+
+&cci1 {
+	status = "okay";
+};
+
+&cci1_i2c0 {
+	/* IMX576 @ 0x10 */
+};
+
 &cdsp {
 	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/cdsp.mdt";

-- 
2.39.1

