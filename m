Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488E71581F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjE3IPx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3IPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:15:50 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4338F;
        Tue, 30 May 2023 01:15:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-565c9109167so25805467b3.2;
        Tue, 30 May 2023 01:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434548; x=1688026548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM3qcrdadY6aQ0n9fF0zhvewI2tLxCW57reHIPxVy30=;
        b=E4cv/8GjMnDDAO5oxIAvVVovZzCN0/JgH/4yrfnrblBM1Hx1HMsSzEdvx9hzQh4SwL
         KBfe0a9Xz7y43X9W14tDavakVlCZ6fWNtGmOCvTZibXLXoldgbF9y9vmCwqvZ2fH5mi1
         xNLdxwzL10hIhAMy4ilW/OeE9PyisPm0TYITENRJBrfZLct39nT6B9lXj7VB0ZZ3d4Oc
         Hspfozm/tZN0EfFqB6Al5NEjEajCzCFY6Ira1zv2rtVbeX+IodKOFp24UHnfXgmZGYWk
         6oSuf0MZRJN04GR0zvsA+QzQeU67wr6llVF3ZnDpUClp85jSOId6eoJPPYrHdpBF7SO7
         Zq9g==
X-Gm-Message-State: AC+VfDz2CzCgo2R3fZ44qqehxk05h7b+HATsTTKHtAgsDg+tSDQg50Du
        iMP5cvieAUDozjIRw42tZob3jvhA4aahKA==
X-Google-Smtp-Source: ACHHUZ6myI68hq/NoShulu+S+TiYX32+W9ABYCv2wXVhDKgKQBX6JD2CkOzSLMRhcJerYict9QPwew==
X-Received: by 2002:a81:5255:0:b0:561:e565:3678 with SMTP id g82-20020a815255000000b00561e5653678mr1422459ywb.11.1685434548684;
        Tue, 30 May 2023 01:15:48 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id k133-20020a816f8b000000b00565f04518b7sm2069211ywc.12.2023.05.30.01.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:15:48 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-565aa2cc428so34801977b3.1;
        Tue, 30 May 2023 01:15:47 -0700 (PDT)
X-Received: by 2002:a0d:db0f:0:b0:55d:820f:11b7 with SMTP id
 d15-20020a0ddb0f000000b0055d820f11b7mr1298578ywe.32.1685434547716; Tue, 30
 May 2023 01:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220307143014.22758-1-lcherian@marvell.com> <164668950224.3277206.2552145973830842260.b4-ty@kernel.org>
 <CAMuHMdUmTV3Mmp-6LGiEqNG7DdxsBq-dpoGwTv7MHHMJQrGcLA@mail.gmail.com>
In-Reply-To: <CAMuHMdUmTV3Mmp-6LGiEqNG7DdxsBq-dpoGwTv7MHHMJQrGcLA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 May 2023 10:15:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUF_V4iwmPKZBoE8HEpnkAtOusDNpRjetBVLRj7PQiXgQ@mail.gmail.com>
Message-ID: <CAMuHMdUF_V4iwmPKZBoE8HEpnkAtOusDNpRjetBVLRj7PQiXgQ@mail.gmail.com>
Subject: Re: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when
 reading IAR
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, Linu Cherian <lcherian@marvell.com>,
        maz@kernel.org, tglx@linutronix.de, kernel-team@android.com,
        linuc.decode@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:13 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Mar 7, 2022 at 11:15 PM Will Deacon <will@kernel.org> wrote:
> > On Mon, 7 Mar 2022 20:00:14 +0530, Linu Cherian wrote:
> > > When a IAR register read races with a GIC interrupt RELEASE event,
> > > GIC-CPU interface could wrongly return a valid INTID to the CPU
> > > for an interrupt that is already released(non activated) instead of 0x3ff.
> > >
> > > As a side effect, an interrupt handler could run twice, once with
> > > interrupt priority and then with idle priority.
> > >
> > > [...]
> >
> > Applied to arm64 (for-next/errata), thanks!
> >
> > [1/1] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
> >       https://git.kernel.org/arm64/c/24a147bcef8c
>
> This workaround is now enabled on R-Car V4H:
>
>     GIC: enabling workaround for GICv3: Cavium erratum 38539
>
> which is not a Cavium SoC. Is this expected?
> Thanks!

Please ignore, wrong thread. Sorry for the fuzz.
(note to myself: do not trust Gmail search to match on all search parameters)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
