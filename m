Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FB600F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJQM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJQM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:59:16 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A031EC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:59:15 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id s3so7578113qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYUtPYFB9C+7Trxy7xCpZPLfeVdftlC1KSkxlxw2jX0=;
        b=NdTQbneosiTpu8ImkaaC27AeSynZKrIelftKMwCvTC16S27Mu0KbgVcqUzmCZHCC8A
         ljuW8mtqNNgAyBbS/RN8FQRqIamAqVGX71lmjEGbHtD8rb8HV4VqzVuGZbOjoaEGSGL3
         qaOZMJUQlEuc/9xVf7OqJe7F7oqPS13YrUU8FmIdkC5ddZFeogopd4fa2e+fcYYF75xv
         tS0rrB7O8kHLrPgZiqEbQq5nK0EEJy3N3w9eDUyOtn3tnmg9Z3jIPBYvr77ElFOFZ1vq
         aNa+HOZRQisygVsDW1UEMI49vU2FjlAmHCuLUMyHfaMrV84v6UZVQpBPTVAg9DvkfCr8
         TCVQ==
X-Gm-Message-State: ACrzQf1c3G0WAfAYWb1Q67OWO/0E/k1Qpe5jhNqYACArTu+Hov0UdWl0
        T3kIO15SQwIJm0b7DjqIKAwSUhv+Syz2qA==
X-Google-Smtp-Source: AMsMyM4Ydaymp+9kcqk1SckSr2n6B4otEn8ct03NTwzz0lL6z8zW/bz6BO5j+fTTwusE2v4EeYoCwA==
X-Received: by 2002:ac8:5b10:0:b0:39c:d63a:d88 with SMTP id m16-20020ac85b10000000b0039cd63a0d88mr8480274qtw.682.1666011554207;
        Mon, 17 Oct 2022 05:59:14 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id t4-20020a05622a01c400b00397e97baa96sm8049482qtw.0.2022.10.17.05.59.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id f205so2000878yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id 129-20020a250687000000b006c22b0c026emr9082996ybg.202.1666011553081;
 Mon, 17 Oct 2022 05:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <3225ba4cfe558d9380155e75385954dd21d4e7eb.1665909132.git.geert@linux-m68k.org>
 <Y00+N/2eE+GSrQqh@sirena.org.uk>
In-Reply-To: <Y00+N/2eE+GSrQqh@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Oct 2022 14:59:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-yGhWMBF9zUXaHmU4rhkdZiHktDLXb=9bK2bYqaDhyQ@mail.gmail.com>
Message-ID: <CAMuHMdU-yGhWMBF9zUXaHmU4rhkdZiHktDLXb=9bK2bYqaDhyQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in __exit_p()
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Oct 17, 2022 at 1:36 PM Mark Brown <broonie@kernel.org> wrote:
> On Sun, Oct 16, 2022 at 10:33:50AM +0200, Geert Uytterhoeven wrote:
> > If CONFIG_SND_SOC_TLV320ADC3XXX=y:
> >
> >     `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
> >
> > Fix this by wrapping the adc3xxx_i2c_remove() pointer in __exit_p().
>
> Why does this driver need this but most others don't?

Because most drivers don't annotate .remove() functions with __exit?
An alternative would be to drop the __exit annotation, at the expense
of a slightly larger kernel in the built-in case.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
