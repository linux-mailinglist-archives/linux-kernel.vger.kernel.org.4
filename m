Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2767E966
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjA0P0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0P0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F28126C7;
        Fri, 27 Jan 2023 07:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C293461CB1;
        Fri, 27 Jan 2023 15:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED7C433D2;
        Fri, 27 Jan 2023 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674833177;
        bh=Z5ZP4DaoVQ2QC+fknVQWZA212TOY3bzBXTC09PEvXyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNQtfsRxBJ762s3ZPwg0veDwjdbh9f/dsZi1AmCtvr9IPvhA0QgR1W5fc+eJTaAt3
         3fIhlHDoqClG+KAB/H/wAuUrSuNj0LJHqLMV/uBDfyjwHiuKiERks4NM9NM+em8apV
         w5G6CF+0nK2wp/CaTdxUqAYilQ43XOrMMdWOp8jh9v31Ct+xn41MVrhcIwRv206g44
         qYy/imjKEgDdF5TwocAS4hjWK9xw6Tq23xSVFKGKCip7+qJwObU+WFo7VEheZUAZiH
         Gvyj1Mpgtq8tKz37ECKoD/HX2f6lleyoY3nC1qGP5ilt2/h8ZreM+2QjJB8jm2X6hL
         Rh80pil6+W1Hg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLQcU-0001Cp-Fp; Fri, 27 Jan 2023 16:26:26 +0100
Date:   Fri, 27 Jan 2023 16:26:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/24] rtc: pm8xxx: add support for uefi offset
Message-ID: <Y9PtIiD1o8eBq2wk@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-20-johan+linaro@kernel.org>
 <Y9PrdqLHZpZrdGJ4@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PrdqLHZpZrdGJ4@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:19:18PM +0100, Alexandre Belloni wrote:
> On 26/01/2023 15:20:52+0100, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which the
> > driver can take into account.
> > 
> > Add support for storing a 32-bit offset from the GPS time epoch in a
> > UEFI variable so that the RTC time can be set on such platforms.
> > 
> 
> Why are you using the GPS epoch? This seems pretty random.

Tell that to the Qualcomm firmware team. ;)

Perhaps I could have made it more clear, but this is the format that the
firmware uses so Linux is not free to pick a different base here (or
time would differ ten years between UEFI/Windows and Linux).

> > The UEFI variable is
> > 
> >             882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> > 
> > and holds a 12-byte structure where the first four bytes is a GPS time
> > offset in little-endian byte order.

Johan
