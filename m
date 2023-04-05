Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED096D812F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjDEPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbjDEPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19B7681;
        Wed,  5 Apr 2023 08:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F654625CB;
        Wed,  5 Apr 2023 15:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFD4C433EF;
        Wed,  5 Apr 2023 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707361;
        bh=FxEmb+M2evgHnsZfxS1UlIMfH2L1Tho1TVG1Xe+iAC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZFI+hPK7i84yEj5DRuNajp7u5CO+lLZbstdWLXSiIhmTyCEHJzqgSQK2mWWzVADj
         UVfAqMLBjzc+0/B8t1S1EtEyTmAX7O4vXGWETm4XB8slG/pY2Y+n1NW8jkYI/p3I4z
         2bhDnE9nPiVv6o8QlPO9o7+kBiLijrMFOS+/IIUI8bqp0QD6qxBPStpUj71GDGL48l
         imc11RsRiFRYgVFkiWgn8l4v52ZOCg38SsHvEnnFHwWGhDHUsB2OAp3bnfv7mBQFv6
         Xfz4sQWmsgF/hu6uuonIy3yuE7mSiqw84kUm55dL8OlqaGqnHtr04qlK4CHM4MzCbT
         6srFOk0V9VyDQ==
Date:   Wed, 5 Apr 2023 16:09:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 05/10] mfd: rt5033: Apply preparatory changes before
 adding rt5033-charger driver
Message-ID: <20230405150915.GN8371@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
 <20230305105551.GJ2574592@google.com>
 <9ce4110c-eaff-3f8b-65da-8407e05af493@rocketmail.com>
 <64840676-b779-8ebb-3a7b-27d58e0e0346@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64840676-b779-8ebb-3a7b-27d58e0e0346@rocketmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Apr 2023, Jakob Hauser wrote:

> Hi Lee,
>
> On 05.03.23 17:14, Jakob Hauser wrote:
> > On 05.03.23 11:55, Lee Jones wrote:
> > > On Tue, 28 Feb 2023, Jakob Hauser wrote:
> > >
> > > > Order the register blocks to have the masks in descending manner.
> > > >
> > > > Add new defines for constant voltage shift (RT5033_CHGCTRL2_CV_SHIFT),
> > > > MIVR mask (RT5033_CHGCTRL4_MIVR_MASK), pre-charge current shift
> > > > (RT5033_CHGCTRL4_IPREC_SHIFT), internal timer disable
> > > > (RT5033_INT_TIMER_DISABLE), termination disable (RT5033_TE_DISABLE),
> > > > CFO disable (RT5033_CFO_DISABLE), UUG disable
> > > > (RT5033_CHARGER_UUG_DISABLE).
> > > >
> > > > The fast charge timer type needs to be written on mask 0x38
> > > > (RT5033_CHGCTRL3_TIMER_MASK). To avoid a bit shift on
> > > > application, change the
> > > > values of the timer types to fit the mask. Added the timout
> > > > duration as a
> > > > comment. And the timer between TIMER8 and TIMER12 is most likely
> > > > TIMER10, see
> > > > e.g. RT5036 [1] page 28 bottom.
> > > >
> > > > Add value options for MIVR (Minimum Input Voltage Regulation).
> > > >
> > > > Move RT5033_TE_ENABLE_MASK to the block "RT5033 CHGCTRL1
> > > > register", in order
> > > > to have the masks of the register collected there. To fit the
> > > > naming scheme,
> > > > rename it to RT5033_CHGCTRL1_TE_EN_MASK.
> > > >
> > > > Move RT5033_CHG_MAX_CURRENT to the block "RT5033 charger
> > > > fast-charge current".
> > > >
> > > > Add new defines RT5033_CV_MAX_VOLTAGE and
> > > > RT5033_CHG_MAX_PRE_CURRENT to the
> > > > blocks "RT5033 charger constant charge voltage" and "RT5033
> > > > charger pre-charge
> > > > current limits".
> > > >
> > > > In include/linux/mfd/rt5033.h, turn power_supply "psy" into a
> > > > pointer in order
> > > > to use it in devm_power_supply_register().
> > >
> > > Are there no present users to account for?
> >
> > At least none I'm aware of. Within the upstream kernel the
> > rt5033_charger power_supply didn't exist so far, the patchset is about
> > to implement it.
>
> Is there anything you want me to change or improve on this patch?

If there were I would have said. :)  Please fix up the other review
comments in the set and submit the next revision.

> > > > [1] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf
> > > >
> > > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > > > ---
> > > >   include/linux/mfd/rt5033-private.h | 53 ++++++++++++++++++++----------
> > > >   include/linux/mfd/rt5033.h         |  2 +-
> > > >   2 files changed, 36 insertions(+),` 19 deletions(-)
>
> Kind regards,
> Jakob

--
Lee Jones [李琼斯]
