Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD896049D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiJSOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJSOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:52:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19352F007
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:44:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j8so111356qvo.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAiE2luUgguCr/L2r8DnPncve5Vq4sxmrnvScAdpRo8=;
        b=yGphDyEdRMVIZNTzVT3f4c9yi9OY4a2pravvCaU7yb1IH5hGbrH3QtVAwcuizXxXr2
         ymdqtviLrjriHkapeqKFgOtTxD3G4nzoefzBu3/XC5OHE59lykY2izH64QM/+7zf8AdH
         apaZu9xVriBoB87f4QEydeWZ+2ESGu016u6G5HIILP8/E7gCVNMLPt2LlMq2l8H3A6iW
         XZ4RF2I2fpJX4PcvHCGmeTuY/9fF6m/PHTEUjYJbBZnYcb+grYRNFBz0LYe39gxYgPVA
         Bh/vzZD/M8+ufqVKo2/Ly2VttFv06iMhE9PSgZiRWS76rqMefPXYKSlVz0Ci17tdP+uG
         dWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAiE2luUgguCr/L2r8DnPncve5Vq4sxmrnvScAdpRo8=;
        b=gt6+OWGMTEALb5BUtjFbOefh8AaDtEoq9b6Ytj76Jz6PTHjqqqya5HACRD4Ztdi/Os
         49ro4lTiC5nAW8yjGPD0C6cLvv8sOHVgKp3nADBLL/q8BjRIoWNeyiopw64Fz1U7UnnR
         8pSY4yCiLmeUdwTQnRLsUGVV+sygyPx3BaXhKpiWhelAksam1j5a2MtfuPMpxh/3Acg1
         9rkBVq8O1d6lrvBtxPrF7Y8GYnJunG4yvlX0TSHma+ua0IjhIW3QtdjKlS+tN2hSlkx8
         g5MdnK6GGAipO8TcAm5QAAAQhuymNuOISKA/IASVwMy/0Rm+tAEBlo1i+jS4ZVmhA7bu
         Tvqg==
X-Gm-Message-State: ACrzQf3rR/OEFmuJ9E2eWk/CQZZjaY1f1ZE8JGVZLszwH6xjL3ZshNT7
        g8CUpVyCEUPO2bXSodUHO+T+XA==
X-Google-Smtp-Source: AMsMyM5rwTrVuM5sxipGPMmGjkWNytNa1xrt6J5pG0VOlsxRXgfsVcDlqMAN0IGuzZmveHg7IydYKQ==
X-Received: by 2002:a05:6214:550a:b0:4b4:dd2:be99 with SMTP id mb10-20020a056214550a00b004b40dd2be99mr6934158qvb.123.1666190678602;
        Wed, 19 Oct 2022 07:44:38 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006ed61f18651sm5211917qko.16.2022.10.19.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:44:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: drop minItems equal to maxItems
Date:   Wed, 19 Oct 2022 10:44:30 -0400
Message-Id: <166619067067.168589.6119506047400360874.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
References: <20221016173625.53769-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:36:25 -0400, Krzysztof Kozlowski wrote:
> If minItems are missing, they are implicitly equal to maxItems.
> Dropping redundant minItems simplifies a bit the binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pinctrl: qcom: drop minItems equal to maxItems
      https://git.kernel.org/krzk/linux-dt/c/c3da325b8fbe809af1ceb14d531f55b5b518a685

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
