Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560D2645891
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLGLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLGLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:05:00 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8055F60
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:04:59 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3c090251d59so182357067b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A004RH27yVsShX10es4mKOUHHS7leP1ZS2svQPkqdf8=;
        b=WtDZ1Fmugh+sqi/kBpK9nicrxzRoIAcrmN8xUI2nug+/Cob7mg7qDiyjy2PFsPHqPV
         8PdHUMj5lgDTxEOVbeTk1qDy6mus992ZzYnhxNa7AojeL8/334fio0M4RrPAVSipd5BY
         s+T3vQR6+cptuVbFJmzQkAloZy4ydjHYus2Mws64NS3pfv1Wlc9xet+OI4EKwKODNF2m
         bSOvdVDnV+AB7WyjpxOT2y4vdLFnpmaM31deQq2J1JRFhf5czEg1Z6uEqeyiuHtPxpp/
         MrEJwoueIwPsPVo4Ywk1KQmLWHEq5x3DtLN27htfydBg+HD9AOtMkjpSy8ozMqqhUatM
         XL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A004RH27yVsShX10es4mKOUHHS7leP1ZS2svQPkqdf8=;
        b=gSVVUYMG9ToWPHE0cRJNLTd/AaMZchYiGSBnGX/WeF4/zgSmMpuzVgmy2GyELliXjS
         p3jmP6jHw0tL7N3Pxt8v+YPx6l6KZzdb7PlmMbau6y5huY4weuAM9PpeuI2BCnFtUcx0
         CXD+Pc6liC8tyQjFuFl2jty4NfTfU+M8GuOSNYh1r4MYi3JL6Ev7xt6dEAGH83mnHQFn
         PE2TNcABzkddhHw2QTXnotcxvreqT2WNGAO5yviRB+dttXvFBeuVYx3kgzzNS80u+m4O
         jsBSfJaOXhYiMe6VC3G4LcxJXd9qAtzbffZetHCUZG12RZvpijjuAz3hN8JEDyYXLtFU
         MYdg==
X-Gm-Message-State: ANoB5pl6pA44Zm7PffXlEaPjBU48IBP+g2SiaC7AL4rYYcV9DzC8ZvtK
        90VAtCma4aT6MbM2lKgxdZcrBa8gP1YpJN7Xl+VBRA==
X-Google-Smtp-Source: AA0mqf71A1GvCGQtwT5htT6M5zkxpKUUh5gmVPX3Y+zw+1YIoEoqvEkYf2aVIBz6zC8wEIQF06liKqpFfsfuU+FgCZw=
X-Received: by 2002:a0d:ebc6:0:b0:3df:ba1d:f51a with SMTP id
 u189-20020a0debc6000000b003dfba1df51amr22237443ywe.64.1670411098444; Wed, 07
 Dec 2022 03:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20221129111055.953833-1-peternewman@google.com>
 <20221129111055.953833-3-peternewman@google.com> <60e7ba72-edff-9bf7-0541-403f25b5bc51@intel.com>
In-Reply-To: <60e7ba72-edff-9bf7-0541-403f25b5bc51@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 7 Dec 2022 12:04:47 +0100
Message-ID: <CALPaoCgZ3XDLGWs2PdRdYMY7uBmV+9uRuahJyt7rwDO96dN9KA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/resctrl: IPI all online CPUs for group updates
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, bp@alien8.de, derkling@google.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Tue, Dec 6, 2022 at 7:57 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 11/29/2022 3:10 AM, Peter Newman wrote:
> > Removing a CTRL_MON or MON group directory moves all tasks to the parent
> > group. The rmdir implementation therefore interrupts any running
> > tasks which were in the deleted group to update their CLOSID/RMID to
> > those of the parent.
> >
> > The rmdir operation iterates over all tasks in the deleted group while
> > read-locking the tasklist_lock to ensure that no newly-created child
> > tasks remain in the deleted group.
>
> The above describes the current behavior. This is great context. What
> follows in the changelog is a description of different fixes. This is
> unexpected because there is no description of a problem with the current
> behavior.
>
> Could you please describe the problem with the current implementation? Next
> you could state the two possible solutions and then I think the reader would
> be ready to parse what is written below.

Ok

> > Calling task_call_func() to perform
> > the updates on every task in the deleted group, similar to the recent
> > fix in __rdtgroup_move_task(), would result in a much longer
> > tasklist_lock critical section.
>
>
> I so still think it would help to state that this additional locking
> does not help to provide precise CPU mask. Especially since
> the next paragraph may be interpreted that a precise CPU mask
> is lost by giving up the additional locking.

Yes, that's a very good point, and I'm afraid I've already made you
reiterate it once before. I will make sure to work it into the next
revision.

-Peter
