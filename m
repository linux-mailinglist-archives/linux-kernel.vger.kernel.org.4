Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F5731DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjFOQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFOQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECFE69;
        Thu, 15 Jun 2023 09:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549D361999;
        Thu, 15 Jun 2023 16:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A5EC433C8;
        Thu, 15 Jun 2023 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686847118;
        bh=F22bVWQutuqXY4+tXA/ymZHSWuT7v9Xwt1AL5BPn/Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TgMX6Ci6I/OTSdrWAA8xWQSNewYLAz7PSAhLvL3XEzyiVsdb+fa57gAMuSUwJ+VEi
         D8peYgh/500K9tDptketizD2OyA11Z9hhQs6EfhuUskeux0oqWl1R+mCVtTf1/81+v
         WtdrbmquTupacBXtvNEhXwID/vFmAChiMbU0Rd9+1KgutYzZej0tuI5WzYw2H6i9In
         hUnf6QzByudzLsdKs41jDQEcyW2DSllNSYGdAsXV6+gMhklsyGScmJxqcOZc49zGMt
         429G5Mod+R821/wtV1v4dEzJH3zLalqcpx+xvhGYorAq+EMGOoQMFmMzKLHwX5UXZT
         aOuOAZMjJ/hMQ==
Date:   Thu, 15 Jun 2023 09:41:58 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-leds@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] video: backlight: lp855x: modernize
 bindings
Message-ID: <20230615164158.6tpsd766mqx3o7y4@ripper>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <168669542896.1315701.6764382551599027707.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168669542896.1315701.6764382551599027707.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 03:30:10PM -0700, Bjorn Andersson wrote:
> On Fri, 19 May 2023 20:07:24 +0200, Artur Weber wrote:
> > Convert TI LP855X backlight controller bindings from TXT to YAML and,
> > while we're at it, rework some of the code related to PWM handling.
> > Also correct existing DTS files to avoid introducing new dtb_check
> > errors.
> > 
> > Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/4] arm64: dts: adapt to LP855X bindings changes
>       commit: ebdcfc8c42c2b9d5ca1b27d8ee558eefb3e904d8
> 

Sorry, that was not for me to pick up. So I've dropped this change
again.

Please note that all other changes to the affected file is prefixed
"arm64: tegra:". Following this is a good idea, and would have helped me
not accidentally pick this change.

Regards,
Bjorn

> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>
