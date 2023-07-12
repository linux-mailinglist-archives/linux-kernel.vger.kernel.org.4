Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02A750217
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjGLIyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGLIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C5610C4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ABB5616FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CA4C433C9;
        Wed, 12 Jul 2023 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152034;
        bh=ofCXvHTPv/zeJHQl2AqWNKHm4kuKx9N/LP5G1kg4FUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKSHyU47so0wXvJB56wVHrsUh5CU4XXNxkcWHXnovPYDIe9oPVqNSu5ZY2kVLFeF5
         Jh9z1n77j5Zj26zXYYEx5fdHL15syJ6QZa9B7GIiDpJh2RqTpMXoYAx/ilKk9ol/6Z
         46kyJyMamuGJ691fbntFm4e6DM7FDbSR3yg+1EYP0/mRMJXvHR3MC0KVJGUygze7hb
         mi2Zaam4hXkEkJVEqF6QBlVNHoJXnryznTAa05XfLKPGupi441k+/Paz8M8dGa9Jwm
         dqPvo6lqqwUn9xsAFRo1C+R4w9S4vI+wrrBx+ks5CzU/Xvcd/EJMcYj7C6Ug1e8OSR
         8GRbo07ZeYe+A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJVbb-00077r-2n;
        Wed, 12 Jul 2023 10:53:51 +0200
Date:   Wed, 12 Jul 2023 10:53:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops on /proc/interrupt access with 6.5-rc1
Message-ID: <ZK5qH7IXZ1KTg9CN@hovoldconsulting.com>
References: <ZK16bmOPqe4Ev1Hb@hovoldconsulting.com>
 <86a5w2wc2d.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <86a5w2wc2d.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:14:02PM +0100, Marc Zyngier wrote:
> On Tue, 11 Jul 2023 16:51:10 +0100,
> Johan Hovold <johan@kernel.org> wrote:

> > Konrad reported on IRC that he hit a segfault and hang when watch:ing
> > /proc/interrupts with 6.5-rc1.
> >=20
> > I tried simply catting it and hit the below oops immediately with my
> > X13s (aarch64).

> I wonder if you have a driver that periodically allocates an interrupt
> and then frees it...

I checked by instrumenting the descriptor allocator, but that does not
appear to be the case.

> > [ 2546.693932] Unable to handle kernel paging request at virtual addres=
s ffff80008106bb19
>=20
> The VA seems legitimate, and not unusual for a string.
>=20
> > [ 2546.695148] Mem abort info:
> > [ 2546.695562]   ESR =3D 0x0000000096000007
> > [ 2546.695976]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [ 2546.696394]   SET =3D 0, FnV =3D 0
> > [ 2546.696807]   EA =3D 0, S1PTW =3D 0
> > [ 2546.697220]   FSC =3D 0x07: level 3 translation fault
> > [ 2546.697642] Data abort info:
> > [ 2546.698066]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
> > [ 2546.698494]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>=20
> This is a read, but we don't have any valid syndrome information.
>=20
> Could you try and enable KASAN?

Just reproduced it with KASAN enabled. See splat below.

Johan

[  537.007382] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  537.007536] BUG: KASAN: vmalloc-out-of-bounds in string+0xec/0x1ec
[  537.007635] Read of size 1 at addr ffff8000813478d0 by task cat/533

[  537.007752] CPU: 6 PID: 533 Comm: cat Not tainted 6.5.0-rc1 #4
[  537.007836] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (=
1.25 ) 10/12/2022
[  537.007947] Call trace:
[  537.007984]  dump_backtrace+0x9c/0x11c
[  537.008042]  show_stack+0x18/0x24
[  537.008092]  dump_stack_lvl+0x60/0xac
[  537.008147]  print_address_description.constprop.0+0x84/0x394
[  537.008231]  kasan_report+0x110/0x144
[  537.008287]  __asan_load1+0x60/0x6c
[  537.008338]  string+0xec/0x1ec
[  537.008386]  vsnprintf+0x224/0x8b8
[  537.008438]  seq_printf+0x164/0x194
[  537.008491]  show_interrupts+0x40c/0x5e8
[  537.008551]  seq_read_iter+0x5d0/0x738
[  537.008605]  proc_reg_read_iter+0xe8/0x140
[  537.008668]  vfs_read+0x33c/0x444
[  537.008720]  ksys_read+0xc4/0x168
[  537.008770]  __arm64_sys_read+0x44/0x58
[  537.008827]  invoke_syscall+0x60/0x190
[  537.008884]  el0_svc_common.constprop.0+0x80/0x154
[  537.008955]  do_el0_svc+0x38/0xa0
[  537.009006]  el0_svc+0x44/0x90
[  537.009053]  el0t_64_sync_handler+0xc0/0xc4
[  537.009115]  el0t_64_sync+0x190/0x194

[  537.009201] Memory state around the buggy address:
[  537.009269]  ffff800081347780: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[  537.009365]  ffff800081347800: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[  537.009462] >ffff800081347880: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[  537.009557]                                                  ^
[  537.009637]  ffff800081347900: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[  537.009733]  ffff800081347980: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8=
 f8 f8
[  537.009829] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  537.009925] Disabling lock debugging due to kernel taint
[  537.009998] Unable to handle kernel paging request at virtual address ff=
ff8000813478d0
[  537.010100] Mem abort info:
[  537.010139]   ESR =3D 0x0000000096000007
[  537.010191]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  537.010261]   SET =3D 0, FnV =3D 0
[  537.010304]   EA =3D 0, S1PTW =3D 0
[  537.010347]   FSC =3D 0x07: level 3 translation fault
[  537.013925] Data abort info:
[  537.017460]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[  537.021044]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  537.024609]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  537.028157] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000032ef050=
00
[  537.031731] [ffff8000813478d0] pgd=3D10000001000de003, p4d=3D10000001000=
de003, pud=3D10000001000df003, pmd=3D1000000100f0f003, pte=3D00000000000000=
00
[  537.035463] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[  537.039178] Modules linked in: snd_soc_wsa883x q6prm_clocks q6apm_lpass_=
dais snd_q6dsp_common q6apm_dai q6prm michael_mic cbc des_generic libdes ec=
b algif_skcipher md5 algif_hash af_alg ip6_tables xt_LOG nf_log_syslog ipt_=
REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack snd_q6apm nf_conntrack libcrc3=
2c nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter r8152 qrtr_mhi mii panel_ed=
p snd_soc_hdmi_codec fastrpc qrtr_smd venus_dec venus_enc videobuf2_dma_con=
tig rpmsg_ctrl apr videobuf2_memops rpmsg_char qcom_pm8008_regulator pmic_g=
link_altmode qcom_battmgr qcom_spmi_adc5 leds_qcom_lpg qcom_spmi_temp_alarm=
 qcom_pon qcom_spmi_adc_tm5 led_class_multicolor reboot_mode industrialio r=
tc_pm8xxx qcom_vadc_common nvmem_qcom_spmi_sdam hci_uart msm btqca snd_soc_=
sc8280xp ath11k_pci snd_soc_qcom_common gpu_sched ath11k bluetooth qcom_pm8=
008 snd_soc_qcom_sdw regmap_i2c gpio_sbu_mux venus_core ecdh_generic ecc dr=
m_display_helper snd_soc_wcd938x mac80211 v4l2_mem2mem videobuf2_v4l2 snd_s=
oc_wcd938x_sdw snd_soc_lpass_tx_macro qcom_stats
[  537.039382]  snd_soc_lpass_va_macro snd_soc_lpass_rx_macro regmap_sdw sn=
d_soc_lpass_wsa_macro soundwire_qcom snd_soc_wcd_mbhc snd_soc_lpass_macro_c=
ommon videodev drm_dp_aux_bus libarc4 qcom_q6v5_pas phy_qcom_edp videobuf2_=
common snd_soc_core mc qcom_pil_info videocc_sc8280xp snd_compress qcom_com=
mon snd_pcm icc_bwmon cfg80211 qcom_glink_smem phy_qcom_qmp_combo qcom_q6v5=
 drm_kms_helper snd_timer rfkill phy_qcom_qmp_usb qcom_sysmon qrtr pmic_gli=
nk typec mhi snd pinctrl_sc8280xp_lpass_lpi pdr_interface mdt_loader soundw=
ire_bus phy_qcom_snps_femto_v2 pinctrl_lpass_lpi lpasscc_sc8280xp qmi_helpe=
rs soundcore pwm_bl socinfo icc_osm_l3 qcom_wdt qcom_rng drm dm_mod ip_tabl=
es x_tables ipv6 pcie_qcom crc8 phy_qcom_qmp_pcie nvme nvme_core hid_multit=
ouch i2c_qcom_geni i2c_hid_of i2c_hid i2c_core
[  537.081081] CPU: 6 PID: 533 Comm: cat Tainted: G    B              6.5.0=
-rc1 #4
[  537.086148] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (=
1.25 ) 10/12/2022
[  537.091295] pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  537.096402] pc : string+0xec/0x1ec
[  537.101518] lr : string+0xec/0x1ec
[  537.106554] sp : ffff8000802876f0
[  537.111608] x29: ffff8000802876f0 x28: ffffcfdaf4ef5144 x27: 1ffff000100=
50f06
[  537.116753] x26: ffff0a00ffffff04 x25: ffff37069f4a4790 x24: 00000000000=
00000
[  537.121933] x23: 00000000ffffffff x22: 1ffff00010050eea x21: ffff37059f4=
a5000
[  537.127075] x20: ffff8000813478d0 x19: ffff37059f4a4791 x18: 00000000000=
00000
[  537.132149] x17: 0000000000000000 x16: ffffcfdaf413a5d4 x15: 00000000000=
00000
[  537.137241] x14: 1ffff00010050dec x13: 0000000041b58ab3 x12: ffff79fb5ec=
6191d
[  537.142267] x11: 1ffff9fb5ec6191c x10: ffff79fb5ec6191c x9 : dfff8000000=
00000
[  537.147258] x8 : 00008604a139e6e4 x7 : ffffcfdaf630c8e7 x6 : 00000000000=
00001
[  537.152222] x5 : ffffcfdaf630c8e0 x4 : ffff79fb5ec6191d x3 : ffffcfdaf41=
015cc
[  537.157174] x2 : 0000000000000001 x1 : ffff3705815a4e00 x0 : 00000000000=
00001
[  537.162123] Call trace:
[  537.167016]  string+0xec/0x1ec
[  537.171904]  vsnprintf+0x224/0x8b8
[  537.176750]  seq_printf+0x164/0x194
[  537.181551]  show_interrupts+0x40c/0x5e8
[  537.186359]  seq_read_iter+0x5d0/0x738
[  537.191160]  proc_reg_read_iter+0xe8/0x140
[  537.195983]  vfs_read+0x33c/0x444
[  537.200785]  ksys_read+0xc4/0x168
[  537.205557]  __arm64_sys_read+0x44/0x58
[  537.210342]  invoke_syscall+0x60/0x190
[  537.215131]  el0_svc_common.constprop.0+0x80/0x154
[  537.219946]  do_el0_svc+0x38/0xa0
[  537.224761]  el0_svc+0x44/0x90
[  537.229569]  el0t_64_sync_handler+0xc0/0xc4
[  537.234393]  el0t_64_sync+0x190/0x194
[  537.239204] Code: eb19027f 540000a0 aa1403e0 97d8fc79 (38401697)=20
[  537.244064] ---[ end trace 0000000000000000 ]---
[  537.248926] note: cat[533] exited with irqs disabled
[  537.254196] note: cat[533] exited with preempt_count 1
