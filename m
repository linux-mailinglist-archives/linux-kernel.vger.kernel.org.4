Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6326FF48B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbjEKOgd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbjEKOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:36:16 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552B106D3;
        Thu, 11 May 2023 07:35:35 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55c939fb24dso81108037b3.2;
        Thu, 11 May 2023 07:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815734; x=1686407734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuNMFCCjBGiRepfEIV/kIi3+pDm4ryspV/CKvccFj/c=;
        b=A9h6pBfQVLkxeZ49T1NCNBgmT73VLkPkLC4+DxjgTlgofNzRABS7jTQ6mly3ue0hn0
         iR9XYeosBM9DZx2rMPul+AJqt2w6mJu/sle/9iJzWEvhwqIq+a9hZ+8vfR2w6qrtHLuz
         YXbd2T6JhjdH5I0Z8BhOCLCi5RcfmxU9eh6PkFk33gJ7fiBHvWRvteU7MZW6K3LNHuAT
         tDa1WL63Ihvn5Pp0zPAJDK9CIPb+9ha5017UmfiB3HJBX/IdBuyJBwHj06/EtAcG4Qlo
         GYa8RsdV08ZKF95GGF2Dndl5jF7k7cHC/zsLKlaO9DHwr77P+z2RT4tc0deAfqnwqp4h
         hjPw==
X-Gm-Message-State: AC+VfDzBf6GRyzKNZlzOoo0VuLQGO7xizHuGwdX9c60yVqcajY9aFRav
        2pEe8zJriIYeKEnOw4EIDfzG/qOWP15B7g==
X-Google-Smtp-Source: ACHHUZ6/C8pDovpD7gt6Gs1M2dYlDqlXiWHvDCgzxLsa2kwyqTH6w3Qt5/xioq9wI19aFyDfY0E2lg==
X-Received: by 2002:a0d:ddd7:0:b0:55a:4bd3:f73b with SMTP id g206-20020a0dddd7000000b0055a4bd3f73bmr24081601ywe.10.1683815734332;
        Thu, 11 May 2023 07:35:34 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id c74-20020a814e4d000000b00552f7767803sm4943160ywb.58.2023.05.11.07.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 07:35:34 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-55a8019379fso81280627b3.0;
        Thu, 11 May 2023 07:35:33 -0700 (PDT)
X-Received: by 2002:a0d:d90f:0:b0:55a:aeb7:2b0a with SMTP id
 b15-20020a0dd90f000000b0055aaeb72b0amr21601241ywe.23.1683815733695; Thu, 11
 May 2023 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 May 2023 16:35:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
Message-ID: <CAMuHMdXmtfCir4dt6CKe2YxDN53nNAcE=i5oyMkOsPavJ-p0Tw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, May 10, 2023 at 6:36 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> The initialization function for the J-Core AIC aic_irq_of_init() is
> currently missing the call to irq_alloc_descs() which allocates and
> initializes all the IRQ descriptors. Add missing function call and
> return the error code from irq_alloc_descs() in case the allocation
> fails.
>
> Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for your patch!

I am not an IRQ expert, so I'd like to leave the technical parts for
e.g. Marc.  But I think you should add to the description that this
is based on a patch by Rich.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
