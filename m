Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455495F22D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJBLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJBLOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:14:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D32BC31;
        Sun,  2 Oct 2022 04:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F10ACE09B0;
        Sun,  2 Oct 2022 11:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F8C433C1;
        Sun,  2 Oct 2022 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664709279;
        bh=Moiaee8arCDFyQsCc3cTgcJnzrt3XyvzVkJjg2EP4JE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asq1FbO9nWd6LIVD/DpGc14Ui2DLc9LQrHmlhR+ozyoNocjnYuOkqyBzt/+Gd7wli
         dGuwCaCouZ0SanZDusNUZ3k3pLVxerpZv26LBW5AsHbujhF0WrDjuwf2ic2KGKl8VT
         iZC6b6saRUcTlezAjD4VLL5qxAPT8slIWJCyuvLf8a5/DG4ecRP03W9quz5EMg0hUG
         dk2N2XWchj7Jh94jKreXtD1GDGVLkwn92qpjfEhZYSrNRPudVWLFTuYdWFbnwhk7XS
         k1JZrfJMyOC5gV1giYZh5eAvpdWPOhrmyply5GB0s8bRNdE5pHsj7UBGIHUNxLMfNQ
         NOsvKZH5mTlBw==
Date:   Sun, 2 Oct 2022 12:14:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221002121454.18ff80b2@jic23-huawei>
In-Reply-To: <e3abc0a9-ad5b-f6ef-8cba-0b4c6c8325c0@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
        <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
        <20220922180339.30138141@jic23-huawei>
        <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
        <YzRU9aRNReonSqbg@smile.fi.intel.com>
        <e3abc0a9-ad5b-f6ef-8cba-0b4c6c8325c0@gmail.com>
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

On Wed, 28 Sep 2022 19:23:06 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Andy,
> 
> On 9/28/22 17:06, Andy Shevchenko wrote:
> > On Wed, Sep 28, 2022 at 02:14:14PM +0300, Matti Vaittinen wrote:  
> >> On 9/22/22 20:03, Jonathan Cameron wrote:  
> >>> On Wed, 21 Sep 2022 14:45:35 +0300  
> > 
> > ...
> >   
> >>>> +		dev_err(dev, "no regmap\n");  
> >>>
> >>> Use dev_err_probe() for all dev_err() stuff in probe paths.
> >>> It ends up cleaner and we don't care about the tiny overhead
> >>> of checking for deferred.  
> >>
> >> This one bothers me a bit. It just does not feel correct to pass -EINVAL for
> >> the dev_err_probe() so the dev_err_probe() can check if -EINVAL !=
> >> -EPROBE_DEFER. I do understand perfectly well the consistent use of
> >> dev_err_probe() for all cases where we get an error-code from a function and
> >> return it - but using dev_err_probe() when we hard-code the return value in
> >> code calling the dev_err_probe() does not feel like "the right thing to do"
> >> (tm).
> >>
> >> Eg, I agree that
> >> return dev_err_probe(dev, ret, "bar");
> >> is nice even if we know the function that gave us the "ret" never requests
> >> defer (as that can change some day).
> >>
> >> However, I don't like issuing:
> >> return dev_err_probe(dev, -EINVAL, "bar");  
> > 
> > This case specifically was added into documentation by 7065f92255bb ("driver
> > core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER").  
> 
> Yes. And this is exactly what I meant with:
>  >> Eg, I agree that
>  >> return dev_err_probe(dev, ret, "bar");
>  >> is nice even if we know the function that gave us the "ret" never   
> requests
>  >> defer  
> 
> There is still (in my opinion) a significant difference if we call:
>  >> return dev_err_probe(dev, -EINVAL, "bar");  
> 
> - where we really hard-code the -EINVAL as a parameter to the 
> dev_err_probe()
> 
> >> Well, please let me know if you think the dev_err_probe() should be used
> >> even in cases where we hard code the return to something...  
> > 
> > And this should be, of course, maintainer's decision.  
> 
> Ultimately, yes.

I'm not that fussed. So happy to accept code taking either view where it
is hard coded in the call like this.
I'd love a dev_err() that took and returned the error value though just
for all those single lines of code saved.

J

> 
> Best Regards
> 	--Matti
> 

