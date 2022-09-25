Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A55E93C4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIYOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIYOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950602A96F;
        Sun, 25 Sep 2022 07:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EFF5B80835;
        Sun, 25 Sep 2022 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C98C433C1;
        Sun, 25 Sep 2022 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664117551;
        bh=Yhn8m8vu6o3GJhZpvX1jvtjYr+7gCNqPBJc0o3j9P/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DLgUmkdVRB8CqOV+f6iWna/DUtjvYsT6AqLj2Vtwdta2lYXGpnfS3BYuke8/Fng+t
         rSwoR/GLJBELkbU6bEMttZwt2n0Rhd23GDQOQ6VAGZ8/WyFwvRCB+lYwr3Y7wRC8L3
         VQlO/TUiOtv68aR6DPdrlBW8NxDyW6jSFYbkmWsugJPmHz3JzFHCPBxMNQpU7+Odw5
         d4BymBEns7vkSWERQP9xsNkp0s7vFZbp6W2FpDB5kEK5KSaKkGjKAAPpVxiY1Z0zCq
         VdHEl6GxQHg2QXREHHvGeLd7+dLVUeeuNxWxbUgsYjyesVF1pMHkeAfsRdSDjzTd3T
         I0ye4qb1B7ftQ==
Date:   Sun, 25 Sep 2022 15:52:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
Message-ID: <20220925155239.7a37c19a@jic23-huawei>
In-Reply-To: <HF07HR.3A0DTIDT17IF1@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
        <HF07HR.3A0DTIDT17IF1@crapouillou.net>
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

On Thu, 25 Aug 2022 23:42:53 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Rafael,
>=20
> Le mar., ao=C3=BBt 23 2022 at 19:47:57 +0200, Rafael J. Wysocki=20
> <rafael@kernel.org> a =C3=A9crit :
> > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil <paul@crapouillou.net>=20
> > wrote: =20
> >>=20
> >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was not used=20
> >> anywhere
> >>  outside pm.h and pm_runtime.h, so it is safe to update it.
> >>=20
> >>  Before, this macro would take a few parameters to be used as sleep=20
> >> and
> >>  runtime callbacks. This made it unsuitable to use with different
> >>  callbacks, for instance the "noirq" ones.
> >>=20
> >>  It is now semantically different: instead of creating a=20
> >> conditionally
> >>  exported dev_pm_ops structure, it only contains part of the=20
> >> definition.
> >>=20
> >>  This macro should however never be used directly (hence the trailing
> >>  underscore). Instead, the following four macros are provided:
> >>  - EXPORT_DEV_PM_OPS(name)
> >>  - EXPORT_GPL_DEV_PM_OPS(name)
> >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
> >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
> >>=20
> >>  For instance, it is now possible to conditionally export noirq
> >>  suspend/resume PM functions like this:
> >>=20
> >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
> >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> >>  };
> >>=20
> >>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
> >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these new=20
> >> macros.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net> =20
> >=20
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > or please let me know if you need me to pick up this one. =20
>=20
> Could you pick this one up then, and make a branch for Jonathan?

Hi Paul, Rafael,

What happened to this in the end?  I can't immediately find it on=20
any of the pm git tree branches.

At this stage in the cycle it would be great if this patch at least
makes the merge window, so we can make use of it next cycle.

Thanks,

Jonathan
