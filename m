Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E770B6630DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjAIUAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjAIT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:59:48 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5911C05
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:59:46 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id y8so6938303qvn.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWm5+Ow7jtxP6LNt+zi9Q1QzLknnyApvLPF3gJjeG08=;
        b=gSjPLq/jaX7s4jSQDVHPalM9uDR1uLtPCbJecGlWeQBhl8xcqDOdJZckT1gsnnSr+n
         7vSKJ2zp3eGkCc/kF+EKhIt8s2z96/o76O8DbqKtKoRq3991D/Pu0GUJKOg7w026AFX9
         c20Ah8M+xU5KEEWq0rKGQmj9golM+B7zhE1IL5VqwiZ6+kXnIcSLtWceizAUQe7mhptP
         GTv3koIdlIb7ulx0DPUCLzmEEp622wnEbL8LTj4r1qZxWbg/rqRFVOemVpaZmNPp3bJw
         KsVYPy9IEvqZAcnKbE+ErHh+2k/Dl/5+Z/i/YcJZ2MZVJcHkvCdxNVAWyEtji3dL7DBh
         nMoQ==
X-Gm-Message-State: AFqh2koVQzSoMW5MYhH6pb82+yKbZGj1U/oow2AA5InlhUv/WA3IbV1J
        BNFVBxUjd1i0GoOAh23+lZOl4ykXfK5DmA==
X-Google-Smtp-Source: AMrXdXuiRBsNAlfYUtbVmpMuhDrO9BRv+07DOCAL4w0UGxmDciKPG/UN8UiAlR4VtW1PpghW59IfqA==
X-Received: by 2002:a0c:f7c1:0:b0:532:1018:2b22 with SMTP id f1-20020a0cf7c1000000b0053210182b22mr22740328qvo.2.1673294385795;
        Mon, 09 Jan 2023 11:59:45 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b006fa9d101775sm4862066qkb.33.2023.01.09.11.59.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:59:45 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 16so9671371ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:59:45 -0800 (PST)
X-Received: by 2002:a25:46c6:0:b0:7b8:a0b8:f7ec with SMTP id
 t189-20020a2546c6000000b007b8a0b8f7ecmr1521014yba.36.1673294385060; Mon, 09
 Jan 2023 11:59:45 -0800 (PST)
MIME-Version: 1.0
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu> <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
 <20230109143059.GB25476@1wt.eu> <CAMuHMdWm8Z-xkDUTjppbPT_uxFqfdOZPrPYxgBNgFRL6E=sN3w@mail.gmail.com>
 <Y7xwUKE64PfPRMt7@duo.ucw.cz>
In-Reply-To: <Y7xwUKE64PfPRMt7@duo.ucw.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 20:59:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQMoEBNQa2VKc3Ye1E6S8KjMh4w=T3Jqxr-yJBJ2U7iA@mail.gmail.com>
Message-ID: <CAMuHMdWQMoEBNQa2VKc3Ye1E6S8KjMh4w=T3Jqxr-yJBJ2U7iA@mail.gmail.com>
Subject: Re: Dhrystone -- userland version
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Willy Tarreau <w@1wt.eu>, "Theodore Ts'o" <tytso@mit.edu>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Jan 9, 2023 at 8:51 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >   count=1666675 us50=20178 us250=99913 diff=79735 cpu_MHz=4180.536 tsc50=42614718 tsc250=211016124 diff=101 rdtsc_MHz=2112.014
> > >
> > > It's also what's used by sbc-bench to verify that CPU vendors are not
> > > cheating in the embedded world. It's very simple, and not arch-dependent
> > > nor compiler-dependent (at least as long as you don't build at -O0 :-)).
> >
> > Seeing the rdtsc stuff, I was a bit skeptical, but it seems to work
> > fine on arm32 and rv64.
> >
> > Unfortunately you forgot to add a LICENSE file ;-)
> >
> > Alternatively, I can use the C version of BogoMIPS.  Which has its
> > own merits and reputation.
>
> I'd expect BogoMIPS to be _much_ worse than Dhrystone. If all the
> cores are same, it should be good enough, but...

Both give different results when run on little vs. big cores.
That's why my in-kernel version prints the CPU number, and supports
running multiple benchmarks in parallel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
