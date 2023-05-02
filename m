Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A516F4710
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjEBPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjEBPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:24:48 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C2D7;
        Tue,  2 May 2023 08:24:47 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 770B8C76A8;
        Tue,  2 May 2023 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683041085; bh=I4YH0QUgucwT4uc2YEZJwhH8Sc7vUD+EOfEVy1pje6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TJEg+z4W2c402E+BIoIKKoPkijwmwHPsPKWhrXs0GUDZ0zsFdZ4p7acjJtX38lYwE
         TEQbmNXprxLn1/p6gGejI+iD71rlqCEkmN6HNuypI3kyS5//fLkH6LLt50Ypc7IbZW
         IcOklYrjDGto3mpf6AEGQrkARMhHum6umHdZ7m7Y=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Date:   Tue, 02 May 2023 17:24:44 +0200
Message-ID: <45489141.fMDQidcC6G@z3ntu.xyz>
In-Reply-To: <8a54d0ec-8a22-9ffd-43a4-55da988fbeb1@linaro.org>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <8250064.NyiUUSuA9g@z3ntu.xyz>
 <8a54d0ec-8a22-9ffd-43a4-55da988fbeb1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 2. Mai 2023 12:39:10 CEST Konrad Dybcio wrote:
> On 28.04.2023 18:06, Luca Weiss wrote:
> > On Freitag, 28. April 2023 01:29:27 CEST Brian Masney wrote:
> >> On Thu, Apr 27, 2023 at 10:34:28PM +0200, Luca Weiss wrote:
> >>> Some pwm vibrators have a dedicated enable GPIO that needs to be set
> >>> high so that the vibrator works. Add support for that optionally.
> >>> 
> >>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >> 
> >> Hi Luca,
> >> 
> >> Thank you for picking up this work!
> >> 
> >>> +	vibrator->enable_gpio = devm_gpiod_get_optional(&pdev->dev,
> > 
> > "enable",
> > 
> >>> +
> > 
> > GPIOD_OUT_LOW);
> > 
> >>> +	err = PTR_ERR_OR_ZERO(vibrator->enable_gpio);
> >>> +	if (err) {
> >>> +		if (err != -EPROBE_DEFER)
> >>> +			dev_err(&pdev->dev, "Failed to request enable
> > 
> > gpio: %d\n",
> > 
> >>> +				err);
> >>> +		return err;
> >>> +	}
> >>> +
> 
> Looks like your email client messes with the replies.. perhaps it tries
> to round them to n characters forcefully?

Quite possible, I'm using KMail with Options -> Wordwrap turned on, otherwise 
I have to manually wrap everything but with this on there doesn't seem to be a 
way to get over that limit, even when posting links etc - or when quoting 
existing text.

Regards
Luca

> 
> Konrad
> 
> >> Take a look at dev_err_probe() to remove the -EPROBE_DEFER check.
> > 
> > The input subsystem doesn't like dev_err_probe for some reason, you should
> > quickly find examples of that being rejected on the mailing list (or see
> > "git grep dev_err_probe drivers/input/")
> > 
> >> With that fixed:
> >> 
> >> Reviewed-by: Brian Masney <bmasney@redhat.com>
> > 
> > Thanks for the reviews!




