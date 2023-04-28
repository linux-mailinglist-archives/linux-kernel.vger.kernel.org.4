Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4A6F1C44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbjD1QHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjD1QHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:07:00 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127375BBB;
        Fri, 28 Apr 2023 09:06:52 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 185D6C5EDB;
        Fri, 28 Apr 2023 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682697981; bh=H2ZopAaOaipo4s98rSRyLSqJBKSYIs1cRJ7qufNhEFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YdKQkX4gT87XWqXdCdKZkie+EnWmT6j18T9qh4Xix6woowAR6puqI4OtJE8/ASwr6
         LSlgtfQvaTxHMZAQyI81kwec9hCdcS/8PCq+wcVwe9gCjc9HD4GFpnAcHk1SOr/G97
         LCWC15LqIZAYZlzy2mmFhynXPQvo46tDjNpa5dMM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Brian Masney <bmasney@redhat.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Date:   Fri, 28 Apr 2023 18:06:20 +0200
Message-ID: <8250064.NyiUUSuA9g@z3ntu.xyz>
In-Reply-To: <ZEsFV6F4CEh2/av8@x1>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz> <ZEsFV6F4CEh2/av8@x1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 28. April 2023 01:29:27 CEST Brian Masney wrote:
> On Thu, Apr 27, 2023 at 10:34:28PM +0200, Luca Weiss wrote:
> > Some pwm vibrators have a dedicated enable GPIO that needs to be set
> > high so that the vibrator works. Add support for that optionally.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> 
> Hi Luca,
> 
> Thank you for picking up this work!
> 
> > +	vibrator->enable_gpio = devm_gpiod_get_optional(&pdev->dev, 
"enable",
> > +							
GPIOD_OUT_LOW);
> > +	err = PTR_ERR_OR_ZERO(vibrator->enable_gpio);
> > +	if (err) {
> > +		if (err != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "Failed to request enable 
gpio: %d\n",
> > +				err);
> > +		return err;
> > +	}
> > +
> 
> Take a look at dev_err_probe() to remove the -EPROBE_DEFER check.

The input subsystem doesn't like dev_err_probe for some reason, you should 
quickly find examples of that being rejected on the mailing list (or see   
"git grep dev_err_probe drivers/input/")

> 
> With that fixed:
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>

Thanks for the reviews!


