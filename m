Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF136630D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbjAIT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjAIT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:57:46 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11FA13E24
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:57:44 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h21so8688463qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xT3iy3/Ce9yXgQp7C5BIAX0h7RVPSzdu2IipBE+OZ7I=;
        b=UttdJQTQ/iIVqu9rlPaviqraSjksKFT3i4tiGODuwqVfc2rLOkuzsFWK0ix28VAPSV
         HGdwDa22XyOLbxCiYaI1jlJK3M02takuw3P0boufsimOOnF9W+FXPUu2SVMalm4s4nSX
         cJtG522pP2qTSSjI3KYP7+p9TGcI/GohxTh/M/bULGVwgh0a1g4tl3JS2V7lBRLhJMd0
         pomSkSOyVKOh6bT3KpKc8rz509umOcFRo64OOeU7FpfEkVFQ92BFxXBUIZC3Yrs5l9KB
         nb1ZsgnF/5WBVg/XJN9+tmx+QhxVAxKfQAGTz7Y2N43YwX6ag6aws7WyzVGz5+Pe67ca
         H6PQ==
X-Gm-Message-State: AFqh2krneDX2K8967xPUNdOvs3t3vmcMeVm5dnGJ0p/4Ofdl5Wih1IAA
        l3zsmMQSCm+3sdwv04hAegCVUzkqqtqzCA==
X-Google-Smtp-Source: AMrXdXsAgmk3Bj7HSXpxZXk1YOruNnw9Qx9TwnAd6r0dtKmFGgDuz5N9Rvo9Y2ttZPas5KZZ/gbbBA==
X-Received: by 2002:a05:622a:5c85:b0:3a7:e271:fc05 with SMTP id ge5-20020a05622a5c8500b003a7e271fc05mr85931349qtb.3.1673294263754;
        Mon, 09 Jan 2023 11:57:43 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm5010141qtr.55.2023.01.09.11.57.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:57:43 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4bf16baa865so126868337b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:57:43 -0800 (PST)
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr1807461ywb.47.1673294262797; Mon, 09
 Jan 2023 11:57:42 -0800 (PST)
MIME-Version: 1.0
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu> <CAMuHMdXP8ycxE_Sny0q+SAzLTwnaA3hks=ErW-ZfiMBw7ZMSgg@mail.gmail.com>
 <20230109143059.GB25476@1wt.eu>
In-Reply-To: <20230109143059.GB25476@1wt.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 20:57:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-xpu-+8kAun90ZdYLe6kMzW3CEoD_hQtpwTPSJ8Tp1A@mail.gmail.com>
Message-ID: <CAMuHMdX-xpu-+8kAun90ZdYLe6kMzW3CEoD_hQtpwTPSJ8Tp1A@mail.gmail.com>
Subject: Re: Dhrystone -- userland version
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Mon, Jan 9, 2023 at 3:31 PM Willy Tarreau <w@1wt.eu> wrote:
> Then maybe you'd rather use this:
>
>    https://github.com/wtarreau/mhz

> It's also what's used by sbc-bench to verify that CPU vendors are not
> cheating in the embedded world. It's very simple, and not arch-dependent
> nor compiler-dependent (at least as long as you don't build at -O0 :-)).

Gcc 4.1.2 (still the userspace compiler on a few of my old systems)
doesn't like the aligned() attribute on functions.
In glibc 2.3, LLONG_MAX is defined conditionally on __USE_ISOC99.

Apart from that, the result is fairly accurate. Nice job!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
