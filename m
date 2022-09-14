Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068FD5B8E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiINRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINRgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:36:36 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96797D1E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:36:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3454b0b1b6dso189377017b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fOIoKPGarOmFiRETNH4hqtwZVGxQ4VkOe6p6uZ6q+IQ=;
        b=YvLlgq7Jlt2jvF88m7ZXuIeezCbvV/bcqfGAvoat5uIavlJ9e1NpDOiu/vlNpaj8OA
         tvmbbudHz0YmFcpviH7NTYApbYewyAOmjhf+viiM6ThaTxI2+wLo1jHB73xJnZww8qxw
         7Wtour+xDyFSUAs/U7Gub8Di4D3tZOtDdLFZbgJp9zjrQdOw9mhdeZd6MtToig9OBzaq
         BqkUl5zbKaokcw978GYyid0STyfWVWyQFIbiGd3m3kUpkXijFeDH+z2V3VPFtUazfQey
         zVeo7zD/Mz4DIm4aPGe6es0P07Wf2EBOGsVheIRjcBU2l1H1YItv6OdCECPDxDl7zAP3
         kjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fOIoKPGarOmFiRETNH4hqtwZVGxQ4VkOe6p6uZ6q+IQ=;
        b=6UrI9mRuwZhHOk38mwkj9Nn//D+ZGx5uAEyTMHmXv2+nPwbqkiX+Eau7O0gBNWp5Tp
         FszLp8dxOluiNVJlnSJIqryWHN3/1IkNzjnvuTAZ8svZUzEpkLD7qvU0eSx7UHHBXHVG
         PsJsQhKAVhYqAzb0sw7kcO6mDqPJmGPTLGrQMnbQ8BWBbyTLAONaa3dje4mVtxfQSb+e
         fxhtnESIxNzspjyxSZ2lHAP1ddHJoesc93fi0RnUxdN9FgR/bbzxPuI05yG+WBL35BYT
         /GfIxPbG/6WvZg/2CmdTZOhHcfDkldalbVOm3ISVbzX5s++hAgcBIm2uPy+RVeHLYzLz
         42kw==
X-Gm-Message-State: ACgBeo36D6fgxoakYtx5u1e4qKzxrF/hct7iupQHLo8MMY+YQ+T9F0B3
        1OL++44+Y8b+kYzLh4jD2Qi10H77cJN9tx+ecceE8w==
X-Google-Smtp-Source: AA6agR6H17nH7CuWoCbYeqwwMkYsU+6qHtat7elM8KtCnYJGqaCIyMsLHEBNuddDwAV93cV5xXTsupGNx7eEKwSXzHQ=
X-Received: by 2002:a81:4842:0:b0:344:fd59:ef81 with SMTP id
 v63-20020a814842000000b00344fd59ef81mr33573878ywa.459.1663176994795; Wed, 14
 Sep 2022 10:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <YuqDMLF2AQyj4+N1@kroah.com> <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
 <YyCequVJnV3p0Cpw@kroah.com> <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
 <YyHehZ5hT8mXKoTX@kroah.com> <CAOesGMid4_pDeUQFwhfSwrBRGhGocA-73V83h5qOsmYg7gAWTA@mail.gmail.com>
In-Reply-To: <CAOesGMid4_pDeUQFwhfSwrBRGhGocA-73V83h5qOsmYg7gAWTA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Sep 2022 10:35:58 -0700
Message-ID: <CAGETcx9Ha+akkuqzanGH9vrCnFQT_zTmezAHwtMhpxsQa=mwjg@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
To:     Olof Johansson <olof@lixom.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 9:24 AM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Wed, Sep 14, 2022 at 7:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 13, 2022 at 09:28:27AM -0700, Olof Johansson wrote:
> > > On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > > > > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > > Saravana Kannan (11):
> > > > > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > > > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > > > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > > > > >       driver core: Add wait_for_init_devices_probe helper function
> > > > > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > > > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > > > > >       driver core: Set fw_devlink.strict=1 by default
> > > > > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > > > > >       driver core: Delete driver_deferred_probe_check_state()
> > > > > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > > > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > > > > >
> > > > > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > > > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > > > > without a single message indicating why.
> > > > > >
> > > > > > The reason seems to be that the iommu-maps property doesn't get
> > > > > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > > > > System works fine without IOMMU, which is how I've ran it for a couple
> > > > > > of years.
> > > > > >
> > > > > > It's also extremely hard to diagnose out of the box because there are
> > > > > > *no error messages*. And there were no warnings leading up to this
> > > > > > strict enforcement.
> > > > > >
> > > > > > This "feature" seems to have been done backwards. The checks should
> > > > > > have been running (and not skipped due to the "optional" flag), but
> > > > > > also not causing errors, just warnings. That would have given users a
> > > > > > chance to know that this is something that needs to be fixed.
> > > > > >
> > > > > > And when you flip the switch, at least report what failed so that
> > > > > > people don't need to spend a whole night bisecting kernels, please.
> > > > > >
> > > > > > Greg, mind reverting just the last one? If I hit this, I presume
> > > > > > others would too.
> > > > >
> > > > > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > > > > fw_devlink.strict=1 by default", 71066545b48e42.
> > > >
> > > > Is this still an issue in -rc5?  A number of patches in the above series
> > > > was just reverted and hopefully should have resolved the issue you are
> > > > seeing.
> > >
> > > Unfortunately, I discovered this regression with -rc5 in the first
> > > place, so it's still there.
> >
> > Ick, ok, Saravana, any thoughts?  I know you're at the conference this
> > week with me, maybe you can give Olof a hint as to what to look for
> > here?
>
> I'm not sure what you want me to look for. The patch turns on
> enforcement of DT contents that never used to be enforced, so now my
> computer no longer boots. And it does it in a way that makes it
> impossible for someone not rebuilding kernels to debug to figure out
> what happened.

Hi Olof,

Sorry for the trouble. It doesn't print any error messages because
there are cases where it's block the probe where it wouldn't be an
error. If I printed it every time fw_devlink blocked a probe, it'd be
a ton of messages.

Btw, when I enabled fw_devlink.strict=1, it was AFTER making changes
that'll stop indefinitely blocking probes. So what you are seeing
shouldn't be happening. After about 10 seconds (configurable), it
should stop blocking the probes.

If you actually want to see the reasons the probe is being blocked,
you can enable the existing dbg messages in drivers/base/core.c.

Would you mind pointing me to the dts (not dtsi) file that corresponds
to this board please? And which specific PCI device is being blocked
from probing? I'll can try to debug it further. Also, can you try to
see why it doesn't get unblocked when driver_deferred_probe_timeout
expires? Or why that's not helping here?

In the meantime, if you want this patch reverted, I'm not opposed to
that. But if you can use fw_devlinks.strict=0 in your commandline for
now and give me time to debug, that'd be nicer.

Thanks,
Saravana
