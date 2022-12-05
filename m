Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF6642D42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiLEQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiLEQjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38194205C4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:11 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x22so6822028ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7SDPTYTDrfGEJ+RynD2emKN+BNWTJBfUnEQ5w+gbNU=;
        b=ZhC2zj14H0eBmdnWzrKouWVPbOm5dk5S/NuWAx5+8eAyP12MMQahYkPEr4yqoDddt3
         FWiVAw+SwGMBeFuo8I9hrXXoOw2UYPVWB4Y2qovyyQQEUua9mkJmCNzwOYtFmH8CNJdO
         NcCFZ9m4OyPlFWF/mfgWGhblIf8mwPIFxcFji4inEG9hgANnHgEVPfkhz3qw8n+ZbeUO
         ELznAooSanBdflFmyqAe9bLrP056n0G5733Eb+edIhJaMITf9WB9zuRvy1OgPUNSIic5
         3pfhp3sskn2oNhh4YOX1O5nTkAifEu2gmtpPIa5VSwTQMjIzxfefj43/tf9FPb0EhE7u
         Xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7SDPTYTDrfGEJ+RynD2emKN+BNWTJBfUnEQ5w+gbNU=;
        b=6oyW8MjfUyl/oao4hgnApNHflOfkzkYKUAmF2YbnSoSr4N3VovYyyzQrm+mWtnsY6T
         xerNC+UIM2KyA+oXEMO8QmIoZ2QK0qC0Ge7fbwuvibygIPseJr7VZTBfEnNWwYMEUZba
         UyeB3TNlfyTjyxI9GYgaEGZB9RZPF2pW0Pp5/XnSwJT3Z0YbBgH5wbz/XkBzeVd53D7b
         sum0RxhFdn6x/UbN/2HdEoHQty3fX/DfPsm0OStUc4PpzGR9uyKdC67Z6IOzCfkSA8Vf
         Yre/SgobXJYhB7X1FB1UZpjVDyrYG6eeLmF6bVUrUUX/ogwPT47BQIIfj1BI1+AYpVnb
         iVAg==
X-Gm-Message-State: ANoB5plXB1gX/6r/7Ymk5cuHq8rFJBXGzvT81NZ0TxVDMP6daA5cUNFv
        wOAHupimHGv616dx61h6IjWjwA==
X-Google-Smtp-Source: AA0mqf43JomvYsw3VZj9x6ZUq2+n2hGeCCKmwzrPs7hKUSlkv5/K9Lwfty0KSSSuXHZrRy0kTQrtVg==
X-Received: by 2002:a17:906:4087:b0:7c0:e6d8:7661 with SMTP id u7-20020a170906408700b007c0e6d87661mr6269511ejj.242.1670258290825;
        Mon, 05 Dec 2022 08:38:10 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:10 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        robert.foss@linaro.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 07/11] arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
Date:   Mon,  5 Dec 2022 17:37:50 +0100
Message-Id: <20221205163754.221139-8-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205163754.221139-1-robert.foss@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmxc power-domain-name is not required, and is not
used by either earlier or later SoC versions (sm8250 / sm8450).

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index cbd48f248df4..805d53d91952 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2558,7 +2558,6 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 
 			power-domains = <&rpmhpd SM8350_MMCX>;
-			power-domain-names = "mmcx";
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.34.1

