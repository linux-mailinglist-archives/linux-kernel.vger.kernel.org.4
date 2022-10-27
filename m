Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E560F93B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiJ0Nhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiJ0Nho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:37:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB13181491
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y14so4638486ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mkge1p063vICqqzVHlh+vcP8z69OSh0XwBhM04hkUno=;
        b=F1x2Ee5IS8Tq2XDWutL6rsQmoQ1q9zJlBBKX7K+bNiDWw/EBbMqQXMfXChBIQotE3L
         /7UD4M0Gc3ykRoWVzOzWYEXUBHIUaq9rTTlHea+pScde5Y1AC96/iBDzx0MguRMBcUgL
         dlo38/NAcrAn5QRITukH57/SpXcJV1GOdy22cxq1S+nw7smW5YkidmdOoX+cF17XORvC
         leZ1oa6FryoJsipLe6RBTgVzg8yPlMSIHCy3t+8IZ3hhU2gXK7jjXQ7KcANy0S/+j9et
         pjgYQpYixznUT+o4aGjT7E80WMvs7Oq+adijsxFD05oDfOTszvp5dSN4R+9wWLVlXw2a
         AKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mkge1p063vICqqzVHlh+vcP8z69OSh0XwBhM04hkUno=;
        b=qu++mklAmXQk+VcdYrFD7w/lRrp2mm8/N9CiNlm+c2jdehMW2RHSDkv9t6wL1HbcEa
         ebEwiD39SOX4Uc+0CIeDD25opwKxZiH9GwyveJwQY0hqgmdU0DKSNqQrim77c5SSQyyk
         81Vi1x8RBdAnWMYp5r5KdN6CvsR8dg5vmMr2+B4G6bm0+9f7fUMvYbtl7hMC93ncYBbG
         WYhKjwH8rc8egCiAcDlGhlt9YuJE5wYM19ZNAM3V18H6o3/ux+t08oQ+EgN2i5Z5DRs+
         PmsDQj59Oxrpw0++cN2CXNO//FdZm54m629OLXNrbpK3VhYXKo6GiaXAZMG4fbNwqcvQ
         SfuA==
X-Gm-Message-State: ACrzQf1VAEk8BtPHHKNSrpe2ZUgTBdifO1AmszJjvHyzjeX29fXfdDor
        DeUGInaTo8phR7N7+1W9iDQCzRB/tRuld/zld1o=
X-Google-Smtp-Source: AMsMyM6zsDvj3/qp7DsjONslKy9A8pDnPY7yNmG4yeWh34P07KUZvvB5pMVti7d4XOdlWWiRGqe2ozRivkCTXT+ub0I=
X-Received: by 2002:a17:907:3188:b0:741:4bf7:ec1a with SMTP id
 xe8-20020a170907318800b007414bf7ec1amr43184298ejb.448.1666877860089; Thu, 27
 Oct 2022 06:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210406130045.15491-1-andrea.merello@gmail.com>
 <20210406130045.15491-2-andrea.merello@gmail.com> <7b61d027-6cb9-f35e-fdd0-c5bba9389783@gmail.com>
In-Reply-To: <7b61d027-6cb9-f35e-fdd0-c5bba9389783@gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 27 Oct 2022 15:37:28 +0200
Message-ID: <CAN8YU5O-vQNcf_uNcPusTLumxrEc=-xXFME0_Semuj3dedRF+w@mail.gmail.com>
Subject: Re: [BUG] [PATCH v2 1/2] clocksource: arm_global_timer: implement
 rate compensation whenever source clock changes
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     tglx@linutronix.de, daniel.lezcano@linaro.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun 17 ott 2022 alle ore 10:03 Johan Jonker
<jbx6244@gmail.com> ha scritto:
>
> Hi Andrea,
>
> Your patch contribution causes a kernel panic on MK808 with Rockchip rk30=
66a SoC.
> Would you like to contribute to fix this issue?

Hi! Thank you for reporting this; I'm definitely interested in
investigating this issue.

> The psv variable divides with 0 and more things might be wrong.
> A revert makes it work again.

Hum, good point: it's probably worth adding a check in the LOC you
pointed out and eventually returning NOTIFY_BAD.. Note however that
this would prevent the division by zeroed-psv (which is really
desirable), but it wouldn't make all magically work - so it's probably
worth understanding what's happening.. :

I'm not familiar with your SoC; is it like the Zynq i.e. when enabling
cpu frequency scaling then the clock source feeding the ARM global
timer keeps changing rate? If the rate-change callback has run (and it
calculated a zero psv) then it seems the case.

If this is really the case, then I'd say that the frequency scaling
needed to be disabled (i.e. locked out) when the ARM global timer was
in use without my patch (otherwise your clocksource would be also
unstable), while to take advantage of my patch a reasonable
CONFIG_ARM_GT_INITIAL_PRESCALER_VAL should be set (and hopefully this
prevents psv to become zero).

IOW, in this case, I would expect KConfig not letting enabling
frequency scaling and ARM global timer together (IIRC that was what
Zynq did) in case my patch is not there, or otherwise defining at
least a good default value for CONFIG_ARM_GT_INITIAL_PRESCALER_VAL,
that make it possible to swing the prescaler in a range wide enough.

How's CONFIG_ARM_GT_INITIAL_PRESCALER_VAL set in your kernel
configuration? Maybe tweaking with it prevents the problem?

On the contrary, in case your SoC doesn't vary the ARM global timer
clock source when scaling CPU frequency, then I don't understand why
the rate-change notification callback, where the psv is calculated, is
ever called (although I admit that I'm starting to wonder whether it
is maybe called one time anyway).. But even if it is, then the clock
rate should be the very same, so I would expect the psv to be
calculated as non-zero anyway.. Or am I missing some case in which
approximations can lead to zero?

BTW I'm not really sure about what's going on here: I cannot directly
correlate the Oops you attached below to the LOC you pointed out. How
did you track down the problem to that?

Thanks
Andrea

>
> Johan
>
> =3D=3D=3D=3D=3D
>
> [   13.087809] ------------[ cut here ]------------
> [   13.110701] kernel BUG at drivers/cpufreq/cpufreq.c:1480!
> [   13.134378] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [   13.157793] Modules linked in:
> [   13.178760] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         =
 6.0.0-next-20221013 #1
> [   13.205990] Hardware name: Rockchip (Device Tree)
> [   13.228793] PC is at cpufreq_online+0x8fc/0xa1c
> [   13.251421] LR is at __wake_up_common_lock+0x98/0xc4
> [   13.274536] pc : [<c06883d8>]    lr : [<c0171c50>]    psr: a0000013
> [   13.299046] sp : f0821c50  ip : f0821b70  fp : f0821c9c
> [   13.322445] r10: 00000000  r9 : 00000000  r8 : c0f9b800
> [   13.345887] r7 : 000493e0  r6 : c115ef18  r5 : c1005058  r4 : c2055e00
> [   13.370714] r3 : b4aeb193  r2 : b4aeb193  r1 : 60000013  r0 : fffffff0
> [   13.395373] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [   13.420948] Control: 10c5387d  Table: 6000404a  DAC: 00000051
> [   13.444914] Register r0 information: non-paged memory
> [   13.468230] Register r1 information: non-paged memory
> [   13.491289] Register r2 information: non-paged memory
> [   13.514135] Register r3 information: non-paged memory
> [   13.536767] Register r4 information: slab kmalloc-512 start c2055e00 p=
ointer offset 0 size 512
> [   13.563712] Register r5 information: non-slab/vmalloc memory
> [   13.587158] Register r6 information: non-slab/vmalloc memory
> [   13.610385] Register r7 information: non-paged memory
> [   13.632699] Register r8 information: non-slab/vmalloc memory
> [   13.655529] Register r9 information: NULL pointer
> [   13.677204] Register r10 information: NULL pointer
> [   13.698865] Register r11 information: 2-page vmalloc region starting a=
t 0xf0820000 allocated at kernel_clone+0xc0/0x3b0
> [   13.727678] Register r12 information: 2-page vmalloc region starting a=
t 0xf0820000 allocated at kernel_clone+0xc0/0x3b0
> [   13.756320] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
> [   13.779523] Stack: (0xf0821c50 to 0xf0822000)
> [   13.800858] 1c40:                                     00000000 0000000=
1 ef7c5050 00000001
> [   13.826719] 1c60: c10da900 00000002 c115ef18 c2055f20 c0942224 0000000=
0 ef7c5050 c1004ec8
> [   13.852544] 1c80: c20d7b40 c10da884 c1005058 c1004f14 f0821cb4 f0821ca=
0 c0688590 c0687ae8
> [   13.878330] 1ca0: c10da570 c10cf8a8 f0821ce4 f0821cb8 c0595080 c068852=
4 c14f7958 c1645434
> [   13.904232] 1cc0: 00000000 b4aeb193 00000060 c10da900 c115ef18 c10da43=
4 f0821d0c f0821ce8
> [   13.930231] 1ce0: c06859e0 c0594fdc c10da8ec ef7c5050 c20d7b40 0000000=
2 c10da8ec ef7c5050
> [   13.956321] 1d00: f0821d8c f0821d10 c068b9a4 c068589c c0b161cc c1004ec=
8 00000000 c0b7b718
> [   13.982392] 1d20: c14e3400 00000000 c20d7b48 00000001 c033f608 c20da5d=
8 c20da688 c160c688
> [   14.008446] 1d40: c0b8bd28 00000001 c0c47d54 c111b000 f0821d84 0000000=
0 00000000 b4aeb193
> [   14.034637] 1d60: c14e3410 c14e3410 00000000 c10da898 00000000 c20d7ab=
8 c0c47d54 c111b000
> [   14.060896] 1d80: f0821dac f0821d90 c0599424 c068b68c c14e3410 0000000=
0 c10da898 00000000
> [   14.087313] 1da0: f0821dcc f0821db0 c0596cd0 c05993c4 c14e3410 c10da89=
8 c14e3410 00000000
> [   14.113601] 1dc0: f0821de4 f0821dd0 c0596f8c c0596c04 c115dd68 c14e341=
0 f0821e04 f0821de8
> [   14.139950] 1de0: c0596fe8 c0596ec0 00000000 c14e3410 c10da898 c059741=
c f0821e2c f0821e08
> [   14.166351] 1e00: c0597490 c0596fb4 c1546ab4 c1004ec8 c10da898 c059741=
c c20d7ab8 c0c47d54
> [   14.192790] 1e20: f0821e5c f0821e30 c0594c2c c0597428 f0821e68 c14f785=
8 c1546ab4 b4aeb193
> [   14.219273] 1e40: c10da898 c10cf808 c20d7a80 00000000 f0821e6c f0821e6=
0 c0596528 c0594bb4
> [   14.245875] 1e60: f0821e9c f0821e70 c0595e60 c0596508 c0b7b7c8 0000000=
0 f0821e9c c10da898
> [   14.272550] 1e80: c1004ec8 c0c28e84 00000000 c1456854 f0821eb4 f0821ea=
0 c0597c80 c0595cc0
> [   14.299270] 1ea0: c110cec0 c1004ec8 f0821ec4 f0821eb8 c0599130 c0597c0=
8 f0821ed4 f0821ec8
> [   14.326125] 1ec0: c0c28ea8 c0599110 f0821f4c f0821ed8 c0102180 c0c28e9=
0 c03318e4 c0b14f30
> [   14.352912] 1ee0: c0b14f10 c0b14f00 c0b2bc78 c1004ec8 00000000 c0b855d=
0 00000006 00000006
> [   14.379805] 1f00: 00000000 c0b76eb0 c0c0055c c0bebf78 c0953a9c c154665=
b 00000000 b4aeb193
> [   14.406665] 1f20: c0181cb8 b4aeb193 000000c6 c0c82160 00000007 c0c47d3=
4 c1546600 000000c6
> [   14.433661] 1f40: f0821f94 f0821f50 c0c01a48 c0102134 00000006 0000000=
6 00000000 c0c0055c
> [   14.460621] 1f60: c0c0055c c0bebf78 c1588000 00004ec0 c096ea48 0000000=
0 00000000 00000000
> [   14.487681] 1f80: 00000000 00000000 f0821fac f0821f98 c096ea6c c0c0188=
4 00000000 c096ea48
> [   14.514695] 1fa0: 00000000 f0821fb0 c0100148 c096ea54 00000000 0000000=
0 00000000 00000000
> [   14.541771] 1fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [   14.568615] 1fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0 00000000 00000000
> [   14.595194] Backtrace:
> [   14.615207]  cpufreq_online from cpufreq_add_dev+0x78/0x84
> [   14.638819]  r10:c1004f14 r9:c1005058 r8:c10da884 r7:c20d7b40 r6:c1004=
ec8 r5:ef7c5050
> [   14.665198]  r4:00000000
> [   14.685514]  cpufreq_add_dev from subsys_interface_register+0xb0/0xfc
> [   14.710558]  r5:c10cf8a8 r4:c10da570
> [   14.732076]  subsys_interface_register from cpufreq_register_driver+0x=
150/0x2d8
> [   14.758094]  r6:c10da434 r5:c115ef18 r4:c10da900
> [   14.780943]  cpufreq_register_driver from dt_cpufreq_probe+0x324/0x49c
> [   14.806283]  r6:ef7c5050 r5:c10da8ec r4:00000002
> [   14.829299]  dt_cpufreq_probe from platform_probe+0x6c/0xc8
> [   14.853499]  r10:c111b000 r9:c0c47d54 r8:c20d7ab8 r7:00000000 r6:c10da=
898 r5:00000000
> [   14.880388]  r4:c14e3410
> [   14.901252]  platform_probe from really_probe+0xd8/0x2bc
> [   14.925473]  r7:00000000 r6:c10da898 r5:00000000 r4:c14e3410
> [   14.949898]  really_probe from __driver_probe_device+0xd8/0xf4
> [   14.974546]  r7:00000000 r6:c14e3410 r5:c10da898 r4:c14e3410
> [   14.998855]  __driver_probe_device from driver_probe_device+0x40/0xd0
> [   15.024426]  r5:c14e3410 r4:c115dd68
> [   15.046857]  driver_probe_device from __driver_attach+0x74/0x120
> [   15.072380]  r7:c059741c r6:c10da898 r5:c14e3410 r4:00000000
> [   15.097388]  __driver_attach from bus_for_each_dev+0x84/0xc4
> [   15.122444]  r9:c0c47d54 r8:c20d7ab8 r7:c059741c r6:c10da898 r5:c1004e=
c8 r4:c1546ab4
> [   15.150131]  bus_for_each_dev from driver_attach+0x2c/0x30
> [   15.175532]  r7:00000000 r6:c20d7a80 r5:c10cf808 r4:c10da898
> [   15.201134]  driver_attach from bus_add_driver+0x1ac/0x1f8
> [   15.226772]  bus_add_driver from driver_register+0x84/0x11c
> [   15.252559]  r8:c1456854 r7:00000000 r6:c0c28e84 r5:c1004ec8 r4:c10da8=
98
> [   15.279483]  driver_register from __platform_driver_register+0x2c/0x34
> [   15.306523]  r5:c1004ec8 r4:c110cec0
> [   15.329801]  __platform_driver_register from dt_cpufreq_platdrv_init+0=
x24/0x28
> [   15.357500]  dt_cpufreq_platdrv_init from do_one_initcall+0x58/0x20c
> [   15.384159]  do_one_initcall from kernel_init_freeable+0x1d0/0x22c
> [   15.410635]  r8:000000c6 r7:c1546600 r6:c0c47d34 r5:00000007 r4:c0c821=
60
> [   15.437567]  kernel_init_freeable from kernel_init+0x24/0x144
> [   15.463573]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000=
000 r5:c096ea48
> [   15.491869]  r4:00004ec0
> [   15.514022]  kernel_init from ret_from_fork+0x14/0x2c
> [   15.539079] Exception stack(0xf0821fb0 to 0xf0821ff8)
> [   15.563943] 1fa0:                                     00000000 0000000=
0 00000000 00000000
> [   15.592459] 1fc0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [   15.620836] 1fe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0
> [   15.647222]  r5:c096ea48 r4:00000000
> [   15.670196] Code: e1a00004 ebfff74d e3500000 0a00001a (e7f001f2)
> [   15.696086] ---[ end trace 0000000000000000 ]---
> [   15.720522] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [   15.748404] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x0000000b ]---
>
>
> On 4/6/21 15:00, Andrea Merello wrote:
> > This patch adds rate change notification support for the parent clock;
> > should that clock change, then we try to adjust the our prescaler in or=
der
> > to compensate (i.e. we adjust to still get the same timer frequency).
> >
> > This is loosely based on what it's done in timer-cadence-ttc. timer-sun=
51,
> > mips-gic-timer and smp_twd.c also seem to look at their parent clock ra=
te
> > and to perform some kind of adjustment whenever needed.
> >
> > In this particular case we have only one single counter and prescaler f=
or
> > all clocksource, clockevent and timer_delay, and we just update it for =
all
> > (i.e. we don't let it go and call clockevents_update_freq() to notify t=
o
> > the kernel that our rate has changed).
> >
> > Note that, there is apparently no other way to fixup things, because on=
ce
> > we call register_current_timer_delay(), specifying the timer rate, it s=
eems
> > that that rate is not supposed to change ever.
> >
> > In order for this mechanism to work, we have to make assumptions about =
how
> > much the initial clock is supposed to eventually decrease from the init=
ial
> > one, and set our initial prescaler to a value that we can eventually
> > decrease enough to compensate. We provide an option in KConfig for this=
.
> >
> > In case we end up in a situation in which we are not able to compensate=
 the
> > parent clock change, we fail returning NOTIFY_BAD.
> >
> > This fixes a real-world problem with Zynq arch not being able to use th=
is
> > driver and CPU_FREQ at the same time (because ARM global timer is fed b=
y
> > the CPU clock, which may keep changing when CPU_FREQ is enabled).
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > Cc: Patrice Chotard <patrice.chotard@st.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  drivers/clocksource/Kconfig            |  13 +++
> >  drivers/clocksource/arm_global_timer.c | 122 +++++++++++++++++++++++--
> >  2 files changed, 125 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 39aa21d01e05..19fc5f8883e0 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -358,6 +358,19 @@ config ARM_GLOBAL_TIMER
> >       help
> >         This option enables support for the ARM global timer unit.
> >
> > +config ARM_GT_INITIAL_PRESCALER_VAL
> > +     int "ARM global timer initial prescaler value"
> > +     default 1
> > +     depends on ARM_GLOBAL_TIMER
> > +     help
> > +       When the ARM global timer initializes, its current rate is decl=
ared
> > +       to the kernel and maintained forever. Should it's parent clock
> > +       change, the driver tries to fix the timer's internal prescaler.
> > +       On some machs (i.e. Zynq) the initial prescaler value thus pose=
s
> > +       bounds about how much the parent clock is allowed to decrease o=
r
> > +       increase wrt the initial clock value.
> > +       This affects CPU_FREQ max delta from the initial frequency.
> > +
> >  config ARM_TIMER_SP804
> >       bool "Support for Dual Timer SP804 module" if COMPILE_TEST
> >       depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
> > diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksour=
ce/arm_global_timer.c
> > index 88b2d38a7a61..60a8047fd32e 100644
> > --- a/drivers/clocksource/arm_global_timer.c
> > +++ b/drivers/clocksource/arm_global_timer.c
> > @@ -31,6 +31,10 @@
> >  #define GT_CONTROL_COMP_ENABLE               BIT(1)  /* banked */
> >  #define GT_CONTROL_IRQ_ENABLE                BIT(2)  /* banked */
> >  #define GT_CONTROL_AUTO_INC          BIT(3)  /* banked */
> > +#define GT_CONTROL_PRESCALER_SHIFT      8
> > +#define GT_CONTROL_PRESCALER_MAX        0xF
> > +#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
> > +                                      GT_CONTROL_PRESCALER_SHIFT)
> >
> >  #define GT_INT_STATUS        0x0c
> >  #define GT_INT_STATUS_EVENT_FLAG     BIT(0)
> > @@ -39,6 +43,7 @@
> >  #define GT_COMP1     0x14
> >  #define GT_AUTO_INC  0x18
> >
> > +#define MAX_F_ERR 50
> >  /*
> >   * We are expecting to be clocked by the ARM peripheral clock.
> >   *
> > @@ -46,7 +51,8 @@
> >   * the units for all operations.
> >   */
> >  static void __iomem *gt_base;
> > -static unsigned long gt_clk_rate;
> > +struct notifier_block gt_clk_rate_change_nb;
> > +static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
> >  static int gt_ppi;
> >  static struct clock_event_device __percpu *gt_evt;
> >
> > @@ -96,7 +102,10 @@ static void gt_compare_set(unsigned long delta, int=
 periodic)
> >       unsigned long ctrl;
> >
> >       counter +=3D delta;
> > -     ctrl =3D GT_CONTROL_TIMER_ENABLE;
> > +     ctrl =3D readl(gt_base + GT_CONTROL);
> > +     ctrl &=3D ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
> > +               GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
> > +     ctrl |=3D GT_CONTROL_TIMER_ENABLE;
> >       writel_relaxed(ctrl, gt_base + GT_CONTROL);
> >       writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
> >       writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
> > @@ -123,7 +132,7 @@ static int gt_clockevent_shutdown(struct clock_even=
t_device *evt)
> >
> >  static int gt_clockevent_set_periodic(struct clock_event_device *evt)
> >  {
> > -     gt_compare_set(DIV_ROUND_CLOSEST(gt_clk_rate, HZ), 1);
> > +     gt_compare_set(DIV_ROUND_CLOSEST(gt_target_rate, HZ), 1);
> >       return 0;
> >  }
> >
> > @@ -177,7 +186,7 @@ static int gt_starting_cpu(unsigned int cpu)
> >       clk->cpumask =3D cpumask_of(cpu);
> >       clk->rating =3D 300;
> >       clk->irq =3D gt_ppi;
> > -     clockevents_config_and_register(clk, gt_clk_rate,
> > +     clockevents_config_and_register(clk, gt_target_rate,
> >                                       1, 0xffffffff);
> >       enable_percpu_irq(clk->irq, IRQ_TYPE_NONE);
> >       return 0;
> > @@ -232,9 +241,28 @@ static struct delay_timer gt_delay_timer =3D {
> >       .read_current_timer =3D gt_read_long,
> >  };
> >
> > +static void gt_write_presc(u32 psv)
> > +{
> > +     u32 reg;
> > +
> > +     reg =3D readl(gt_base + GT_CONTROL);
> > +     reg &=3D ~GT_CONTROL_PRESCALER_MASK;
> > +     reg |=3D psv << GT_CONTROL_PRESCALER_SHIFT;
> > +     writel(reg, gt_base + GT_CONTROL);
> > +}
> > +
> > +static u32 gt_read_presc(void)
> > +{
> > +     u32 reg;
> > +
> > +     reg =3D readl(gt_base + GT_CONTROL);
> > +     reg &=3D GT_CONTROL_PRESCALER_MASK;
> > +     return reg >> GT_CONTROL_PRESCALER_SHIFT;
> > +}
> > +
> >  static void __init gt_delay_timer_init(void)
> >  {
> > -     gt_delay_timer.freq =3D gt_clk_rate;
> > +     gt_delay_timer.freq =3D gt_target_rate;
> >       register_current_timer_delay(&gt_delay_timer);
> >  }
> >
> > @@ -243,18 +271,81 @@ static int __init gt_clocksource_init(void)
> >       writel(0, gt_base + GT_CONTROL);
> >       writel(0, gt_base + GT_COUNTER0);
> >       writel(0, gt_base + GT_COUNTER1);
> > -     /* enables timer on all the cores */
> > -     writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> > +     /* set prescaler and enable timer on all the cores */
> > +     writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
> > +             GT_CONTROL_PRESCALER_SHIFT)
> > +            | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> >
> >  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> > -     sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
> > +     sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
> >  #endif
> > -     return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
> > +     return clocksource_register_hz(&gt_clocksource, gt_target_rate);
> > +}
> > +
> > +static int gt_clk_rate_change_cb(struct notifier_block *nb,
> > +                              unsigned long event, void *data)
> > +{
> > +     struct clk_notifier_data *ndata =3D data;
> > +
> > +     switch (event) {
> > +     case PRE_RATE_CHANGE:
> > +     {
> > +             int psv;
> > +
>
> > +             psv =3D DIV_ROUND_CLOSEST(ndata->new_rate,
> > +                                     gt_target_rate);
> > +
>
> > +             if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F=
_ERR)
> > +                     return NOTIFY_BAD;
>
> This psv variable can become a 0 divider.
>
> > +
> > +             psv--;
> > +
> > +             /* prescaler within legal range? */
> > +             if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> > +                     return NOTIFY_BAD;
> > +
> > +             /*
> > +              * store timer clock ctrl register so we can restore it i=
n case
> > +              * of an abort.
> > +              */
> > +             gt_psv_bck =3D gt_read_presc();
> > +             gt_psv_new =3D psv;
> > +             /* scale down: adjust divider in post-change notification=
 */
> > +             if (ndata->new_rate < ndata->old_rate)
> > +                     return NOTIFY_DONE;
> > +
> > +             /* scale up: adjust divider now - before frequency change=
 */
> > +             gt_write_presc(psv);
> > +             break;
> > +     }
> > +     case POST_RATE_CHANGE:
> > +             /* scale up: pre-change notification did the adjustment *=
/
> > +             if (ndata->new_rate > ndata->old_rate)
> > +                     return NOTIFY_OK;
> > +
> > +             /* scale down: adjust divider now - after frequency chang=
e */
> > +             gt_write_presc(gt_psv_new);
> > +             break;
> > +
> > +     case ABORT_RATE_CHANGE:
> > +             /* we have to undo the adjustment in case we scale up */
> > +             if (ndata->new_rate < ndata->old_rate)
> > +                     return NOTIFY_OK;
> > +
> > +             /* restore original register value */
> > +             gt_write_presc(gt_psv_bck);
> > +             break;
> > +     default:
> > +             return NOTIFY_DONE;
> > +     }
> > +
> > +     return NOTIFY_DONE;
> >  }
> >
> >  static int __init global_timer_of_register(struct device_node *np)
> >  {
> >       struct clk *gt_clk;
> > +     static unsigned long gt_clk_rate;
> >       int err =3D 0;
> >
> >       /*
> > @@ -292,11 +383,20 @@ static int __init global_timer_of_register(struct=
 device_node *np)
> >       }
> >
> >       gt_clk_rate =3D clk_get_rate(gt_clk);
> > +     gt_target_rate =3D gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_=
VAL;
> > +     gt_clk_rate_change_nb.notifier_call =3D
> > +             gt_clk_rate_change_cb;
> > +     err =3D clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
> > +     if (err) {
> > +             pr_warn("Unable to register clock notifier\n");
> > +             goto out_clk;
> > +     }
> > +
> >       gt_evt =3D alloc_percpu(struct clock_event_device);
> >       if (!gt_evt) {
> >               pr_warn("global-timer: can't allocate memory\n");
> >               err =3D -ENOMEM;
> > -             goto out_clk;
> > +             goto out_clk_nb;
> >       }
> >
> >       err =3D request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
> > @@ -326,6 +426,8 @@ static int __init global_timer_of_register(struct d=
evice_node *np)
> >       free_percpu_irq(gt_ppi, gt_evt);
> >  out_free:
> >       free_percpu(gt_evt);
> > +out_clk_nb:
> > +     clk_notifier_unregister(gt_clk, &gt_clk_rate_change_nb);
> >  out_clk:
> >       clk_disable_unprepare(gt_clk);
> >  out_unmap:
