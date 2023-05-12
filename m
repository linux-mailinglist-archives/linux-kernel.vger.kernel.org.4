Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAB7006BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbjELLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbjELLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:25:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC56129
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:25:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307c040797bso1964678f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683890750; x=1686482750;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYeMvzhacTAsEhRnGaiSXOklc6JbdbjUEO+PqKj86EM=;
        b=dfv2IP6dc/J7G7LCOD6YdSjkGbLk6Ym2enw4dsh2izhdZq4S3jUNgmbNkoOZTGgpVG
         Vxz4fEDBwar1w40gWofnY1aY1isxVn6EGJviIbfXtsZQScLqUBK5QD1TAtEPdLBg4xpo
         Cc+7ftFm93pLinp+H+dhQGhU77O4h3oqQ2AF/3x+EoHMPACSlSQCNNbv3VqPU0qJWymA
         YtvpWoBvdwjOvZ8h7n+H1jgaxhAzlDUg9wd22N2+OIW3YVgNS05lHWaRa5uyL7n1fybQ
         bmzReIiEy51m8sdNhp6QdFc5dPPKIf9B9uNv7bNVDBUM4Jt3bJ134ACU5AQvVPhSvtHF
         hWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890750; x=1686482750;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYeMvzhacTAsEhRnGaiSXOklc6JbdbjUEO+PqKj86EM=;
        b=lQkruFDeQ0bVrcQ1euFqGwXSWVq67y8DNhU2kRnJVzfgc5IGnvlh1As6hkHAvCZ7Rx
         +E+Rg0HHmz7ulFwGBBlOoJWGuKkMZQX/TIOpbzu5SY1Yds8jO6d29s0E79Jlb4Ke0dc4
         OBkwd/JA24ipaKRKcvcvU3yOGM5UkW+BurHPd0yzkBfLPGXlpLNbra6mUSXSwYTuo/N2
         JLsksaOOW6BghaAc+9XmLxk+FRTLXkQjogp4NZdPOniTOf09AZuSEFmfQXg53zzqfGGp
         Mq5EKH526ZwuBU8lR+F8Ax/JjjJMuQMHciOySp8y0j0QILPbVk7GXVLjSLvAbAJ6o161
         XxFg==
X-Gm-Message-State: AC+VfDySLPAprQ+w4I1tti/ErZ6N0cLd97+bxRmKrPiLvcJLFRMGP9iY
        RbZZ4VtX1CPyKoE0arxm5WkPbA==
X-Google-Smtp-Source: ACHHUZ5/M3ZTfApneO2t4X8QYio6oz00ANSzZfjIz5Npz04E29FdhAnsPQlbM01TQYxvdJJfOHEG8g==
X-Received: by 2002:a05:6000:510:b0:306:2fab:1f81 with SMTP id a16-20020a056000051000b003062fab1f81mr18570217wrf.21.1683890749922;
        Fri, 12 May 2023 04:25:49 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id u19-20020a7bc053000000b003f09d7b6e20sm28284207wmc.2.2023.05.12.04.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:25:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Kumar Thella <sthella@codeaurora.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
References: <20230505120814.1057152-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: nvmem: mxs-ocotp: drop unneeded
 address/size-cells
Message-Id: <168389074843.55515.5646738672764702598.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 12:25:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 05 May 2023 14:08:10 +0200, Krzysztof Kozlowski wrote:
> Referenced nvmem.yaml schema already defines address/size-cells, so
> remove redundant entries and use unevaluatedProperties: false.
> 
> 

Applied, thanks!

[1/5] dt-bindings: nvmem: mxs-ocotp: drop unneeded address/size-cells
      commit: 6c1eb69485752935580226a2e39d366625d0fc2a
[2/5] dt-bindings: nvmem: qcom,qfprom: drop unneeded address/size-cells
      commit: 426b30ed585c09b9bc6c3d615ed264b2f8d6c56c
[3/5] dt-bindings: nvmem: qcom,spmi-sdam: drop unneeded address/size-cells
      commit: 2881bbe70740e663ab29ce7da80d5fb0b9cd9518
[4/5] dt-bindings: nvmem: socionext,uniphier-efuse: drop unneeded address/size-cells
      commit: bb7a2f40d77337d9fc5a6e0bf12cc89620b62241
[5/5] dt-bindings: nvmem: sunplus,sp7021-ocotp: drop unneeded address/size-cells
      commit: 103066fdb0dedd2dcccd1e0fa4255b9b46b46be5

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

