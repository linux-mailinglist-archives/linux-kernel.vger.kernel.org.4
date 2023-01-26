Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9365667C62C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjAZIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAZIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:47:10 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D64B18B22;
        Thu, 26 Jan 2023 00:47:10 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id g16so772712qtu.2;
        Thu, 26 Jan 2023 00:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyvIiOs8TFT5QdDt56s5AZud5rN36NlIHxnKx2RxH+M=;
        b=z5VQVQj2l/0Y4IAJi6pSC2tqdGbQ3r5MZL3TB+bRvecbWXbfLYivj9nwrAPnOeh+83
         ocFxmEFXuhtQtpiu4OsmRm55blVyHy/b6BCikZGiPMHJcBxvvUbQTjpEMKurKbCHXnR1
         qqmapMkdiMhrQyeIjZC2UE0wiHEKljgeanirpQSMDbYosw6Jsp5h0IZNThggXe5FIGP0
         E90OhFgpVwkx1MZIhCVyyBINJMh+7PAjdFzND0D+jvDdfSKqyfA/e9Q04twQ/XdTF2r0
         Uo3pebGuhyQT2PkVDtVtQRaydO3KR6j0AF3h9zdGKwjddVV/Cp0dXKkD9LcxbuZPqILS
         TQCA==
X-Gm-Message-State: AFqh2krB25Kc65Vez+ZjRNDViOy22qazmwADD+Gw/pYEms4OPy4FHQod
        QxNlPeoScfMTl+AQ+g8Mt1022Mi6Omd3JA==
X-Google-Smtp-Source: AMrXdXsIrvAqIzyGRdIbtJ55Ah+FjFDlwSZQCkO1edIw4lVoAxIN0o40T4G1211v6mXH3ejVwqxm9A==
X-Received: by 2002:ac8:1008:0:b0:3ab:6a9a:aa8b with SMTP id z8-20020ac81008000000b003ab6a9aaa8bmr45157604qti.60.1674722828933;
        Thu, 26 Jan 2023 00:47:08 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85602000000b003b68c7aeebfsm421736qtr.3.2023.01.26.00.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:47:08 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-50660e2d2ffso14483657b3.1;
        Thu, 26 Jan 2023 00:47:07 -0800 (PST)
X-Received: by 2002:a0d:f281:0:b0:508:2f2c:8e5f with SMTP id
 b123-20020a0df281000000b005082f2c8e5fmr253434ywf.384.1674722827384; Thu, 26
 Jan 2023 00:47:07 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR07MB98308653E259A6F2CE94A4AFABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
In-Reply-To: <IA1PR07MB98308653E259A6F2CE94A4AFABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 09:46:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbW7jmO-Q8=f1HicPNzxb70TPE57akkDCcqvrS=gA9Hg@mail.gmail.com>
Message-ID: <CAMuHMdVbW7jmO-Q8=f1HicPNzxb70TPE57akkDCcqvrS=gA9Hg@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in fbcon_set_font
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "deller@gmx.de" <deller@gmx.de>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "samuel.thibault@ens-lyon.org" <samuel.thibault@ens-lyon.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
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

Hi Sanan,

On Thu, Jan 26, 2023 at 12:58 AM Sanan Hasanov
<sanan.hasanov@knights.ucf.edu> wrote:
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocalizer.
>
> Kernel Branch: 6.2.0-rc5-next-20230124
> Kernel config: https://drive.google.com/file/d/1F-LszDAizEEH0ZX0HcSR06v5q8FPl2Uv/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1mP1jcLBY7vWCNM60OMf-ogw-urQRjNrm/view?usp=sharing
>
> Thank you!
>
> Best regards,
> Sanan Hasanov
>
> ================================================================================
> UBSAN: shift-out-of-bounds in drivers/video/fbdev/core/fbcon.c:2489:33
> shift exponent 35 is too large for 32-bit type 'int'

This looks valid to me: con_font_set() checks the font width and height
against max_font_width (64) and max_font_height (128), but fbcon has
stricter limits.

fbcon_set_font() should reject fonts with width > 32 or height > 32.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
