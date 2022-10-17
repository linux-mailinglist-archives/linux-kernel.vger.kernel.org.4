Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98C60189A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJQUIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJQUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:08:27 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDE79697
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 8so7410563qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdC5nxyXzAXv4k4E+7JQ7BAuFg0c1DNv36UsU1hqjTY=;
        b=nbbJeovDD/h3RG2AFYctecGdTMKeGG1ndArDFAX+XEa6CU5gKNMQkjLZxzOfFSew6g
         pfgTe9w2oviO0Hh191eqpLqO2dT+IQKs9r8KxAQktPik9+XeLHIc2V//AGMzSPA8FKsI
         5SE9yWF4fdhy+6NubKG05/EqpDWhVKjKYFV5a6UYacCi94Vy48MQj7A2lk9Vy8ChO4xD
         rrnlWEfC+g0OJeA5KI5WtlSaDfMpaxzoEAYfYoLO+udZloWR1in1fmEgpNhnQFmg/yGU
         dBuaXn0XuH0EtL9U+r4AQcw2Je2Wu8Ds+ZKCk0vrqhyxqB2MPjbbKLeUpv3WElVIA71/
         YYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdC5nxyXzAXv4k4E+7JQ7BAuFg0c1DNv36UsU1hqjTY=;
        b=mrIspwDGVGOa/9jIWwbCoD/2VG4pWN6HKvKvL8PVlNGCYkQvFJ+O1mK9iI8B1mh19Z
         QsQsUdQ1f3IR82Nfp6vUDY5la4qPElps5jB4spFRGUPX8/K1GBC4KGBifHnp9T+Tfbcz
         aMaA1YPp+tPqi479iekUZLhHLLJ76x5XPsQYeLeU7Y+hcwmJ2HJJXERnrYBUg9eZtlpb
         drS+nE3fSLXSRNQCc/YoqMuSsUgygyJZEUXjKZ+ub2oxrK8U6pJQPdYHFBtK9B7v2EBd
         9EHdb6lx9gcNHHhh98BdDqmRW4DnlvAdaUe4UgAG9XinJh5smDgJQamdX3W/lNS9LIAd
         4UCQ==
X-Gm-Message-State: ACrzQf21jK3UM8VzLbkUFLP+jWYxGrIePIfLSO0m8ek4/CpfqALfDqGR
        azZHgabDY2Vx0u9XA+4NMRibiw==
X-Google-Smtp-Source: AMsMyM7KmC7znzpKfpH9zAQOjG4In62SkVG2lxnRR8FQhrOuqn3fwNoPsZ9jqRUGhWoM4rd2ZtD6Eg==
X-Received: by 2002:a05:620a:b96:b0:6ed:1daa:8040 with SMTP id k22-20020a05620a0b9600b006ed1daa8040mr8817497qkh.294.1666037304555;
        Mon, 17 Oct 2022 13:08:24 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:08:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v2 08/12] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix matching pin config
Date:   Mon, 17 Oct 2022 16:07:43 -0400
Message-Id: <166603728600.4991.7753800750625905236.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-9-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org> <20220927153429.55365-9-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Sep 2022 17:34:25 +0200, Krzysztof Kozlowski wrote:
> The LPASS pin controller follows generic pin-controller bindings, so
> just like TLMM, should have subnodes with '-state' and '-pins'.
> 
> 

Applied, thanks!

[08/12] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/b47a6c8b771c62140b619a288acdd5ee46e29272

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
