Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFC72597D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbjFGJGR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbjFGJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:05:40 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF91725;
        Wed,  7 Jun 2023 02:05:14 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-565cdb77b01so75292037b3.0;
        Wed, 07 Jun 2023 02:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128713; x=1688720713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E422pSWL3ak6KdRHBbqkZaT44vzRnDyfnzTSQCDwJNI=;
        b=FTSZNvdUSA2Mi4EiP2S5bT5qcLHNBj82BdV4YxFzqMP45qXO8w4AYGjNFXdNtkhiBA
         9t1F/GX//KZqSN+lS+p26o0D1e7dMPOW+Mz22ByNapH36bhWPPND3qDHRf4IZK2VLkYv
         qfqBsm1ZtMZ7Zn/Vjhr1ICp9FSYbQJMRI8MVj6Nz11wz993p+ghuvhVgN+igLmTlAyiA
         DwioYewbolvTC1EWIOMfhaZXNbcK+CljIuGpsgduBlx68b4PnJUcnk23Otgt22mZgetZ
         OLm/uGHHBCUq9xlCQr7Mg+8VSsV5RcqVriZbk4k55f33gjwcaSMHqcugJMFwehm0fwdH
         Pzhw==
X-Gm-Message-State: AC+VfDziq2igMD9Dka5YkOP+LcnQkkJxCfdHzFiYim/fO55oCmADum5j
        XneEmY9C54b8idrgxgDwpwAeWiaUHZXpeg==
X-Google-Smtp-Source: ACHHUZ7yodeTt/O+VkPe7iBcY4Od3RWmqfB6ntLg9rUTEyobthgtasbctpaVGiuDI7MYHC0ciUp67Q==
X-Received: by 2002:a81:7cd4:0:b0:54f:8b56:bb3 with SMTP id x203-20020a817cd4000000b0054f8b560bb3mr4870829ywc.5.1686128713065;
        Wed, 07 Jun 2023 02:05:13 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id y141-20020a0dd693000000b00562b8c7edf0sm4705393ywd.51.2023.06.07.02.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:05:12 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so8335935276.3;
        Wed, 07 Jun 2023 02:05:12 -0700 (PDT)
X-Received: by 2002:a25:ccc7:0:b0:bb4:204f:bb79 with SMTP id
 l190-20020a25ccc7000000b00bb4204fbb79mr2168697ybf.55.1686128712106; Wed, 07
 Jun 2023 02:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu> <20230527164452.64797-3-contact@artur-rojek.eu>
In-Reply-To: <20230527164452.64797-3-contact@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 11:05:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXe+R-OhC8LSupR8YUNXcebFQ+7nSDNFphdBn_K-owGyA@mail.gmail.com>
Message-ID: <CAMuHMdXe+R-OhC8LSupR8YUNXcebFQ+7nSDNFphdBn_K-owGyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sh: dma: Drop incorrect SH_DMAC_BASE1 for SH4
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
> None of the supported SH4 family SoCs features a second DMAC module. As
> this define negatively impacts DMA channel calculation for the above
> targets, remove it from the code.
>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>
> v2: new patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
