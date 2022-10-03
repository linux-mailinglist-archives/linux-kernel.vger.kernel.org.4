Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE515F2898
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJCGhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJCGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:37:37 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D5C6460;
        Sun,  2 Oct 2022 23:37:30 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id de14so6306848qvb.5;
        Sun, 02 Oct 2022 23:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bk2C3u/t27y03cPLtgq1Q59OlKnnWoH0jHqzc388cwA=;
        b=g+Psh3cAL+repNIB2scKxwj43RCNGQKIaM9Or0HdXFoy4G/8+f8MXOtalH9a4C5jge
         lgNn9km433z89LwHiJ/kFqUmPsSCL8U8s7L7ByMqS+phqWY81dLq6k2dO5h1ALYhE5Y3
         yliAM49/eV745cLOJQ4kLbuSv3WHiTg7BCcoNBCjhve6CRLDBTIJMMfZmhcM7UGonn5f
         VEjXuydMDpDcV1xGiTAL3Uu9EDVAaIuAb72Nu1j1T0or8nIpX1+5fsQf9VIUdXEsDSXf
         w43z8rJ4lU/iRu55Xh46AphH0oe8i3+zIlKYDEh5VHAtg06LX8VfFvnrLP24pZhThBWK
         y8XA==
X-Gm-Message-State: ACrzQf2qGUCjnkwxIiEMFv69riQr3dNwOGF56ATyw84E/9SsvJng4JIF
        bCsSHyCcKeHrP0bmhbR7DlaYbeMbxGqJbA==
X-Google-Smtp-Source: AMsMyM4bwSS7HxIQiZtnjmZecLCFJcAK1wkCjwk9snWQWoUtQti7KVg57CtRZVqIvaC2fPXIrwW9eg==
X-Received: by 2002:a05:6214:20e2:b0:4ac:b9a6:17be with SMTP id 2-20020a05621420e200b004acb9a617bemr14807276qvk.104.1664779048952;
        Sun, 02 Oct 2022 23:37:28 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id az19-20020a05620a171300b006bbe7ded98csm10133099qkb.112.2022.10.02.23.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 23:37:28 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-354c7abf786so97492127b3.0;
        Sun, 02 Oct 2022 23:37:27 -0700 (PDT)
X-Received: by 2002:a81:848c:0:b0:356:e173:2c7a with SMTP id
 u134-20020a81848c000000b00356e1732c7amr10829162ywf.502.1664779047579; Sun, 02
 Oct 2022 23:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com> <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002150522.ul4nbtfawqjhnsag@meerkat.local> <b594681b-6b8c-ffb7-f526-3da847d160a8@gmx.com>
 <20221002205430.GC22129@1wt.eu> <d1f99826-2a66-c2d5-c9cd-d2fadd35eca4@gmx.com>
 <20221002213235.GA22532@1wt.eu> <867b35b7-da2b-fed0-1f75-b2021d9be499@gmx.com>
In-Reply-To: <867b35b7-da2b-fed0-1f75-b2021d9be499@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Oct 2022 08:37:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkFdXiqV-k2X8yDh5VkR3cv0a4z78z+uCF_PfgHgGx=Q@mail.gmail.com>
Message-ID: <CAMuHMdVkFdXiqV-k2X8yDh5VkR3cv0a4z78z+uCF_PfgHgGx=Q@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Sun, Oct 2, 2022 at 11:54 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> It's easy to join an existing bug report. Tell me how can I join an
> existing email thread without being first subscribed to it? I certainly
> can, absolute most people will not be able to.

lore.kernel.org

> What about sending large dump files? Should everyone on the mailing list
> receive it?

post a link

> A bug report is a simple plain list of messages in a single place which
> could be read with a web browser. An email thread is anything but.

lore.kernel.org

> Searching through many emails at once? Good luck with that.

lore.kernel.org

> Replying to a particular email? Good luck with that.

lore.kernel.org

> It looks like you're under the impression that every Linux user who is
> willing to ever use Linux must:
>
> 1) Subscribe to _all_ the existing mailing lists (just in case - what if
> you need to work on something which was started by someone else)

lore.kernel.org

> 2) Know the email etiquette

Just Be Polite

> 3) Learn to be persistent and resend (an unknown number of times) your
> concerns hoping they will eventually be addressed.
>
> Bugzilla: sign up once. Follow up. If you file a dupe, hopefully it will
> be marked as a dupe. Everyone's happy. No particular skills, email
> clients, formatting, referencing, etc. etc. etc.

Having at last the skill to provide a good rebug port would be nice...

Now, back to work. The merge window has opened, so there will be
bugs to report and/or fix...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
