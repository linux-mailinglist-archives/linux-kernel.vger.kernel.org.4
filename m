Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06458691194
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBITvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBITvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:51:03 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE723671
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:51:02 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-52ec329dc01so20154367b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQirvFkXJNys2L/QVLtaaVUPThdd0nYg4wfN1XkQF9k=;
        b=TJcF2CUbuaWP2iDAiOYLqAAkSYwbwKGvbvBVFGLWm6YOtCZlzrSZhhje+1MAJUgGKt
         DM3TUSgtiWWdKAnGIaiCAb5mmxEcfXcpS6hN7y8xEYoP0LVPqANMBoRFUYn/G/SBmMV6
         NvEiIfMhuuIBXKQ8AsfgRyPgMJ3MEbqbTwkHj612+QFEc7UmlWegiziMU6NJT3jPq47+
         Omm9MVnqFvUklKa0811m5IL8doDzl+mcBamcfd8bu+DSiwzTHPn9SVZq1p2xIzlINFHt
         w8/4mc//+jMZ2ADKn4RsxqcWG8s7Ul/bB3B99UMK33KRuGNvcBUQu614BQYcsQcgmy88
         EkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQirvFkXJNys2L/QVLtaaVUPThdd0nYg4wfN1XkQF9k=;
        b=KrhZtRtm9pW6Y3B4Dotc1uNoJKm946rpmPrfi1W5FP4QWDQg4cht09savrnWhiNQMv
         ktIk+5E/gFuucg3Nj7Q6IkIysTlbup0k1/XR9DCWnIlr5wlqXSBlISbYRGSnwZfy6pKD
         UPv3c+TeuKRWZlCw7cwiC/4fTFJWJbmZ9Jo/KpPc16Ge1CelLyxvZxEvNc9Kz6ooNx7e
         /p/MmOhYwhzpENK1U2vpGkXwS7+0gaU5N0GO1z3JF89HtJL22tCSEHs98baMhsadaapF
         k7ENkfsGYII1DBZAm/zQpNIOf+LUOrd6DFW1oqTXE5/NhRrhxMMM9ao3DFM53NtOis4O
         sxpg==
X-Gm-Message-State: AO0yUKW5+4K8kPhFcFj9o25DdTd8JjQOoX0+yYmr+6uL44cUCCX3hjWd
        qVRxY7AEZMLfvpicCAdMnnTjQyzqlxirmW08C0S9
X-Google-Smtp-Source: AK7set/tuNoRXCYBdZYRG8v3DyGqWC26c5R3O53w8gFYK+KKegGlSCWqmDNDCSgAtMiDiDZsg4p551wirLwuT+nG8V0=
X-Received: by 2002:a0d:d5ce:0:b0:506:6e0b:7441 with SMTP id
 x197-20020a0dd5ce000000b005066e0b7441mr1279691ywd.208.1675972261271; Thu, 09
 Feb 2023 11:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20230208094813.20874-1-walter.chang@mediatek.com> <fdcea75c-1ddf-c4f4-5d46-f32a6619b66d@linaro.org>
In-Reply-To: <fdcea75c-1ddf-c4f4-5d46-f32a6619b66d@linaro.org>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 9 Feb 2023 11:50:49 -0800
Message-ID: <CANDhNCp6esdor4kDDTDowkKRfRN9QW8Au7uJMhsxyw0eAG4i8A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support timer drivers as loadable modules
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     walter.chang@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Feb 9, 2023 at 7:36 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
> > From: Walter Chang <walter.chang@mediatek.com>
> >
> > This patch exports functions in kernel so that timer drivers,
> > such as timer-mediatek.c can become loadable modules in GKI.
>
> What for ?

In general, it's the same reason why modules exist: We want to be able
to support a wide array of devices with a single kernel, but we don't
want all devices to pay the memory cost of code that will never be
used there. So being able to support loading device-specific bits like
clocksources (along with other device specific logic) helps.
Obviously it still has to make sense, and others have raised concerns
of stability issues if the hardware support is needed before we can
get to module loading, but I think if this allows drivers (such as
timer-mediatek) to be loadable safely, I see it as beneficial.

(And as others pointed out:  this patch series is incomplete as it
doesn't modularize the timer-mediatek driver, which would be a prereq
to supporting it upstream)

thanks
-john
