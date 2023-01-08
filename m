Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7066182F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjAHScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjAHSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:32:29 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290FB1D2
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:32:28 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id s5so1845298qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 10:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8OInR6yfAiE0IZmPszq2t+0HphzYJeQkbam0IHbtMQ=;
        b=uNha23ua0GPPVyy0dYoaQo88Ybwcve1v92c2JMVHt/Cgl4x5sIpFkafSa98/MT5hkp
         Fe6bifoJiHIhcPoL5PygaL85F+N0CUMRpyH/sDX09f1/UJrl3uKjgqKS20iXSV+slWLH
         zTMniowqW0A3wnQlNvwU4SPrv4G+hPcSzqTV+NmUBjfZ3o93WZAycp5Lbz2VNR0aC9yi
         m5RXT+dbZkiJ6b6JfkWjc3Oz3cIMSgdlQoABnUoPB0XsEm3W9NXj6VKvaYQSQ2WK59Aw
         leSc2WF/WsbVXTueX4yP62iVGr8ADSA7qHumKp8PCjXyf1g+chpo9uehuoi695r4g/cb
         JIvg==
X-Gm-Message-State: AFqh2kq1AwwIyM1lb+98QzhQB0aKB9pBfsnQX8bjXxnSnddpABSJNGwv
        SPdyuwukh1jK0Fkvp0YCqJ4CviFb72Xabw==
X-Google-Smtp-Source: AMrXdXtj3/FonfLb1/Kb5xdEsLkJrO55Rj7goZodKsgSFQhkex4XPUFLL1bo4GBWB0SQd9mlPF8Ecg==
X-Received: by 2002:a05:622a:5c05:b0:3ab:bb76:5d4f with SMTP id gd5-20020a05622a5c0500b003abbb765d4fmr31952197qtb.60.1673202747540;
        Sun, 08 Jan 2023 10:32:27 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b006fa9d101775sm3054572qkb.33.2023.01.08.10.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 10:32:27 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-4b6255ce5baso86543197b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 10:32:26 -0800 (PST)
X-Received: by 2002:a81:1a16:0:b0:46f:bd6:957d with SMTP id
 a22-20020a811a16000000b0046f0bd6957dmr340305ywa.383.1673202746615; Sun, 08
 Jan 2023 10:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20230106143002.1434266-1-steve@sk2.org> <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
 <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com>
In-Reply-To: <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 8 Jan 2023 19:32:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
Message-ID: <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Stephen Kitt <steve@sk2.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sun, Jan 8, 2023 at 3:57 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sun, Jan 8, 2023 at 11:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> This will likely go through drm-misc as part of a bigger series:
>
>     https://lore.kernel.org/lkml/20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org/
>
> So you may want to copy-paste your tag there.

Oh, I sent it here because of
https://lore.kernel.org/all/Y7qM+ZlG5gQiOW4K@ravnborg.org ?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
