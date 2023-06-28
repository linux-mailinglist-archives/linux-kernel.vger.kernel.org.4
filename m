Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EAC7412B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjF1Nk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjF1NkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C6129;
        Wed, 28 Jun 2023 06:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31FAF612D6;
        Wed, 28 Jun 2023 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46700C433C8;
        Wed, 28 Jun 2023 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687959620;
        bh=n93fGuiqy7H4U4TmzEq5JRsE3duXMKbiuJlE6vujB4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jhdnl+5aF3fp26RLRbHB7ZKnexyfwuqNwTwZBaiQ67XpFKJ4ZAi8fYSJdinmjTeK6
         VYiNyZ/PQCzWxRlVvlF0rMYZaPJSv1od0hUc2jB1FbGEFcy1mg+4i9hvKb3PtrAYbz
         ZWUriLsuyp4zenTbNwmCDBM1+VC44TDabXln8iP4bkrVAKWrkYeDDB9CKb7tU0HLhx
         AwYYFtmvWfY+Je+PIypbpZMXXxaSkm/cureteAl/ZkGQ2xrASDtfuIOkOklX6KuQrn
         ei/VTgELIuMH8l97s4nl2WIcKG/2v+PK01NpR8/EgPwr2CKUWYQ6ciORMclmmaVUb1
         nzl9ZMr9J+mrg==
Date:   Wed, 28 Jun 2023 14:40:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230628134013.GH10378@google.com>
References: <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023, Rob Herring wrote:

> On Tue, Jun 27, 2023 at 10:33 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 27 Jun 2023, William Breathitt Gray wrote:
> >
> > > On Tue, Jun 27, 2023 at 08:10:59AM -0600, Rob Herring wrote:
> > > > On Tue, Jun 27, 2023 at 7:56 AM Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > On Mon, 26 Jun 2023, Rob Herring wrote:
> > > > >
> > > > > > On Wed, Jun 21, 2023 at 06:13:15PM +0100, Lee Jones wrote:
> > > > > > > On Tue, 13 Jun 2023, Sahin, Okan wrote:
> > > > > > >
> > > > > > > > >On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:
> > > > > > > > >
> > > > > > > > >> I'll try anything once!
> > > > > > > > >
> > > > > > > > >> Fair warning, I think this is going to massively complicate things.
> > > > > > > > >
> > > > > > > > >> Either we're going to be left with a situation where child-driver
> > > > > > > > >> maintainers are scrabbling around looking for previous versions for the
> > > > > > > > >> MFD pull-request or contributors being forced to wait a full cycle for
> > > > > > > > >> their dependencies to arrive in the maintainer's base.
> > > > > > > > >
> > > > > > > > >If people are resending after the MFD has gone in they really ought to
> > > > > > > > >be including the pull request in the cover letter, with some combination
> > > > > > > > >of either referencing the mail or just saying "this depends on the
> > > > > > > > >signed tag at url+tag", the same way they would for any other dependency.
> > > > > > > > >
> > > > > > > > >I can't see how you applying stuff when you can slow things down TBH,
> > > > > > > > >the MFD bits will be applied faster and either people can pull in a
> > > > > > > > >shared tag or you can apply more commits on top of the existing core
> > > > > > > > >driver.
> > > > > > > > >
> > > > > > > > >> I'm not sure why simply providing your Ack when you're happy with the
> > > > > > > > >> driver and forgetting about the set until the pull-request arrives, like
> > > > > > > > >> we've been doing for nearly a decade now, isn't working for you anymore
> > > > > > > > >> but I'm mostly sure this method will be a regression.
> > > > > > > > >
> > > > > > > > >Like I said I've not been doing that, I've mostly been just applying the
> > > > > > > > >driver when it's ready.  This might not have been so visible to you
> > > > > > > > >since it means that the regulator driver doesn't appear in the series by
> > > > > > > > >the time the MFD settles down.  The whole "Acked-for-MFD" has always
> > > > > > > > >been a bit confusing TBH, it's not a normal ack ("go ahead and apply
> > > > > > > > >this, I'm fine with it") so it was never clear what the intention was.
> > > > > > > > >
> > > > > > > > >Before I started just applying the drivers there used to be constant
> > > > > > > > >problems with things like tags going missing (which some of the time is
> > > > > > > > >the submitter just not carrying them but can also be the result of some
> > > > > > > > >churn causing them to be deliberately dropped due to changes) or
> > > > > > > > >forgetting the series as you suggest and then not looking at some other
> > > > > > > > >very similarly named series that was also getting lots of versions after
> > > > > > > > >thinking it was one that had been reviewed already.  It was all very
> > > > > > > > >frustrating.  Not doing the tags until the dependencies have settled
> > > > > > > > >down means that if it's in my inbox it at least consistently needs some
> > > > > > > > >kind of attention and that the submitter didn't drop tags or anything so
> > > > > > > > >I know why there's no tag on it even though the version number is high,
> > > > > > > > >though it's not ideal either.
> > > > > > > >
> > > > > > > > Hi Mark and Lee,
> > > > > > > >
> > > > > > > > Is there anything that I need to do for this patch set. I have received reviewed
> > > > > > > > by tag for all of them so far.
> > > > > > >
> > > > > > > Since we are so late in the day, I'm going to just apply this for v6.5.
> > > > > > >
> > > > > > > The remainder can then be applied, friction free, for v6.6.
> > > > > >
> > > > > > Now we have undocmented bindings in use by the driver (as pointed out by
> > > > > > 'make dt_compatible_check').
> > > > > >
> > > > > > The whole series has all the acks/reviews needed for you to apply the
> > > > > > whole thing, so why not take the whole thing? Plus this series has been
> > > > > > sitting for 2 months. Not a great experience for submitters...
> > > > >
> > > > > Patches are missing Acked-by tags.
> > > > >
> > > > >   Reviewed-by != Acked-by
> > > >
> > > > Reviewed-by > Acked-by
> > > >
> > > > >
> > > > > I cannot merge other subsystem's patches without and Acked-by.
> > > >
> > > > I (and Krzysztof) give one or the other. If I'm taking a patch, then
> > > > it's neither. I'm pretty sure Mark only gives Reviewed-by when he is
> > > > not taking something.
> > > >
> > > > Rob
> > >
> > > It does seem a bit ambiguous whether an "Acked-by" indicates a
> > > "Reviewed-by + acceptance of the changes" or just a brief look-over with
> > > acceptance of the changes. FWIW the documentation does use the word
> > > "reviewed" when describing Acked-by. [^1]
> > >
> > > However, I would argue that a Reviewed-by has a implicit acceptance of
> > > the changes: why else provide a Reviewed-by line for the commit message
> > > if you fundamentally disagree with the changes being merged? So a
> >
> > Where MFD is concerned the complexities are seldom 'whether' a patch
> > should be merged, but rather 'how' it should be merged.
> >
> > In order to solve some of these issues in the past, I created a bespoke
> > tag for scenarios where I'd like to indicate that a submission had been
> > reviewed, but I also intended to take the patch via the MFD tree once
> > all of the other pieces were ready.  Despite using this tag for around a
> > decade, it did cause occasional confusion, even amongst maintainers I'd
> > been working with for the longest time, so I recently stopped using it
> > and replaced it with a standard Reviewed-by, to mean that it's reviewed
> > but permission was *not* given for someone else to merge it - since my
> > understanding, according to the documentation, is that an Acked-by is
> > required for that.
> >
> > Recent discussions with other maintainers culminated in an agreement
> > that I would start only taking the MFD pieces and follow-up with a
> > pull-request for an immutable branch for them to pull from.  Since there
> > is no more time to create, test and submit a maintainer-maintainer
> > pull-request, I decided to merge this patch anyway, so the leaf drivers
> > can be applied in a couple of weeks, after the merge-window is closed.
> >
> > Which brings us to where we are now!
> >
> > Without different tag which doesn't exist today, I'm not entirely sure
> > how to solve this issue.  Ideas welcome.
> 
> IMO, a series with interdependencies, which most cases of a new MFD
> are, should be applied as a series. That's generally what happens
> everywhere else. Creating a branch and PR seems like extra work for
> everyone. The downside to that is any API changes outside of MFD would

This is what we've been doing for the last decade.  However, I'm getting
mixed messages from folk.  Mark recently asked for something completely
different (which I did say would be a bad idea at the time):

https://lore.kernel.org/all/20230421073938.GO996918@google.com/

Could we please just pick a strategy and go with it?

> need some coordination. That coordination would only be needed when a
> subsystem has some API change and there's a new MFD using that
> subsystem rather than by default for every new MFD.
> 
> Another option is just that you take all the binding patches since the
> MFD binding depends on the others. The drivers can still go via the
> subsystem. Not totally ideal to have branches of drivers missing
> bindings, but better than mainline missing bindings.

My original method of taking everything with Acks was fine IMHO.

-- 
Lee Jones [李琼斯]
