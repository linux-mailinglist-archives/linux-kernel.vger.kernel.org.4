Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B767A0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjAXSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjAXSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:04:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5D6E8F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:04:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t18so1896738wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcv6YlYwthbf33Ogqv6JLVX/MechHhaaWBX2ABOcF1o=;
        b=f7DEZIkMC/7DBK+b63R294AHhM+QuJSZ2ePjRoNtRFJUAg/MUT1/OkhDdhsSAERR4r
         YzCK0o5Dk2ZZ9+ftaFQ6EMC+0Vg2QX7YdJNA4LcLHJClNy9tB+PRzeSTFL3qRHpy/qV/
         RJ/kPfa71io5LOL8anirbwIWGq0JF+N2hu3OIWIZCVY2nSnUhmD5gSwxz4jUMA/uirUG
         PTCZ1mPlkAA9noN+x2FRC3EREW8F3NQ4yFj/XbZIoi5TiTJFVRsgNr7Tw7WVnluy+wkP
         Lo+pBmOrKdinubVnkHNNUoL2ojByak63Y06teyx08HhJvdY/WqAHUOMnPyCNZrlkvuHT
         gjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcv6YlYwthbf33Ogqv6JLVX/MechHhaaWBX2ABOcF1o=;
        b=l3dRWvbmj/n0R4Z2+f4bhxeonhrOdGr+DrqwkxOZX8zwPcvInWU8Plxmoolcy5JhzF
         I4G5Z3IuZ9dAY9YfYdcq3OtmOsoECA4VIn1az4p9FxAjdNCOW9gauN9EAZOi3rCoOV89
         SD6e2uYHoGxhJowH6HQaT599OUni0Hs84JR73jY2MGG/BmcaJd6c0G5/hpNbAdz+N6oU
         u02FNDNc6l7E1GqwvIwKY8yZ9sfPLf/Ph0chIefwJLhngqUpfXcD2LH+4EfvswDD2XGO
         f0eUm4XseYBBLwL1TN+lnJlVQt55TP9yHfeuhsdYjn39vJxSRa5cEm/vbS+/jo25IRTR
         MV4w==
X-Gm-Message-State: AFqh2krEEIx6jK06NNLB7MXJuLO7lsbfuyMU1MlrT49lijinD3BpF5z7
        5jC/oU6bSPEn7BYyf2ied1Fg1A==
X-Google-Smtp-Source: AMrXdXuM4rUMNiLb4hrXmD8jVCbf4WgTZ7QqQC++AaS5X6Q/RQKGhcFaU75SaD/t8AllsLN1P/mCdQ==
X-Received: by 2002:adf:a147:0:b0:2be:34fb:673 with SMTP id r7-20020adfa147000000b002be34fb0673mr19234592wrr.52.1674583485645;
        Tue, 24 Jan 2023 10:04:45 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d4b85000000b00273cd321a1bsm2359492wrt.107.2023.01.24.10.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:04:44 -0800 (PST)
Date:   Tue, 24 Jan 2023 18:04:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com, liwei391@huawei.com,
        mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org
Subject: Re: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
Message-ID: <Y9AdunpawWzWKIXN@aspen.lan>
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 02:52:49PM +0530, Sumit Garg wrote:
> Hi Will, Catalin,
>
> On Mon, 19 Dec 2022 at 15:55, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > This patch-set reworks pending fixes from Wei's series [1] to make
> > single-step debugging via kgdb/kdb on arm64 work as expected. There was
> > a prior discussion on ML [2] regarding if we should keep the interrupts
> > enabled during single-stepping. So patch #1 follows suggestion from Will
> > [3] to not disable interrupts during single stepping but rather skip
> > single stepping within interrupt handler.
> >
> > [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> > [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> > [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> >
> > Changes in v5:
> > - Incorporated misc. comments from Mark.
> >
>
> Since patch #1 has already been reviewed/acked by Mark and the
> complete patchset has been tested by Doug, would it be fine for you to
> pick up this patchset? It fixes a real single stepping problem for
> kgdb on arm64.

Sorry to be quiet for so long.

Testing this patch set has proven to be a little difficult.

It certainly fixes the single step tests in the kgdbtest suite.
That's a good start.

Unfortunately when testing using qemu/KVM (hosted on NXP
2k/Solidrun Honeycomb) the patch set is resulting in instability
running the built-in self tests (specifically this one:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/kgdbts.c#n74 ). Running this test using the kgdbtest harness
results in the test failing roughly a third of the time.

The error reported is that the trap handler tried to unlock a spinlock
that isn't currently locked. To be honest I suspect this is a generic
problem that the new feature happens to tickle (this test has
historically been unreliable on x86 too... and x86 is noteworthy for
being the only other platform I test using KVM rather than pure qemu).
Of course the only way to prove that would be to find and fix the
problem in the trap handler (which probably involves rewriting it) and I
haven't managed to do that yet.

In short, I think the debugger is more useful with this patchset than
without so, although it is caveated by the above, I'd call this:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
