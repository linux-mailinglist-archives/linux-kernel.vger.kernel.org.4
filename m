Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB526E3263
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDOQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDOQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3204230;
        Sat, 15 Apr 2023 09:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CF3612ED;
        Sat, 15 Apr 2023 16:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8FCC433EF;
        Sat, 15 Apr 2023 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681575610;
        bh=DTWP6xThhLREOoWWAUdntoavtxBw4x/BgKGr7En2G+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GmUNzIsw/k9u6mHIPjmMJSdolY4BlTCHrz6o7gYdxbGZ4PeqtrXozfp7Q0xrDnbiC
         N6ekHJxPfDEloG4V6MmfkCTixSIWH1HgBN+y1e31mC07b0+LhDW0C7uMoCN/A/BhTi
         jUvvq4lR3/PsJM4LKq8P622ks4HUD+ow7FgYUcGyuPPF338khCSriVkmAo8+iMuIcL
         HpcSRkBGLZcccS36Cc+ZDyy8vRsL7XDfWkoY+X6I3k3wFeExu1KK/hteM8F+nK+guS
         ib5saxEInFemsZ9wUM71gB7w4pIgdeqdZvHr5xOpxOy1pq+gMq4Er0BxK1bjFZYFSl
         njkcndZEX5djw==
Date:   Sat, 15 Apr 2023 17:20:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16
 for pre-scaling
Message-ID: <20230415172009.529d91c5@jic23-huawei>
In-Reply-To: <577ecd98-94eb-3795-4859-ffad03192f89@linaro.org>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
        <20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz>
        <577ecd98-94eb-3795-4859-ffad03192f89@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 09:56:07 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/04/2023 01:17, Luca Weiss wrote:
> > The channel ADC5_USB_IN_V_16 is using 1/16 pre-scaling on at least
> > pm7250b and pmi632. Allow that in the schema.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >   
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied this patch to the IIO togreg branch initially pushed out as testing
for 0-day to poke at it.

I'm doubtful this one will make the upcoming merge window but seems unlikely
the rest will all make it either so that shouldn't be a problem.

Jonathan
