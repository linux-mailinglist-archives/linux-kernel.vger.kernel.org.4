Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0362C548
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiKPQrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 11:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:46:38 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5A5C763
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:43:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id x21-20020a5d9455000000b006bc1172e639so9040990ior.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80cOLj3p9gwIm0aIYBRwI7P4/kgv5BMdbqsCYwBmRQo=;
        b=LhRTukrVMP/t+SuYWjSqzZ+G2pc8ifr0ve/4YdLSYvCZlOtVLIq8Ve9wI1x3xfeS11
         tBUIrkqi2K+J+UmGPOtDuykTR44ff6tJbeWwoSH5Q/NQJbH4d8ov3ri5tK9ryJuL1+qN
         kK4qhkZwytSfqkCj4J/3Dg1b2Tl/ES1ldv/dfF6p2ijD148k6u1IJqZyVSTvlbzGksIw
         h/LELneNwfh0Fxwq2DsYcRJpQPSgHQC2+rl3+jcmYRYUwh03QUGomzrTELW3YuKgP8yQ
         S27CA9KjGpzoZjih5YQ0ex+JeC/4B60JQm2TB1+0H5X5T4P5FtIjnNi7gxY1rU58Yy6O
         txbA==
X-Gm-Message-State: ANoB5pnlGVpMLdvh54oUxODiWu4HPb9P0oYjIF3dGUa1Y8SkbshQM/9L
        BOfuCSHyA+n0XMM4h1mHwOVF5/ydi7nkfpkQ6nx/xTQ3dzYQ
X-Google-Smtp-Source: AA0mqf7VdaUIAHmH53NN6LSbC3dF24OUUKi4Edxt+Is+1n9HZ+cNbN0OnSg5ImejH7ES2uTulQyiNaHLOruP7WIXBqEViWquEUPO
MIME-Version: 1.0
X-Received: by 2002:a02:ccf1:0:b0:375:ab48:de95 with SMTP id
 l17-20020a02ccf1000000b00375ab48de95mr10434153jaq.14.1668616998524; Wed, 16
 Nov 2022 08:43:18 -0800 (PST)
Date:   Wed, 16 Nov 2022 08:43:18 -0800
In-Reply-To: <20221116084731.3123-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076a1d305ed992bfc@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in netdev_core_pick_tx
From:   syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ice registered as radio22
[    9.280484][    T1] vivid-011: V4L2 transmitter device registered as radio23
[    9.281637][    T1] vivid-011: V4L2 metadata capture device registered as video53
[    9.282665][    T1] vivid-011: V4L2 metadata output device registered as video54
[    9.283695][    T1] vivid-011: V4L2 touch capture device registered as v4l-touch11
[    9.284749][    T1] vivid-012: using single planar format API
[    9.313834][    T1] vivid-012: CEC adapter cec24 registered for HDMI input 0
[    9.314750][    T1] vivid-012: V4L2 capture device registered as video55
[    9.315693][    T1] vivid-012: CEC adapter cec25 registered for HDMI output 0
[    9.316677][    T1] vivid-012: V4L2 output device registered as video56
[    9.317646][    T1] vivid-012: V4L2 capture device registered as vbi24, supports raw and sliced VBI
[    9.318291][    T1] vivid-012: V4L2 output device registered as vbi25, supports raw and sliced VBI
[    9.320037][    T1] vivid-012: V4L2 capture device registered as swradio12
[    9.321192][    T1] vivid-012: V4L2 receiver device registered as radio24
[    9.322138][    T1] vivid-012: V4L2 transmitter device registered as radio25
[    9.323120][    T1] vivid-012: V4L2 metadata capture device registered as video57
[    9.324128][    T1] vivid-012: V4L2 metadata output device registered as video58
[    9.325064][    T1] vivid-012: V4L2 touch capture device registered as v4l-touch12
[    9.326045][    T1] vivid-013: using multiplanar format API
[    9.353487][    T1] vivid-013: CEC adapter cec26 registered for HDMI input 0
[    9.354582][    T1] vivid-013: V4L2 capture device registered as video59
[    9.355753][    T1] vivid-013: CEC adapter cec27 registered for HDMI output 0
[    9.357436][    T1] vivid-013: V4L2 output device registered as video60
[    9.358424][    T1] vivid-013: V4L2 capture device registered as vbi26, supports raw and sliced VBI
[    9.359083][    T1] vivid-013: V4L2 output device registered as vbi27, supports raw and sliced VBI
[    9.359853][    T1] vivid-013: V4L2 capture device registered as swradio13
[    9.362214][    T1] vivid-013: V4L2 receiver device registered as radio26
[    9.363251][    T1] vivid-013: V4L2 transmitter device registered as radio27
[    9.364242][    T1] vivid-013: V4L2 metadata capture device registered as video61
[    9.365221][    T1] vivid-013: V4L2 metadata output device registered as video62
[    9.366272][    T1] vivid-013: V4L2 touch capture device registered as v4l-touch13
[    9.367776][    T1] vivid-014: using single planar format API
[    9.395970][    T1] vivid-014: CEC adapter cec28 registered for HDMI input 0
[    9.397055][    T1] vivid-014: V4L2 capture device registered as video63
[    9.398170][    T1] vivid-014: CEC adapter cec29 registered for HDMI output 0
[    9.399246][    T1] vivid-014: V4L2 output device registered as video64
[    9.400190][    T1] vivid-014: V4L2 capture device registered as vbi28, supports raw and sliced VBI
[    9.400893][    T1] vivid-014: V4L2 output device registered as vbi29, supports raw and sliced VBI
[    9.402605][    T1] vivid-014: V4L2 capture device registered as swradio14
[    9.403517][    T1] vivid-014: V4L2 receiver device registered as radio28
[    9.404644][    T1] vivid-014: V4L2 transmitter device registered as radio29
[    9.406460][    T1] vivid-014: V4L2 metadata capture device registered as video65
[    9.407559][    T1] vivid-014: V4L2 metadata output device registered as video66
[    9.408605][    T1] vivid-014: V4L2 touch capture device registered as v4l-touch14
[    9.409611][    T1] vivid-015: using multiplanar format API
[    9.438655][    T1] vivid-015: CEC adapter cec30 registered for HDMI input 0
[    9.439767][    T1] vivid-015: V4L2 capture device registered as video67
[    9.440915][    T1] vivid-015: CEC adapter cec31 registered for HDMI output 0
[    9.442045][    T1] vivid-015: V4L2 output device registered as video68
[    9.443006][    T1] vivid-015: V4L2 capture device registered as vbi30, supports raw and sliced VBI
[    9.443770][    T1] vivid-015: V4L2 output device registered as vbi31, supports raw and sliced VBI
[    9.445343][    T1] vivid-015: V4L2 capture device registered as swradio15
[    9.446659][    T1] vivid-015: V4L2 receiver device registered as radio30
[    9.447727][    T1] vivid-015: V4L2 transmitter device registered as radio31
[    9.449013][    T1] vivid-015: V4L2 metadata capture device registered as video69
[    9.450180][    T1] vivid-015: V4L2 metadata output device registered as video70
[    9.451250][    T1] vivid-015: V4L2 touch capture device registered as v4l-touch15
[    9.453925][    T1] usbcore: registered new interface driver radioshark2
[    9.454577][    T1] usbcore: registered new interface driver radioshark
[    9.455355][    T1] usbcore: registered new interface driver radio-si470x
[    9.456610][    T1] usbcore: registered new interface driver radio-usb-si4713
[    9.457292][    T1] usbcore: registered new interface driver dsbr100
[    9.462150][    T8] floppy0: no floppy controllers found
[    9.462792][    T8] work still pending
[    9.463392][  T983] floppy0: floppy_shutdown: timeout handler died.  
[    9.475753][    T1] usbcore: registered new interface driver radio-keene
[    9.476503][    T1] usbcore: registered new interface driver radio-ma901
[    9.477112][    T1] usbcore: registered new interface driver radio-mr800
[    9.477798][    T1] usbcore: registered new interface driver radio-raremono
[    9.481027][    T1] usbcore: registered new interface driver pcwd_usb
[    9.494826][    T1] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    9.495376][    T1] device-mapper: uevent: version 1.0.3
[    9.497645][    T1] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    9.501149][    T1] device-mapper: multipath round-robin: version 1.2.0 loaded
[    9.501167][    T1] device-mapper: multipath queue-length: version 0.2.0 loaded
[    9.501181][    T1] device-mapper: multipath service-time: version 0.3.0 loaded
[    9.502267][    T1] device-mapper: raid: Loading target version 1.15.1
[    9.505124][    T1] Bluetooth: HCI UART driver ver 2.3
[    9.505144][    T1] Bluetooth: HCI UART protocol H4 registered
[    9.505152][    T1] Bluetooth: HCI UART protocol BCSP registered
[    9.505633][    T1] Bluetooth: HCI UART protocol LL registered
[    9.506139][    T1] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    9.506647][    T1] Bluetooth: HCI UART protocol QCA registered
[    9.506658][    T1] Bluetooth: HCI UART protocol AG6XX registered
[    9.507116][    T1] Bluetooth: HCI UART protocol Marvell registered
[    9.507954][    T1] usbcore: registered new interface driver bcm203x
[    9.508662][    T1] usbcore: registered new interface driver bpa10x
[    9.509399][    T1] usbcore: registered new interface driver bfusb
[    9.510131][    T1] usbcore: registered new interface driver btusb
[    9.511709][    T1] usbcore: registered new interface driver ath3k
[    9.513851][    T1] CAPI 2.0 started up with major 68 (middleware)
[    9.513866][    T1] Modular ISDN core version 1.1.29
[    9.515537][    T1] NET: Registered PF_ISDN protocol family
[    9.515549][    T1] DSP module 2.0
[    9.515556][    T1] mISDN_dsp: DSP clocks every 80 samples. This equals 1 jiffies.
[    9.522655][    T1] mISDN: Layer-1-over-IP driver Rev. 2.00
[    9.523481][    T1] 0 virtual devices registered
[    9.524502][    T1] usbcore: registered new interface driver HFC-S_USB
[    9.524519][    T1] intel_pstate: CPU model not supported
[    9.524530][    T1] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
[    9.537137][    T1] usbcore: registered new interface driver vub300
[    9.537472][    T1] usbcore: registered new interface driver ushc
[    9.552092][    T1] iscsi: registered transport (iser)
[    9.555962][    T1] SoftiWARP attached
[    9.556710][    T1] Driver 'memconsole' was unable to register with bus_type 'coreboot' because the bus was not initialized.
[    9.556724][    T1] Driver 'vpd' was unable to register with bus_type 'coreboot' because the bus was not initialized.
[    9.577857][    T1] hid: raw HID events driver (C) Jiri Kosina
[    9.659663][    T1] usbcore: registered new interface driver usbhid
[    9.659678][    T1] usbhid: USB HID core driver
[    9.670996][    T1] usbcore: registered new interface driver es2_ap_driver
[    9.671013][    T1] comedi: version 0.7.76 - http://www.comedi.org
[    9.672407][    T1] usbcore: registered new interface driver dt9812
[    9.673045][    T1] usbcore: registered new interface driver ni6501
[    9.673705][    T1] usbcore: registered new interface driver usbdux
[    9.674341][    T1] usbcore: registered new interface driver usbduxfast
[    9.675032][    T1] usbcore: registered new interface driver usbduxsigma
[    9.675723][    T1] usbcore: registered new interface driver vmk80xx
[    9.676478][    T1] usbcore: registered new interface driver prism2_usb
[    9.677979][    T1] usbcore: registered new interface driver r8712u
[    9.678861][    T1] greybus: registered new driver hid
[    9.679716][    T1] greybus: registered new driver gbphy
[    9.681416][    T1] gb_gbphy: registered new driver usb
[    9.681426][    T1] asus_wmi: ASUS WMI generic driver loaded
[    9.810733][ T1233] CPU: 0 PID: 1233 Comm: aoe_tx0 Not tainted 5.18.0-rc7-syzkaller-dirty #0
[    9.810733][ T1233] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[    9.810733][ T1233] Call Trace:
[    9.810733][ T1233]  <TASK>
[    9.810733][ T1233]  dump_stack_lvl+0x1e3/0x2cb
[    9.810733][ T1233]  ? bfq_pos_tree_add_move+0x436/0x436
[    9.810733][ T1233]  ? panic+0x76e/0x76e
[    9.810733][ T1233]  ? vscnprintf+0x59/0x80
[    9.810733][ T1233]  ? refcount_warn_saturate+0x120/0x1a0
[    9.810733][ T1233]  panic+0x312/0x76e
[    9.810733][ T1233]  ? __warn+0x131/0x220
[    9.810733][ T1233]  ? fb_is_primary_device+0xcc/0xcc
[    9.810733][ T1233]  ? ret_from_fork+0x1f/0x30
[    9.810733][ T1233]  ? refcount_warn_saturate+0x17c/0x1a0
[    9.810733][ T1233]  __warn+0x1fa/0x220
[    9.810733][ T1233]  ? refcount_warn_saturate+0x17c/0x1a0
[    9.845860][    T1] usbcore: registered new interface driver snd-usb-audio
[    9.846654][    T1] usbcore: registered new interface driver snd-ua101
[    9.847409][    T1] usbcore: registered new interface driver snd-usb-usx2y
[    9.848855][    T1] usbcore: registered new interface driver snd-usb-us122l
[    9.853684][    T1] usbcore: registered new interface driver snd-usb-caiaq
[    9.856046][    T1] usbcore: registered new interface driver snd-usb-6fire
[    9.860384][    T1] usbcore: registered new interface driver snd-usb-hiface
[    9.863557][    T1] usbcore: registered new interface driver snd-bcd2000
[    9.864161][    T1] usbcore: registered new interface driver snd_usb_pod
[    9.864962][    T1] usbcore: registered new interface driver snd_usb_podhd
[    9.865647][    T1] usbcore: registered new interface driver snd_usb_toneport
[    9.866260][    T1] usbcore: registered new interface driver snd_usb_variax
[    9.867610][    T1] drop_monitor: Initializing network drop monitor service
[    9.868126][    T1] NET: Registered PF_LLC protocol family
[    9.868421][    T1] GACT probability on
[    9.868478][    T1] Mirror/redirect action on
[    9.868814][    T1] Simple TC action Loaded
[    9.860705][ T1233]  report_bug+0x1b1/0x2e0
[    9.860705][ T1233]  handle_bug+0x3d/0x70
[    9.860705][ T1233]  exc_invalid_op+0x16/0x40
[    9.860705][ T1233]  asm_exc_invalid_op+0x12/0x20
[    9.860705][ T1233] RIP: 0010:refcount_warn_saturate+0x17c/0x1a0
[    9.860705][ T1233] Code: e8 8a 31 c0 e8 65 80 26 fd 0f 0b e9 64 ff ff ff e8 b9 14 5d fd c6 05 bc 02 c5 09 01 48 c7 c7 80 4b e8 8a 31 c0 e8 44 80 26 fd <0f> 0b e9 43 ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a2 fe ff
[    9.860705][ T1233] RSP: 0000:ffffc900050afc28 EFLAGS: 00010246
[    9.860705][ T1233] RAX: f57a10d46fd60000 RBX: 0000000000000004 RCX: ffff88801e663b00
[    9.860705][ T1233] RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
[    9.860705][ T1233] RBP: 0000000000000004 R08: ffffffff816ad552 R09: fffff52000a15ed5
[    9.860705][ T1233] R10: fffff52000a15ed5 R11: 1ffff92000a15ed4 R12: ffff8881459f05b8
[    9.860705][ T1233] R13: 1ffff92000a15f8c R14: ffff8881459f0600 R15: dffffc0000000000
[    9.860705][ T1233]  ? wake_up_klogd+0xb2/0xf0
[    9.860705][ T1233]  ? refcount_warn_saturate+0x17c/0x1a0
[    9.860705][ T1233]  ref_tracker_free+0x659/0x7a0
[    9.860705][ T1233]  ? refcount_inc+0x80/0x80
[    9.860705][ T1233]  ? do_raw_spin_unlock+0x134/0x8a0
[    9.860705][ T1233]  ? _raw_spin_unlock_irq+0x1f/0x40
[    9.860705][ T1233]  ? lockdep_hardirqs_on+0x95/0x140
[    9.860705][ T1233]  tx+0xc9/0x190
[    9.860705][ T1233]  ? aoenet_xmit+0x1a0/0x1a0
[    9.860705][ T1233]  kthread+0x241/0x450
[    9.860705][ T1233]  ? aoe_ktstart+0x130/0x130
[    9.860705][ T1233]  ? do_task_dead+0xc0/0xc0
[    9.860705][ T1233]  ? _raw_spin_unlock+0x40/0x40
[    9.860705][ T1233]  ? lockdep_hardirqs_on_prepare+0x448/0x7b0
[    9.860705][ T1233]  ? __kthread_parkme+0x166/0x1c0
[    9.860705][ T1233]  kthread+0x266/0x300
[    9.860705][ T1233]  ? aoe_ktstart+0x130/0x130
[    9.860705][ T1233]  ? kthread_blkcg+0xd0/0xd0
[    9.860705][ T1233]  ret_from_fork+0x1f/0x30
[    9.860705][ T1233]  </TASK>
[    9.860705][ T1233] Kernel Offset: disabled
[    9.860705][ T1233] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build3020494642=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 744a39e22
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=744a39e220cece33e207035facce6c5ae161b775 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220514-093120'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=744a39e220cece33e207035facce6c5ae161b775 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220514-093120'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=744a39e220cece33e207035facce6c5ae161b775 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220514-093120'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"744a39e220cece33e207035facce6c5ae161b775\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=125fadbe880000


Tested on:

commit:         42226c98 Linux 5.18-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=10a7a8ca6e94600110ec
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=161ac065880000

