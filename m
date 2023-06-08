Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C272841B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjFHPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjFHPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900230E0;
        Thu,  8 Jun 2023 08:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F0464EA0;
        Thu,  8 Jun 2023 15:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A29C433D2;
        Thu,  8 Jun 2023 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239202;
        bh=psBvk6mN593bIlBgtU6wkxUL3ZGst2R4Vx8Kkhe4M3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UW02NtL8Fjy1LUBBkVDvMOiLTfqqjG4rdVzRLHS+d+X2PtkJov6QX7+BRfRoYiIc+
         HB4YYXI8UFYzuBRam+RrVAuC9Kifdjmz05Nnr/eRIRoGlqYUQx2GgkCKMiP98KhOKx
         LiA6ja35HQG0kahlijXRE7SJEscPykCkRgipmLYjrYJawdXFZl4SbyP6Z2RlzGaNug
         Aoex1Dq9eJ/DhcYklNW+fIPLSbLxtS7TiKzO8KyKJ2Y8ZKLMZcHbiHsTgwMxF8p8P5
         N/dwaxqgEPPOs2lheKsKHOuBoeibPrx/1s91s+DJGR9/kW/E+W+/Amj0na58ZHA3Em
         lVUkmWafBmHzg==
Date:   Thu, 8 Jun 2023 16:46:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: backlight: lp855x: convert to YAML
 and modernize
Message-ID: <20230608154634.GQ1930705@google.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <20230519180728.2281-2-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519180728.2281-2-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Artur Weber wrote:

> Notable changes:
> - ROM child nodes use dashes instead of underscores; the driver
>   reads all child nodes regardless of their names, so this doesn't
>   break ABI.
> - pwm-period argument is deprecated, as it effectively duplicates
>   the period value provided in pwms. The driver continues to accept
>   the property, so this should not break ABI.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changed in v2:
>  - Added additionalProperties to ROM patternProperties
> ---
>  .../leds/backlight/lp855x-backlight.yaml      | 149 ++++++++++++++++++
>  .../bindings/leds/backlight/lp855x.txt        |  72 ---------
>  2 files changed, 149 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x-backlight.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/lp855x.txt

Applied, thanks

-- 
Lee Jones [李琼斯]
