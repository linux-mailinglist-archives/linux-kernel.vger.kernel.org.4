Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719F68907D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBCHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjBCHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:17:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5621928C8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:17:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so3788393wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AIgxCweWs4+DnxABoHv8HSYkYCkBtQd6RKyyeXAI4o=;
        b=hGVzxC6EWGSen7yIJrc27Vu0co0n3zGYIxJm6/ZvKpEHu4xXqXrn2jaWb8XYSI+w9a
         fpzN1wSy9EnL+biWpukc3T7bFFfwi3pvq/Yl1egkmre2acTVXWmlLIuNIqPX5mg+kLFs
         gCe24kzyKsvpC4P47r9oDhKka+8c7BMEYaZQwRiA1usqjUXWDDDmnF0a4GpXNKxeiHzK
         YTRaf7g6op8gIk0P+TcjUNwunnQegnrS898aIT3Ys2dVO85DdsgWxTrhgaaY8QaFts7S
         48ju5jSbYTD8P0MV4rEIHxByDMwSTzdN/fqxfslLfqsykHCr8XEEI0JG6keXQHRtBDjP
         nGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AIgxCweWs4+DnxABoHv8HSYkYCkBtQd6RKyyeXAI4o=;
        b=Kv/FGFixBN4iv07G+EQEmnOHeX+muW28paVoPl8BcoHjokFysg7hzhY2PEpl3/ps7w
         NQ4VkK4Eo2Qgnu/az4eu9c9FzDrBzJ4NHBh/hJhP9+98c1vCkdTdOZUiqy7ssZPeOD5g
         NQ7DJcY6QJNziuR1n0KDT6ykWU46rEG2tAa7Ly3zVfASZW+2sHocZRgKBSTbw2t+kOKv
         zkoaCB01hHRXqYf79QvN3tmijPxSPA4s/2bpfXVZzoOr6/aooJEL51UyCB3lOt13nBsG
         YDuvvRoqDicUQs7U7jLqGyFlUIJldCWdprFoK16ZFgzC+AqHpwS2EystAKPbxb9wMhPZ
         +qwg==
X-Gm-Message-State: AO0yUKV0lxmWKPejIt3Itdc4nvSPXYWU2HsivJ3GNARPLc7GA4tty/Ry
        wxGQfInsYBiPz+6gAoQd3EB97A==
X-Google-Smtp-Source: AK7set+e8woENYsUqYAhyzTz/ne5s8s2T6I/2mq2Ioe8we0VVJyKEUc6koF8sPz1v08iVWL9pCM0/A==
X-Received: by 2002:a5d:610c:0:b0:2c2:6541:7af7 with SMTP id v12-20020a5d610c000000b002c265417af7mr7151784wrt.66.1675408662307;
        Thu, 02 Feb 2023 23:17:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bff574a250sm1291828wrr.2.2023.02.02.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:17:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Iskren Chernev <me@iskren.info>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v2 07/10] dt-bindings: pinctrl: qcom: correct gpio-ranges in examples
Date:   Fri,  3 Feb 2023 08:17:27 +0100
Message-Id: <167540864401.6835.15877953602860075826.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202104452.299048-8-krzysztof.kozlowski@linaro.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org> <20230202104452.299048-8-krzysztof.kozlowski@linaro.org>
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

On Thu, 2 Feb 2023 11:44:49 +0100, Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in gpio-ranges to match reality.
> 
> 

Applied, thanks!

[07/10] dt-bindings: pinctrl: qcom: correct gpio-ranges in examples
        https://git.kernel.org/krzk/linux-dt/c/6f4e10ffa8fbccf220f7c5c869e8373065b9ef7d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
