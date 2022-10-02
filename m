Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD35F22DB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJBLSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJBLSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:18:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CD27FC6;
        Sun,  2 Oct 2022 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1664709489; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvETKxFSRiPOptKhQD6Q7KHSMeZlmowZWNFg3zwzHxc=;
        b=Z0y51wdWyYhKnCKhMTyFCuxc2NkE9ERro45ZHCPHIxnrOSk4kPxbreDRWVTzIL5/qR+nYU
        qqipq0oMu7L5CMfS8wc9E0zt1bHG96cF+ih8/xoxDt0UTMKyM8KLYxQlA2n2aDR4+59i9L
        gRx2xEAubz1sxquHw6Cn8yiXZXkp3Ss=
Date:   Sun, 02 Oct 2022 12:18:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-Id: <02I4JR.BHDWVSR51INT1@crapouillou.net>
In-Reply-To: <20221001180130.73a26c68@jic23-huawei>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
        <HF07HR.3A0DTIDT17IF1@crapouillou.net>
        <20220925155239.7a37c19a@jic23-huawei>
        <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
        <E1KTIR.IK6LI11BUNDM3@crapouillou.net>
        <CAJZ5v0hW049fh=NebWqCMUzZAU=pfHWEFd-dkegRb4qwuHxSXA@mail.gmail.com>
        <20221001180130.73a26c68@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam., oct. 1 2022 at 18:01:30 +0100, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> On Mon, 26 Sep 2022 15:35:35 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
>>  On Mon, Sep 26, 2022 at 3:27 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>  >
>>  > Hi,
>>  >
>>  > Le lun., sept. 26 2022 at 14:00:52 +0200, Rafael J. Wysocki
>>  > <rafael@kernel.org> a =E9crit :
>>  > > On Sun, Sep 25, 2022 at 4:52 PM Jonathan Cameron=20
>> <jic23@kernel.org>
>>  > > wrote:
>>  > >>
>>  > >>  On Thu, 25 Aug 2022 23:42:53 +0100
>>  > >>  Paul Cercueil <paul@crapouillou.net> wrote:
>>  > >>
>>  > >>  > Hi Rafael,
>>  > >>  >
>>  > >>  > Le mar., ao=FBt 23 2022 at 19:47:57 +0200, Rafael J. Wysocki
>>  > >>  > <rafael@kernel.org> a =E9crit :
>>  > >>  > > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil
>>  > >> <paul@crapouillou.net>
>>  > >>  > > wrote:
>>  > >>  > >>
>>  > >>  > >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was=20
>> not
>>  > >> used
>>  > >>  > >> anywhere
>>  > >>  > >>  outside pm.h and pm_runtime.h, so it is safe to update=20
>> it.
>>  > >>  > >>
>>  > >>  > >>  Before, this macro would take a few parameters to be=20
>> used as
>>  > >> sleep
>>  > >>  > >> and
>>  > >>  > >>  runtime callbacks. This made it unsuitable to use with
>>  > >> different
>>  > >>  > >>  callbacks, for instance the "noirq" ones.
>>  > >>  > >>
>>  > >>  > >>  It is now semantically different: instead of creating a
>>  > >>  > >> conditionally
>>  > >>  > >>  exported dev_pm_ops structure, it only contains part of=20
>> the
>>  > >>  > >> definition.
>>  > >>  > >>
>>  > >>  > >>  This macro should however never be used directly (hence=20
>> the
>>  > >> trailing
>>  > >>  > >>  underscore). Instead, the following four macros are=20
>> provided:
>>  > >>  > >>  - EXPORT_DEV_PM_OPS(name)
>>  > >>  > >>  - EXPORT_GPL_DEV_PM_OPS(name)
>>  > >>  > >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
>>  > >>  > >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
>>  > >>  > >>
>>  > >>  > >>  For instance, it is now possible to conditionally=20
>> export noirq
>>  > >>  > >>  suspend/resume PM functions like this:
>>  > >>  > >>
>>  > >>  > >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
>>  > >>  > >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
>>  > >>  > >>  };
>>  > >>  > >>
>>  > >>  > >>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS()=20
>> and
>>  > >>  > >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use=20
>> these
>>  > >> new
>>  > >>  > >> macros.
>>  > >>  > >>
>>  > >>  > >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >>  > >
>>  > >>  > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>  > >>  > >
>>  > >>  > > or please let me know if you need me to pick up this one.
>>  > >>  >
>>  > >>  > Could you pick this one up then, and make a branch for=20
>> Jonathan?
>>  > >>
>>  > >>  Hi Paul, Rafael,
>>  > >>
>>  > >>  What happened to this in the end?  I can't immediately find=20
>> it on
>>  > >>  any of the pm git tree branches.
>>  > >>
>>  > >>  At this stage in the cycle it would be great if this patch at=20
>> least
>>  > >>  makes the merge window, so we can make use of it next cycle.
>>  > >
>>  > > I thought that this would go in along with the other patches in=20
>> the
>>  > > series.
>>  > >
>>  > > I can apply it directly, though, if needed.
>>  > >
>>  > > Thanks!
>>  >
>>  > I think at this point Jonathan can just take it in his tree with=20
>> his
>>  > own patchset. Then I'll rebase this patchset on v6.1-rc1.
>>=20
>>  Sure.
>>=20
>>  Jonathan, please go ahead and take the patch directly.
>=20
> Too late for me to take this for this cycle (I route via Greg KH so=20
> need to have things
> in place a little bit before the merge window).  If Lee doesn't pick=20
> it up, I'll do an
> immutable branch after rc1 is out with just this patch on it, then=20
> anyone who wants
> it can pick it up.

Rafael or Lee, can you take it now?

Or is it already too late? :(

-Paul


