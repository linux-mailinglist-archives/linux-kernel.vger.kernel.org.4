Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EF620F51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiKHLkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiKHLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:40:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422F4C27C;
        Tue,  8 Nov 2022 03:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAB72B81912;
        Tue,  8 Nov 2022 11:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E81C433C1;
        Tue,  8 Nov 2022 11:40:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OV+k2FSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667907631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QRzaz/OenfJp+r6yaKiscfmlDS/YWjOXCyB1m+YgKk=;
        b=OV+k2FSWl23wVW/XgY+M0THCyXgIwWOOnscqiT0kTaFqt9OM2LXZ+a3NYSlhhTW0Q1YeXM
        fz+EPyXERDas5CJJOIKcbhxi25MdszTwTplARLxBbg4aVTRVWAMWDVchmDFe1oF1UBaNVP
        2KCv55EBic/9ijDa0c4ls+WGF8Kt15I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1e063cfe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 11:40:31 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id k67so13388010vsk.2;
        Tue, 08 Nov 2022 03:40:31 -0800 (PST)
X-Gm-Message-State: ACrzQf2eO2lnR83ykqYxVdiByM9QyjsUqgXP7uw/FI+3WNIqVoSDYUXg
        +NVlLF7Ow/kYKOk2Kp5BNYA0pZeH8yCIJHyjJTA=
X-Google-Smtp-Source: AMsMyM50Z8EdMSF4Ux8Jn4LmQ/p9eMK0jvqLMOYwcTuPxMbrsmVN1aRm9IETX8R9DxWX+G5QltJwcWJ4knbF5FB/Zfg=
X-Received: by 2002:a67:c297:0:b0:3aa:3cac:97b6 with SMTP id
 k23-20020a67c297000000b003aa3cac97b6mr29936878vsj.76.1667907630270; Tue, 08
 Nov 2022 03:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20220916125916.652546-1-Jason@zx2c4.com> <87v8np978s.ffs@tglx>
In-Reply-To: <87v8np978s.ffs@tglx>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Nov 2022 12:40:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9rye4sqKNbpu=oOvLjgMY=Whi13Qz8L0xyZR=Ty27pHfw@mail.gmail.com>
Message-ID: <CAHmME9rye4sqKNbpu=oOvLjgMY=Whi13Qz8L0xyZR=Ty27pHfw@mail.gmail.com>
Subject: Re: [PATCH RFC v3] random: implement getrandom() in vDSO
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 9:32 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Sep 16 2022 at 13:59, Jason A. Donenfeld wrote:
> > ---
> >  MAINTAINERS                            |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> >  arch/x86/entry/vdso/Makefile           |   3 +-
> >  arch/x86/entry/vdso/vdso.lds.S         |   2 +
> >  arch/x86/entry/vdso/vgetrandom.c       |  16 ++++
> >  arch/x86/include/asm/vdso/getrandom.h  |  37 ++++++++
> >  arch/x86/include/asm/vvar.h            |  16 ++++
> >  drivers/char/random.c                  |  64 ++++++++++++++
> >  include/vdso/datapage.h                |   6 ++
> >  lib/crypto/chacha.c                    |   4 +
> >  lib/vdso/getrandom.c                   | 117 +++++++++++++++++++++++++
> >  lib/vdso/getrandom.h                   |  25 ++++++
> >  13 files changed, 293 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/x86/entry/vdso/vgetrandom.c
> >  create mode 100644 arch/x86/include/asm/vdso/getrandom.h
> >  create mode 100644 lib/vdso/getrandom.c
> >  create mode 100644 lib/vdso/getrandom.h
>
> This is not how it works. Please split this apart into reviewable bits
> and pieces:
>
> 1) Add the new syscall
> 2) Add the vdso infrastructure
> 3) Wire it up on x86

No problem, will do.

Jason
