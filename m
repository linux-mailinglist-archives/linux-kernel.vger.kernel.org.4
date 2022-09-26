Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194695EA952
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiIZO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiIZO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:37 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CC83BCA;
        Mon, 26 Sep 2022 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1664198846; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ULdw5+ZZcqnYjD/PcdYVErjo2OqoNNOUkGfsILCHOY=;
        b=S2lnlGqH7h0ZsWCwfTPeamyzC6hEzvU/gS36Y//QLukvNaM9xbbwoXIb7tVu5OnE/0ximh
        zUdrl+c1otOqACLriHpOFa7ofn7UR4dclPM1xQGlVcM8og0I4nLISD+yWGSTMUn2f6M7vo
        6NDVw6fw5VuaSeuuSvVHef68GuX+QCc=
Date:   Mon, 26 Sep 2022 09:27:14 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/30] pm: Improve EXPORT_*_DEV_PM_OPS macros
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-Id: <E1KTIR.IK6LI11BUNDM3@crapouillou.net>
In-Reply-To: <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
References: <20220808174107.38676-1-paul@crapouillou.net>
        <20220808174107.38676-2-paul@crapouillou.net>
        <CAJZ5v0h3hf06xQsJGOfOyGbD470jyxkPNuaHP+E-pvXbS6Egxg@mail.gmail.com>
        <HF07HR.3A0DTIDT17IF1@crapouillou.net>
        <20220925155239.7a37c19a@jic23-huawei>
        <CAJZ5v0igQL_766obp2csNCg7b0g3g2+gkuqZXjUNL7Jj9Da7zQ@mail.gmail.com>
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

Hi,

Le lun., sept. 26 2022 at 14:00:52 +0200, Rafael J. Wysocki=20
<rafael@kernel.org> a =E9crit :
> On Sun, Sep 25, 2022 at 4:52 PM Jonathan Cameron <jic23@kernel.org>=20
> wrote:
>>=20
>>  On Thu, 25 Aug 2022 23:42:53 +0100
>>  Paul Cercueil <paul@crapouillou.net> wrote:
>>=20
>>  > Hi Rafael,
>>  >
>>  > Le mar., ao=FBt 23 2022 at 19:47:57 +0200, Rafael J. Wysocki
>>  > <rafael@kernel.org> a =E9crit :
>>  > > On Mon, Aug 8, 2022 at 7:41 PM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > > wrote:
>>  > >>
>>  > >>  Update the _EXPORT_DEV_PM_OPS() internal macro. It was not=20
>> used
>>  > >> anywhere
>>  > >>  outside pm.h and pm_runtime.h, so it is safe to update it.
>>  > >>
>>  > >>  Before, this macro would take a few parameters to be used as=20
>> sleep
>>  > >> and
>>  > >>  runtime callbacks. This made it unsuitable to use with=20
>> different
>>  > >>  callbacks, for instance the "noirq" ones.
>>  > >>
>>  > >>  It is now semantically different: instead of creating a
>>  > >> conditionally
>>  > >>  exported dev_pm_ops structure, it only contains part of the
>>  > >> definition.
>>  > >>
>>  > >>  This macro should however never be used directly (hence the=20
>> trailing
>>  > >>  underscore). Instead, the following four macros are provided:
>>  > >>  - EXPORT_DEV_PM_OPS(name)
>>  > >>  - EXPORT_GPL_DEV_PM_OPS(name)
>>  > >>  - EXPORT_NS_DEV_PM_OPS(name, ns)
>>  > >>  - EXPORT_NS_GPL_DEV_PM_OPS(name, ns)
>>  > >>
>>  > >>  For instance, it is now possible to conditionally export noirq
>>  > >>  suspend/resume PM functions like this:
>>  > >>
>>  > >>  EXPORT_GPL_DEV_PM_OPS(foo_pm_ops) =3D {
>>  > >>      NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
>>  > >>  };
>>  > >>
>>  > >>  The existing helper macros EXPORT_*_SIMPLE_DEV_PM_OPS() and
>>  > >>  EXPORT_*_RUNTIME_DEV_PM_OPS() have been updated to use these=20
>> new
>>  > >> macros.
>>  > >>
>>  > >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >
>>  > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>  > >
>>  > > or please let me know if you need me to pick up this one.
>>  >
>>  > Could you pick this one up then, and make a branch for Jonathan?
>>=20
>>  Hi Paul, Rafael,
>>=20
>>  What happened to this in the end?  I can't immediately find it on
>>  any of the pm git tree branches.
>>=20
>>  At this stage in the cycle it would be great if this patch at least
>>  makes the merge window, so we can make use of it next cycle.
>=20
> I thought that this would go in along with the other patches in the=20
> series.
>=20
> I can apply it directly, though, if needed.
>=20
> Thanks!

I think at this point Jonathan can just take it in his tree with his=20
own patchset. Then I'll rebase this patchset on v6.1-rc1.

Cheers,
-Paul


