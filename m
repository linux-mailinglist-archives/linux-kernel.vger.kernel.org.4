Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF46F8E13
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEFChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFChA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:37:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A712693
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683340616; i=efault@gmx.de;
        bh=XsgF4uNEMsXSypxK/Pc24nf4ciBYqz5xIIp29JS0aOM=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=efNGvErYfjPe1SU8Ii0TDbwPt2bvE2jFfM6QXHtRaEeQiWVhhru2+3mCVifsTmXuG
         +HTy+4g3yNSkPndPxkzmFT23ag3x5z1skEQ6699x6aI24KsEnFEiG5CNnK75p0J8Cr
         Hd/LpgYnAgHO75pcFD5SJMAH7T+xixU4pB9qQIcCQKIIQohGGPMPLYogsoVh7JsnOn
         tjvKZSPHs6irYP4H29SRvZTNgfBYvqb7BSFH7txSRfz2zJ2Lgpyw7mQXwImw/AAeMM
         O1gkzpgEZC5hVLs6A1uzxuJCuGtQvWQhsnjXNqoCITRFQPW96+B8NBU/h+Idki46OL
         3iJ4tIkxel3ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1pds1T2D4d-00ITab; Sat, 06
 May 2023 04:36:56 +0200
Message-ID: <dba3f7d693a1e224f4b6808ea0c38eb4897d7121.camel@gmx.de>
Subject: ext4_release_dir..rb_next_postorder crash during resume
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 06 May 2023 04:36:56 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZ0oTJdz23YaBNxck2n/N5d5MI9V99Q561LoCL+uKTtq8wNzTfu
 zshoT+q29HMnlYytCqKS6kz0nFI+4qE7CYj+aWOjWaJJssI1wcQDZTpvmiu4Qp6pae2Ns3d
 PZEPFJeU2wv70xdNG8PunvqfFvAkdAI5w9GQeHuPUZicctCnB7ZA/S8jOX4prltOfPSx/mU
 GsYd6DHQagBOzZjawMEEw==
UI-OutboundReport: notjunk:1;M01:P0:5aPjFGB/7Pk=;ssH64P9G75iPHarAVOA2v3unxXa
 XNtuGhk/nr1AhmPGKyyh2xvFebHZzE4ZowIOv2LAK+RjerQ3CJ5MuS9NkthY6tl+PwJlw1j8m
 O81IZW5ecae60xWq9C16CO42m99MQOu15XecPoHv06FTS7m43EOGoDEueLNm8Y8ShKTzZrSmJ
 65muCZVz1W0zbc2ngKdIlmB9BtXKpVwm1Ggp731A1Q4JNmNcyUJ/8aAvHu5bc9LqzYN055Uyg
 Y41WB/MVPwtfZHoLoFLPVjEcsztIqp31MMs6voAsYf7pGYhZeKULBPUmETU08T/hBz7lyWadI
 FgAqxGgzYcQ/UcPw+I14P3mtVaELc7e6VeXzH9eO9rv8yVxy2KxmTbhDOnOcK27LB33XmsMQv
 NsNtYVpOWwnFfznjF6C18svFMn+e1vVqrFns7H7HCUPE7rAi/Am7bKOtlPjrUzJl2MxaLVbYW
 OX3hsVYqiHmRAGcU3pvQUXlYbPobn3OapKdYq5EsMzSgXbhs/DJ42fHXXWRZkKxElOfM2uIqM
 vqco7WDq+a8V6sT4kiudv5M1DCAfdwMV/UdZF+uDqF/YRI9bkgE/hgMmlgwb9NEsDpaXvuZpP
 kkDbe96+jCq88MAtjXlNuwPxrAWVUhYUffZykFdX5swoh6qAQXK64bt2jw5zWMjs5Nt/LXAl8
 OeOiqFX/TwmT4aBfuGOuc0fXoOZzvXQsHkPmYoOClvK3NoiXF1Wp/3jFZdLnVPwrPNunLmJvA
 ZJ6vUgT2iQaplGfwSs1wejHzCXKkK+IJLqSx5gXFOZU1KHTZn76NwJ/wD3Jlpqes1OR/djYQC
 TUgL2c42a0OItn4ZjrGMusNA7GMMY6x50tATul+UhBux9JRrXF8kjj69YLznaQ1hr5gLb9hWQ
 KdyLoCXzFWN9YqOWmoD93Mw9p1JnnVZcgCxIMKpEKvGuO1tRMUiktaSeCvYBhcRCX62mYXwiw
 rYgCSVyMcoDjwUdIXJaj1+jlJPQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[11440.128780] PM: suspend exit
[11441.013370] general protection fault, probably for non-canonical address=
 0x3c301188a7121294: 0000 [#1] SMP NOPTI
[11441.013379] CPU: 0 PID: 20199 Comm: mandb Kdump: loaded Tainted: G      =
      E      6.3.0.g78b421b-master #9
[11441.013383] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[11441.013385] RIP: 0010:rb_next_postorder+0x10/0x50
[11441.013391] Code: 10 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 31 c0 48 85 ff 74 12 48 8b 17 48 83 e2 fc 74 09 <48=
> 39 7a 10 48 89 d0 74 05 c3 cc cc cc cc 48 8b 52 08 48 85 d2 74
[11441.013395] RSP: 0018:ffff888289a73e70 EFLAGS: 00010206
[11441.013397] RAX: 0000000000000000 RBX: ffff88819472c7d8 RCX: 00000000003=
77d77
[11441.013400] RDX: 3c301188a7121284 RSI: ffff88819472ca48 RDI: ffff8881947=
2c7e0
[11441.013402] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8881947=
93740
[11441.013403] R10: 0000000000000246 R11: 0000000000000000 R12: ffff8881947=
2c7d8
[11441.013405] R13: 0000000000000000 R14: ffff888194793fc0 R15: 00000000000=
00000
[11441.013407] FS:  00007f00826235c0(0000) GS:ffff88840ec00000(0000) knlGS:=
0000000000000000
[11441.013410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11441.013421] CR2: 000055b19886e000 CR3: 000000022743a002 CR4: 00000000001=
706f0
[11441.013423] Call Trace:
[11441.013426]  <TASK>
[11441.013429]  free_rb_tree_fname+0x2f/0x70 [ext4]
[11441.013465]  ext4_release_dir+0x1a/0x30 [ext4]
[11441.013486]  __fput+0x87/0x240
[11441.013491]  task_work_run+0x66/0xa0
[11441.013505]  exit_to_user_mode_prepare+0x18a/0x190
[11441.013508]  syscall_exit_to_user_mode+0x12/0x30
[11441.013512]  do_syscall_64+0x46/0x90
[11441.013515]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[11441.013519] RIP: 0033:0x7f0081716ae7
[11441.013521] Code: 02 b8 ff ff ff ff eb c0 66 2e 0f 1f 84 00 00 00 00 00 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 b8 03 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 09 f3 c3 0f 1f 80 00 00 00 00 48 8b 15 71 d3
[11441.013524] RSP: 002b:00007ffcc64775e8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003
[11441.013527] RAX: 0000000000000000 RBX: 000055b198858b30 RCX: 00007f00817=
16ae7
[11441.013529] RDX: 00007f00817f4a40 RSI: 0000000000000000 RDI: 00000000000=
00004
[11441.013530] RBP: 000055b1974208e0 R08: 0000000000000000 R09: 000055b1974=
20878
[11441.013532] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcc64=
77708
[11441.013534] R13: 000055b198858b50 R14: 000055b198865e70 R15: 00000000000=
00000
[11441.013536]  </TASK>
[11441.013538] Modules linked in: af_packet(E) uas(E) ip6table_mangle(E) ip=
6table_raw(E) iptable_raw(E) usblp(E) joydev(E) usb_storage(E) bridge(E) st=
p(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) nfnetlink(E) ebtabl=
e_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) =
bpfilter(E) nls_iso8859_1(E) nls_cp437(E) intel_rapl_msr(E) intel_rapl_comm=
on(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) =
iTCO_wdt(E) snd_hda_codec_realtek(E) intel_pmc_bxt(E) at24(E) snd_hda_codec=
_generic(E) regmap_i2c(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) mei_hdcp(E=
) iTCO_vendor_support(E) snd_hda_intel(E) snd_intel_dspcfg(E) kvm(E) snd_hd=
a_codec(E) snd_hwdep(E) snd_hda_core(E) r8169(E) irqbypass(E) snd_pcm(E) re=
altek(E) i2c_i801(E) snd_timer(E) pcspkr(E) mdio_devres(E) i2c_smbus(E) mei=
_me(E) snd(E) lpc_ich(E) libphy(E) soundcore(E) mfd_core(E) mei(E) fan(E) t=
hermal(E) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) =
grace(E) sch_fq_codel(E) sunrpc(E) fuse(E) configfs(E)
[11441.013582]  ip_tables(E) x_tables(E) hid_logitech_hidpp(E) hid_logitech=
_dj(E) hid_generic(E) usbhid(E) nouveau(E) drm_ttm_helper(E) ttm(E) i2c_alg=
o_bit(E) drm_display_helper(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_cl=
mulni_intel(E) drm_kms_helper(E) sha512_ssse3(E) sha512_generic(E) xhci_pci=
(E) syscopyarea(E) sysfillrect(E) ehci_pci(E) sysimgblt(E) ahci(E) aesni_in=
tel(E) xhci_hcd(E) libahci(E) crypto_simd(E) ehci_hcd(E) cryptd(E) drm(E) l=
ibata(E) usbcore(E) cec(E) usb_common(E) rc_core(E) video(E) wmi(E) button(=
E) sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E)=
 vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio(E) virtio_ring(E) ext4(=
E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E=
) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi=
_common(E) msr(E) efivarfs(E) autofs4(E)
[11441.013627] Dumping ftrace buffer:
[11441.013630]    (ftrace buffer empty)

(gdb) list *rb_next_postorder+0x10
0xffffffff818d9eb0 is in rb_next_postorder (lib/rbtree.c:612).
607             if (!node)
608                     return NULL;
609             parent =3D rb_parent(node);
610
611             /* If we're sitting on node, we've already seen our childre=
n */
612             if (parent && node =3D=3D parent->rb_left && parent->rb_rig=
ht) {
613                     /* If we are the parent's left node, go to the pare=
nt's right
614                      * node then all the way down to the left */
615                     return rb_left_deepest_node(parent->rb_right);
616             } else
(gdb)


