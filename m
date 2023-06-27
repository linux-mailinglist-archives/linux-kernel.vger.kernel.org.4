Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D4673FD47
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjF0N41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjF0N4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22183211B;
        Tue, 27 Jun 2023 06:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B20DA611AA;
        Tue, 27 Jun 2023 13:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF733C433C9;
        Tue, 27 Jun 2023 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687874183;
        bh=E4G5QaWDfviVyRBgE/mtHmjt/TgaKJD7ZOMkrRJ8Cvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AqoFcXvTw8DyOug1fHyH3NWpPSLDXDdIq8PV8oekhHdacYfVxJoUnYX1iHk/XpgcU
         81n4iB8yDyfqrhuLguDwi564YXqm7nLhRy7UzdN0gSHjmVrp86najDXAhbI6C9x3UF
         +thGwNM8e6Rh4eNklv6R0VYHyLXoyisPCsULjJNgBzKpPtvtXxqXzsuKRsYGCUdjl6
         yZNfJ+VJdfnA61puendJvBHMd9ezU3sa3W++2eUnR/h1KHRyrac1/u2EfheYOEJOS8
         LA+7gnV15sNSZFv4Yt9uk7bK+LYbFuqg5aFXiZAS+zYogP/yVBCHX90/PQtx5dj1We
         xyLlrQyD1L4Xw==
Date:   Tue, 27 Jun 2023 14:56:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Mark Brown <broonie@kernel.org>,
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
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230627135615.GF10378@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626175443.GA3446604-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023, Rob Herring wrote:

> On Wed, Jun 21, 2023 at 06:13:15PM +0100, Lee Jones wrote:
> > On Tue, 13 Jun 2023, Sahin, Okan wrote:
> > 
> > > >On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:
> > > >
> > > >> I'll try anything once!
> > > >
> > > >> Fair warning, I think this is going to massively complicate things.
> > > >
> > > >> Either we're going to be left with a situation where child-driver
> > > >> maintainers are scrabbling around looking for previous versions for the
> > > >> MFD pull-request or contributors being forced to wait a full cycle for
> > > >> their dependencies to arrive in the maintainer's base.
> > > >
> > > >If people are resending after the MFD has gone in they really ought to
> > > >be including the pull request in the cover letter, with some combination
> > > >of either referencing the mail or just saying "this depends on the
> > > >signed tag at url+tag", the same way they would for any other dependency.
> > > >
> > > >I can't see how you applying stuff when you can slow things down TBH,
> > > >the MFD bits will be applied faster and either people can pull in a
> > > >shared tag or you can apply more commits on top of the existing core
> > > >driver.
> > > >
> > > >> I'm not sure why simply providing your Ack when you're happy with the
> > > >> driver and forgetting about the set until the pull-request arrives, like
> > > >> we've been doing for nearly a decade now, isn't working for you anymore
> > > >> but I'm mostly sure this method will be a regression.
> > > >
> > > >Like I said I've not been doing that, I've mostly been just applying the
> > > >driver when it's ready.  This might not have been so visible to you
> > > >since it means that the regulator driver doesn't appear in the series by
> > > >the time the MFD settles down.  The whole "Acked-for-MFD" has always
> > > >been a bit confusing TBH, it's not a normal ack ("go ahead and apply
> > > >this, I'm fine with it") so it was never clear what the intention was.
> > > >
> > > >Before I started just applying the drivers there used to be constant
> > > >problems with things like tags going missing (which some of the time is
> > > >the submitter just not carrying them but can also be the result of some
> > > >churn causing them to be deliberately dropped due to changes) or
> > > >forgetting the series as you suggest and then not looking at some other
> > > >very similarly named series that was also getting lots of versions after
> > > >thinking it was one that had been reviewed already.  It was all very
> > > >frustrating.  Not doing the tags until the dependencies have settled
> > > >down means that if it's in my inbox it at least consistently needs some
> > > >kind of attention and that the submitter didn't drop tags or anything so
> > > >I know why there's no tag on it even though the version number is high,
> > > >though it's not ideal either.
> > > 
> > > Hi Mark and Lee,
> > > 
> > > Is there anything that I need to do for this patch set. I have received reviewed
> > > by tag for all of them so far. 
> > 
> > Since we are so late in the day, I'm going to just apply this for v6.5.
> > 
> > The remainder can then be applied, friction free, for v6.6.
> 
> Now we have undocmented bindings in use by the driver (as pointed out by 
> 'make dt_compatible_check').
> 
> The whole series has all the acks/reviews needed for you to apply the 
> whole thing, so why not take the whole thing? Plus this series has been 
> sitting for 2 months. Not a great experience for submitters...

Patches are missing Acked-by tags.

  Reviewed-by != Acked-by

I cannot merge other subsystem's patches without and Acked-by.

-- 
Lee Jones [李琼斯]
