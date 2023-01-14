Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3C66A814
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjANBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjANBRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:17:09 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28337EC9B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:17:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id t15so24396836ybq.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnwxzAKo/vM+Pp92W06o/VIj2Y2nM48UBMSrN4SaRyg=;
        b=Sx3ClhseLPYV9qwlsLAmRsaXSactpShAaZrLr3LwyzXogroBiU8hB/A69+IKlswxaF
         DRKfxQ5Pve0y4bowgDsraVLlMWl8WjQICubEHadXAKYcTlC6BVkBUpXz7Xydrbhl/e5z
         xNXnaaVSWe5M6nFUUavNSaHpvrzIItb8YinIGV5GeWQRPw3JMTWGKI45xiKiqiJUUsxk
         3mcxs+TENVo4QVmWbwAZu+PGEslpIM/WFUW+PqGuPXXsZL3U3VDIynDicaWkNnRp9RDc
         iQ7BudZAkEF/60p//oFYgAazNkgW0yVwyE1QAbFY6UxscfL86hGszUurp32Iealw7boh
         rLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnwxzAKo/vM+Pp92W06o/VIj2Y2nM48UBMSrN4SaRyg=;
        b=X/czNcLbmxuEl3dbACIBKI/0zy3dTxSBEqsuheKs53hdW2WeYjBZtTFhYMFiNpXN72
         Nd9Zm/yTmXARkQEE8KfidhiVIZPGUgdAXKcRrecvLH71UZbFDqcHOEXrLbhhW5nMw2ja
         IQcqEz47ZM7FQuDYkeeAko19NNFg41iTxwme9oMnxS1Vs/8ciBjkpg/ZZcKCpJxCH34i
         leQuFj6+Lr7GKIm4IXpKbmTxMs/qmQsm+hrqFktETkPrFebBLBszR+eQTGVoHmW/D6gr
         cWNhRtsm4fVwY7pT2vZeBZBKG7NdpH6QWI1Pnsj6LWpTuBR8F5gTKfqib7vFCSJhvi5W
         ZjLw==
X-Gm-Message-State: AFqh2komgFXPZGFlATIr2AlDw0SMAF4g0tTShEa5/VGgAVX6J5YiniYK
        INNG64bXuO1lEARcSPzH7aP/C+0UxWA/VDp2bZA=
X-Google-Smtp-Source: AMrXdXv2GeOKwegsPccASBlbivxFuhAEdxjyUT27JAxT86Gf97+gDG6lodbpG3WGoTVE56ZqXb/jZ9xMVj46mpf39jg=
X-Received: by 2002:a05:6902:110f:b0:7d2:ba22:4b89 with SMTP id
 o15-20020a056902110f00b007d2ba224b89mr234976ybu.478.1673659027714; Fri, 13
 Jan 2023 17:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com> <20230110213010.2683185-5-avagin@google.com>
 <Y8AgiZqYSjozXbhP@tycho.pizza>
In-Reply-To: <Y8AgiZqYSjozXbhP@tycho.pizza>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Fri, 13 Jan 2023 17:16:56 -0800
Message-ID: <CANaxB-z_Dn4qpDim3Ec29fXpumOCaS0cO4ByatrPWbZYvuopyA@mail.gmail.com>
Subject: Re: [PATCH 4/5] seccomp: add the synchronous mode for seccomp_unotify
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 7:00 AM Tycho Andersen <tycho@tycho.pizza> wrote:
>
> On Tue, Jan 10, 2023 at 01:30:09PM -0800, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> >
> > seccomp_unotify allows more privileged processes do actions on behalf
> > of less privileged processes.
> >
> > In many cases, the workflow is fully synchronous. It means a target
> > process triggers a system call and passes controls to a supervisor
> > process that handles the system call and returns controls to the target
> > process. In this context, "synchronous" means that only one process is
> > running and another one is waiting.
> >
> > There is the WF_CURRENT_CPU flag that is used to advise the scheduler t=
o
> > move the wakee to the current CPU. For such synchronous workflows, it
> > makes context switches a few times faster.
> >
> > Right now, each interaction takes 12=E7=9B=9C. With this patch, it take=
s about
> > 3=E7=9B=9C.
> >
> > This change introduces the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> > it used to enable the sync mode.
>
> What about just not having a flag and using the new primitives all the
> time? Is there any reason not to?

I was thinking about that but then I decided that it can have a
negative impact in cases
when workflows are not synchronous. This can happen when one process wakes =
up
another one and continues running on cpu. With the flag, both
processes are scheduled
on the same cpu. Without the flag, they can be scheduled on different
cpu-s and run
concurrently.

In the seccomp unotify, switches from tracee to supervisor are always
synchronous.
Switches into the opposite direction can be either type.

I think it is better to let users decide what type is more suitable
for their workloads.

Thanks,
Andrei
