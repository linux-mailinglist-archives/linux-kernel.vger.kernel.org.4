Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2366A557
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjAMVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAMVv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:51:27 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334C8479FE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:51:26 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4bf16baa865so302513767b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj2zTXarbWhvc5XXJu+fEcql+MeJmws87SUOUrR/jgM=;
        b=fG4ngEr130nl6aUC0+uAySp9IxGRRyIV4BQLUqMSDmxdl5x9qBRlwTavadEVVCtQja
         lVpG9p4fBPVNBBVJu63WcOGitkyGhkgihODV9GDm5eazhOeREKGwDdKlTuC3wFzfgZta
         FzlR+9vpxc6+ET5S9ynXzjjgjigsNEFcy2gjavi+w75vRHhGV67Qj139g+73zHIDQvL1
         jjDzLYWu36j9KmDOC02EucXwvdV4G80FDRCWZrYtV3ke4aErPNwrmGgDooocna3+JFBL
         IxDPLLF4xFUffaIQ/vpnr45MZJO7bhGkcTQbgXG41+YFqjhxKmMQvps885EumTgjg4RU
         wJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aj2zTXarbWhvc5XXJu+fEcql+MeJmws87SUOUrR/jgM=;
        b=4SAA2HX3xcrAHnL8s75Qc6v9kZG7VdxWwMYShVls9I3MSDoggPsWU+R1Fl4wSZWNoy
         wnv1AJttBWE9DL2V9S6vzEoatABFkJv68AFaM7LeCDRgwXTwq01s5rywamnSzsnXetdQ
         MJY9ZPNavIHwPCMLw9KTrQp7tyK7b3pmQMp8c57sw2G4sQJQxxXDoa8dTXwpPCY7D6AB
         wBMKugmNxCZrodbU5PZqHYJfplat8FT7VYdDnKhaojadImyfJzuEG7/Rbjw0d0QTQIRG
         Z/aTU3kxWtYFLYpc7HRniRbS9fINh0Nyln39l0zTocoBlPXxgtmmowyeDeEKJrTyDTc3
         YlBQ==
X-Gm-Message-State: AFqh2krJ2IU3U/nMhhqHUANzyPm+2p1fy5sHpwA6cD1ehy8NEr0dkUE7
        8QAESwIpBDVomnWDH+yez81W93TW5X2vAOEMhiI=
X-Google-Smtp-Source: AMrXdXuouL8p/djpcjplnswXbq5R1CLkMUkZALLDsNvNphzusnzuxlcLfGMQyPT89UZVN4gVexs7XbV6x8DyLl54iu4=
X-Received: by 2002:a0d:f846:0:b0:3f6:489a:a06f with SMTP id
 i67-20020a0df846000000b003f6489aa06fmr1143783ywf.470.1673646685187; Fri, 13
 Jan 2023 13:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com> <20230110213010.2683185-2-avagin@google.com>
 <Y8AgC99AUeMjFWKt@tycho.pizza>
In-Reply-To: <Y8AgC99AUeMjFWKt@tycho.pizza>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 13 Jan 2023 13:51:14 -0800
Message-ID: <CANaxB-wVizq9RbSmidH6iSU2ymbHcpZc0k7AaA727qk-q78c0A@mail.gmail.com>
Subject: Re: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 6:58 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Tue, Jan 10, 2023 at 01:30:06PM -0800, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> >
> > The main reason is to use new wake_up helpers that will be added in the
> > following patches. But here are a few other reasons:
> >
> > * if we use two different ways, we always need to call them both. This
> >   patch fixes seccomp_notify_recv where we forgot to call wake_up_poll
> >   in the error path.
>
> [snip]
>
> > @@ -1515,7 +1546,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
> >                       if (should_sleep_killable(filter, knotif))
> >                               complete(&knotif->ready);
> >                       knotif->state = SECCOMP_NOTIFY_INIT;
> > -                     up(&filter->notif->request);
> > +                     atomic_add(1, &filter->notif->requests);
> > +                     wake_up_poll(&filter->wqh, EPOLLIN | EPOLLRDNORM);
> >               }
> >               mutex_unlock(&filter->notify_lock);
> >       }
>
> I wonder if this shouldn't be a separate patch that you can send now
> independent of this series?

You are right. It is a bug fix and I can send it in a separate patch.
I didn't expect it would take so long to merge the whole set.

Thanks,
Andrei
