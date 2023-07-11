Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C874EECB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGKM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjGKM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCC719B4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689078366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWnKTFPzORj5uj8OeswCvw5/E4Y6zo44Dm+dJYO01CQ=;
        b=Rzg6+QOxLGeoMRGHr8LTGuaUWc2LZWfNO/iGKcIUsXTMtc03i0PXoOZmnpPv5DnzResXGd
        L2a49nZAaw6Qh9ZvCfBDD2nocLSrFNT93sfjktgPaWCsdAO7FHfmm9kt9NivsBcalYZzAg
        ChCAcpFpdk62oLRJVeP9l7KTRYJ9mWY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-t8cJ9QyjMv2p5I26r7zDFg-1; Tue, 11 Jul 2023 08:26:05 -0400
X-MC-Unique: t8cJ9QyjMv2p5I26r7zDFg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fb748a83b4so4972882e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078364; x=1691670364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWnKTFPzORj5uj8OeswCvw5/E4Y6zo44Dm+dJYO01CQ=;
        b=PvOFeVWtoERpSs5cD2y2enTAoQcY4QNE8BmlViknhgewQAxpG8+i5G/ZX8vAQMkR7S
         3CQaCtpPABeoS8h2VZ8/LZokF6owkYKKlPn7ouy3moWZSei48n7Wl+dmtonT7A5Ntfpu
         rOgtXYiDr++PO2y7ab3WMy33vjSw0BL7mOhQzk3d/beoxgvToQacd5U4T0kpJ27drW4c
         wKO5p2gb4ZAirbEiIDB4C+o1EMqg8Bj7I6ywlw7fBy47gQ16XeAwrAFnN4oRVpQ9aLjN
         nC75XU6TRh4y2JeM5BmqWonbfX4cKDqKLZyJHE0WqkjL7XAhpPNs/NpsxTms59q2UuVI
         Pg/A==
X-Gm-Message-State: ABy/qLYx2vrvgC3m99JEncgzzukTn8UrcrNh94uF9kQcDqV9HVOxsdHR
        u2T1jP8Fy3W1K6a99CIFN8vhi5wVJddY4LMfvNcUkMuA5I4Wf9yCKWxwcsUcJ2OF2ViqsNasgC3
        kI0lQz2H0vSZKJ4wrYW/qhA7mXYB7izRNviMlyuO2
X-Received: by 2002:a05:6512:3451:b0:4fb:c67e:b067 with SMTP id j17-20020a056512345100b004fbc67eb067mr10820068lfr.66.1689078363664;
        Tue, 11 Jul 2023 05:26:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGc53rK6X2J696tXWxIzhRuECmpXQ0jPe6NdhtLW0Zg9TKxDdPKGQrl0SONNrj1fwTj4r8H9Yq/APpzJzdZv6k=
X-Received: by 2002:a05:6512:3451:b0:4fb:c67e:b067 with SMTP id
 j17-20020a056512345100b004fbc67eb067mr10820054lfr.66.1689078363347; Tue, 11
 Jul 2023 05:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
In-Reply-To: <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 11 Jul 2023 14:25:51 +0200
Message-ID: <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     arjan@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 at 13:27, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 11, 2023 at 11:11:44AM +0200, Bruno Goncalves wrote:
> > Hello Arjan and Rafael,
> >
> > I'm not sure if you are the right person to contact about this, but
> > we've noticed the following call trace when booting on KVM machines
> > using kernel 6.5.0-rc1:
> >
> > [    1.089740] io scheduler kyber registered
> > [    1.091080] io scheduler bfq registered
> > [    1.094696] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> > [    1.097371] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > [    1.099559] unchecked MSR access error: RDMSR from 0xe2 at rIP:
> > 0xffffffffa60912d7 (native_read_msr+0x7/0x40)
> > [    1.102725] Call Trace:
> > [    1.103547]  <TASK>
> > [    1.104236]  ? ex_handler_msr+0x121/0x130
> > [    1.105545]  ? fixup_exception+0x234/0x310
> > [    1.106858]  ? gp_try_fixup_and_notify+0x1d/0xb0
> > [    1.108342]  ? exc_general_protection+0x147/0x420
> > [    1.109838]  ? pcpu_block_refresh_hint+0x87/0xb0
> > [    1.111309]  ? asm_exc_general_protection+0x26/0x30
> > [    1.112866]  ? native_read_msr+0x7/0x40
> > [    1.114099]  intel_idle_init_cstates_icpu.constprop.0+0x762/0x7f0
> > [    1.116063]  intel_idle_init+0x31b/0x4c0
> > [    1.117315]  ? __pfx_intel_idle_init+0x10/0x10
> > [    1.118734]  do_one_initcall+0x5a/0x320
> > [    1.119981]  kernel_init_freeable+0x31b/0x470
> > [    1.121373]  ? __pfx_kernel_init+0x10/0x10
> > [    1.122681]  kernel_init+0x1a/0x1c0
> > [    1.123796]  ret_from_fork+0x29/0x50
> > [    1.124963]  </TASK>
> > [    1.126012] input: Power Button as
> > /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> > [    1.128477] ACPI: button: Power Button [PWRF]
> > [    1.163767] ACPI: \_SB_.LNKB: Enabled at IRQ 10
> > [    1.193831] ACPI: \_SB_.LNKC: Enabled at IRQ 11
>
> You forgot to say on what host hardware, what qemu options and you
> forgot to run the above through scripts/decode_stacktrace.sh.

I don't have access to the host machines, but the information I could
get so far is:

R640 2x  Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz

and start the VM with:

/usr/libexec/qemu-kvm -name guest=kvm-06-guest10,debug-threads=on -S
-object {"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/libvirt/qemu/domain-3-kvm-06-guest10/master-key.aes"}
-machine pc-i440fx-rhel7.6.0,usb=off,dump-guest-core=off,memory-backend=pc.ram
-accel kvm -cpu
Skylake-Server-IBRS,ss=on,vmx=on,pdcm=on,hypervisor=on,tsc-adjust=on,clflushopt=on,umip=on,pku=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaves=on,ibpb=on,ibrs=on,amd-stibp=on,amd-ssbd=on,rsba=on,skip-l1dfl-vmentry=on,pschange-mc-no=on
-m 4096 -object
{"qom-type":"memory-backend-file","id":"pc.ram","mem-path":"/dev/hugepages/libvirt/qemu/3-kvm-06-guest10","x-use-canonical-path-for-ramblock-id":false,"prealloc":true,"size":4294967296,"host-nodes":[0],"policy":"bind"}
-overcommit mem-lock=off -smp 2,sockets=2,cores=1,threads=1 -uuid
cb26926d-fdcd-414e-a259-4fe99235d5bf -display none -no-user-config
-nodefaults -chardev socket,id=charmonitor,fd=45,server=on,wait=off
-mon chardev=charmonitor,id=monitor,mode=control -rtc
base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet
-no-shutdown -boot strict=on -device
piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -blockdev
{"driver":"file","filename":"/var/lib/libvirt/images/kvm-06-guest10.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
-blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}
-device virtio-blk-pci,bus=pci.0,addr=0x3,drive=libvirt-1-format,id=virtio-disk0,bootindex=2
-netdev tap,fd=46,id=hostnet0,vhost=on,vhostfd=48 -device
virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:9d:24:62,bootindex=1,bus=pci.0,addr=0x2
-chardev socket,id=charserial0,fd=44,server=on,wait=off -device
isa-serial,chardev=charserial0,id=serial0 -audiodev
{"id":"audio1","driver":"none"} -device
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
-msg timestamp=on

The decoded call trace:

[   14.476177] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.478145] unchecked MSR access error: RDMSR from 0xe2 at rIP:
0xffffffffb421dfd7 native_read_msr
(/builds/4620032464/workdir/./arch/x86/include/asm/msr.h:84
/builds/4620032464/workdir/./arch/x86/include/asm/msr.h:118)
[   14.480268] Call Trace:
[   14.480809]  <TASK>
[   14.481283] ? ex_handler_msr
(/builds/4618511676/workdir/arch/x86/mm/extable.c:191)
[   14.482153] ? fixup_exception
(/builds/4618511676/workdir/arch/x86/mm/extable.c:305)
[   14.483042] ? gp_try_fixup_and_notify (arch/x86/kernel/traps.c:702
(discriminator 1))
[   14.484045] ? exc_general_protection (arch/x86/kernel/traps.c:762
(discriminator 1) arch/x86/kernel/traps.c:728 (discriminator 1))
[   14.485085] ? asm_exc_general_protection
(/builds/4618511676/workdir/./arch/x86/include/asm/idtentry.h:564)
[   14.486152] ? cpuidle_poll_state_init
(/builds/4618511676/workdir/drivers/cpuidle/poll_state.c:60)
[   14.487195] ? native_read_msr
(/builds/4620032464/workdir/./arch/x86/include/asm/msr.h:84
/builds/4620032464/workdir/./arch/x86/include/asm/msr.h:118)
[   14.488049] intel_idle_init_cstates_icpu.constprop.0
(/builds/4626306068/workdir/./arch/x86/include/asm/paravirt.h:190
/builds/4626306068/workdir/drivers/idle/intel_idle.c:1820
/builds/4626306068/workdir/drivers/idle/intel_idle.c:1974)
[   14.489360] ? __pfx_intel_idle_init_cstates_icpu.constprop.0
(/builds/4626306068/workdir/drivers/idle/intel_idle.c:1958)
[   14.490773] ? pcpu_alloc (/builds/4626306068/workdir/mm/percpu.c:1886)
[   14.491577] intel_idle_init
(/builds/4626306068/workdir/drivers/idle/intel_idle.c:2205
/builds/4626306068/workdir/drivers/idle/intel_idle.c:2246)
[   14.492430] ? __pfx_intel_idle_init
(/builds/4626306068/workdir/drivers/idle/intel_idle.c:2228)
[   14.493387] ? add_device_randomness
(/builds/4620032464/workdir/drivers/char/random.c:918)
[   14.494382] ? __pfx_intel_idle_init
(/builds/4626306068/workdir/drivers/idle/intel_idle.c:2228)
[   14.495372] do_one_initcall (init/main.c:1232)
[   14.496205] ? __pfx_do_one_initcall (init/main.c:1223)
[   14.497169] ? kasan_set_track
(/builds/4620032464/workdir/mm/kasan/common.c:52 (discriminator 1))
[   14.498033] ? __kasan_kmalloc
(/builds/4620032464/workdir/mm/kasan/common.c:374
/builds/4620032464/workdir/mm/kasan/common.c:383)
[   14.498920] kernel_init_freeable (init/main.c:1293 (discriminator
1) init/main.c:1310 (discriminator 1) init/main.c:1329 (discriminator
1) init/main.c:1546 (discriminator 1))
[   14.499897] ? __pfx_kernel_init (init/main.c:1429)
[   14.500843] kernel_init (init/main.c:1439)
[   14.501602] ? __pfx_kernel_init (init/main.c:1429)
[   14.502490] ret_from_fork
(/builds/4618511676/workdir/arch/x86/entry/entry_64.S:308)
[   14.503270]  </TASK>
[   14.507587] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   14.510321] ACPI: button: Power Button [PWRF]
[-- MARK -- Mon Jul 10 18:40:00 2023]

Bruno

