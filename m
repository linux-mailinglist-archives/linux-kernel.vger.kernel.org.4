Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E40C6568A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiL0JAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiL0I74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:59:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EEB6547
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 1so18792292lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2jyW9oO0L5sNCKiAMzOgDIduuGoHpIUZwCicD1bQoE=;
        b=JZwQsVMJwgbf4ouWgI08xzLNj+/D8oyBQ8PoAqZARN0yaW4A8CxuEuOwYLDHx17Gss
         NHdf06fE9IX/K7zs+g2eqa/zfQMX4ok/VnNLf6rio6lQtB4acPnR7vOsxn8bRvbqqR17
         1GLCvkjqjmxDY49wwhquuLix2RMqrHPg/5ur+f306SwwOSkiIDqIkm65FGOHJLCDdhfp
         bZlEuDZ2DgYaVG4tIm17Qj5xCpxmochtftkM45RetZeqOnrnRcn8B2PKlQ7bTECAoR45
         csZpT37naqT61J8ClA4tbWBjIi806Xv0jjgi5kdv+rcn73ZhTgatiyzqNPHePWxaVbYY
         t2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2jyW9oO0L5sNCKiAMzOgDIduuGoHpIUZwCicD1bQoE=;
        b=ESFMIDYkzb/uJhndXURcgqQ1KWRj12b/819Qnvq19zIo9Xd0AeR0LF3ECTca30UNrI
         y3eq12KBW8mBSNUTEgZoZs4eh1OsFP8fIhVMBI5CeHHU7B4sP0xd8A1FRPCD3ywhO+7s
         NapEc2RwwDDned9c0M3yP8QV7UVfdMN5kzQDoVARb3oOiFQX40wHLRZhcm0fG1p5nlmu
         A8An6lyZ+Je3iIDirVT1Pv0cJLQSz/1B8toP58yCd8lYrW4e8vv8uWurJLYNb/Jr6/af
         ufU6HuQ9yTY3GuLOmi94CSsNiDGIAIFxNd+1+r9iFpkAHn9KPN37facC9wQE/9rKyNsb
         l2tg==
X-Gm-Message-State: AFqh2koQoC/rxsIFdqtzX5b08RP4196Gu60aCtsvgQFP5VsHBlem+5Nz
        yqKCRZEX6OIK9QuvlRS9CBBowA==
X-Google-Smtp-Source: AMrXdXucTjCQ6gkyUd6reb6FyMHIo0JTFApHHKAuiP95qwebl7407ISTva+utaDjhqpWRmUt+tiAmQ==
X-Received: by 2002:ac2:55ab:0:b0:4b4:f19a:5aed with SMTP id y11-20020ac255ab000000b004b4f19a5aedmr7038882lfg.49.1672131594248;
        Tue, 27 Dec 2022 00:59:54 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b0026bf0d71b1esm1534837ljp.93.2022.12.27.00.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 00:59:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     JaimeLiao <jaimeliao.tw@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        juliensu@mxic.com.tw, leoyu@mxic.com.tw, alvinzhou@mxic.com.tw,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix missing setting address
Date:   Tue, 27 Dec 2022 09:59:45 +0100
Message-Id: <167213158106.15520.12651563480098587733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
References: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 10:51:41 +0800, JaimeLiao wrote:
> In the RPC manual mode, if the data direction is not set
> (such as the flash erase command), the address misses the
> setting.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: Fix missing setting address
      https://git.kernel.org/krzk/linux-mem-ctrl/c/21a1234f82cbf4258445072bb23c38fed2ce6cb3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
