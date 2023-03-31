Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E5C6D2669
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCaRIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCaRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:08:52 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36851165F;
        Fri, 31 Mar 2023 10:08:50 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id ay14so16598885uab.13;
        Fri, 31 Mar 2023 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680282530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f9hvPbwazZj7iAbvz4qZSnw0iLYPbMcB3zPpVsb/2s=;
        b=mbqJk3P013xVQ8qjsNa2dvVxExDh1nFS41sT3qvat35ZaurrTVLDR21JPkrG+NcgIF
         NvnmkAWNlP7+9ffzqeEPpmhvSF6ePHq55su1MBdpk4zg0vpiPd9w9KXsbZE/UVtwaN7r
         94vBTjj/i3YFE8Ut8gRhfoq1tX9KRRgDxobyZm2SCA3KubLSrQq54pB/Noo9C3Yjhkkd
         KoJQUiwnU3rg0hAP21Eu4kBLuIDhnZE3QhfVj0btYX+b2+ZdICaXAZO6IdPGzscqSUst
         +ruKE4ZtGaPxeI5diXvmRjEFXcc8jxrmzQXxLgSdEHEH/f3lmyzf34omVG+AG5ohRPrt
         7LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f9hvPbwazZj7iAbvz4qZSnw0iLYPbMcB3zPpVsb/2s=;
        b=CUAq+fDhsUzZHu/e3tZQFkFzEqx3VQKa+ys3AwR8b4fKng6+mzS5ht+rwNBX2z3aIa
         bC0PB3yyU2cpLw4apUvjlpFFU2mDDaNGgyyoTCylAdDj3rHQ14EcB2ysmohc+3t7m6Gg
         w9J9IwPVox7Q5k4O5bLCFC/G5CmItS0D11QeC7Jgo+sxVN7tlNDEnxgpg0VAC9lrwQR5
         u1tD2Zey2WxKE17A42rRsGycS0ihWvCCQY4mdBneXAynRSFpra5ZLDcsFVpeiLram75u
         DCaM0zcoZblJZhWewgjSKkZo6mk8toIWp9IY/F/t3BhdTTmGlj4YVtimoCzrQiMRzCXP
         6XOQ==
X-Gm-Message-State: AAQBX9cN5hH6OlbmtHxjIduNqFihu++kA0Xd6TozwDwq26ZA/fGBCsta
        alrCSQLG3157XN0Zs7TgmNd1AaPYTTIp7jURfnp41mml/C8=
X-Google-Smtp-Source: AKy350b8o3pIupL+AI+Fs4vUU+n6/HN7G5reGAUsP5qFvBBhS3fCC+ykpypAyAAimqMMwVlVe35mKAEBUH+fT3yGU2E=
X-Received: by 2002:a1f:9043:0:b0:433:7ae0:6045 with SMTP id
 s64-20020a1f9043000000b004337ae06045mr14960110vkd.0.1680282529864; Fri, 31
 Mar 2023 10:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
 <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
In-Reply-To: <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
From:   jim.cromie@gmail.com
Date:   Fri, 31 Mar 2023 11:08:23 -0600
Message-ID: <CAJfuBxwng_fB5XH5LEWAWwN29fitGLBZ8hpdW3+4HjO_MDK1Eg@mail.gmail.com>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with module_memory")
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 1:00=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> > hi Luis, etal
> >
> > kmemleak is reporting 19 leaks during boot
> >
> > because the hexdumps appeared to have module-names,
> > and Ive been hacking nearby, and see the same names
> > every time I boot my test-vm, I needed a clearer picture
> > Jason corroborated and bisected.
> >
> > the 19 leaks split into 2 groups,
> > 9 with names of builtin modules in the hexdump,
> > all with the same backtrace
> > 9 without module-names (with a shared backtrace)
> > +1 wo name-ish and a separate backtrace
>
> Song, please take a look.
>
> Thanks for the report Jim, what kernel are you on exactly?
>
>   Luis

:#> uptime
 09:45:32 up 1 day, 23:07,  0 users,  load average: 0.07, 0.04, 0.01
:#> uname -a
Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux

the leaks I sent previously might be from/on a different commit,
heres the relevant one

fwiw, the config is unremarkable.  it started with
CONFIG_BUILD_SALT=3D"5.16.8-200.fc35.x86_64"
then `make localmodconfig` to drop anything I dont have hw for
then `virtme-configkernel --update` to pick up the 9p,etc config options
And some extra DEBUG_* options
If you'd like to see runs with others, or see the config itself, please ask=
.

:#> uname -a
Linux (none) 6.3.0-rc1-f2-00001-gac3b43283923 #359 SMP PREEMPT_DYNAMIC
Wed Mar 29 09:33:11 MDT 2023 x86_64 x86_64 x86_64 GNU/Linux
:#> ./grok_kmemleak -n
not: bless( {
  'backtraces' =3D> {
    '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
    [<00000000a2f80203>] memdup_user+0x26/0x90
    [<00000000f7cd3624>] strndup_user+0x3f/0x60
    [<0000000098fd26c5>] load_module+0x188b/0x20e0
    [<0000000074361279>] __do_sys_finit_module+0x93/0xf0
    [<000000004caeb948>] do_syscall_64+0x34/0x80
    [<000000009f5d036c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D> 16,
    '[<0000000094c136c3>] kmalloc_trace+0x26/0x90
    [<00000000700fd414>] resolve_symbol+0x2a5/0x3a0
    [<000000001dd9228b>] load_module+0x1465/0x20e0
    [<0000000074361279>] __do_sys_finit_module+0x93/0xf0
    [<000000004caeb948>] do_syscall_64+0x34/0x80
    [<000000009f5d036c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D> 3
  },
  'hexdumps' =3D> {
    '00 b3 af 5a de 87 df 17                          ...Z....' =3D> 1,
    '00 b6 af 5a de 87 d8 cf                          ...Z....' =3D> 1,
    '00 b7 af 5a de 87 d5 77                          ...Z...w' =3D> 1,
    '00 c8 b9 5a de 91 a2 2f                          ...Z.../' =3D> 1,
    '00 ca b9 5a de 91 a6 3f                          ...Z...?' =3D> 1,
    '00 cf b9 5a de 91 a2 07                          ...Z....' =3D> 1,
    '00 e0 4c 56 d2 64 8b 77                          ..LV.d.w' =3D> 1,
    '00 e0 f2 59 dd da 85 7f                          ...Y....' =3D> 1,
    '00 e3 4c 56 d2 64 89 1f                          ..LV.d..' =3D> 1,
    '00 e4 f2 59 dd da 8f 4f                          ...Y...O' =3D> 1,
    '00 e5 4c 56 d2 64 87 bf                          ..LV.d..' =3D> 1,
    '00 e6 f2 59 dd da 89 57                          ...Y...W' =3D> 1,
    '00 e8 f2 59 dd da 83 17                          ...Y....' =3D> 1,
    '00 e9 4c 56 d2 64 8e df                          ..LV.d..' =3D> 1,
    '00 eb 4c 56 d2 64 80 67                          ..LV.d.g' =3D> 1,
    '00 ec 4c 56 d2 64 8f 7f                          ..LV.d..' =3D> 1,
    '40 d4 1c 08 80 88 ff ff 88 99 37 c0 ff ff ff ff  @.........7.....' =3D=
> 1,
    '88 99 37 c0 ff ff ff ff 40 09 e8 13 80 88 ff ff  ..7.....@.......' =3D=
> 1,
    'c8 8a 23 c0 ff ff ff ff c8 8a 23 c0 ff ff ff ff  ..#.......#.....' =3D=
> 1
  },
  'users' =3D> {
    'comm "(udev-worker)", pid 219,' =3D> 1,
    'comm "(udev-worker)", pid 221,' =3D> 4,
    'comm "(udev-worker)", pid 224,' =3D> 3,
    'comm "(udev-worker)", pid 229,' =3D> 1,
    'comm "(udev-worker)", pid 230,' =3D> 1,
    'comm "modprobe", pid 728,' =3D> 1,
    'comm "modprobe", pid 814,' =3D> 1,
    'comm "modprobe", pid 825,' =3D> 4,
    'comm "modprobe", pid 832,' =3D> 1,
    'comm "modprobe", pid 835,' =3D> 2
  }
}, 'LeakSet' )
mods: bless( {
  'backtraces' =3D> {
    '[<0000000058fb276d>] __kmalloc_node_track_caller+0x4a/0x140
    [<00000000ab7b01fd>] kstrdup+0x32/0x60
    [<000000005ed25b98>] kobject_set_name_vargs+0x1c/0x90
    [<0000000090fe19ca>] kobject_init_and_add+0x4d/0x90
    [<0000000045666935>] mod_sysfs_setup+0xa9/0x6e0
    [<00000000d6f7187b>] load_module+0x1de3/0x20e0
    [<0000000074361279>] __do_sys_finit_module+0x93/0xf0
    [<000000004caeb948>] do_syscall_64+0x34/0x80
    [<000000009f5d036c>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' =3D> 16
  },
  'hexdumps' =3D> {
    '63 65 63 00 d2 64 80 7f                          cec..d..' =3D> 1,
    '63 72 63 33 32 5f 70 63 6c 6d 75 6c 00 24 14 48  crc32_pclmul.$.H' =3D=
> 1,
    '63 72 63 33 32 63 5f 69 6e 74 65 6c 00 a7 e0 f8  crc32c_intel....' =3D=
> 1,
    '63 72 63 74 31 30 64 69 66 5f 70 63 6c 6d 75 6c  crct10dif_pclmul' =3D=
> 1,
    '67 68 61 73 68 5f 63 6c 6d 75 6c 6e 69 5f 69 6e  ghash_clmulni_in' =3D=
> 1,
    '69 32 63 5f 61 6c 67 6f 5f 62 69 74 00 c4 b6 08  i2c_algo_bit....' =3D=
> 1,
    '69 32 63 5f 70 69 69 78 34 00 cb 8a 66 a7 e2 48  i2c_piix4...f..H' =3D=
> 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 63 6f 6d 6d 6f  intel_rapl_commo' =3D=
> 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 6d 73 72 00 98  intel_rapl_msr..' =3D=
> 1,
    '69 6f 6d 6d 75 5f 76 32 00 70 a8 80 6c c4 bd 08  iommu_v2.p..l...' =3D=
> 1,
    '6d 78 6d 5f 77 6d 69 00                          mxm_wmi.' =3D> 1,
    '70 63 73 70 6b 72 00 8f                          pcspkr..' =3D> 1,
    '73 65 72 69 6f 5f 72 61 77 00 cb 8a 66 a7 ed b8  serio_raw...f...' =3D=
> 1,
    '74 65 73 74 5f 64 79 6e 61 6d 69 63 5f 64 65 62  test_dynamic_deb' =3D=
> 1,
    '76 69 64 65 6f 00 d9 bf                          video...' =3D> 1,
    '77 6d 69 00 dd da 80 df                          wmi.....' =3D> 1
  },
  'users' =3D> {
    'comm "(udev-worker)", pid 219,' =3D> 1,
    'comm "(udev-worker)", pid 221,' =3D> 4,
    'comm "(udev-worker)", pid 224,' =3D> 2,
    'comm "(udev-worker)", pid 229,' =3D> 1,
    'comm "(udev-worker)", pid 230,' =3D> 1,
    'comm "modprobe", pid 728,' =3D> 1,
    'comm "modprobe", pid 814,' =3D> 1,
    'comm "modprobe", pid 825,' =3D> 3,
    'comm "modprobe", pid 832,' =3D> 1,
    'comm "modprobe", pid 835,' =3D> 1
  }
}, 'LeakSet' )
:#> lsmod
Module                  Size  Used by
mxm_wmi                12288  0
iommu_v2               20480  0
video                  65536  0
i2c_algo_bit           12288  0
wmi                    32768  2 video,mxm_wmi
cec                    57344  0
test_dynamic_debug     20480  0
intel_rapl_msr         16384  0
crc32_pclmul           12288  0
intel_rapl_common      28672  1 intel_rapl_msr
ghash_clmulni_intel    12288  0
crct10dif_pclmul       12288  1
crc32c_intel           20480  0
serio_raw              16384  0
pcspkr                 12288  0
i2c_piix4              28672  0
:#>
