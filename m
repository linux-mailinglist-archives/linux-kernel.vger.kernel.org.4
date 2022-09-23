Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B765E7ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiIWMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiIWMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73BEDD0A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D720B61200
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E6C433D7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:26:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T5ep2L9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663936008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXusBGFAsMKquMe9re/2GvZ6wLv7vVurNIKZnqYB1mg=;
        b=T5ep2L9mcaf+4ctPGdi9I+C+9jfPlpykDPbXDhoe6YVdaGSsEHph62E5r9xkI1atl8Ztno
        XPL76/E4WZRdHLXCAIeLNZwx1x8ZA+lo93HITWbzSV+DfU35dMzXJ7dhghwcS8VWftcUx6
        Q+SKnZzSB4bhMVDinDiP2vkphr6T4Bs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e3aced8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 12:26:48 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id p4so13485391vsa.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:26:48 -0700 (PDT)
X-Gm-Message-State: ACrzQf1RMI2rdZNv+00r+TIf8F7F5ZN5B5iCrL7RC4IjwAFYYJjlyUF3
        RsAJLCQlPS3Ccv+bEkQ4qvWDTJ1ucN52Rf/HphY=
X-Google-Smtp-Source: AMsMyM5du5nwiIFPkjCC66fKPLWxyTLwx7a+nWFOZ790a7nzExdXnb4iF4ivoVOEDv+BjKXiYUF+FsOF09cNvDcr5x0=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr3114043vsv.70.1663936007655; Fri, 23 Sep
 2022 05:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com> <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
In-Reply-To: <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 14:26:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
Message-ID: <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
> > > > +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
> > > > +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
> > > > +               *(u16 *)rng_seed_record->data = len;
>
> Storing the length should use the proper cpu_to_be16 accessor.

Okay, I'll do that for v2.

(Simply out of curiosity, why? Isn't m68k always big endian and this
is arch/ code?)

> > The way I tested this is by having my initramfs just call
> > `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
> > its contents to the console. I checked that it was both present and
> > different every time.
>
> Are you sure the new kernel did receive the same randomness as prepared
> by get_random_bytes()? I would expect it to just reboot into qemu,
> reload the kernel from disk, and recreate a new bootinfo from scratch,
> including generating a new random seed.

Yes I'm sure. Without this patch, the new kernel sees the zeroed state.

Jason
