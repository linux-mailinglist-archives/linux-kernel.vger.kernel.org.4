Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98091725977
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjFGJGD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 05:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjFGJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:05:35 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225A213A;
        Wed,  7 Jun 2023 02:04:41 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-568ba7abc11so92692397b3.3;
        Wed, 07 Jun 2023 02:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128681; x=1688720681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNEKaP7UVQJpZRtahYRlPOw3JCnkhMyaEr720NhUxp4=;
        b=UiTsLu8aEUZnsPcrwJyYjFJUWWzeLRQuuaixny4S6NMUajkWequgCYA1KoSt0F6PFF
         tDyPmUYAUtOwhPf4fElCgvfNeRQedwWel4QmUtvqZUTG0YXyVK28PBgzB/Xg6H4dZCUs
         CUP9zh01m9+drC7lo3KTZhe+ZOWQ7eiApRX9y3c1Xtw0kWKhHcG+vm7i8fA6PwdOhUK6
         kky8sEHlFXSWm9wRVXC1MvtZjnbSusMGXw+y0Ht6Eo3y1HacTWe4vvAidv5D0flKUqK0
         S/ZlIxfbZY7Rx060J5mjkIcUjy6SIWRQeC+GgmEn+nlBMLiVPEUFrk/eDiPO4EgNx4oY
         E8bg==
X-Gm-Message-State: AC+VfDyikJ1YeRW0L32BvKdYW7iyI0ckeXi+TL7JLvbQ4qg5gNJ/dnhw
        TNkj/qgqtdBQLbwuQMcarJ9fHh++/9SZ2w==
X-Google-Smtp-Source: ACHHUZ6ziPtuMJubFT3g+33BIHcHeG/nAX5QuAXl3nB3Xq4YZjO4/eOuVWaFPJ5SceOgVJPJlns7YQ==
X-Received: by 2002:a81:61d6:0:b0:561:3fb7:1333 with SMTP id v205-20020a8161d6000000b005613fb71333mr7171131ywb.43.1686128681034;
        Wed, 07 Jun 2023 02:04:41 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id d14-20020a81d34e000000b00568ab5dd873sm4573007ywl.65.2023.06.07.02.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:04:40 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-568ba7abc11so92692137b3.3;
        Wed, 07 Jun 2023 02:04:39 -0700 (PDT)
X-Received: by 2002:a0d:eb88:0:b0:55a:4a73:6177 with SMTP id
 u130-20020a0deb88000000b0055a4a736177mr6153827ywe.42.1686128679544; Wed, 07
 Jun 2023 02:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu> <20230527164452.64797-2-contact@artur-rojek.eu>
In-Reply-To: <20230527164452.64797-2-contact@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 11:04:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfeF9jttu7K5C1CMqb+wsGY5z3GzNaFzdQLWbOrgqicQ@mail.gmail.com>
Message-ID: <CAMuHMdXfeF9jttu7K5C1CMqb+wsGY5z3GzNaFzdQLWbOrgqicQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sh: dma: Fix dma channel offset calculation
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 6:45 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> Various SoCs of the SH3, SH4 and SH4A family, which use this driver,
> feature a differing number of DMA channels, which can be distributed
> between up to two DMAC modules. Existing implementation fails to
> correctly accommodate for all those variations, resulting in wrong
> channel offset calculations and leading to kernel panics.
>
> Rewrite dma_base_addr() in order to properly calculate channel offsets
> in a DMAC module. Fix dmaor_read_reg() and dmaor_write_reg(), so that
> the correct DMAC module base is selected for the DMAOR register.
>
> Fixes: 7f47c7189b3e8f19 ("sh: dma: More legacy cpu dma chainsawing.")
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> v2: also handle differing numbers of DMAC modules and channels

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
