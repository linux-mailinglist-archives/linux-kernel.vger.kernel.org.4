Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9E7420EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjF2H0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjF2HZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:25:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C9E58;
        Thu, 29 Jun 2023 00:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5365614D9;
        Thu, 29 Jun 2023 07:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC66BC433C0;
        Thu, 29 Jun 2023 07:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688023508;
        bh=DjGPmaicOQHgW2B1UVzAGqUY9g3dDTuRLVc78Aqh5sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzhjPaFGCqitPXcsjJBa7ewG2MrowqLK4Pn7QehP9MoRIHdKsLwzBIavjatsHlx6Q
         TXR+2X01fpY86ujJAuRMjW8Nw5Pa//VGABKpDut/AeHsEW8ovuyciNXEiR/BzMYXnC
         MbcXgE7UVXw2fwPPhWSQZ6iG5z3fT4qrNMLSnu3cu2U9HfB0ziq9nN4LBPFgF9klnk
         stXPWjZL+cKAGWyXHSeBbB7NzfZj7LFC43yuI+3rhivd+mrFK6OXHIR33wiggMHCHG
         5BI4B2irsuORvef9EudHjRpf2CndIy7xh09Vz5RsMjBmdnvqr7fps6lNwQlLVnQo9r
         7YWsvfkjAxhpw==
Date:   Thu, 29 Jun 2023 08:25:00 +0100
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
Message-ID: <20230629072500.GA2110266@google.com>
References: <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: I'm reverting back to the old style of cross-subsystem patch
management where sets get merged as sets with maintainer Acks (or
Reviews!).

On Wed, 28 Jun 2023, Mark Brown wrote:
> On Wed, Jun 28, 2023 at 02:40:13PM +0100, Lee Jones wrote:
> > On Tue, 27 Jun 2023, Rob Herring wrote:
> > > On Tue, Jun 27, 2023 at 10:33 AM Lee Jones <lee@kernel.org> wrote:
> 
> > > IMO, a series with interdependencies, which most cases of a new MFD
> > > are, should be applied as a series. That's generally what happens
> > > everywhere else. Creating a branch and PR seems like extra work for
> > > everyone. The downside to that is any API changes outside of MFD would
> 
> > This is what we've been doing for the last decade.  However, I'm getting
> > mixed messages from folk.  Mark recently asked for something completely
> > different (which I did say would be a bad idea at the time):
> 
> > https://lore.kernel.org/all/20230421073938.GO996918@google.com/
> 
> > Could we please just pick a strategy and go with it?
> 
> The basic ask from me is for things that cause these serieses to make
> progress, ideally in ways that minimise the amount of noise that they
> generate (given that they're generally pretty routine).  Applying
> patches when they're ready at least mitigates the size of the series,
> makes it easy to tell that they're OK and doesn't preclude applying more
> patches on top of it if that's a thing that people want to do.
> 
> > > need some coordination. That coordination would only be needed when a
> > > subsystem has some API change and there's a new MFD using that
> > > subsystem rather than by default for every new MFD.
> 
> > > Another option is just that you take all the binding patches since the
> > > MFD binding depends on the others. The drivers can still go via the
> > > subsystem. Not totally ideal to have branches of drivers missing
> > > bindings, but better than mainline missing bindings.
> 
> > My original method of taking everything with Acks was fine IMHO.
> 
> As I mentioned before the number of resends of what are frequently very
> similar serieses (eg, two PMICs from the same vendor in flight at the
> same time) was causing me real issues with tags going AWOL and things
> getting lost in the noise.

As much as I empathise with each of these points (I feel it too), the
alternative seems to be causing more issues for more people.  With that
in mind, I'm going to revert back to how we've been doing things for a
long time now.  Please try to Ack and forget.  If a contributor fails to
apply a previously issued tag, we'll have to bring that up at the time.

-- 
Lee Jones [李琼斯]
