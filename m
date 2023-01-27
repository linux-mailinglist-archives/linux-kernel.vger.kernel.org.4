Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B81367DD55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjA0GEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjA0GEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:04:51 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57348638
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:04:48 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id t190so1967096vkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AJeax0vdCIY8QtFNuBBZaJ4qQclhPg5wqKkqhwxvPA=;
        b=TycDQ9m30oieb0d2SF22E5q+oqVC55WxhzMu9/TmgPT1AoRkmlCeD2aarWqzyhuuim
         EsoTD5CyJPXjkJBqGSJbCGDnOO3FG7jbE5fc2OK33iXQeZV2FvwnFhJR8b7jko7uLeP+
         VKLZw9aw79jDt9XAKwZ/SAn90SK0XmE4arkHOFSIPyCZrtz/WINGEfrun3aIBpGfJt+5
         xFzOEsGsHpppqfG8NOZq+JQ8WFbkTgfez3xxc4afPZm4K86a5fDLY47HEQd5xLJ8zYAk
         Cilcy2x87NQyp8ymTVARR4LFowPFYm0iUDxZ0zdCiTyzLeHSZ8QthJcywP8TAwRHPEG8
         7qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AJeax0vdCIY8QtFNuBBZaJ4qQclhPg5wqKkqhwxvPA=;
        b=A3VIEB0tMiynLiMPglNuktZsItjJDF8BDURbLrorALJWHbUvl4PVMCmSlmz03BPYBX
         hqZIB/7r8J8iGKGXd4wTDmi2ASURG0gbODZKxRx13GF5K9+Gwj+Z56VV6ARKvHAOPQZ7
         SutIf/Imk7kwvXPGXHMcdVaUXgCrquS9FhVVnfdW0v3EFbxnBQEDXKEC61bZBAziJ3wH
         xjo3IQEd6VC32R40AiPVzJe5fUf1IXCurotMkNGDR85WMcsPMnwtSAzqu/cwU8uT4Fyh
         n3U/TgbNv9XwXPX0lXR5Az740/hQ2D9n2ZeCVhV6KnG4BtiewpLwNVJNnPVARC49rMYL
         Tg0w==
X-Gm-Message-State: AO0yUKWVGwrWcjYwMGW1yKchLU+WSYTc59jLGdeFSMZDQdRj2B5tzgEI
        AM45iShDEqDlCsGdOrLgj+O2d93QOI7CW8Fkhio8GQ==
X-Google-Smtp-Source: AK7set+ePzVtNcHDOh5WmI6uqiw6dRWj9iLctjH37WbUnba7ePkSi+xQgApVY+l4GgtOVlaiowiDFL735sqBSRvciOk=
X-Received: by 2002:a05:6122:78d:b0:3e8:5fcc:54d0 with SMTP id
 k13-20020a056122078d00b003e85fcc54d0mr496672vkr.4.1674799487789; Thu, 26 Jan
 2023 22:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com> <Y9AdunpawWzWKIXN@aspen.lan>
In-Reply-To: <Y9AdunpawWzWKIXN@aspen.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Jan 2023 11:34:36 +0530
Message-ID: <CAFA6WYMVosk_-P4hUonMtzmC+BXHzQkyHvkq47xvWXrm6CYtWg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com, liwei391@huawei.com,
        mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 at 23:34, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jan 12, 2023 at 02:52:49PM +0530, Sumit Garg wrote:
> > Hi Will, Catalin,
> >
> > On Mon, 19 Dec 2022 at 15:55, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > This patch-set reworks pending fixes from Wei's series [1] to make
> > > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > > a prior discussion on ML [2] regarding if we should keep the interrupts
> > > enabled during single-stepping. So patch #1 follows suggestion from Will
> > > [3] to not disable interrupts during single stepping but rather skip
> > > single stepping within interrupt handler.
> > >
> > > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> > > [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> > >
> > > Changes in v5:
> > > - Incorporated misc. comments from Mark.
> > >
> >
> > Since patch #1 has already been reviewed/acked by Mark and the
> > complete patchset has been tested by Doug, would it be fine for you to
> > pick up this patchset? It fixes a real single stepping problem for
> > kgdb on arm64.
>
> Sorry to be quiet for so long.
>
> Testing this patch set has proven to be a little difficult.
>
> It certainly fixes the single step tests in the kgdbtest suite.
> That's a good start.
>
> Unfortunately when testing using qemu/KVM (hosted on NXP
> 2k/Solidrun Honeycomb) the patch set is resulting in instability
> running the built-in self tests (specifically this one:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/kgdbts.c#n74 ). Running this test using the kgdbtest harness
> results in the test failing roughly a third of the time.
>
> The error reported is that the trap handler tried to unlock a spinlock
> that isn't currently locked. To be honest I suspect this is a generic
> problem that the new feature happens to tickle (this test has
> historically been unreliable on x86 too... and x86 is noteworthy for
> being the only other platform I test using KVM rather than pure qemu).
> Of course the only way to prove that would be to find and fix the
> problem in the trap handler (which probably involves rewriting it) and I
> haven't managed to do that yet.
>
> In short, I think the debugger is more useful with this patchset than
> without so, although it is caveated by the above, I'd call this:
>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
>

Thanks Daniel for the in-depth testing.

-Sumit

>
> Daniel.
