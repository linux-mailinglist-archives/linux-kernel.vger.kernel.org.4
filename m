Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3967A6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjAXXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAXXKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:10:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6835D1C318;
        Tue, 24 Jan 2023 15:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E555B816A2;
        Tue, 24 Jan 2023 23:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC5FC433D2;
        Tue, 24 Jan 2023 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674601797;
        bh=wGkrTvwbUrvsMXFde+BwpUrtWLtdKcEhQ4ZYux9Jo2Y=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=pcdTUIPNx9Zu3k5T2uBy9ivkf/HvJ+OXoumhCiDjxtptmUFkCNHKn1X6bX3cPeDR5
         4+5zqBl2Z25nNzxSXZ3AWBQ/ApnSOT3W4OOppBX+CVlIaETHASWqyuEUgFWADAfSo4
         jbpVzVejtO92IaMfszWqPu65zpGEhfXZ0efNQNuDqC4Tz+lGUPUbYVfgihnP98sMrT
         GmptyJ/kOLHqRp+NANz+76X8pPYBUV/T34zp+S848L74Feg4ONFcu00DXh9ED9t+m8
         KsxJ26FUqSY/e5ZxgHvNXWwieONWLcV8ZevkV7Q+dRp7fXCZmvPAttHGB9aUJEgUJ1
         JISFOnWySeBzw==
Date:   Tue, 24 Jan 2023 15:09:51 -0800
From:   Kees Cook <kees@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     Seth Jenkins <sethjenkins@google.com>,
        SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/6] exit: Put an upper limit on how often we can oops
User-Agent: K-9 Mail for Android
In-Reply-To: <Y9AzndICHRElk4jI@sol.localdomain>
References: <20221117234328.594699-2-keescook@chromium.org> <20230119201023.4003-1-sj@kernel.org> <CALxfFW76Ey=QNu--Vp59u2wukr6dzvOE25PkOHVw0b13YoCSiA@mail.gmail.com> <202301191627.FC1E24ED5@keescook> <Y9ApdF5LaUl9dNFm@sol.localdomain> <Y9AzndICHRElk4jI@sol.localdomain>
Message-ID: <E5988762-D1D7-4C8A-ACC8-E623D4B29A11@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 24, 2023 11:38:05 AM PST, Eric Biggers <ebiggers@kernel=2Eorg> w=
rote:
>On Tue, Jan 24, 2023 at 10:54:57AM -0800, Eric Biggers wrote:
>> On Thu, Jan 19, 2023 at 04:28:42PM -0800, Kees Cook wrote:
>> > On Thu, Jan 19, 2023 at 03:19:21PM -0500, Seth Jenkins wrote:
>> > > > Do you have a plan to backport this into upstream LTS kernels?
>> > >=20
>> > > As I understand, the answer is "hopefully yes" with the big
>> > > presumption that all stakeholders are on board for the change=2E Th=
ere
>> > > is *definitely* a plan to *submit* backports to the stable trees, b=
ut
>> > > ofc it will require some approvals=2E
>> >=20
>> > I've asked for at least v6=2E1=2Ex (it's a clean cherry-pick)=2E Earl=
ier
>> > kernels will need some non-trivial backporting=2E Is there anyone tha=
t
>> > would be interested in stepping up to do that?
>> >=20
>> > https://lore=2Ekernel=2Eorg/lkml/202301191532=2EAEEC765@keescook
>> >=20
>>=20
>> I've sent out a backport to 5=2E15:
>> https://lore=2Ekernel=2Eorg/stable/20230124185110=2E143857-1-ebiggers@k=
ernel=2Eorg/T/#t
>
>Also 5=2E10, which wasn't too hard after doing 5=2E15:
>https://lore=2Ekernel=2Eorg/stable/20230124193004=2E206841-1-ebiggers@ker=
nel=2Eorg/T/#t

Oh excellent! Thank you very much!

-Kees



--=20
Kees Cook
