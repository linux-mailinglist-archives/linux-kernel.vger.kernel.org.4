Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97D5F1E02
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJARCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJARCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AF278;
        Sat,  1 Oct 2022 10:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A2D60C4A;
        Sat,  1 Oct 2022 17:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A737C433D6;
        Sat,  1 Oct 2022 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664643674;
        bh=Lqpg3UgpPBXoX36zdDlIkFsUKkVufb4LAga1gaHXJrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BhBTr3eJC4IO7g5XhVa6Ama3J8nckkmNE1P7n1NTmwuQ5CHcJen5lAHtqusr5Vm7v
         faWtgifpODzzX4Q3BSwp4LQWb3SRcRQLtiHwf41XNmfk5E4dyfF75Zg8kxj1Sne+Ze
         knbXkk+UCzXMgoL8x7mz6aFbl/NDpd50nSNIFVdTEQVtq9RiBO2HbvQHDtackq+gyc
         CmzTOulmMiPZR9WmteXRlNyJCSije0s9D/BHYMPzklVRIwEDN0g37JQuzxaXYqFpZO
         fGEPphIi9s6IjO60+FJ91nORe6zDhb7tCqFpRXXinqLg3LV8No+4Lf9wwoGQXT2iLk
         IynDdUNakVZCA==
Date:   Sat, 1 Oct 2022 18:01:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
Message-ID: <20221001180130.73a26c68@jic23-huawei>
In-Reply-To: <CAJZ5v0hW049fh=NebWqCMUzZAU=pfHWEFd-dkegRb4qwuHxSXA@mail.gmail.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
        <HF07HR.3A0DTIDT17IF1@crapouillou.net>
        <20220925155239.7a37c19a@jic23-huawei>
        <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
        <E1KTIR.IK6LI11BUNDM3@crapouillou.net>
        <CAJZ5v0hW049fh=NebWqCMUzZAU=pfHWEFd-dkegRb4qwuHxSXA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 15:35:35 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Sep 26, 2022 at 3:27 PM Paul Cercueil <paul@crapouillou.net> wrot=
e:
> >
> > Hi,
> >
> > Le lun., sept. 26 2022 at 14:00:52 +0200, Rafael J. Wysocki
> > <rafael@kernel.org> a =C3=A9crit : =20
> > > On Sun, Sep 25, 2022 at 4:52 PM Jonathan Cameron <jic23@kernel.org>
> > > wrote: =20
> > >>
> > >>  On Thu, 25 Aug 2022 23:42:53 +0100
> > >>  Paul Cercueil <paul@crapouillou.net> wrote:
> > >> =20
> > >>  > Hi Rafael,
> > >>  >
> > >>  > Le mar., ao=C3=BBt 23 2022 at 19:47:57 +0200, Rafael J. Wysocki
> > >>  > <rafael@kernel.org> a =C3=A9crit : =20
> > >>  > > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil =20
> > >> <paul@crapouillou.net> =20
> > >>  > > wrote: =20
> > >>  > >>
> > >>  > >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was not =20
> > >> used =20
> > >>  > >> anywhere
> > >>  > >>  outside pm.h and pm_runtime.h, so it is safe to update it.
> > >>  > >>
> > >>  > >>  Before, this macro would take a few parameters to be used as =
=20
> > >> sleep =20
> > >>  > >> and
> > >>  > >>  runtime callbacks. This made it unsuitable to use with =20
> > >> different =20
> > >>  > >>  callbacks, for instance the "noirq" ones.
> > >>  > >>
> > >>  > >>  It is now semantically different: instead of creating a
> > >>  > >> conditionally
> > >>  > >>  exported dev_pm_ops structure, it only contains part of the
> > >>  > >> definition.
> > >>  > >>
> > >>  > >>  This macro should however never be used directly (hence the =
=20
> > >> trailing =20
> > >>  > >>  underscore). Instead, the following four macros are provided:
> > >>  > >>  - EXPORT_DEV_PM_OPS(name)
> > >>  > >>  - EXPORT_GPL_DEV_PM_OPS(name)
> > >>  > >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
> > >>  > >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
> > >>  > >>
> > >>  > >>  For instance, it is now possible to conditionally export noirq
> > >>  > >>  suspend/resume PM functions like this:
> > >>  > >>
> > >>  > >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
> > >>  > >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> > >>  > >>  };
> > >>  > >>
> > >>  > >>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
> > >>  > >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these =
=20
> > >> new =20
> > >>  > >> macros.
> > >>  > >>
> > >>  > >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net> =20
> > >>  > >
> > >>  > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>  > >
> > >>  > > or please let me know if you need me to pick up this one. =20
> > >>  >
> > >>  > Could you pick this one up then, and make a branch for Jonathan? =
=20
> > >>
> > >>  Hi Paul, Rafael,
> > >>
> > >>  What happened to this in the end?  I can't immediately find it on
> > >>  any of the pm git tree branches.
> > >>
> > >>  At this stage in the cycle it would be great if this patch at least
> > >>  makes the merge window, so we can make use of it next cycle. =20
> > >
> > > I thought that this would go in along with the other patches in the
> > > series.
> > >
> > > I can apply it directly, though, if needed.
> > >
> > > Thanks! =20
> >
> > I think at this point Jonathan can just take it in his tree with his
> > own patchset. Then I'll rebase this patchset on v6.1-rc1. =20
>=20
> Sure.
>=20
> Jonathan, please go ahead and take the patch directly.

Too late for me to take this for this cycle (I route via Greg KH so need to=
 have things
in place a little bit before the merge window).  If Lee doesn't pick it up,=
 I'll do an
immutable branch after rc1 is out with just this patch on it, then anyone w=
ho wants
it can pick it up.

Thanks,

Jonathan
