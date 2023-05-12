Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB370018F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjELHfF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 03:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbjELHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:35:02 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2930F4;
        Fri, 12 May 2023 00:35:00 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55dc3431c64so70410847b3.2;
        Fri, 12 May 2023 00:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683876899; x=1686468899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krHFF4VrQFF8ZdKbjFXoyE6dRQVVUTVc+JTNIgiYdP4=;
        b=Rm4u6bptwbpVEu7gAjRWPCStzRG7pFI+1Ct33NT5gAgMt9NuFcdxldneWeEJdQjluA
         QLcHRCO7Ys7T7Fn+FL8LA6GVQv9MX+r+6kkHfxKJxpMftYpQ1OBgd/AFZWAI0yKt7InF
         Bn/d+HypRD8xb3KaOjRzP5owvayUbhpoo5puFbypkg0tAXEt6bQeSb0znqanD20I6uCE
         gba4+9QBNtEUYSdRUmpUV+djc+s+Gk95WlWp3Rr01zrP/sVF3/pVnZ8a/3Z6UY36CF2U
         bKVNoeshMWLF+Thr4JISoVPusHGj51DdxnCtK8b19HxwFSBJyA+zBI0V/AWTbrzBsOhz
         Regg==
X-Gm-Message-State: AC+VfDxPbiOAdsJf6SbvjAnQpX46DIXp+LXvA0RVWQ9f7N5Y8Q4jR8ME
        UMok12mpOQrZS7xZ/r1NTIumvz75Sp1SaBEw
X-Google-Smtp-Source: ACHHUZ6G9iN1KeyQc9bDVbD81iB24r5gztRuhuN1/b3Nw0gqG/uj3uYtx/dxmJKyEwFzzroAwsWOtA==
X-Received: by 2002:a25:d68c:0:b0:ba7:1421:ce06 with SMTP id n134-20020a25d68c000000b00ba71421ce06mr625424ybg.49.1683876899170;
        Fri, 12 May 2023 00:34:59 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id p78-20020a25d851000000b00b9a63c60fefsm4972620ybg.31.2023.05.12.00.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:34:58 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-55dc3431c64so70410667b3.2;
        Fri, 12 May 2023 00:34:58 -0700 (PDT)
X-Received: by 2002:a05:6902:1892:b0:b72:4ca:b3ce with SMTP id
 cj18-20020a056902189200b00b7204cab3cemr28721655ybb.16.1683876898563; Fri, 12
 May 2023 00:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-3-contact@artur-rojek.eu> <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
 <079f78025bf0af7808951ff0b56393cff99d957b.camel@physik.fu-berlin.de>
In-Reply-To: <079f78025bf0af7808951ff0b56393cff99d957b.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 09:34:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD9kDqhaZsVO8sLMAxB0NX524y8e7m-3n=Bz+PALJJ7Q@mail.gmail.com>
Message-ID: <CAMuHMdVD9kDqhaZsVO8sLMAxB0NX524y8e7m-3n=Bz+PALJJ7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: dma: Correct the number of DMA channels in SH7709
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
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

Hi Adrian,

On Thu, May 11, 2023 at 10:20 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-05-08 at 12:55 +0200, Geert Uytterhoeven wrote:
> > On Sat, May 6, 2023 at 4:22 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> > > According to the PM, the DMAC found in SH7709 features only 4 channels.
> > >
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume we can't find a commit for the Fixes tag? Looking at the "git blame"
> for the Kconfig file, it seems the corresponding lines were changed before
> the source tree was imported into git in 1da177e4c3f4.

I don't think Fixes has much relevance, as the issue is present in all
LTS kernel versions that are still maintained.
The stable machinery AI will just pick it up, based on the word "correct" in
the description.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
