Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4A5EA89A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiIZOiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiIZOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:37:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA621C911
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC460B8094E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CFC433D6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:56:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TOoBxpWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664197002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpsGjfRrgHbI6FXm1QC1wO4wH3BrNOjl6qxJDhY9hn8=;
        b=TOoBxpWo5q7rp8p1KDLpsoZtUuV6erYMMrNKa3l+acbL0dwegmv1Ms3Bv2ciZzYm4e36OL
        lnyi1TvFgz1LjiVfi1dmeZ/Zy4+3boDUmLo/EI9+63K+VWCfu6os95YqGXNmZb8YMz4gPS
        SFcJI6vmdtlV2s1UEG2/TrVOPmwP/lA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 726c228e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 12:56:41 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id k14so3370306vkk.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:56:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf1L/OiYXEijrouCQOd3a/+PYc0X78ypsxX9AD08SxvetD1Qhr69
        raz/Bo6Smi4eoMc1D6JztbpsePmpYkv2l7qdgn0=
X-Google-Smtp-Source: AMsMyM5GyYQnypghoAoMENwLzvzPDZggGLaKRN/3EtOqw/XtKZXgDAoFaa1CN/2lGVtitZQESNXib8Vzgm1pIrLflmY=
X-Received: by 2002:a05:6122:91e:b0:3a2:e497:2484 with SMTP id
 j30-20020a056122091e00b003a2e4972484mr8060480vka.41.1664197000770; Mon, 26
 Sep 2022 05:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
 <eb798159-c003-3b43-c891-039080e06e03@vivier.eu> <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
 <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu>
In-Reply-To: <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 14:56:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
Message-ID: <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Hi Jason,
>
> Le 26/09/2022 =C3=A0 14:02, Jason A. Donenfeld a =C3=A9crit :
> > Hi Laurent,
> >
> > On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 23/09/2022 =C3=A0 14:50, Geert Uytterhoeven a =C3=A9crit :
> >>> Hi Jason,
> >>>
> >>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> =
wrote:
> >>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> >>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*r=
ng_seed_record) + 2) {
> >>>>>>>> +               u16 len =3D rng_seed_record->size - sizeof(*rng_=
seed_record) - 2;
> >>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2=
, len);
> >>>>>>>> +               *(u16 *)rng_seed_record->data =3D len;
> >>>>>
> >>>>> Storing the length should use the proper cpu_to_be16 accessor.
> >>>>
> >>>> Okay, I'll do that for v2.
> >>>>
> >>>> (Simply out of curiosity, why? Isn't m68k always big endian and this
> >>>> is arch/ code?)
> >>>
> >>> Yes it is.  But virt_parse_bootinfo() below already uses the right
> >>> accessor.
> >>>
> >>> BTW, I guess people thought the same about PowerPC?
> >>> Although I agree the probability of someone creating a little-endian
> >>> m68k clone in an FPGA or SkyWater project and trying to run Linux on
> >>> it quite low ;-)
> >>>
> >>>>>> The way I tested this is by having my initramfs just call
> >>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() pri=
nt
> >>>>>> its contents to the console. I checked that it was both present an=
d
> >>>>>> different every time.
> >>>>>
> >>>>> Are you sure the new kernel did receive the same randomness as prep=
ared
> >>>>> by get_random_bytes()? I would expect it to just reboot into qemu,
> >>>>> reload the kernel from disk, and recreate a new bootinfo from scrat=
ch,
> >>>>> including generating a new random seed.
> >>>>
> >>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed sta=
te.
> >>>
> >>> That's interesting.  So QEMU preserves the old bootinfo, which is
> >>> AFAIK not guaranteed to be still available (that's why I added
> >>> save_bootinfo()).  Perhaps that works because only memory starting
> >>> from a rounded-up value of _end will be used, and you're just lucky?
> >>> I'm wondering what else it preserves. It sure has to reload the
> >>> kernel image, as at least the data section will no longer contain the
> >>> initialization values after a reboot...
> >>>
> >>> Laurent?
> >>>
> >>
> >> In QEMU the loader makes a copy of the kernel and the initrd and this =
copy is restored on a reset.
> >>
> >> I don't think there is a mechanism in QEMU to save the BOOTINFO sectio=
n, so I think it works by
> >> luck. I will check.
> >>
> >> Thanks,
> >> Laurent
> >
> > Are you sure about that? Or at least, could you point me to where you
> > think this happens? I'm not as familiar as you with this code base,
> > but I really am not seeing it. So far as I can tell, on reset, the pc
> > and stack are reset to their initial places, after TCG resets the cpu
> > registers to a known state. But the kernel is not reloaded. The same
> > thing that was in memory before is used again.
>
> Yes, this is not clear in QEMU but I think this happens in rom_reset():
>
> hw/core/loader.c
>
> 1180         if (rom->mr) {
> 1181             void *host =3D memory_region_get_ram_ptr(rom->mr);
> 1182             memcpy(host, rom->data, rom->datasize);
> 1183             memset(host + rom->datasize, 0, rom->romsize - rom->data=
size);
> 1184         } else {
> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_U=
NSPECIFIED,
> 1186                                     rom->data, rom->datasize);
> 1187             address_space_set(rom->as, rom->addr + rom->datasize, 0,
> 1188                               rom->romsize - rom->datasize,
> 1189                               MEMTXATTRS_UNSPECIFIED);
> 1190         }
>
> kernel and initrd are loaded with load_elf() and load_image_targphys() on=
ly once at startup by the
> machine init function (virt_init()).
>
> rom_add_elf_program() adds the kernel to the ROM list
> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32() =
when SZ is 32...)
>
> rom_add_file() adds the initrd to the ROM list too.
>
> And ROMs are restored on reset from these copies by rom_reset().
>
> rom_reset() is registered as a reset handler with qemu_register_reset() b=
y
> rom_check_and_register_reset() at the end of the machine creation by qdev=
_machine_creation_done().
>
> So I think bootinfo are not restored because there is no such function ca=
lls. Perhaps they are saved
> and restaured if they are stored in address space of one of the previous =
registered ROM.

Ahh interesting, thanks for the explanation.

So from my debugging, bootinfo is *not* restored, and the previous one
appears to be used. Fortunately it's intact and everything works well
on a reboot.

With that in mind, we now we have to decide whether to:
A) Go with my linux patch to write the rng seed before rebooting (3/3
in v4 of that series).
B) Not go with the linux patch, but instead make sure bootinfo is
restored to its previous value, and then also register a qemu reboot
notifier to refresh the seed in it, like what x86 does.

(A) sounds a lot easier to me. Opinions?

Jason
