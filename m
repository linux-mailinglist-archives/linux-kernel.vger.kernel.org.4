Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390885E7998
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIWLa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIWLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:30:20 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD946F2762
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:30:19 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 3so8019179qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vgb4KaCMBS26tk8RsPqB4bluO87s7au7hKeumOGx9zw=;
        b=FE7baU4G8GkMwOlLVa+RWhGY4ZJTJBmrT2wB88q4q9h8qsnnhEJKpnLt/O7v3m5GCV
         urZvFTLsjVJ+twPXrdl9dvNPApQ0sLsbv46fBXGiPMo+PvnhCHMBTkwXh6wbErxq/ExX
         koRBGoj3XyYOKEE6s/9kifzoO9dl9VFQghpohHUQbvY82X6eqpOU+ujJIP8wZpmWwcVv
         Bl0pyS9JhDOQDYReN4xqz9QCztaWMrwrUuTm2x6Mw9WR06V7Ho9v/CRQHm01f9WceVDW
         ukRMwZ2sHzZKL6AHT57dr9HexGybo1vk5fOh2rCfSJrlPfb4PUj63WH2KR9/9EPaIPrS
         lBOA==
X-Gm-Message-State: ACrzQf0RpFNHODOTJzXNjpJ6F95oDYmCqvMk5Uzd6LdR8R3JwnNUMTuM
        2PAHcnlkL1p+aCGE7l8MLqXZYkFBWlovbw==
X-Google-Smtp-Source: AMsMyM6lwfPW3kH4rfsqYLlrOX0UDdU0gVc7zwvso/DCND/jogcjPgc+ypW3djvtaYif+jzoAOHQ5w==
X-Received: by 2002:a05:620a:108d:b0:6ce:612b:7075 with SMTP id g13-20020a05620a108d00b006ce612b7075mr5180121qkk.162.1663932618671;
        Fri, 23 Sep 2022 04:30:18 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id d21-20020ac84e35000000b00359961365f1sm5402167qtw.68.2022.09.23.04.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:30:18 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id c9so16696490ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:30:18 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr8165572ybl.604.1663932618054; Fri, 23
 Sep 2022 04:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
In-Reply-To: <20220921185208.3549140-2-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Sep 2022 13:30:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
Message-ID: <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Sep 21, 2022 at 8:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Rather than rebooting into a system with no entropy, regenerate the RNG
> seed before rebooting, so that the new system has a fresh seed.
>
> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for your patch!

> --- a/arch/m68k/virt/config.c
> +++ b/arch/m68k/virt/config.c
> @@ -45,10 +45,18 @@ static void virt_halt(void)
>                 ;
>  }
>
> +static struct bi_record *rng_seed_record;

This can be const...

> +
>  static void virt_reset(void)
>  {
>         void __iomem *base = (void __iomem *)virt_bi_data.ctrl.mmio;
>
> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
> +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
> +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> +               *(u16 *)rng_seed_record->data = len;

Wouldn't it be simpler to just use the existing length?

    if (rnd_seed_record) {
           u16 len = be16_to_cpup(data);
           get_random_bytes((u8 *)rng_seed_record->data + 2, len);
    }

However, I have my doubts this will actually work. Was this tested?
The bootinfo is passed from userspace, usually by reading
/proc/bootinfo, and adapting it where needed.
So I think you should implement this in kexec-tools instead.

> +       }
> +
>         iowrite32be(CMD_RESET, base + VIRT_CTRL_REG_CMD);
>         local_irq_disable();
>         while (1)
> @@ -101,6 +109,8 @@ int __init virt_parse_bootinfo(const struct bi_record *record)
>                  * length to prevent kexec from using it.
>                  */
>                 memzero_explicit((void *)data, len + 2);
> +                /* Store a reference to be filled in on reboot. */
> +               rng_seed_record = (void *)record;

... so this cast can be dropped.

>                 break;
>         }
>         default:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
