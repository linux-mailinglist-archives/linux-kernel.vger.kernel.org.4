Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D537A5E9EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiIZKJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiIZKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:08:50 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59C38441
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:08:49 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id j8so3973324qvt.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wQTsHrE4DrjLcABGfj6LEXsJg7Ql+9uK2OtUgcnTbVA=;
        b=fl3E7AiGR22uKfRRWJ4v0CUZ3TDHXkT61mOrtnF8twNCamygu3vfPoQHmZuDJk+elG
         qdNQGFDJgI1xAVWDe5mT3h0Uf9IjaHYuYwAPzGbzl0erY4aQm4FGuGn5O+l3cqxLKlXN
         Zv6rI2/483VEoM+SIflJsc5MrxurVguqdZ72QWk3SkZ7eOZ7U+wrEca2PSVffq8KKSgD
         1TgVDljzXuw495iT9rvsU2crlErk/nsdDWB18UKD0Zi8hUCSGguiwboWhoX6EpZI975f
         ro4Ydu0wzL2uVUdhDso3bBMreIbxxh8/L/IY9CL3bEb6t1Wj8EETh5ICVYyRXwwB9IrP
         hgRA==
X-Gm-Message-State: ACrzQf0FLt3EQCDb98/Lxy/TcwSR+O0YbLK9zy7zUu46yUvlRgS+bGWT
        t9R7jgCwU3S/p9HLf+bllZZBeM86l44olQ==
X-Google-Smtp-Source: AMsMyM67oP8g7ejQy7pboX8fB9P7zH6QiwxCpwKKKAvLlVD5HZ34jLsP/KyOCETWxdKnYENyWoIgsA==
X-Received: by 2002:a05:6214:2589:b0:4af:7db6:2a4e with SMTP id fq9-20020a056214258900b004af7db62a4emr328057qvb.116.1664186928493;
        Mon, 26 Sep 2022 03:08:48 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id f26-20020a05620a069a00b006cebda00630sm10747418qkh.60.2022.09.26.03.08.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:08:48 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-324ec5a9e97so63125437b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:08:48 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:344:fca5:9b44 with SMTP id
 g9-20020a0ddd09000000b00344fca59b44mr19683884ywe.358.1664186928023; Mon, 26
 Sep 2022 03:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170340.4099226-1-Jason@zx2c4.com> <CAMuHMdVJoocGUugnhv=pbgu7z6MFexmRGH1JkQCjm9g-=HiowQ@mail.gmail.com>
 <CAHmME9qnsaUq4PvXM-BW63B=gvgzR3gV6zszEy2VFgzCx=B=wQ@mail.gmail.com>
In-Reply-To: <CAHmME9qnsaUq4PvXM-BW63B=gvgzR3gV6zszEy2VFgzCx=B=wQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 12:08:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsFQC6RKbYO2x+9esf_j6H7ySJhQ6yPocf9feJRN4b2w@mail.gmail.com>
Message-ID: <CAMuHMdVsFQC6RKbYO2x+9esf_j6H7ySJhQ6yPocf9feJRN4b2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: process bootinfo records before saving them
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

On Mon, Sep 26, 2022 at 12:06 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On 9/26/22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Sep 23, 2022 at 7:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >> The RNG seed boot record is memzeroed after processing, in order to
> >> preserve forward secrecy. By saving the bootinfo for procfs prior to
> >> that, forward secrecy is violated, since it becomes possible to recover
> >> past states. So, save the bootinfo block only after first processing
> >> them.
> >>
> >> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> >> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for the review.
>
> Did you intend to take these 3 patches through your m68k tree, or did
> you want me to take them for some reason instead?

This is all TBD, see the comments I'm writing on the other patches ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
