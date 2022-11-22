Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B5633652
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKVHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiKVHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:52:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3CAB93
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:52:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r8so6439993ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDtkA0XFBmkmd6/1WuZg/n1IXM2u150R3Lg8BfO2cX8=;
        b=Sq6+H7FboDA8qvgZFS7Th3CtZJSerz1PKpDxL50JHJJqnNBJfKDP/p7W645UlLXgf2
         0Xsc5sXQGaM2hhLkMW6KKoGNutQ6FCWKeQ2O18R7TEifFFQE+UH7GBjAiV5VJhJBZE8p
         64AT1/gPld/XWPbbb2aJXTPHN9y/TLuXb4KeuopJp3eBYVMmaX3H8zxguWvfiE9h1Dpl
         p+TNweRFCg9Fu8wsXRfAC1Us6dUl6EdNlJr/yNer/FoLBrr7bi295H/VnaobbVdz/co4
         kQ4yZ5Tya9rFgFHSWV+nGbpKv6eU3Az/KXYbGm9pMunV4jQHGYq6Ug+cLgcFkFhCX+fH
         0gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDtkA0XFBmkmd6/1WuZg/n1IXM2u150R3Lg8BfO2cX8=;
        b=jWAbGsEmfAXLFy9fHhlqf8vEZ6z1T1h6gpqtlC3rtIpES6HmY1LuPSy32+DLvTvMws
         H901fOsRVb+ZMSTtdQk1qjfwgPlHd7t/oKJZlfkelA29f21CePbMVFhuBOR/MxJAyv5w
         wSDFwzQBbFRZ/y3It1CgaEBZ7vd46Zk8ptah9b/qI5lYFUTiWBNkqu2tIfbijrwZs7H1
         fx3F/BTtJAiEIQ/iCZHxorwLnJd5Si4Ni89sf7nU1jDmmOx5QIRlJQJPUCpESxxDLMn/
         dIaPePMxb0b0VkxQeHIVWul6uZBFLQMaFK7/ZeRSgeGmCVdz3QdYz6rvYfgyFUwNKZsZ
         fCCg==
X-Gm-Message-State: ANoB5pkDcXMgfBQckN996uqoWEzuOU8CguYld3goJ/nnrFuR8/aIIusz
        XXdabTHI7+qFMBG4KHwQlsggm5cURVZOB9nmDss=
X-Google-Smtp-Source: AA0mqf6TTxP4HyDGaUkASGwU7kfSeISvuE5qNQWLKDBomtrUf8Z0uGvO3a4by5NrjjUbv72Pv3GHHujNL6OCAUe1YL8=
X-Received: by 2002:a2e:9c51:0:b0:277:e8e:8d90 with SMTP id
 t17-20020a2e9c51000000b002770e8e8d90mr1761835ljj.243.1669103543233; Mon, 21
 Nov 2022 23:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com> <202211181438.7D252CDC10@keescook>
In-Reply-To: <202211181438.7D252CDC10@keescook>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 21 Nov 2022 23:52:11 -0800
Message-ID: <CANaxB-zB_DuUrKuhDFAFVZVGphoVk=2PzF20-nJwJkx-xnbSfQ@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] seccomp: add the synchronous mode for seccomp_unotify
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Andrei Vagin <avagin@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Nov 18, 2022 at 2:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 10, 2022 at 11:31:49PM -0800, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> >
> > seccomp_unotify allows more privileged processes do actions on behalf
> > of less privileged processes.
> >
> > In many cases, the workflow is fully synchronous. It means a target
> > process triggers a system call and passes controls to a supervisor
> > process that handles the system call and returns controls back to the
> > target process. In this context, "synchronous" means that only one
> > process is running and another one is waiting.
> >
> > The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
> > the current CPU. For such synchronous workflows, it makes context
> > switches a few times faster.
> >
> > Right now, each interaction takes 12=E7=9B=9C. With this patch, it take=
s about
> > 3=E7=9B=9C.
> >
> > v2: clean up the first patch and add the test.
> > v3: update commit messages and a few fixes suggested by Kees Cook.
>
> Thanks for the update! If I can get Acks from the sched folks, I think
> this looks good to take.

Peter, Ingo, could you take a look at this series?

Thanks,
Andrei
