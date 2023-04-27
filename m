Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF536F0858
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbjD0P2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbjD0P17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B8DC0;
        Thu, 27 Apr 2023 08:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00BB260D2F;
        Thu, 27 Apr 2023 15:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C06C433EF;
        Thu, 27 Apr 2023 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682609277;
        bh=FHo9B8U/StGwaxLluZybZY5fUQBOTmO+agyo9xW3X7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGbZ7gBNnf9N+DGmNAudgJGk/7FaoIGzjbWTarDDNDz+Y+1VP6p3630v3vTyB51An
         u5JckP9gU9aYiOulm8OLnUCNUpjm5Tt0H8eSIOpRn2QTBgE80o9VpTWFStYcU44aKK
         FqWOWmJgIZDnxZZlXvCP99yPdR4IUACuURqO8xPiZj90mIlzas/uK1X3dE9Dq0XFpV
         bba4x7uo0+q5dMGYY4GX7EnrgOKJJANkXHn9KWyiChzrwhnoWZGRUBq8AjLhsv3rF+
         l7xArxlBcYSbabvgqKWavfJoCB7MxbInEnpU5SPZE7wpb55uF8bF0FmXTn+p/P/+MC
         6+A9g6kqeRZag==
Date:   Thu, 27 Apr 2023 16:27:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/8] leds: qcom-lpg: Add support for PMI632 LPG
Message-ID: <20230427152750.GA50521@google.com>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-4-98bafa909c36@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414-pmi632-v2-4-98bafa909c36@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Luca Weiss wrote:

> The PMI632 PMIC contains 5 PWM channels, 3 of which can be used for
> LEDs.
> 
> For the LED pattern it doesn't have LUT like other PMICs but uses SDAM
> instead. This is not currently implemented in the driver but since LPG
> works fine without it, add support for the PMIC now.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
