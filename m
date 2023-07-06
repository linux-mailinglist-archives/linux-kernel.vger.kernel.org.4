Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C4749486
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGFEDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGFEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:03:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28781988
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:03:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b74e2d8c98so236130a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 21:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688616215; x=1691208215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FYnNIawbku4DKzQ1lg5ea0ay/M1V65V06UjetuXA9iA=;
        b=m0mCMyE1InXnqQ5cdii/3F7YbEoSK9lxA+z+DQdZTCfCx8cXChj8jRFysYNlLPMEAe
         EptgGsCkDLVwc4TzxOPyiJY0RfeO17V+Of1nSUEmvNq0zgf+8VEFmJVxIZuNjyQ8wtcP
         DZru+OMi/twpsdDVsIA/y1fSYVd0IJIYbi77ufYGez2Aj3f4lqGVrLsrBppNJFmEy0AQ
         3AQ2zZSaWxkkQhc2jhlgo9NRpxi2/0ljjvSbK1oY0yuwgj3qzZGtyRs9TXS2GHo3HdLn
         9E2J+F0p2vIrbu26KS4Mca5vOmuA8XX+F/HjF7XNyFoA5bWQrynh87gmX2sTdqRtGktl
         khUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616215; x=1691208215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYnNIawbku4DKzQ1lg5ea0ay/M1V65V06UjetuXA9iA=;
        b=HYRm63lH0dXWFy1p6sME2wR/D6f9j7cfujJDqB5osZ8/697vixjsrrCFTipxV69TfZ
         MrAogJ1XC0K5+J/7dCIhLI3NIPfUyRZRsa1EIgRIWOZEdxZeGsDYJMlaLfg5FloJNTwa
         y3zOPqK2TY4rttvgsJ01OIY4ODfNoVEOV0pHJ6ZpYK7Sj3HsKNlZeSQwoR/VvhNqpr59
         U0LQLwAwC95i5Qk+esdAE5hu1Eev9eYeTVSChd/LjkgTd+71wJ2ICAC/gjcY26lf0QyP
         L6fIDyBOo1BiW3m7HrNQBrB9l0P5p/AxIxVAZdRcCm1MRBDChSveTTYeYxeSi2Zwlfyf
         K4rA==
X-Gm-Message-State: ABy/qLY64ik1qak+cAgPNNDsdGLz/34O+QE4307f/t7TEuKCqDXhf+Kv
        z+meK++v9D0vG1aCEh48vqHD9Q==
X-Google-Smtp-Source: APBJJlEqmZLxNQQuzUk///fUNFmjd1X6nxiU+4HGt0ELa+ZA5RK91Tyw0++U5t+sxlKc/LKULTeoPg==
X-Received: by 2002:a05:6358:4196:b0:134:d122:b681 with SMTP id w22-20020a056358419600b00134d122b681mr580552rwc.20.1688616215142;
        Wed, 05 Jul 2023 21:03:35 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b0063f0068cf6csm263890pfb.198.2023.07.05.21.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:03:34 -0700 (PDT)
Date:   Thu, 6 Jul 2023 09:33:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: dts: st: add missing space before {
Message-ID: <20230706040331.izqrdsq7wfrm6fqp@vireshk-i7>
References: <20230705150033.293832-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705150033.293832-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-23, 17:00, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/st/spear1310.dtsi                    |  2 +-
>  arch/arm/boot/dts/st/spear1340.dtsi                    |  2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
