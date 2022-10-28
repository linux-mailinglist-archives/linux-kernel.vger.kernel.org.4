Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D955611320
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJ1Ni4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJ1NiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:38:18 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073F1DB88B;
        Fri, 28 Oct 2022 06:38:00 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id l28so3446988qtv.4;
        Fri, 28 Oct 2022 06:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWh8pd3OdimW0V1XMFr3AP+GAzmhu3IzOkunAen1PLE=;
        b=QMiXTsHYm15EkI6DwAJt5deevKG8ZuoS8PSMuPWIl4Zar+bSLdUAt6xdQv31y8YVau
         DpqToJy6+MyFwWJQdBvlh05dWpoPk32IxZwGGpnB7PD/HMDCt3clj+LjfMpul88KFUgE
         M6TldUsq5c87UxI0wCWMPKMtymixMgBsw6u4s/njiu0e1GgqfBCmzHVSgtuiUuzxXSMG
         ZAH6DRh1tC3BRtRLkcCR5z5jZeT1kDXmTF2+Ewk01U3x8mmKMXZPXo3q/KwSfSqGXbW3
         hqMwW2hes4bLxMLmRJ4aWBfsXSexplLloXJEaQOj/Lhuv/0KB4vr8WZY+ndoHCqiCssn
         H0ZQ==
X-Gm-Message-State: ACrzQf1bAcj6vM4JLd809LoUTqV0aKINp+sKyptppCiIvqxetEAQagLS
        63V/8ERf8cqJgLKqdst4oYI8G4stI0fM8GfRWkQ=
X-Google-Smtp-Source: AMsMyM7NPhUyQmUgvWcje65omOtwg4jxAApag4GzvyM3n67acb1tlKtlyROefyouc3bKBoe0EXuvRZ+6hdc/y5zK67Q=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr45882092qtb.147.1666964279219; Fri, 28
 Oct 2022 06:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com> <f799f67c-c9e9-c702-8457-db8da78500c9@arm.com>
In-Reply-To: <f799f67c-c9e9-c702-8457-db8da78500c9@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 15:37:48 +0200
Message-ID: <CAJZ5v0iBqnD3bCVxk0xcO1gtgrzoZX3YPjvo9Cckaz6D1MbJCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 27, 2022 at 10:04 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 10/13/22 12:12, Kajetan Puchalski wrote:
> > On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
> >> On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
> >> <kajetan.puchalski@arm.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> At the moment, all the available idle governors operate mainly based on their own past performance
> >>
> >> Not true, at least for the menu and teo governors that use the
> >> information on the distribution of CPU wakeups that is available to
> >> them and try to predict the next idle duration with the help of it.
> >> This has a little to do with their performance.
> >
> > You're right of course, I should have written "their own past
> > correctness" as that's what I was referring to. I just meant that for
> > instance with TEO the initial timer-based choice is only adjusted using
> > the governor's own metrics and not any information from anywhere else in
> > the system.
> >
>
> [snip]
>
> Would it be possible to consider a new small and simple idle governor
> which is better suited for those other workloads and platforms?
> Kajetan has such one and can send to the LKML, so you could have a look.
>
> I have sent some detailed explanation about this to Doug in this
> thread (don't want to duplicate it).
>
> It looks like it would be hard to meet both worlds' requirements.

It may or may not be the case.  Let's first explore the original idea
of improving "teo" a bit more.

As I said in another message in this thread, there are clear cases in
which the new governor is likely to underperform, because it only
takes 2 sources of information into account (the next timer event and
CPU utilization).  If some more information is to be taken into
account without adding too much overhead, "teo" is the simplest thing
that I could imagine (but perhaps my imagination is limited).
