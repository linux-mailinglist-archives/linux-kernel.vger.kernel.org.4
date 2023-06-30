Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC47435A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF3HSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3HSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D81731;
        Fri, 30 Jun 2023 00:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC93D616D4;
        Fri, 30 Jun 2023 07:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17820C433C0;
        Fri, 30 Jun 2023 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688109480;
        bh=pB6a8MtXW9LfZbrAZovpz0Qoo2FMyZhdSLuByWXv/p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tngw9s3h5Aiar0GBBlumSxvQpfOKfKZ4pOx6A/DmQM6dkRwrU+mlKLYw8mLXyTy8H
         5PWMcuJyc35eYxs/SGEbJP9da+cPMt1D3GpbaTP346PLUZoojXoADDoaW6VoP8Sif2
         Lm+CDZe7fO4/tiqalXtpgNXsOA6x1KcsGu0UN8Nn82A+gwF5JbVUmL0UmB/nkZARX3
         XRonjnO2UWTw6aeuKkN/wdIizOpjBMwudqlz938SJT+b/cssjWhzpX2a+Hsfj4JB2b
         Ln+btnFedIvtiDt6G9oldwTFwNVjBtZfq33SrznmhcjHxxzgn1snuWH6jy3/D4rVsC
         G+4fwHGFCuOrg==
Date:   Fri, 30 Jun 2023 08:17:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230630071751.GC2110266@google.com>
References: <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com>
 <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
 <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
 <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
 <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
 <920531c8-b5c1-409a-9cda-3ec77ba944e7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <920531c8-b5c1-409a-9cda-3ec77ba944e7@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023, Mark Brown wrote:

> On Thu, Jun 29, 2023 at 12:14:00PM -0600, Rob Herring wrote:
> > On Thu, Jun 29, 2023 at 11:59 AM Mark Brown <broonie@kernel.org> wrote:
> 
> > > Right, I'm suggesting applying the core part without waiting for every
> > > single leaf driver to be lined up rather than the other way around -
> > > that way the core part is stable and the leaf drivers only have issues
> > > with changes in their subsystems that they'll have anyway even with
> > > waiting.  Leaf drivers can be added on top as they're ready and if
> > > something misses a release then it can go through the subsystem, and if
> > > people do end up wandering off then you've still got whatever did get
> > > merged in case someone else wants to pick things up.
> 
> > I misunderstood. I thought you wanted to apply things to get them out
> > of your queue.
> 
> Well, I *do* but that's got issues especially when things get stuck so
> I'm not going to.
> 
> >                That doesn't work when the leaf drivers depend on the
> > core, so what do we do there? A branch or Lee takes everything? That's
> > almost always the case with the bindings as the core binding
> > references the child node bindings. My preference there would be that
> > Lee picks up all the bindings with the core driver.
> 
> My suggestion is that once the core is ready to apply that and also
> start applying everything else to Lee's tree as it's ready.  A branch
> also works and might come in handy anyway in the case where there's some
> subsystem wide updates in some other subsystem (since it avoids having
> to pull the whole MFD tree in or anything like that) but it's not
> essential to the idea.

The issue we currently have is that the core usually comes with a header
file which is included by some or all of the leaf drivers.  If leaf
drivers are pulled in without that header, the drivers will fail to
build which will make people grumpy.

The suggestion of a separate branch that's added to over time as leaf
drivers become ready is even more work that a one-hit strategy.  It will
also mean littering the working branch which a bunch more merges and/or
more frequent rebases than I'm happy with.

-- 
Lee Jones [李琼斯]
