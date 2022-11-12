Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF50626631
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKLB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:28:38 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F3D120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:28:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id x18so4214518qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CNtVFTk9zAhkS3CLauB15QuywoVuwPBzCzG6uKiNbQ=;
        b=Ac7BE+YvlpctmfMrgd1c+nyA12srOBBQSvslGfa3EYFPqHQyY2qzA7CMiRwFMgyfSl
         c7fhraclen5OJQFTtRGkaDz3rRGBCzgjT/kUoWy13PobtuBYfpV5IdPWYcfe6sOztGYp
         6SjGxvKCR/A4oqiy5S+0xvqo2DPXiS9xiOUOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CNtVFTk9zAhkS3CLauB15QuywoVuwPBzCzG6uKiNbQ=;
        b=GAPdr0OSydt+i/9jL895CLxfyiG/ygO7SdqtPYL64fG95tHG0rfZkP6gzupPZ8KTrX
         lTKcrLWRpeWmYj+mk6kG/uMkOZ1ZPyR6WV5wToTMJDvD+CBg3vfIeGC5//Ptf47lGhZN
         wEMD2smz9L0cBJS+DCy/4lWC4KQSjY0ra3AFLQiG9t8MACEdqiJmNXQwmsMZaGzeUubp
         ZGHQ0lsYTgz8ktXJW0eFjH9Z/M6c+Hpwv3NmdAj+nFjzmyUEENGIAXCn0NM9B0P4Qg1w
         qYiZiFCPZQoFd/iy0W4hl9rOZdkNw55DYisXgQFz2zSVMw6PxruW+8ryFxnu4iKmQTWy
         7+QA==
X-Gm-Message-State: ANoB5pn3+4t/RplEQHrJ2KCgyv+WnTKWUSDljML6Kx5xjnJ5DMgZYR2j
        wgoKKq/kSmi3D3ZmYXWNyygP1SAJamrvYg==
X-Google-Smtp-Source: AA0mqf5iBRwOl2zR6+1Lwc+yaWELBA/0ClctvxKJ9rmsKAks1+ikVkiQDSatEiG8wCBOEsTjJWMZqg==
X-Received: by 2002:a37:e110:0:b0:6fb:11d1:dab2 with SMTP id c16-20020a37e110000000b006fb11d1dab2mr3458762qkm.75.1668216517073;
        Fri, 11 Nov 2022 17:28:37 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n7-20020ac86747000000b00399ad646794sm2069548qtp.41.2022.11.11.17.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 17:28:36 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3775545dc24so58435017b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:28:36 -0800 (PST)
X-Received: by 2002:a81:99d7:0:b0:34d:93d7:ea86 with SMTP id
 q206-20020a8199d7000000b0034d93d7ea86mr4308761ywg.112.1668216515755; Fri, 11
 Nov 2022 17:28:35 -0800 (PST)
MIME-Version: 1.0
References: <87fsepx42m.wl-tiwai@suse.de>
In-Reply-To: <87fsepx42m.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Nov 2022 17:28:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSH5ubdvt76gNwa004ooZAEJL_1Q-Fyw5M2FDdqL==dg@mail.gmail.com>
Message-ID: <CAHk-=wgSH5ubdvt76gNwa004ooZAEJL_1Q-Fyw5M2FDdqL==dg@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 6.1-rc5
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:56 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> please pull sound fixes for v6.1-rc5 from:

Hmm. I don't know that this came in through this particular pull
request, but I don't seem to have seen it before:

  Nov 11 14:32:37 xps13 kernel:
        snd_hda_intel 0000:00:1f.3: Too many BDL entries:
buffer=2097152, period=65536

there's six of those lines in my logs (two batches of three, five
seconds apart).

I don't see any negative side effects aside from the messages, and
sound seems to work fine, but since I don't think I've ever seen this
one before I thought I'd just mention it.

I also haven't been using this laptop on a while - an arm64 Fedora
uboot update broke my M2 boot, so I'm temporarily back to using my
trusty old xps13.

So while it's new to me, the issue that introduced it may not be
particularly new.

Google does show that the message itself has been happening for others
for a long time. But I checked with 'journalctl', and it hasn't
happened on this particular machine before.

It might be a non-kernel change that triggers it, of course.

                 Linus
