Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82476694C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjAMKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbjAMKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:52:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3087A219
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy8so51275633ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3myJhmUiWtH4lRuqHXfTN8UvF1xgmdxDNFNibkPzqEo=;
        b=BC9MlILMDFqLAU51lB/3MZX+vYQ8+pMmfSDVPlktQN/IGNMDi6nOhvsBsAFuGdyU1s
         nfC7Ms5Ph7h8D479deeejcBG6DqlcvEuV9XD4Lup9fMztlZaeJVgTlxTZDGDHFUBT6N2
         4G2E/mQh1DTDilCdaJjdUGL1duCG2ayQCN+rgMyfEk15h/9dm8PFrT7AbutXDrlWk7kj
         pmNk84lbD1FCYIUueUfz+UHxsqnewAUf9xEMNP24gaDsM6x/AJaj4Phs5H4SIqx0ZptO
         jQnG14NR3T4Zb5zjzV/t4c1uLXYYe2yiiZcgiV9wt3UmB5tOgeIdvICq53jTFIJTCcoD
         38JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3myJhmUiWtH4lRuqHXfTN8UvF1xgmdxDNFNibkPzqEo=;
        b=otQzBimauYFmy2Xln0kXI2YGc72DAI7THGsi0hDI+iXlHrPA27PidTH8wFb1Eu4IdB
         0gc38ttOdvjypLF1SUQViUjEEIJK71pdHV0mJGjO3zvxafASr2mQjUzJEV7LHlHRCUXU
         m+usOnwxQmOmuBN2b+3Q5oQ9SSJlKiVU9LZQBKcKWGcflGlDg9osnZA79Bf7naY1XTV4
         CQEp8TvnWBc+m7env9Ww3/LHezrzCiq6/SALMsR0F2nDu8Z5TA8u1WEiVtdOqd2Miz0f
         aLwo/zHOnzRH+9jbPhCOycuJIJB6PRI7flCH755JDVZTMDLdojf8eBuLtDCSu2gzl9U8
         pWlA==
X-Gm-Message-State: AFqh2kpkdAVeT6W4aLQ/anDRxAZopAggnZbdH7uSsgYZxh9A56/caSBv
        I6VW+q+Le92p6HHaUkkc7vYN+Q==
X-Google-Smtp-Source: AMrXdXuC+Ik1UNqGaX8tn7V1Fpmvu8fTO228HDTEWSJRFm2T0LYJ0k3KNCWO1pFolMux+0RzuAcdJg==
X-Received: by 2002:a17:906:5dad:b0:7c0:dfba:54d3 with SMTP id n13-20020a1709065dad00b007c0dfba54d3mr10799998ejv.20.1673607043247;
        Fri, 13 Jan 2023 02:50:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm8348581ejf.210.2023.01.13.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:50:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH 6/9] dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins pattern
Date:   Fri, 13 Jan 2023 11:50:17 +0100
Message-Id: <167360698783.32701.16349619919183432543.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-6-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org> <20221230135645.56401-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Fri, 30 Dec 2022 14:56:42 +0100, Krzysztof Kozlowski wrote:
> SM8350 TLMM pin controller has GPIOs 0-202.
> 
> 

Applied, thanks!

[6/9] dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins pattern
      https://git.kernel.org/krzk/linux-dt/c/45277153d46500ce7f4a1637412f0db7c208300a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
