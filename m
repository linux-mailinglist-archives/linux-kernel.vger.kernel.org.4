Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00983670BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAQWo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAQWnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215666CD7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id tz11so14507696ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/649yjEuK23rZZzK3k1WHwJIEsvrTOVei/MBU/upUo=;
        b=LTbrlGLrZvUgcQ1jtBvu5QHiVbmOZuHuey3EpptHHUoKDfLK46vSH8ZT3dYo89GLVw
         RK5CZn3qVZYlm9IFkiGwg6IvxbPuiFrhFDQmpW5H6plhalBm+rkZTscjEkeb3/746dCz
         Qy4sV5ov893ugyLT792EqKLCLvctSXYmzQ4tqranpLjTf1YYxbx/hD+E3tZATah5+3So
         YpDLC0NIH/hUKdHTfdRp5dHJD6cw/nMhkgvWs+ZWadQqMcWjx8yWGmVfxNLbkQk+16Ky
         0v8DH2q7fU5pHkSvhW6wIkc/MokT85QXy8Q6/gw5D7ghWyXzfQqBcHzfw4mQehhn4mBi
         slsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/649yjEuK23rZZzK3k1WHwJIEsvrTOVei/MBU/upUo=;
        b=3+DIIay6cvfltb+B9z9YbfMaJzxYoqpPklqBZ4CZwNUBdKooeweMKS/eJ4SNekHrb2
         wbGhqlX8Lr+MuQYxE4n6jXRvjkrvzRItWr7wBewGj29hHR54Bxgkxjo2YM0O4352jK1/
         esYkhuK+NwuQQd+GVji8Wo8eILo7e3BbWCo9cwvNTcm1AuxHZxofy9UDCktrN8feLo9q
         utj0h+DisvXDPdvHKvpuq+R/WjcGCJyjw4uTDCHJQI5AZxCIwrFn5ZRjSEKBH+tLfyRU
         3lItXsFrAt2Oo2vc1X9QHavAahKn5PM4xHj/q24mA9L4ykm3KsRL2lYeOjeDXMrbX4pa
         KK0g==
X-Gm-Message-State: AFqh2kpSehWVgGJPkKQJobSLvC32vzeT9EMnYE67MescPhsSRXUJrcr1
        G0vXeGuYUQ6IcBTttVb0v/rSHA==
X-Google-Smtp-Source: AMrXdXtP74UzqEdjchqIUiS/J3XmwshoVvYZSgQukiS//9qMvVXCXdFUIWuEj453Xzb1A5rTPJWndw==
X-Received: by 2002:a17:907:cc2a:b0:86e:d375:1f0c with SMTP id uo42-20020a170907cc2a00b0086ed3751f0cmr4406823ejc.37.1673994619093;
        Tue, 17 Jan 2023 14:30:19 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id ec20-20020a170906b6d400b007c0f5d6f754sm13835189ejb.79.2023.01.17.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:30:18 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] dt-bindings: mailbox: qcom: add #clock-cells to msm8996 example
Date:   Wed, 18 Jan 2023 00:30:11 +0200
Message-Id: <20230117223013.1545026-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
References: <20230117223013.1545026-1-dmitry.baryshkov@linaro.org>
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

Add the #clock-cells property to the MSM8996 example, as the APCS block
is going to provide the `sys_apcs_aux' clock to the consumers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 7d8de7a16984..1633aa82fc84 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -166,6 +166,7 @@ examples:
         reg = <0x9820000 0x1000>;
 
         #mbox-cells = <1>;
+        #clock-cells = <0>;
     };
 
     rpm-glink {
-- 
2.39.0

