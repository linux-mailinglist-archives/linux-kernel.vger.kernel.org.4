Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB166AB48
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjANMHS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Jan 2023 07:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjANMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:07:03 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3C5BB1;
        Sat, 14 Jan 2023 04:07:02 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id y7so2664247qtv.5;
        Sat, 14 Jan 2023 04:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjDf02IMHvV+t7jAXm+ttuj2xmadx1ibBLutjJki3dM=;
        b=ETTEo+3T+YWJPrgFvT+mgDa14OJixhCqx64ae8lOqc1yVCdxKgjhbJMxmU3517Uksu
         zGOAfvRLH85zDPvjkW8DYuzwPsfWM2QPq+9wuqXTkwys7IPf5cZ9iOwg9/aK9h5UcfJK
         dgeCol9dK4Iwu7rMHzeCQJKupSZgfbzfguEeMd595Ruc//2s1VPiEGlvxkcOYt4j4H9I
         3MtoFbKVvaXtmQEgEgAP8/eOMC5UoI1JN55ea5wq0QczzCtrNaOmt7oN3kGRzPO9Jp/r
         hJRo+AlUbcpZIVho8PmnJj3yZ0X6DdGd9fMxzgnN+S1VLDKwoHPc+pY4AufOshzUK6n+
         w6iA==
X-Gm-Message-State: AFqh2kpOTWPjbJbxO/QdKdnIPYB6eu9lAjH7tIcxvNsyQf9qz5g8TZWh
        eWDrVLqhAgyNJz5nIE4LVFG+btDAibpBtA==
X-Google-Smtp-Source: AMrXdXv/fFFB8u4EVx36dQy5gPWqsMCsaJTjI7dgiqwhrwugjUZEmoE+BQsNZQeJpJUne8+SxqQQOw==
X-Received: by 2002:ac8:7957:0:b0:3ad:903d:3ed4 with SMTP id r23-20020ac87957000000b003ad903d3ed4mr28232408qtt.59.1673698021369;
        Sat, 14 Jan 2023 04:07:01 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x3-20020ac84a03000000b003a820f9fb70sm776356qtq.36.2023.01.14.04.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 04:07:00 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4bf16baa865so318910777b3.13;
        Sat, 14 Jan 2023 04:07:00 -0800 (PST)
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr4020257ywb.47.1673698020048; Sat, 14
 Jan 2023 04:07:00 -0800 (PST)
MIME-Version: 1.0
References: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru> <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
In-Reply-To: <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 14 Jan 2023 13:06:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8=JF4CVSJZqQ=FZKRfWALGRVmg+sC+pOw+0TxF680Pg@mail.gmail.com>
Message-ID: <CAMuHMdW8=JF4CVSJZqQ=FZKRfWALGRVmg+sC+pOw+0TxF680Pg@mail.gmail.com>
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Jan 13, 2023 at 7:49 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> > On Jan 13, 2023, at 7:27 PM, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> >> On 5/3/22 11:42 PM, Sergey Shtylyov wrote:
> >> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> >> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
> >> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
> >> at 0 -- modify that code to start the IRQ #s from 16 instead.
> >>
> >> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> >> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> >>
> >> [1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/
> >>
> >> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >>
> >> ---
> >> The patch is against Linus Torvalds' 'linux.git' repo.
> >
> >   So, this patch hasn't been merged... may I ask why? :-(
>
> The SH maintainers have been MIA which is why the other maintainers want to kill the architecture again.
>
> I’m seriously considering adopting the architecture.
>
> Not sure whether Linus would grant that though.

Why not?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
