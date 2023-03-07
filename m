Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541936AD9B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCGI6M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 03:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCGI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:58:06 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F23771E;
        Tue,  7 Mar 2023 00:58:05 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id s12so13549834qtq.11;
        Tue, 07 Mar 2023 00:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf9D3mYUVq4IaTZ5HVptNWacWozv4toT5Gz07corxFA=;
        b=ffk8EL3sdG3VkZS4APfVKnR1CQhIwPL4WP4Erd7vZGYROWwQ9tn9AVwTiDRTHU7H8U
         wAMsBrCv+RDC4GfNZsL5Pi5RQrehG0Ae7mdCzFFwq2lEHgQE3+ymTVMXwthTR9glLwHg
         c0kAm7FKDwRlDpN6LRFQo4HkB9i1azj809KykryHmhdKAysOfonVeLDN0kAvCMWc1Y3X
         jkREM067RfpJVqV6afj6Dit2gvF2ZB/ofiHa+Lxoz+5H4IfOXoAF4h/yrzbkmFb4R5hi
         89yX76BEA6LU2HttPxUT9Gxix/SfQ0Ih56kYol5ViD/AcV7AUyDiQQvD/QL5MNX0jYqg
         kdOg==
X-Gm-Message-State: AO0yUKV2kRwD5r1no58T6oOCfmoNR1eYhfrH1asARSdWYXrQH+QtqQ05
        MklvnsMudyRzkZin7d5Gx577XBRpzLU2Yw==
X-Google-Smtp-Source: AK7set9Px7/QAsJmiwp0nMg/ie2mPRbur1K0kO39/K80fBbviaq8CX7/UPNZ5bZvWwyhOQIWd/Fzxw==
X-Received: by 2002:a05:622a:348:b0:3bf:dc2e:ce3f with SMTP id r8-20020a05622a034800b003bfdc2ece3fmr18741653qtw.16.1678179484426;
        Tue, 07 Mar 2023 00:58:04 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id q28-20020a05620a2a5c00b007422fd3009esm9267355qkp.20.2023.03.07.00.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:58:03 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id k199so10695679ybf.4;
        Tue, 07 Mar 2023 00:58:03 -0800 (PST)
X-Received: by 2002:a5b:542:0:b0:a67:c976:c910 with SMTP id
 r2-20020a5b0542000000b00a67c976c910mr6389341ybp.7.1678179482859; Tue, 07 Mar
 2023 00:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20230306160016.4459-1-tzimmermann@suse.de> <CAMuHMdU5AwE0pK=ppip4J81ByEye+jmvff1s8saeEuWZWZiqPw@mail.gmail.com>
 <c560dd1c-03ac-1aa7-f3ac-2a2d9f411505@suse.de>
In-Reply-To: <c560dd1c-03ac-1aa7-f3ac-2a2d9f411505@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Mar 2023 09:57:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWRwN7Ks1ougy81Lh=NKLD+y04Xr6O+Ee+3k5Z4QH2Rg@mail.gmail.com>
Message-ID: <CAMuHMdUWRwN7Ks1ougy81Lh=NKLD+y04Xr6O+Ee+3k5Z4QH2Rg@mail.gmail.com>
Subject: Re: [PATCH 00/99] fbdev: Fix memory leak in option parsing
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Mar 7, 2023 at 9:23 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 07.03.23 um 08:53 schrieb Geert Uytterhoeven:
> > On Mon, Mar 6, 2023 at 5:00 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Introduce struct option_iter and helpers to parse command-line
> >> options with comma-separated key-value pairs. Then convert fbdev
> >> drivers to the new interface. Fixes a memory leak in the parsing of
> >> the video= option.
> >>
> >> Before commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
> >> caller; clarify ownership"), a call to fb_get_options() either
> >> returned an internal string or a duplicated string; hence ownership of
> >> the string's memory buffer was not well defined, but depended on how
> >> users specified the video= option on the kernel command line. For
> >> global settings, the caller owned the returned memory and for per-driver
> >> settings, fb_get_options() owned the memory. As calling drivers were
> >> unable to detect the case, the memory was leaked.
> >>
> >> Commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller;
> >> clarify ownership") changed sematics to caller-owned strings. Drivers
> >> still leaked the memory, but at least ownership was clear.
> >>
> >> This patchset fixes the memory leak and changes string ownership back
> >> to fb_get_options(). Patch 1 introduces struct option_iter and a few
> >> helpers. The interface takes an option string, such as video=, in the
> >> common form value1,key2:value2,value3 etc and returns the individial
> >> comma-separated pairs. Various modules use this pattern, so the code
> >> is located under lib/.
> >>
> >> Patches 2 to 98 go through fbdev drivers and convert them to the new
> >> interface. This often requires a number of cleanups. A driver would
> >> typically refer to the option string's video mode. Such strings are now
> >> copied to driver-allocated memory so that drivers don't refer directly
> >> to the option string's memory. The option iterator then replaces manual
> >> parsing loops based on strsep(",").
> >
> > Thanks for your series!
> >
> > Unfortunately I cannot say I'm thrilled about this: you are replacing
> > a single small dynamic memory leak by 36 larger static memory leaks.
>
> That's fair enough.
>
> > Am I missing something?
>
> The current size of the videomode buffers is ridiculously large. I just
> needed something that could hold the string. A long mode description
> might look like
>
>    1920x1080MR-32@120ime
>
> which has 21 characters. 32-byte buffers would probably be more than enough.

But there are a few exceptions...

> I think it should also be possible to do a simple kstrdup() on the given
> videomode string and free the copy in the module's _fini function.

That sounds like the sanest approach to me.

> That also brings up the question of these MODULE ifdefs. Almost all of
> the fbdev drivers only parse the command-line option if they are not
> build as a module. Do you know why? Because of the awkward semantics of
> the old fb_get_options()?

That's just historical: to get to see anything on the console (on
the graphics hardware without VGA text mode that fbdev was originally
developed for), you needed to have your main fbdev driver builtin.
Drivers for secondary displays could be loadable modules, and using
fbset for those offered more flexibility than a module parameter.

> I think this should be changed so that they
> always respect the video= parameter.

I agree that makes sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
