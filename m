Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FBF666E38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjALJ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbjALJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:28:50 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5D646E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:23:01 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id v127so14045983vsb.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=efmws3aCVsefaN/g574EcJacERdCtGnCzw1lKaWrtJ8=;
        b=GdTPUKmKD1zp1f2/sb8ZHPcnrhm/yHA25oG5+eQzBHHL8bHPUfVe7KzzRG6j3j4Wky
         DjyP0C4PalipMvKfJNnG8T8cpSycdBBHdzfBSDHe6rtwOgE+kyjj7Jxcj2j2g0X41iU0
         vumZ7UuFLi/kX+7CxZyaadj/72xJOXk3q5i9DYsUYwkM89sPk6CjXGKfNYScuJm1HE0T
         rfHdnMYj1B6miGD/M3uyRdN3nlag9Xh3qlXPP9lWENfpt/SwEQcs5OuKC6+v2wRF66O+
         E9eo04TgR3FDFc65zzRuYmJkhC17Hf84a8bypT5Jn9LzMcQ2VINwer8LVwwB25+HOdoJ
         I2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efmws3aCVsefaN/g574EcJacERdCtGnCzw1lKaWrtJ8=;
        b=pzulmBAXz3v75Gii3m270IPO66gwBkisaVJW19UHkfn09skOkzpggLqvJlFzbv+URD
         0AF0HLBE6CVA9D75abTYG+KZ8wfVd3LDC2tVEfKHWnpLKMlJNaMjiLMUq7G3Yk7Q+nNV
         Z4pVmW31pM7v9Cl2nEdtHlFLXmFYP5Y7ykucUmqJCojlzBYzq+vEqDEQm4xuqt5WrnXA
         rfOK2jlqWPCr5VVao5/7/YVHcN4xezlvHU7IrUbltmphcJoOqAaRAFzDoAIIWETjN9d7
         4as5ZvgNZEZMuS/HaBKsc8NzzeTd+/5W885O0WOpOH14e0Jlgq+YOIXXouoq8Ouw0T1d
         rTVA==
X-Gm-Message-State: AFqh2kr0glz70X4zs7kEEXBTUcgcxsOtpXQ9KgqAyJVPOhIgF/nerNer
        a0HXH1ZB2w9N+DdLITjtpMGp2ElJ2+YyWViHySIwIQZ1trG6pg==
X-Google-Smtp-Source: AMrXdXv216uurPD4Hcsh/hCF9XN+Gp4H4zV+YAa+KQIn/WZ2I1E73IEgzTfF5Euyc+V6l/e8U+yGqGBqwYubsIc/wLw=
X-Received: by 2002:a67:2204:0:b0:3b5:2762:568b with SMTP id
 i4-20020a672204000000b003b52762568bmr10338430vsi.62.1673515380482; Thu, 12
 Jan 2023 01:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
In-Reply-To: <20221219102452.2860088-1-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 12 Jan 2023 14:52:49 +0530
Message-ID: <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Catalin,

On Mon, 19 Dec 2022 at 15:55, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> This patch-set reworks pending fixes from Wei's series [1] to make
> single-step debugging via kgdb/kdb on arm64 work as expected. There was
> a prior discussion on ML [2] regarding if we should keep the interrupts
> enabled during single-stepping. So patch #1 follows suggestion from Will
> [3] to not disable interrupts during single stepping but rather skip
> single stepping within interrupt handler.
>
> [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
>
> Changes in v5:
> - Incorporated misc. comments from Mark.
>

Since patch #1 has already been reviewed/acked by Mark and the
complete patchset has been tested by Doug, would it be fine for you to
pick up this patchset? It fixes a real single stepping problem for
kgdb on arm64.

-Sumit

> Changes in v4:
> - Rebased to the tip of mainline.
> - Picked up Doug's Tested-by tag.
>
> Changes in v3:
> - Reword commit descriptions as per Daniel's suggestions.
>
> Changes in v2:
> - Replace patch #1 to rather follow Will's suggestion.
>
> Sumit Garg (2):
>   arm64: entry: Skip single stepping into interrupt handlers
>   arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
>
>  arch/arm64/include/asm/debug-monitors.h |  1 +
>  arch/arm64/kernel/debug-monitors.c      |  5 +++++
>  arch/arm64/kernel/entry-common.c        | 22 ++++++++++++++++++++--
>  arch/arm64/kernel/kgdb.c                |  2 ++
>  4 files changed, 28 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
