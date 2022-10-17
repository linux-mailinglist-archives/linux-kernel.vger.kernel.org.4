Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7B6018FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJQULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiJQUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:10:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5A74349
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:09:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id df9so8076496qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv5bowrokGOx9n+prz8o/61sZ1leiBoWTbx4shzSeGU=;
        b=MJ7AWHprvJz9Jd9w+p1LV2ehnDGXxW2rpNRAg7VD9mqouijKkBwv2hGouuZAs1qGz+
         bBsMEUCn8lUB+DtzyM3Za1lgPjnrVCoHG8DgSJgwN8LxZE8dIY07/2ZAXqqMJYpp8Tt/
         yIT0QtnrYQ6ngm9Q1MYgn4LdB9BDsWc6x8JS1cDqzbNpGF8WtGAPVgrVEu8oG7zovUBt
         3KmbX78KS/Eq+g+KWYR3xUM7sHQvTVjV8LkA/6qW6ICC4VJisg2VUSm4RT8W9TJVWEjv
         38jQmb8b4XMgthv22HaRdLicAdTBmJz7BuIp2mujQF9+ihhQ/LoW02I+yyiqk8HKEnQX
         udkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv5bowrokGOx9n+prz8o/61sZ1leiBoWTbx4shzSeGU=;
        b=5FpCQ9riTMCKOgO2kO19Sj+l5teS4BGJDPDGRfxTKmBC13n5WoJK3h9Nj6YHDTKO/S
         Xeawoo0SeJl2poqcAbbKbuQHupdIFx5go2Mm5aRboUwOfAD3U0buoQBk01V/w6wmxmJ7
         iEPlcrAZTKvDTsTw/bFZPmuBNxV7bLNUC3RlK0aXQIqnJXl7Tldv+yFpqEEDKHCzEYfJ
         dK/2Y0OKiN34A7lyvo1R/WOyAVxZFA4eqwur12GeBy4834+DkWYP3UITwyppJBaFjP+7
         1K5BvD1NmtxKhiNdeO49OOimZdgts9m8hw/AF+SZsBD6ZXxbNEiN/qkl7z/DzP7dL4Sp
         CoZw==
X-Gm-Message-State: ACrzQf2DVnC+7nndXDUET+12L39tcQ7LI0CUiLkzoQTa8kstK7QP1fgm
        UtiHnvrPKE6h6Yp+QYghpcGmMQ==
X-Google-Smtp-Source: AMsMyM5KwQW3whJ9r8AJTII7sbS2mAT4v2aPmCI/wwlb+V8fJ0Q1OpekrswQUkJqgD1GnW33CHuBgw==
X-Received: by 2002:a05:6214:2a84:b0:4b4:4fb:4286 with SMTP id jr4-20020a0562142a8400b004b404fb4286mr9517708qvb.127.1666037356278;
        Mon, 17 Oct 2022 13:09:16 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v5 24/34] dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GPIOs
Date:   Mon, 17 Oct 2022 16:08:05 -0400
Message-Id: <166603728602.4991.10484336964368011064.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-25-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-25-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 13:00:25 -0400, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> 

Applied, thanks!

[24/34] dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GPIOs
        https://git.kernel.org/krzk/linux-dt/c/590d1b93bf75d84fbb21e066c8a7de351f3d0323

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
