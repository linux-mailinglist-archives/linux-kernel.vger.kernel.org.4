Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027767782A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjAWKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAWKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:01:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9E8CC1D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso8683856wmn.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdnsFmNbrdKiXDK5mA+9lOKKIJ/fodMoPTrcBE3d8b0=;
        b=Wt4IQ0/u8mRIbLs8nRHWFRH3CLXBHzwZQy6me3Txzepw20y9bGZyBQGkli+HVeHGce
         Qb1zFaaMtjNip39iUjM1vJZ/6d98U/xWAPW2vniITuizVqLHqkz3tYCUyBVoFXomTRw8
         78O+FKtic1M7imTbzL+F1+fg84d1oBgRRJVPPhgXoOZGgd75Bvac2iWhdgyACIQYmOk7
         rEfkopaV2NRDJGPYFj5xbUjjpx49IjisnvWL/rti2MfS4GXzL+wMwiy3wY7D/710YVXi
         XH0o2yve0deA+/prKHxKsES5bIAL51DH4zF2BdPvnb6Lq7n9HtHjV0CJ3o5UZGCxQgQ5
         cPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdnsFmNbrdKiXDK5mA+9lOKKIJ/fodMoPTrcBE3d8b0=;
        b=vA10pv6Yjweo2enBjANCR7v8oVAlaq9iE3nomwAOBGqWibVZI+tFfjoN0dKa89WUWp
         UKMg0bkphPTDRiS77J0y20so2+Lo0WelxPDU3MOPn4Fppg3AHjIqfiFc5RJ/GpQ3/1YU
         8EDwnYd1HZu4jOmpbx2v7h13hEP8S+2m72YsPPfqXMi+ZPOKVGgoiLD4Dw1Z84Nx4CfG
         9i9LEGKMn71pFpQD84AbnMs4kDXdyhbBEvIYwU3e/sEhaUa3HFkhB6pxAPS+UgLMbMeR
         PRUn7UqJNSHmrIuHFhBNatqu6tJlLjk+RQtBI3fbihgpIeBsGsEuZIW1wEcv9Eb2XEXr
         373A==
X-Gm-Message-State: AFqh2kqz+Vr6WjPJwe0LpvbtnGBC1daAovgykTIj8tp5uOSmznEOMqJW
        knDYFgvHaLhpQixMD1VOw9JelA==
X-Google-Smtp-Source: AMrXdXvvby54p3PUVxoYWQ06w3Nmoq+NRjJnHR3tTX5+ciEssl3hms0rATN2Izdl/MyNbmqN4AP1Tw==
X-Received: by 2002:a05:600c:4f42:b0:3db:2e62:1d69 with SMTP id m2-20020a05600c4f4200b003db2e621d69mr12821028wmq.31.1674468110997;
        Mon, 23 Jan 2023 02:01:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm11050831wmq.28.2023.01.23.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:01:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: drop incorrect power-supplies in P4 Note
Date:   Mon, 23 Jan 2023 11:01:41 +0100
Message-Id: <167446806832.57213.14059225386091066791.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120071151.116272-1-krzysztof.kozlowski@linaro.org>
References: <20230120071151.116272-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 Jan 2023 08:11:51 +0100, Krzysztof Kozlowski wrote:
> simple-battery does not have supplies, but it is referenced by charger
> instead:
> 
>   exynos4412-p4note-n8010.dtb: battery-cell: 'power-supplies' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: drop incorrect power-supplies in P4 Note
      https://git.kernel.org/krzk/linux/c/4069be845bbff7b4761aa513c30d6400e5f63846

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
