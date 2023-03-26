Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB66C931B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCZIX3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Mar 2023 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCZIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:23:27 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D229ED1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:23:26 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i7so7011193ybt.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679819005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMPWm/UNWwNEh+tuXqq8buHzHEocFm7N8w/bA5pWOoE=;
        b=SN6uMbcgDhLs2P8pNncv314RXquC01FYfnayW4zHZA1L504EXAARKwqMg1JHmcljgp
         3FAjtUqNq6XBMC9ZUBdzw7nkr6r7oApbUIdbs7Lpz1Jh+bmuzDG3s6pMoVHyH6t+7Lu1
         xz2TWLInOgQyJ10X76V+uD7n8BHO/s+bk3y36IzXx3M9qIwDFDf4Cp2Bwim5TkqKYv9Y
         8jeWmf/iwufcSxNav+bYW6rNRq8OAf3kggcJ33ntfkjQBtRoeZtQGKIN4mTl/XWRGDCO
         tlyzKN60esh3zy4ssGKNiJGsJxrM33M3zJTxiHEcEGGLM2hwc0epBt6DWuRdqMdVvTDY
         0tAQ==
X-Gm-Message-State: AAQBX9frObDru3RV6mruhqzF6Un0Ft7l0mYvzM9XTXdnPvmIh+r7BF2I
        2ROGS8Ie/MkXDGTimph8s1G+YK3lzeeZi9Xo
X-Google-Smtp-Source: AKy350ZFlovNWbXfd5Vu7MBA/S6em9zncFEgFgt8KkRto/VSrNqtKHa0x8XgNbSP3EcEvSzRxpcinQ==
X-Received: by 2002:a25:accc:0:b0:afe:e13e:6379 with SMTP id x12-20020a25accc000000b00afee13e6379mr8872161ybd.13.1679819005676;
        Sun, 26 Mar 2023 01:23:25 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j19-20020a817653000000b00545a08184a2sm1379926ywk.50.2023.03.26.01.23.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:23:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5416b0ab0ecso115726017b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:23:25 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:544:8bc1:a179 with SMTP id
 h31-20020a81b65f000000b005448bc1a179mr3625143ywk.4.1679819004976; Sun, 26 Mar
 2023 01:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org>
 <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com>
 <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org> <20230324085927.GA6354@allandria.com>
 <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org> <CAMuHMdXi1mF=j_Qzzg971AqHF-JdgfaDd+v0HymXXusFt-WBUQ@mail.gmail.com>
 <20230326000318.GB31801@allandria.com>
In-Reply-To: <20230326000318.GB31801@allandria.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Mar 2023 10:23:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4EKGngXGUuyN6CUh9ByH9sVpZY-2_LsTgCiAMddbxOQ@mail.gmail.com>
Message-ID: <CAMuHMdX4EKGngXGUuyN6CUh9ByH9sVpZY-2_LsTgCiAMddbxOQ@mail.gmail.com>
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
To:     Brad Boyer <flar@allandria.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Sun, Mar 26, 2023 at 1:03 AM Brad Boyer <flar@allandria.com> wrote:
> On Sat, Mar 25, 2023 at 01:44:43PM +0100, Geert Uytterhoeven wrote:
> > Perhaps it would be worthwhile to move the resources out of /proc,
> > but into a separate virtual file system?
> > That way people who need access to the additional info can load the
> > separate virtual file system kernel module, and mount the file system?
>
> I could be wrong, but I believe the more recent trend has been to
> move things like this out of /proc anyway.

Correct. Use sysfs, debugfs, configfs, or your own custom file system
where appropriate.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
