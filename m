Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFE55E5446
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIUUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIUUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:13:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10279A4064;
        Wed, 21 Sep 2022 13:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E5F2B832B8;
        Wed, 21 Sep 2022 20:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201EC433C1;
        Wed, 21 Sep 2022 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663791185;
        bh=X7z+fI3ZRL+DFxQVMWPW8bnZDmrWwwWcqlWdAoxgJO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ozcTn7OSEJyck68gtMf9+g0Eu5/pco2mYKS28tu27Amm8Pg8/yPK0pQTN8gupcZHU
         9bv77+RHbetL/njKR3LYaLImeVcRcYylMmOf3cqXnX4HXaKQ52YOzNlkKsApQE/6Ip
         jtV4T5uwvuJr7JCjl6nprJsfvJ4UkRNBHDJRs68ZeMeXjqR9VFJevMD65LGWgVDvHf
         A7bg/wRurEDr71CTG2zKWtVoTdRCRjCzVsykMIc5+tGMCPzx8+bTtzMMFMAiaF7nZX
         iiwwr0oVaiRw8vfX6ONfl+EdJquDtXTa93RnTd6XALF9lSkNufNgnYa+e/llpJR+W4
         gkkk+lQGQKWiw==
Date:   Wed, 21 Sep 2022 21:13:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220921211308.40d33c50@jic23-huawei>
In-Reply-To: <20220919163600.77b50331@jic23-huawei>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
        <20220815061625.35568-5-marcus.folkesson@gmail.com>
        <20220820134150.2b45339c@jic23-huawei>
        <Yx8Ru3x1IgmUYzUA@gmail.com>
        <20220919163600.77b50331@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 19 Sep 2022 16:36:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 12 Sep 2022 13:02:19 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> 
> > Hi,
> > 
> > On Sat, Aug 20, 2022 at 01:41:50PM +0100, Jonathan Cameron wrote:  
> > > On Mon, 15 Aug 2022 08:16:20 +0200
> > > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
> > >     
> > > > Keep using managed resources as much as possible.
> > > > 
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > ---
> > > >  drivers/iio/adc/mcp3911.c | 53 ++++++++++++---------------------------
> > > >  1 file changed, 16 insertions(+), 37 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > > > index 890af7dca62d..7e2efe702e57 100644
> > > > --- a/drivers/iio/adc/mcp3911.c
> > > > +++ b/drivers/iio/adc/mcp3911.c
> > > > @@ -258,6 +258,13 @@ static int mcp3911_config(struct mcp3911 *adc)
> > > >  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> > > >  }
> > > >  
> > > > +static void mcp3911_cleanup_regulator(void *_adc)    
> > > 
> > > Missed this on previous versions, but why not pass
> > > the regulator pointer in as the parameter for the callback?
> > > 
> > > static void mcp391_cleanup_regulator(void *reg)
> > > {
> > > 	regulator_disable(adc->vref);
> > > }
> > > 
> > > Note this can't use the new devm_regulator_get_enable()
> > > because we need access to the regulator within the driver.
> > > 
> > > I can tidy this up whilst applying (or given it's really minor I might
> > > not bother :)
> > > 
> > > Note we are stalled at the moment with this series on getting the
> > > fixes upstream.  I'll probably send that pull request shortly.    
> > 
> > Just a friendly reminder to not forget to pick up this series.  
> 
> If things go according to plan, Greg will take the pull request
> I sent the other day and I can fast forward the tree such that
> the first 3 patches are in my upstream, then do a second pull
> request with these applied. They aim here being to keep the
> history reasonably clean rather than spaghetti merges.
> Fingers crossed on timing working out. This all got delayed
> because I sat on the pull request for a week due to travel and
> dodgy airport wifi etc.
> 

Now applied to the togreg branch of iio.git.
Pushed out as testing for some brief testing by 0day etc.

Jonathan

> Jonathan
> 
> > 
> > Thanks,
> > 
> > /Marcus  
> 

