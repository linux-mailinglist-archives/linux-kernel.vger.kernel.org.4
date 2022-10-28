Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E19611583
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ1PIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ1PIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:08:42 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84528208832;
        Fri, 28 Oct 2022 08:08:38 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id r19so3609449qtx.6;
        Fri, 28 Oct 2022 08:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYii+0fW0gEKCWGN+D7BxbLvb2ZrmudcEIDGIcfsEBs=;
        b=lxdkkRzhhdN5w6Q12sb9uZzvWAZxG3MxGZo9iXqP6QUTA7/7E/xckczlwQSMlRmZ2n
         2QJM+9i8uD5E2rfA/J7rJPA8YzD+PGZD4w5laHWbP5S8+bcyFD/iLzNUxHqEyQa8Tk8W
         Cmv/9kvlEbxW1mSC7BssqkOMdsdej+VXUXi7PGRgO7+fnjCgGrjvtxdttJknzK+7weN8
         FdlqI3KwXlMZOu/kOI0/a+jjN57eSDOiazFCA01L4aHsqM6mXYeK3Ys8DciFA3MRjNm0
         USuyJudj/qmBVucuFIEhmM+HfeTVgjqR1lVeX6z9CIj7bsAqwlAHmhcPPTi6Bmv7PnYi
         8tdw==
X-Gm-Message-State: ACrzQf1NjBJi41eNwpRBtkljnzsekZBy3ywsT+EN84RXJqxAeW4tigRU
        irE/tG5vx4EnPH5ILx3VqA2GrULDYffvmUdYy3p0r4yE
X-Google-Smtp-Source: AMsMyM7oYD83QNmGbnNTLaNVUXqpU/34cwf3LMweStOy4pBRdXXttiV/RN14ltJFbmmMQ5L05ce61fr71s7gmW2vCbA=
X-Received: by 2002:a05:622a:44d:b0:39c:f7a4:5ee0 with SMTP id
 o13-20020a05622a044d00b0039cf7a45ee0mr45218839qtx.48.1666969717630; Fri, 28
 Oct 2022 08:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com> <CAJZ5v0gvAtpzdQo0Tj13ZGFcop8fdNht7e_Nc_UNYCgbU1zZLA@mail.gmail.com>
 <Y1vum4BECMf2BXQW@e126311.manchester.arm.com> <CAJZ5v0hZbw18BuG64046DiG2_dWOFk9gcg0bD+X3rQknwp0xsA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hZbw18BuG64046DiG2_dWOFk9gcg0bD+X3rQknwp0xsA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 17:08:26 +0200
Message-ID: <CAJZ5v0iGM84i72m2eJkF6k8PkFqHw4gTDQhYV-K9D_VPWNKW7A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 28, 2022 at 5:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 28, 2022 at 5:01 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > On Fri, Oct 28, 2022 at 03:12:43PM +0200, Rafael J. Wysocki wrote:
> >
> > > > The result being that this util-aware TEO variant while using much less
> > > > C1 and decreasing the percentage of too deep sleeps from ~24% to ~3% in
> > > > PCMark Web Browsing also uses almost 2% less power. Clearly the power is
> > > > being wasted on not hitting C1 residency over and over.
> > >
> > > Hmm.  The PCMark Web Browsing table in your cover letter doesn't indicate that.
> > >
> > > The "gmean power usage" there for "teo + util-aware" is 205, whereas
> > > for "teo" alone it is 187.8.  This is still arguably balanced by the
> > > latency difference (~100 us vs ~185 us, respectively), but this looks
> > > like trading energy for performance.
> >
> > In this case yes, I meant 2% less compared to menu but you're right of
> > course.
> >
> > [...]
> >
> > > Definitely it should not be changed if the previous state is a polling
> > > one which can be checked right away.  That would take care of the
> > > "Intel case" automatically.
> >
> > Makes sense, I already used the polling flag to implement this in this other
> > governor I mentioned.
> >
> > >
> > > > Should make it much less intense for Intel systems.
> > >
> > > So I think that this adjustment only makes sense if the current
> > > candidate state is state 1 and state 0 is not polling.  In the other
> > > cases the cost of missing an opportunity to save energy would be too
> > > high for the observed performance gain.
> >
> > Interesting, but only applying it to C1 and only when C0 isn't polling would
> > make it effectively not do anything on Intel systems, right?
>
> Indeed.
>
> > From what I've seen on Doug's plots even C1 is hardly ever used on his platform, most
> > sleeps end up in the deepest possible state.
>
> That depends a lot on the workload.  There are workloads in which C1
> is mostly used and the deeper idle states aren't.
>
> > Checking for the polling flag is a good idea regardless so I can send a
> > v3 with that. If you'd like me to also restrict the entire mechanism to
> > only working on C1 as you suggested then I'm okay with including that in
> > the v3 as well. What do you think?
>
> It would be good to do that and see if there are any significant
> differences in the results.

BTW, you may as well drop the extra #ifdeffery from the v3, I don't
think that it is particularly useful.
