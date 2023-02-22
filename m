Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3169EF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBVHHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBVHHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:07:10 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112CD36681
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:07:09 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id f20so2247263uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677049628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swo/AVRGoOMfKCuHRg1QypMC/toJqloCtmfqbfFX1yE=;
        b=UR3daz9+LDL6M2fVY4jjBENnMayiPhWT6h6ZsS+Zga6e/L2rj118PB4PSnb6i45Z1o
         A0N8NV0y9VHkoAIdLjWj3wiDouo+Ulw/gQbBXTpAc3DMeqKjd+qG5ZCW/cu4ff/klRUO
         Or4T/q1OU+RaNv3ej7KqDuRNwrEh3Wbf92/HGnKExqw7/Es6D3XAqrBmJSrQHPkV3Vxs
         bojHRnkpwgY24NBGdlRthGAn/oTy9dmFXkmtpSLxxLSzyrgjK7oBAzwF4MfRu6TUoQ3K
         FwhygeKz5ITsP+6cM3vhATXlIdpYUjHQhml5E+9lGZAM/81gd/U1TbvToJHDpnEK+0jA
         UI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677049628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swo/AVRGoOMfKCuHRg1QypMC/toJqloCtmfqbfFX1yE=;
        b=piQaaaawKh/gR8VkITTrjpsr/NFVLycLjP3pD9gNik7DsabimZGITI6FZW3I/sLjA+
         Zmg+dq/y37dq7eHgmEN/NIPBLkTNifa7h94p8K4LuZZxZvCQS+6ek2Xb6AeQM+OlMHtV
         IPCoEdWFP44QnF37GpWQwZFpmw0S8oO75QrKk/hGFGajFgscmtPPL8Y/okWEr1qlrQeH
         9uxiwR6avYcEhdwlCEoZ6J+LDIlfMCXRqIFDsq2IylrZuYiHL0o91cWchU/0AXtsB1hV
         OLJXYaAzEVbrTJEBjwNQG0xrbPdIwdwmEioOlltAopDEZ9uN65NDMgCwXC66vdHy3sRW
         s0xQ==
X-Gm-Message-State: AO0yUKWn14yG28qpBuVYh45lkMvq71Oq+820XmbE/tZ8nrB2KqxBQ4fN
        yYtoWD+Eh8xXWTwBGqLK/msZh3Ey8q6R9KB4VLeljA==
X-Google-Smtp-Source: AK7set95TR3c8U46sH0ZY0kZjohLy02UfcaSbSVOPVr0aKJXD5TWClylFBY/nVZk3XmY1zOLnMg72Uv0nz0qaIhmz4Y=
X-Received: by 2002:a05:6122:1435:b0:3e1:f8b0:e35d with SMTP id
 o21-20020a056122143500b003e1f8b0e35dmr1463080vkp.35.1677049628100; Tue, 21
 Feb 2023 23:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230202073148.657746-1-sumit.garg@linaro.org>
In-Reply-To: <20230202073148.657746-1-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 22 Feb 2023 12:36:57 +0530
Message-ID: <CAFA6WYPOx2EWFL8zGXvjqYhQap+v26TWxQ1Pg8k4DiZupfZvCQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] arm64: Fix pending single-step debugging issues
To:     will@kernel.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org,
        liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Thu, 2 Feb 2023 at 13:02, Sumit Garg <sumit.garg@linaro.org> wrote:
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
> Changes in v6:
> - Fix incorrect rescheduling check introduced by rework for v5.
> - Patch #2: s/kernel_regs_reset_single_step/kernel_rewind_single_step/
> - Collected Daniel's tags.
>

Would you be happy to pick up patch #2 independently? Also, it would
be great if you can provide some guidance regarding patch #1 which
certainly fixes single stepping on arm64 but I am not sure how it
would have side-effects.

-Sumit

> Changes in v5:
> - Incorporated misc. comments from Mark.
>
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
