Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3666FD354
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjEJAnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEJAm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:42:58 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A45273E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:42:57 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-77d049b9040so33576179241.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 17:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683679377; x=1686271377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfRga80IFuib6OMLZt4mIA+A4rhSmfiaklSGZGPK0eo=;
        b=j6jM2RsRggsIUWWDWav+T+GSfgONKJ2cfTHzigFEsD4nVoLDhSJyO9nWLq6z3tiB29
         5k5zHxnYxi6++Uc+cWX5diuWzdn2GNsZeCbh7UPeDubpSNqEC5PTPNpCd1Fz5NgYojeZ
         gs2ymbbyClB5Uy6pX5GVIHy4nbI6Ed1utcBUjmQc8ZBe2QNpKb9tXEnTf4YAeUdrpQWE
         RodTHexICk/ZRV+9hdHUz1iV6CaJJmBoQLfNJqi+vxfJ+LuhjiEzVDQguXY26VkclIUo
         5qwoJWb1dmRMHgGK/ndxJgqspoFGj2iUQSnXnKRFKfK+Bb9zgJ79EaB1MYQ1TMqgWF3P
         JM8w==
X-Gm-Message-State: AC+VfDxwC+5wgUXKl2zXAxkAeddy4iqCw0VPzcfHMS2Ln5/PUDQI0QpR
        0cdqqh0udMoT26SMr2mYeLWdIEufa0TDotz5f94=
X-Google-Smtp-Source: ACHHUZ5M12ot5FKEaJ5k49lbu1dAcp1028MakEWQcpTLZLKGbIECvQUnFJA2gmhzEzB2i/34d/bIGY6+uxvGP8l4C7Y=
X-Received: by 2002:a05:6122:dd:b0:440:4c82:6508 with SMTP id
 h29-20020a05612200dd00b004404c826508mr4556264vkc.3.1683679376495; Tue, 09 May
 2023 17:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230425181827.219128101@linutronix.de> <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen> <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx>
 <878rdy32ri.ffs@tglx> <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx>
In-Reply-To: <875y911xeg.ffs@tglx>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Tue, 9 May 2023 17:42:43 -0700
Message-ID: <CANaxB-zyaS2OZsdmAGRjz8ZQxGUU8b_cEAgtXNmUW+hyCLY9GQ@mail.gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit is valid
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 5:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, May 09 2023 at 11:30, Thomas Gleixner wrote:
> > On Mon, May 08 2023 at 23:57, Thomas Gleixner wrote:
> >> More thoughts on this. If we go there and accept the extra page of
> >> memory then we can just go all the way and make the xarray per process,
> >> actually per signal.
> >
> > Thinking more about it. The current scheme how timer ID allocation works
> > is really interesting vs. CRIU.
> >
> > Assume a process creates/deletes timers frequently. It's not hard to
> > move the next ID close to INT_MAX, i.e. 2G
> >
> > Now checkpoint that thing and restore it which means to do the
> > create/delete dance to move next ID up to the last one-1. Will only take
> > a couple of hours....
>
> I'm cursing myself for overlooking this back then when the CRIU changes
> to the timer ID management were made. Why?
>
>    Because that created an ABI which CRIU relies on.
>
> The proper solution for this would be to make it possible to create a
> timer with a given ID. That's not rocket science, but we need buy in
> from the CRIU folks. Otherwise we are up the regression creek without a
> paddle.

Let's go with the proper solution. I will prepare CRIU changes when
kernel patches are ready.

Thanks,
Andrei
