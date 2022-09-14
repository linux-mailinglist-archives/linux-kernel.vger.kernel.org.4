Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF85B8CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiINQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiINQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:24:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7B52DFD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:24:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a26so7236376ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iPvcRKQ3/RqRnb/KNOcwBsKTik/oM2E9btzJlJ3xtbw=;
        b=UUW/XmCV1JYV8LfgqC/Yi2kUbkZfzbWyffYAPE5XdIdCMrNxQAvlr3wOP2Hzc6uACl
         syl37yzz3CubUgn6U+5UnhQzmJf1voYR7fFNBFzhXNrWdK4xzmesc8AKheuoYDgus+3c
         TqcxYBb4kdjzOcQxxc1kuSBpVrJkfGghOrocYl257Fw4moSaEviRq2ROpoHYe5OALvDL
         jhZUWCKC32/Iutw6ZOZDZoACEINekhhh0ba8ayJSAilnYa7+YKqvr5tpKVyzrfPNdklL
         eX/cwh0SaOCan4rKJ4OGUR0CecYOzwB0sWRYEHxSVzD+Dm7E4ujlAGJ3JJ+QiaRouMUU
         wCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iPvcRKQ3/RqRnb/KNOcwBsKTik/oM2E9btzJlJ3xtbw=;
        b=71bYgpakN9uDGxyvOnRyu0JzNXVI7ONq1t+43t99ihk0dH5dBVPaq2J6ksYJ7K+F7h
         hBtDJgfVCXUjWM4uBijlfK4P0c/lx3FvzbW5HTUi8Wq2BD5rHUnOEoIyK9p9j8b3wjEn
         q8FqrQA7BX6OvBPmmuKrO9biO+NQqMwvQL/rZiLedau3CxMYFO5who2/7BQMpYl7mqfY
         f9mhFOrGBKrrAiOZvlXDF6YHzjB42BDcPDO0Zaf7DlHcqOpBycXKIWhWFrDaqzKXJJm0
         4tVai0KQSNvj+r0IDcbUEwThSY6aF9rueP4YtAAdGaVauWpv2Drkv87orCVd/ke0kj2b
         CxCQ==
X-Gm-Message-State: ACgBeo2Qi2wQTz8X7er+MktZdvrRsPxczMDx0JQO7eCoLjDAOcxoXjDO
        OdgobksjSRkZnAAVte65PLtadGUQVUTjA6k9xG6BMA==
X-Google-Smtp-Source: AA6agR7BqJBqsWKt2M6q7i2A14Fsfv98BBM2NQBaW6bfjVBNdJDDAfqKYlb+MIOrQnSw7kuWVO3vrb/BkPMPvM0Nst4=
X-Received: by 2002:a17:907:a0c7:b0:77f:a9d2:9be2 with SMTP id
 hw7-20020a170907a0c700b0077fa9d29be2mr7773678ejc.352.1663172690708; Wed, 14
 Sep 2022 09:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com> <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
 <YyCequVJnV3p0Cpw@kroah.com> <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
 <YyHehZ5hT8mXKoTX@kroah.com>
In-Reply-To: <YyHehZ5hT8mXKoTX@kroah.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 14 Sep 2022 09:24:39 -0700
Message-ID: <CAOesGMid4_pDeUQFwhfSwrBRGhGocA-73V83h5qOsmYg7gAWTA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 14, 2022 at 7:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 13, 2022 at 09:28:27AM -0700, Olof Johansson wrote:
> > On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > > > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > > Saravana Kannan (11):
> > > > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > > > >       driver core: Add wait_for_init_devices_probe helper function
> > > > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > > > >       driver core: Set fw_devlink.strict=1 by default
> > > > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > > > >       driver core: Delete driver_deferred_probe_check_state()
> > > > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > > > >
> > > > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > > > without a single message indicating why.
> > > > >
> > > > > The reason seems to be that the iommu-maps property doesn't get
> > > > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > > > System works fine without IOMMU, which is how I've ran it for a couple
> > > > > of years.
> > > > >
> > > > > It's also extremely hard to diagnose out of the box because there are
> > > > > *no error messages*. And there were no warnings leading up to this
> > > > > strict enforcement.
> > > > >
> > > > > This "feature" seems to have been done backwards. The checks should
> > > > > have been running (and not skipped due to the "optional" flag), but
> > > > > also not causing errors, just warnings. That would have given users a
> > > > > chance to know that this is something that needs to be fixed.
> > > > >
> > > > > And when you flip the switch, at least report what failed so that
> > > > > people don't need to spend a whole night bisecting kernels, please.
> > > > >
> > > > > Greg, mind reverting just the last one? If I hit this, I presume
> > > > > others would too.
> > > >
> > > > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > > > fw_devlink.strict=1 by default", 71066545b48e42.
> > >
> > > Is this still an issue in -rc5?  A number of patches in the above series
> > > was just reverted and hopefully should have resolved the issue you are
> > > seeing.
> >
> > Unfortunately, I discovered this regression with -rc5 in the first
> > place, so it's still there.
>
> Ick, ok, Saravana, any thoughts?  I know you're at the conference this
> week with me, maybe you can give Olof a hint as to what to look for
> here?

I'm not sure what you want me to look for. The patch turns on
enforcement of DT contents that never used to be enforced, so now my
computer no longer boots. And it does it in a way that makes it
impossible for someone not rebuilding kernels to debug to figure out
what happened.

The patch needs to be reverted.


-Olof
