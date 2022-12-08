Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3C646EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHLji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:39:37 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B00560376;
        Thu,  8 Dec 2022 03:39:36 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id x28so755493qtv.13;
        Thu, 08 Dec 2022 03:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIpxnDoZjAkqZAv3rHV7QD8ppXd8SdopcMLMjenqit0=;
        b=40pvNxr3nmw3qv7aYeiGQREB736UNjLr2c8TEPA/KuoxciiUOGGEuzyuf+8uvV2BQq
         aTxcAmB7PZWxAqdtA3ZT1t8ROKVPLHtJBX3Vu8RjalAOfh3ooVSag9lpGfmaKncZjmSA
         bTKWzEDkavUbibT1uLS4zzbgI7IX8a0SZoxWiXcWtReeDgTA3d7thK1Vu712OuT3lqQI
         wltoSceZ2abeE8J08a5MB0geEdIq/RpuzVbnksq1jgUJnks/kEUcMwAhIewVZRu16U8d
         io5/2juB7X1Zbd/cnPDRfWZMjHvV97lOKo7ZBCkP/EWFdnX/44fyGC8XvdO5yA8jH90l
         G62Q==
X-Gm-Message-State: ANoB5pnV1Te4YAK8D8rgd6hX7hifkFgHXhjHqDus9pxhknyfum1Z0HFg
        cP0L8YL64IivBob8tlsohHsqmZMR9mhsTCq26W4=
X-Google-Smtp-Source: AA0mqf6JvVAxvPNkBGTdWV1kY5YcZGSoZeqrVd8m813gmZ5ELk6sSzCwB0YZhK6JjWaievgdsbNKd+nQBaJYdlulvg0=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr30379387qte.411.1670499575434; Thu, 08
 Dec 2022 03:39:35 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
 <9e19c594bcf144fbb433fb4cfee54e08@baidu.com>
In-Reply-To: <9e19c594bcf144fbb433fb4cfee54e08@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:39:24 +0100
Message-ID: <CAJZ5v0jofKbdRbKzLSEMkjQjP1GTcbt7OYqO=0ZYvpt_HwTQTg@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 2:48 AM Li,Rongqing <lirongqing@baidu.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Wednesday, December 7, 2022 10:38 PM
> > To: Li,Rongqing <lirongqing@baidu.com>
> > Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> > dave.hansen@linux.intel.com; x86@kernel.org; rafael@kernel.org;
> > daniel.lezcano@linaro.org; peterz@infradead.org; akpm@linux-foundation.org;
> > tony.luck@intel.com; jpoimboe@kernel.org; linux-kernel@vger.kernel.org;
> > linux-pm@vger.kernel.org
> > Subject: Re: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with
> > arch_cpu_idle
> >
> > On Wed, Dec 7, 2022 at 1:42 PM <lirongqing@baidu.com> wrote:
> > >
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > When KVM guest has MWAIT and mwait_idle is used as default idle
> > > function, but once cpuidle-haltpoll is loaded, default_idle in
> > > default_enter_idle is used, which is using HLT, and cause a
> > > performance regression. As the commit aebef63cf7ff ("x86: Remove
> > > vendor checks from prefer_mwait_c1_over_halt") explains that mwait is
> > > preferred
> > >
> > > so replace default_idle with arch_cpu_idle which can using MWAIT
> > > optimization.
> > >
> > > latency of sockperf ping-pong localhost test is reduced by more 20%
> > > unixbench has 5% performance improvements for single core
> > >
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  arch/x86/kernel/process.c          | 1 +
> > >  drivers/cpuidle/cpuidle-haltpoll.c | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > index c21b734..303afad 100644
> > > --- a/arch/x86/kernel/process.c
> > > +++ b/arch/x86/kernel/process.c
> > > @@ -721,6 +721,7 @@ void arch_cpu_idle(void)  {
> > >         x86_idle();
> > >  }
> > > +EXPORT_SYMBOL(arch_cpu_idle);
> >
> > Why do you need this export at all?
> >
>
> When cpuidle-haltpoll is built as module,

But it isn't now.

> if arch_cpu_idle is not export, cpuidle-haltpoll will complain "arch_cpu_idle" undefined

So no, this won't happen.
