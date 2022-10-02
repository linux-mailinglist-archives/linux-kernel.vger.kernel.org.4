Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA65F248A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJBSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJBSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:17:56 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1D2A963;
        Sun,  2 Oct 2022 11:17:56 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id i3so5573423qkl.3;
        Sun, 02 Oct 2022 11:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LWR8MWFukGpMBQkq/zeXNemsOOXLVgT5+tpaLCTk4t8=;
        b=ZOMDpYDHLu6wn7ZOAtUySJPOlD6fmkmuIb/RIZ9nJ4DSBfe62eQt5G8cBNRA8/kgad
         wX/eHMaiOZlDE5GIKvJolr+Id6W9PVtPY744NV1UmNvNg43mHnBrwfPj5SibXg1QrGxm
         cD79e1UqIwmyta9i8h2pzC83BtjLZFtFwgJQ41n/bC9POOaD8BAP2nSd4Kkqb95Shqb1
         aw60y/e/R3nCHhVOmv1dnB4dql+WXuBGudpCdDJgJH+3J/GDN3Pm103BrqmTmqIGkDaG
         pnnTAmwfJkBhpEWGVFdJqgv74juLpDempykiR9KVP59dN6wAh3zmV4C5BTh3NejC8gs5
         5xTg==
X-Gm-Message-State: ACrzQf3phPXOxCAPHoTuNZJF/ldFSDZKj1dCNW9Mp1FVrUSwb5pP32wX
        8/6RdFN7eHaaRVIOKCOZf8lzxc1UyDx7Dw==
X-Google-Smtp-Source: AMsMyM4XqMCt4tbdrJgQ2HfKfGqkRd1O3AW/nsF06Ps+HLGQXl3yf7CxYy2I+Z27+kg+8q7SXZqQiQ==
X-Received: by 2002:a05:620a:4089:b0:6ce:29eb:9692 with SMTP id f9-20020a05620a408900b006ce29eb9692mr11780405qko.273.1664734674014;
        Sun, 02 Oct 2022 11:17:54 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cq15-20020a05622a424f00b0035cdd7a42d0sm7387560qtb.22.2022.10.02.11.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 11:17:53 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o123so10829849yba.0;
        Sun, 02 Oct 2022 11:17:53 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr15975184ybl.604.1664734672797; Sun, 02
 Oct 2022 11:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info> <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info> <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 20:17:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxUgyU97EK3S5Xx_vsbTv-cNO1wC9kDwsWEDx+6w9phw@mail.gmail.com>
Message-ID: <CAMuHMdVxUgyU97EK3S5Xx_vsbTv-cNO1wC9kDwsWEDx+6w9phw@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Sun, Oct 2, 2022 at 2:49 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> > On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
> Bugzilla gets around two dozen bug reports weekly which encompass at
> most thirty emails, which equals to four emails daily on average.

So we're discussing about the fate of a tool through which on average
four bugs per day are submitted (some of which are not very useful
due to lack of information)? A tool which is not maintained upstream?
Perhaps that's enough reason to just kill the tool, so no one has to
worry about it, or maintain it?

However, at four emails per day, you might as well just subscribe the
subsystem mailing lists (each of which would receive only a fraction
of that, right?).  Maintainers and several developers won't even notice
that minor increase in the number of daily emails received, although
they might still complain about the contents ;-)
And that still needs someone to keep the tool working...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
