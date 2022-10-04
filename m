Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687035F4984
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJDSyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJDSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:54:42 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514B26FA;
        Tue,  4 Oct 2022 11:54:40 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id d17so8916336qko.13;
        Tue, 04 Oct 2022 11:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdtc+t7wGNjswxQTZhTlNSVRnQ6rM6gPFaGPVkVUU6w=;
        b=QX9kcupKDeWc+/qseMH7c3TzIorwlqlVC9yCzuQqoYnjvHJGKqEl4xVWisdCpioKMI
         odG9mish6Aw2ppTVNe1HHMc3o9VM+Ky3yMB5yRDM57WCeSxAuU/WhoBFHZPUWivSngxL
         d4bqpkk0uIoaaEMV7esazN9ggClDKa1bqBcA5xIoM0PYApZDp6XLd+nAX0QO2PN+je8d
         Uhf8HND81Dt3GD9VP6dMhpsl1ie6O0vD50df9bGZYJpteY6HeVPYYEIHj9jUq4WfeOZi
         zU5L8ky52IVg2p5/tH7h2R9m8p7ygg9wdP+dEBZJm52KeO2FLyp3A55RyEBer4AnJRb/
         9CWA==
X-Gm-Message-State: ACrzQf3Uwpb7w85glHShU7ahOD5SAPuf2nUYZvXM6bBhCusdKUjmar8F
        XHzMwMpLhAmlPsqGZJGcG0mokByEpjokMIriNw84vObv
X-Google-Smtp-Source: AMsMyM4C4SVFFijCPL5dNypnlGnD3SRLw1FjYeQygBpL6DCozK911C1c7gWxdXTVJkaPuWg9lYBmPeu9r2udSrwhfcM=
X-Received: by 2002:ae9:e50e:0:b0:6e0:c985:6383 with SMTP id
 w14-20020ae9e50e000000b006e0c9856383mr1940426qkf.505.1664909679673; Tue, 04
 Oct 2022 11:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220808174107.38676-1-paul@crapouillou.net> <20220808174107.38676-2-paul@crapouillou.net>
 <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
 <HF07HR.3A0DTIDT17IF1@crapouillou.net> <20220925155239.7a37c19a@jic23-huawei>
 <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
 <E1KTIR.IK6LI11BUNDM3@crapouillou.net> <CAJZ5v0hW049fh=NebWqCMUzZAU=pfHWEFd-dkegRb4qwuHxSXA@mail.gmail.com>
 <20221001180130.73a26c68@jic23-huawei> <02I4JR.BHDWVSR51INT1@crapouillou.net>
In-Reply-To: <02I4JR.BHDWVSR51INT1@crapouillou.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 20:54:28 +0200
Message-ID: <CAJZ5v0i06Nj1+kWDPtok-3vB1UPKfdieux8VrLm21NT0XFCftA@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 1:18 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le sam., oct. 1 2022 at 18:01:30 +0100, Jonathan Cameron
> <jic23@kernel.org> a écrit :
> > On Mon, 26 Sep 2022 15:35:35 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> >>  On Mon, Sep 26, 2022 at 3:27 PM Paul Cercueil
> >> <paul@crapouillou.net> wrote:
> >>  >
> >>  > Hi,
> >>  >
> >>  > Le lun., sept. 26 2022 at 14:00:52 +0200, Rafael J. Wysocki
> >>  > <rafael@kernel.org> a écrit :
> >>  > > On Sun, Sep 25, 2022 at 4:52 PM Jonathan Cameron
> >> <jic23@kernel.org>
> >>  > > wrote:
> >>  > >>
> >>  > >>  On Thu, 25 Aug 2022 23:42:53 +0100
> >>  > >>  Paul Cercueil <paul@crapouillou.net> wrote:
> >>  > >>
> >>  > >>  > Hi Rafael,
> >>  > >>  >
> >>  > >>  > Le mar., août 23 2022 at 19:47:57 +0200, Rafael J. Wysocki
> >>  > >>  > <rafael@kernel.org> a écrit :
> >>  > >>  > > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil
> >>  > >> <paul@crapouillou.net>
> >>  > >>  > > wrote:
> >>  > >>  > >>
> >>  > >>  > >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was
> >> not
> >>  > >> used
> >>  > >>  > >> anywhere
> >>  > >>  > >>  outside pm.h and pm_runtime.h, so it is safe to update
> >> it.
> >>  > >>  > >>
> >>  > >>  > >>  Before, this macro would take a few parameters to be
> >> used as
> >>  > >> sleep
> >>  > >>  > >> and
> >>  > >>  > >>  runtime callbacks. This made it unsuitable to use with
> >>  > >> different
> >>  > >>  > >>  callbacks, for instance the "noirq" ones.
> >>  > >>  > >>
> >>  > >>  > >>  It is now semantically different: instead of creating a
> >>  > >>  > >> conditionally
> >>  > >>  > >>  exported dev_pm_ops structure, it only contains part of
> >> the
> >>  > >>  > >> definition.
> >>  > >>  > >>
> >>  > >>  > >>  This macro should however never be used directly (hence
> >> the
> >>  > >> trailing
> >>  > >>  > >>  underscore). Instead, the following four macros are
> >> provided:
> >>  > >>  > >>  - EXPORT_DEV_PM_OPS(name)
> >>  > >>  > >>  - EXPORT_GPL_DEV_PM_OPS(name)
> >>  > >>  > >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
> >>  > >>  > >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
> >>  > >>  > >>
> >>  > >>  > >>  For instance, it is now possible to conditionally
> >> export noirq
> >>  > >>  > >>  suspend/resume PM functions like this:
> >>  > >>  > >>
> >>  > >>  > >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) = {
> >>  > >>  > >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> >>  > >>  > >>  };
> >>  > >>  > >>
> >>  > >>  > >>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS()
> >> and
> >>  > >>  > >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use
> >> these
> >>  > >> new
> >>  > >>  > >> macros.
> >>  > >>  > >>
> >>  > >>  > >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  > >>  > >
> >>  > >>  > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>  > >>  > >
> >>  > >>  > > or please let me know if you need me to pick up this one.
> >>  > >>  >
> >>  > >>  > Could you pick this one up then, and make a branch for
> >> Jonathan?
> >>  > >>
> >>  > >>  Hi Paul, Rafael,
> >>  > >>
> >>  > >>  What happened to this in the end?  I can't immediately find
> >> it on
> >>  > >>  any of the pm git tree branches.
> >>  > >>
> >>  > >>  At this stage in the cycle it would be great if this patch at
> >> least
> >>  > >>  makes the merge window, so we can make use of it next cycle.
> >>  > >
> >>  > > I thought that this would go in along with the other patches in
> >> the
> >>  > > series.
> >>  > >
> >>  > > I can apply it directly, though, if needed.
> >>  > >
> >>  > > Thanks!
> >>  >
> >>  > I think at this point Jonathan can just take it in his tree with
> >> his
> >>  > own patchset. Then I'll rebase this patchset on v6.1-rc1.
> >>
> >>  Sure.
> >>
> >>  Jonathan, please go ahead and take the patch directly.
> >
> > Too late for me to take this for this cycle (I route via Greg KH so
> > need to have things
> > in place a little bit before the merge window).  If Lee doesn't pick
> > it up, I'll do an
> > immutable branch after rc1 is out with just this patch on it, then
> > anyone who wants
> > it can pick it up.
>
> Rafael or Lee, can you take it now?
>
> Or is it already too late? :(

I've applied this patch as 6.1-rc material, thanks!
