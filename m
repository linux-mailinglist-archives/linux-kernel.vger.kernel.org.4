Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F395EA8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiIZOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiIZOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D913DCB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4BB6B8076A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E1C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:12:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ih5ffrph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664197933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eq8UZwmEEK3aBpCkedqZGcd9yizvPrerwUoO9AqakD8=;
        b=ih5ffrphEh0aJlrzbC5yX/dmt/4yuA1Z+tXKNtLy3Xb9pIDl3kmYlKyW9O/xaFOz1GqOw9
        U70yVGvs31ACpbdZjsFfxHVdhMpLl+iHjKPwqaV6zGvPmcQYXd8Ne9/Qp4cCGu+DMMY+sS
        1Bgc3bUwgII/zubUOs5Flqnhn/W7+Cw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 783e3007 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 13:12:13 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id o123so6507806vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:12:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf2TludazYn+tIDscteIa0j/uDSzdXKOKGfVzevbq9ULocq+Js9q
        7Wdw/9OHGY1XfDGC3xptZHtrB7IqdY7vpASyQ2U=
X-Google-Smtp-Source: AMsMyM6FRbwSR0my7EQz9DT3QP2B3fjecT7m1nwlYI+pXGzC+XhCFdKeEyNaTvRkr0C65amXbRHZ1nh1DaEJEi39xRU=
X-Received: by 2002:a67:d81e:0:b0:398:2c98:229b with SMTP id
 e30-20020a67d81e000000b003982c98229bmr8213051vsj.73.1664197932583; Mon, 26
 Sep 2022 06:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
 <eb798159-c003-3b43-c891-039080e06e03@vivier.eu> <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
 <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu> <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
 <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu> <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
 <de443669-dff9-a6e1-83cb-601fd1d93ddb@vivier.eu>
In-Reply-To: <de443669-dff9-a6e1-83cb-601fd1d93ddb@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 15:12:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9pRMqqsdzVVNu7XiF0gbm6Ah8tSqNRb8SWDtHnHhT4LZA@mail.gmail.com>
Message-ID: <CAHmME9pRMqqsdzVVNu7XiF0gbm6Ah8tSqNRb8SWDtHnHhT4LZA@mail.gmail.com>
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

On Mon, Sep 26, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 26/09/2022 =C3=A0 15:04, Jason A. Donenfeld a =C3=A9crit :
> > On Mon, Sep 26, 2022 at 3:02 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 26/09/2022 =C3=A0 14:56, Jason A. Donenfeld a =C3=A9crit :
> >>> Hi Laurent,
> >>>
> >>> On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wr=
ote:
> >>>>
> >>>> Hi Jason,
> >>>>
> >>>> Le 26/09/2022 =C3=A0 14:02, Jason A. Donenfeld a =C3=A9crit :
> >>>>> Hi Laurent,
> >>>>>
> >>>>> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> =
wrote:
> >>>>>>
> >>>>>> Le 23/09/2022 =C3=A0 14:50, Geert Uytterhoeven a =C3=A9crit :
> >>>>>>> Hi Jason,
> >>>>>>>
> >>>>>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.c=
om> wrote:
> >>>>>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> >>>>>>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeo=
f(*rng_seed_record) + 2) {
> >>>>>>>>>>>> +               u16 len =3D rng_seed_record->size - sizeof(*=
rng_seed_record) - 2;
> >>>>>>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data=
 + 2, len);
> >>>>>>>>>>>> +               *(u16 *)rng_seed_record->data =3D len;
> >>>>>>>>>
> >>>>>>>>> Storing the length should use the proper cpu_to_be16 accessor.
> >>>>>>>>
> >>>>>>>> Okay, I'll do that for v2.
> >>>>>>>>
> >>>>>>>> (Simply out of curiosity, why? Isn't m68k always big endian and =
this
> >>>>>>>> is arch/ code?)
> >>>>>>>
> >>>>>>> Yes it is.  But virt_parse_bootinfo() below already uses the righ=
t
> >>>>>>> accessor.
> >>>>>>>
> >>>>>>> BTW, I guess people thought the same about PowerPC?
> >>>>>>> Although I agree the probability of someone creating a little-end=
ian
> >>>>>>> m68k clone in an FPGA or SkyWater project and trying to run Linux=
 on
> >>>>>>> it quite low ;-)
> >>>>>>>
> >>>>>>>>>> The way I tested this is by having my initramfs just call
> >>>>>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness()=
 print
> >>>>>>>>>> its contents to the console. I checked that it was both presen=
t and
> >>>>>>>>>> different every time.
> >>>>>>>>>
> >>>>>>>>> Are you sure the new kernel did receive the same randomness as =
prepared
> >>>>>>>>> by get_random_bytes()? I would expect it to just reboot into qe=
mu,
> >>>>>>>>> reload the kernel from disk, and recreate a new bootinfo from s=
cratch,
> >>>>>>>>> including generating a new random seed.
> >>>>>>>>
> >>>>>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed=
 state.
> >>>>>>>
> >>>>>>> That's interesting.  So QEMU preserves the old bootinfo, which is
> >>>>>>> AFAIK not guaranteed to be still available (that's why I added
> >>>>>>> save_bootinfo()).  Perhaps that works because only memory startin=
g
> >>>>>>> from a rounded-up value of _end will be used, and you're just luc=
ky?
> >>>>>>> I'm wondering what else it preserves. It sure has to reload the
> >>>>>>> kernel image, as at least the data section will no longer contain=
 the
> >>>>>>> initialization values after a reboot...
> >>>>>>>
> >>>>>>> Laurent?
> >>>>>>>
> >>>>>>
> >>>>>> In QEMU the loader makes a copy of the kernel and the initrd and t=
his copy is restored on a reset.
> >>>>>>
> >>>>>> I don't think there is a mechanism in QEMU to save the BOOTINFO se=
ction, so I think it works by
> >>>>>> luck. I will check.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Laurent
> >>>>>
> >>>>> Are you sure about that? Or at least, could you point me to where y=
ou
> >>>>> think this happens? I'm not as familiar as you with this code base,
> >>>>> but I really am not seeing it. So far as I can tell, on reset, the =
pc
> >>>>> and stack are reset to their initial places, after TCG resets the c=
pu
> >>>>> registers to a known state. But the kernel is not reloaded. The sam=
e
> >>>>> thing that was in memory before is used again.
> >>>>
> >>>> Yes, this is not clear in QEMU but I think this happens in rom_reset=
():
> >>>>
> >>>> hw/core/loader.c
> >>>>
> >>>> 1180         if (rom->mr) {
> >>>> 1181             void *host =3D memory_region_get_ram_ptr(rom->mr);
> >>>> 1182             memcpy(host, rom->data, rom->datasize);
> >>>> 1183             memset(host + rom->datasize, 0, rom->romsize - rom-=
>datasize);
> >>>> 1184         } else {
> >>>> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXAT=
TRS_UNSPECIFIED,
> >>>> 1186                                     rom->data, rom->datasize);
> >>>> 1187             address_space_set(rom->as, rom->addr + rom->datasiz=
e, 0,
> >>>> 1188                               rom->romsize - rom->datasize,
> >>>> 1189                               MEMTXATTRS_UNSPECIFIED);
> >>>> 1190         }
> >>>>
> >>>> kernel and initrd are loaded with load_elf() and load_image_targphys=
() only once at startup by the
> >>>> machine init function (virt_init()).
> >>>>
> >>>> rom_add_elf_program() adds the kernel to the ROM list
> >>>> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf=
32() when SZ is 32...)
> >>>>
> >>>> rom_add_file() adds the initrd to the ROM list too.
> >>>>
> >>>> And ROMs are restored on reset from these copies by rom_reset().
> >>>>
> >>>> rom_reset() is registered as a reset handler with qemu_register_rese=
t() by
> >>>> rom_check_and_register_reset() at the end of the machine creation by=
 qdev_machine_creation_done().
> >>>>
> >>>> So I think bootinfo are not restored because there is no such functi=
on calls. Perhaps they are saved
> >>>> and restaured if they are stored in address space of one of the prev=
ious registered ROM.
> >>>
> >>> Ahh interesting, thanks for the explanation.
> >>>
> >>> So from my debugging, bootinfo is *not* restored, and the previous on=
e
> >>> appears to be used. Fortunately it's intact and everything works well
> >>> on a reboot.
> >>>
> >>> With that in mind, we now we have to decide whether to:
> >>> A) Go with my linux patch to write the rng seed before rebooting (3/3
> >>> in v4 of that series).
> >>> B) Not go with the linux patch, but instead make sure bootinfo is
> >>> restored to its previous value, and then also register a qemu reboot
> >>> notifier to refresh the seed in it, like what x86 does.
> >>>
> >>
> >> I prefer B :)
> >> It's cleaner and under QEMU control.
> >
> > Okay. I'm happy to follow your preference. Just one last question,
> > though: is this what happens on baremetal bootloaders too? Or does no
> > such thing really exist so it doesn't matter?
>
> With a baremetal bootloader information are provided by the firmware.
>
> In our case, we don't have bootloader nor firmware as the kernel is loade=
d and started by QEMU.
> So QEMU must do the bootloader and the firmware actions. It's why I prefe=
r B.

Okay, so on reboot, control goes back to firmware, which then supplies
fresh arguments and such. So QEMU should do the same. Makes sense.

Jason
