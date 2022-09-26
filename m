Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5165EA1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiIZKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiIZKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:50:39 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF958DFA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:27:27 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id i15so4033154qvp.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wvCseJKa4wntAVz+3aizGq2aXDX4B8OJZy0Gi3dyPRI=;
        b=ODWMZy8ZSbgmcQGjz9qsusG03Kr61jRyOvAYlPec7ntWGid2DPB6vQoaLDWHJfvtA1
         W0HNn0//+dQlHZ20XvFetP8rWlba0iSytJqWbYR4LP7SYwXzRy/VItlK3zfustNbgd8H
         5PTD3LykFpaJScOw8/DcJYJMbdwWGaANd62vjphgrkMO8nNbtjedgAkY5KWwjizvktTV
         E3dEaoNlwqxi7+AEfXTzXCqDr2Rj/GboCUTX0r5pxdkhfuZCYREv731CsmkLNhilB5Ux
         /GmhkN0mdgfz5dkPNs1ZYmNkqRFf6D9TCHUkBeGZAf5aLn0gP770pBLvu4QQ2bM0k2ko
         oOhQ==
X-Gm-Message-State: ACrzQf2HjJE/t6Ztogc9fngK7Peam6+xqnh563561O2qLKPSWEiURHjF
        cPwwhTnWNChUCAUAzH1oi8omIhXWdkDI6A==
X-Google-Smtp-Source: AMsMyM77IlXbBKNImx64H7qpuLlitne3bqi2ZjBNruPZz/LnkzAdD406sK/uxGE5ZvActk8OFR/ljA==
X-Received: by 2002:a0c:e888:0:b0:4aa:a307:4dca with SMTP id b8-20020a0ce888000000b004aaa3074dcamr16095672qvo.91.1664188045826;
        Mon, 26 Sep 2022 03:27:25 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006bb0f9b89cfsm11104301qkb.87.2022.09.26.03.27.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:27:25 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3457bc84d53so64255357b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:27:25 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr19158627yww.502.1664188045078; Mon, 26
 Sep 2022 03:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170340.4099226-1-Jason@zx2c4.com> <20220923170340.4099226-3-Jason@zx2c4.com>
In-Reply-To: <20220923170340.4099226-3-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 12:27:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPcXq_F0dQdJ5nV2io1eDhJs7BZf+TmXWPqGVn9xeLNA@mail.gmail.com>
Message-ID: <CAMuHMdXPcXq_F0dQdJ5nV2io1eDhJs7BZf+TmXWPqGVn9xeLNA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
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

On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This is useful on !virt platforms for kexec, so change things from
> BI_VIRT_RNG_SEED to be BI_RNG_SEED, and simply remove BI_VIRT_RNG_SEED
> because it only ever lasted one release, and nothing is broken by not
> having it. At the same time, keep a comment noting that it's been
> removed, so that ID isn't reused.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

The approach LGTM, but given my doubts on [PATCH v3 2/3], I think this
patch should be moved up, to not depend on [2/3].

> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> @@ -13,13 +13,8 @@
>  #define BI_VIRT_VIRTIO_BASE    0x8004
>  #define BI_VIRT_CTRL_BASE      0x8005
>
> -/*
> - * A random seed used to initialize the RNG. Record format:
> - *
> - *   - length       [ 2 bytes, 16-bit big endian ]
> - *   - seed data    [ `length` bytes, padded to preserve 2-byte alignment ]
> - */
> -#define BI_VIRT_RNG_SEED       0x8006
> +/* No longer used -- replaced with BI_RNG_SEED -- but don't reuse this index:
> + *     #define BI_VIRT_RNG_SEED        0x8006 */

Please drop the space before TAB.

> --- a/arch/m68k/include/uapi/asm/bootinfo.h
> +++ b/arch/m68k/include/uapi/asm/bootinfo.h
> @@ -64,7 +64,13 @@ struct mem_info {
>                                         /* (struct mem_info) */
>  #define BI_COMMAND_LINE                0x0007  /* kernel command line parameters */
>                                         /* (string) */
> -
> +/*
> + * A random seed used to initialize the RNG. Record format:
> + *
> + *   - length       [ 2 bytes, 16-bit big endian ]
> + *   - seed data    [ `length` bytes, padded to preserve 2-byte alignment ]

While experimenting, I noticed this must actually be a 4-byte alignment,
as data[] is an integral multiple of __be32 words:

    struct bi_record {
            __be16 tag;                     /* tag ID */
            __be16 size;                    /* size of record (in bytes) */
            __be32 data[];                  /* data */
    };

m68kboot[1] and kexec-boot[2] do implement the correct rounding,
but qemu's BOOTINFOSTR()[3] and BOOTINFODATA()[4] do not.
Sorry for missing that before, I guess I was misled by the existing
bug in BOOTINFOSTR().

Consequently, both kexec-tools[5] and the m68k-bootinfo tool[6] cannot
parse /proc/bootinfo if the size is not a multiple of 4, which can
easily be triggered by changing the command line of the m68k virt
machine.

> + */
> +#define BI_RNG_SEED            0x0008
>
>      /*
>       *  Linux/m68k Architectures (BI_MACHTYPE)

[1] https://github.com/geertu/m68kboot/blob/master/common/bootinf.c#L171
[2] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/arch/m68k/bootinfo.c#n60
[3] https://git.qemu.org/?p=qemu.git;a=blob;f=hw/m68k/bootinfo.h;h=bd8b212fd35ce216917e07eb67783b5b69f1e11b;hb=HEAD#l57
[4] https://git.qemu.org/?p=qemu.git;a=blob;f=hw/m68k/bootinfo.h;h=bd8b212fd35ce216917e07eb67783b5b69f1e11b;hb=HEAD#l73
[5] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/arch/m68k/bootinfo.c#n106
[6] https://github.com/geertu/m68k-bootinfo/blob/master/m68k-bootinfo.c#L466

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
