Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE45EA7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiIZN7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiIZN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA771FD8B2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73DD460B55
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C40EC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:02:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LiEuZy9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664193759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkFtIoUdR315WEH9/7niaUp6HiVQkpvQMuCb+rqRTTw=;
        b=LiEuZy9+MEEaX3pxgawv57Y1kLtilQQqzNqD8c2vBGk1yVqfyDull4PK2nd/31msm88pMp
        5pXCie5Ra7l1HH0TtUGi1Y6RG2qstrDCmPNSCp+ws9nTGZPN2ngxAd/D0jS2DuF+Cb9NxA
        kAoqNfNkoTX7bGhO3lNeUguDkXgT06A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5a640f04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 12:02:39 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id d187so6290944vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:02:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf1eQL+zPCJtQFIAT86SHg7dbBI3lGgm7f0KEDsYKasRLN480ZS7
        Ne/IvJhod+bbnEsUOqFpW0z5hHr6MwIaP6/8utA=
X-Google-Smtp-Source: AMsMyM4tjUxATVB54T/+nve/OPb0asHi6DUacBhJA49DCRB+qTWJY6A6o724lYZk8UZHJ7q6us+uim++ZIieCLtu8iI=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr7859616vsv.70.1664193758563; Mon, 26 Sep
 2022 05:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com> <eb798159-c003-3b43-c891-039080e06e03@vivier.eu>
In-Reply-To: <eb798159-c003-3b43-c891-039080e06e03@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 14:02:27 +0200
X-Gmail-Original-Message-ID: <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
Message-ID: <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 23/09/2022 =C3=A0 14:50, Geert Uytterhoeven a =C3=A9crit :
> > Hi Jason,
> >
> > On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wr=
ote:
> >> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.o=
rg> wrote:
> >>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng=
_seed_record) + 2) {
> >>>>>> +               u16 len =3D rng_seed_record->size - sizeof(*rng_se=
ed_record) - 2;
> >>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2, =
len);
> >>>>>> +               *(u16 *)rng_seed_record->data =3D len;
> >>>
> >>> Storing the length should use the proper cpu_to_be16 accessor.
> >>
> >> Okay, I'll do that for v2.
> >>
> >> (Simply out of curiosity, why? Isn't m68k always big endian and this
> >> is arch/ code?)
> >
> > Yes it is.  But virt_parse_bootinfo() below already uses the right
> > accessor.
> >
> > BTW, I guess people thought the same about PowerPC?
> > Although I agree the probability of someone creating a little-endian
> > m68k clone in an FPGA or SkyWater project and trying to run Linux on
> > it quite low ;-)
> >
> >>>> The way I tested this is by having my initramfs just call
> >>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
> >>>> its contents to the console. I checked that it was both present and
> >>>> different every time.
> >>>
> >>> Are you sure the new kernel did receive the same randomness as prepar=
ed
> >>> by get_random_bytes()? I would expect it to just reboot into qemu,
> >>> reload the kernel from disk, and recreate a new bootinfo from scratch=
,
> >>> including generating a new random seed.
> >>
> >> Yes I'm sure. Without this patch, the new kernel sees the zeroed state=
.
> >
> > That's interesting.  So QEMU preserves the old bootinfo, which is
> > AFAIK not guaranteed to be still available (that's why I added
> > save_bootinfo()).  Perhaps that works because only memory starting
> > from a rounded-up value of _end will be used, and you're just lucky?
> > I'm wondering what else it preserves. It sure has to reload the
> > kernel image, as at least the data section will no longer contain the
> > initialization values after a reboot...
> >
> > Laurent?
> >
>
> In QEMU the loader makes a copy of the kernel and the initrd and this cop=
y is restored on a reset.
>
> I don't think there is a mechanism in QEMU to save the BOOTINFO section, =
so I think it works by
> luck. I will check.
>
> Thanks,
> Laurent

Are you sure about that? Or at least, could you point me to where you
think this happens? I'm not as familiar as you with this code base,
but I really am not seeing it. So far as I can tell, on reset, the pc
and stack are reset to their initial places, after TCG resets the cpu
registers to a known state. But the kernel is not reloaded. The same
thing that was in memory before is used again.

Jason
