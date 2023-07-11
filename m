Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6474F416
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjGKPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjGKPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298FF11D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8375E61515
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D3C433C7;
        Tue, 11 Jul 2023 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689090640;
        bh=U0PHVGVjx0SWnBfY0rtwyyuh4XzWsITCji93Fyu9/T4=;
        h=Date:From:To:Cc:Subject:From;
        b=J9hnMyPYS4p3JT0DLq4L7pafJXtAzcy3U6aqP/ieeh0cyKuFi1AqgDfbNwyUUS61y
         aw5RmYVwCsWOj1qRmEIyQxkV47pSTsO3V0k8bxvF44xLY1zICzAY2WG931XF2AyqF3
         8y3hMt8TeD0dP7gicVF5ujrBlRC/NyEwYGNDMtz1HxxtGpjwENbW51qpYQMYhryaFP
         5lJEmUatIcgqAnUA4St2kWUTg3ZNayGXdD2trBztWmDfldpR+Qn2Yu403Tt+OWSyPX
         ZLeopoo7ZvYOcLsZ5W1M7Kf1qDCQOX6LPQgyb++DxCxsYcpmivSssY9JgXTdaAubB5
         EouOwWvat8BmA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qJFdu-000784-1n;
        Tue, 11 Jul 2023 17:51:10 +0200
Date:   Tue, 11 Jul 2023 17:51:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Oops on /proc/interrupt access with 6.5-rc1
Message-ID: <ZK16bmOPqe4Ev1Hb@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Konrad reported on IRC that he hit a segfault and hang when watch:ing
/proc/interrupts with 6.5-rc1.

I tried simply catting it and hit the below oops immediately with my
X13s (aarch64).

Commit 721255b9826b ("genirq: Use a maple tree for interrupt descriptor
management") stood out when skimming the log, and Marc soon suggested
the same possible culprit on IRC.

I have not been able to reproduce it with the maple tree patch reverted,
but I hit it again after adding it back. Did not trigger immediately
after boot though, I had had the machine idling for a few minutes in
between.

Marc asked for a dump so figured I'd CC the list as well.

Johan


[ 2546.693932] Unable to handle kernel paging request at virtual address ff=
ff80008106bb19
[ 2546.695148] Mem abort info:
[ 2546.695562]   ESR =3D 0x0000000096000007
[ 2546.695976]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[ 2546.696394]   SET =3D 0, FnV =3D 0
[ 2546.696807]   EA =3D 0, S1PTW =3D 0
[ 2546.697220]   FSC =3D 0x07: level 3 translation fault
[ 2546.697642] Data abort info:
[ 2546.698066]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[ 2546.698494]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[ 2546.698922]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[ 2546.699355] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000002d7a050=
00
[ 2546.699792] [ffff80008106bb19] pgd=3D10000001000a5003, p4d=3D10000001000=
a5003, pud=3D10000001000a6003, pmd=3D1000000100d5a003, pte=3D00000000000000=
00
[ 2546.700387] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[ 2546.700796] Modules linked in: snd_soc_wsa883x q6prm_clocks q6apm_lpass_=
dais snd_q6dsp_common q6apm_dai q6prm michael_mic cbc des_generic libdes ec=
b algif_skcipher md5 algif_hash af_alg ip6_tables xt_LOG nf_log_syslog ipt_=
REJECT nf_reject_ipv4 xt_tcpudp snd_q6apm xt_conntrack nf_conntrack libcrc3=
2c nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter r8152 mii qrtr_mhi panel_ed=
p snd_soc_hdmi_codec venus_enc venus_dec apr videobuf2_dma_contig videobuf2=
_memops fastrpc qrtr_smd rpmsg_ctrl rpmsg_char qcom_pm8008_regulator qcom_b=
attmgr pmic_glink_altmode ath11k_pci ath11k venus_core snd_soc_wcd938x v4l2=
_mem2mem hci_uart mac80211 msm videobuf2_v4l2 snd_soc_wcd938x_sdw snd_soc_s=
c8280xp libarc4 btqca snd_soc_qcom_common regmap_sdw snd_soc_lpass_rx_macro=
 videodev snd_soc_lpass_va_macro soundwire_qcom leds_qcom_lpg snd_soc_lpass=
_wsa_macro bluetooth snd_soc_lpass_tx_macro qcom_spmi_adc_tm5 snd_soc_wcd_m=
bhc snd_soc_qcom_sdw snd_soc_lpass_macro_common cfg80211 gpu_sched gpio_sbu=
_mux videobuf2_common qcom_spmi_temp_alarm snd_soc_core
[ 2546.700875]  qcom_spmi_adc5 ecdh_generic drm_display_helper ecc qcom_pon=
 mc snd_compress qcom_q6v5_pas industrialio rtc_pm8xxx reboot_mode phy_qcom=
_qmp_combo mhi led_class_multicolor nvmem_qcom_spmi_sdam drm_dp_aux_bus rfk=
ill qcom_vadc_common snd_pcm qcom_pil_info drm_kms_helper qcom_common phy_q=
com_edp qcom_pm8008 qcom_stats qrtr qcom_glink_smem snd_timer typec videocc=
_sc8280xp icc_bwmon qcom_q6v5 phy_qcom_qmp_usb pinctrl_sc8280xp_lpass_lpi r=
egmap_i2c snd qcom_sysmon phy_qcom_snps_femto_v2 pmic_glink soundwire_bus p=
inctrl_lpass_lpi pdr_interface lpasscc_sc8280xp icc_osm_l3 mdt_loader sound=
core socinfo qcom_wdt qcom_rng qmi_helpers pwm_bl drm dm_mod ip_tables x_ta=
bles ipv6 pcie_qcom crc8 phy_qcom_qmp_pcie nvme nvme_core hid_multitouch i2=
c_qcom_geni i2c_hid_of i2c_hid i2c_core
[ 2546.705703] CPU: 4 PID: 610 Comm: cat Not tainted 6.5.0-rc1 #45
[ 2546.706287] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (=
1.25 ) 10/12/2022
[ 2546.706880] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[ 2546.707476] pc : string+0x4c/0xfc
[ 2546.708080] lr : vsnprintf+0x170/0x748
[ 2546.708674] sp : ffff800083563ac0
[ 2546.709265] x29: ffff800083563ac0 x28: ffff11b942bca791 x27: ffffbb03f92=
e0974
[ 2546.709866] x26: ffffbb03f92e0974 x25: 0000000000000020 x24: 00000000000=
00871
[ 2546.710476] x23: 00000000ffffffd8 x22: ffffbb03f9161778 x21: ffff8000835=
63c10
[ 2546.711083] x20: ffff11b942bca78f x19: ffff11b942bcb000 x18: 00000000000=
00020
[ 2546.711688] x17: 0000000000000000 x16: 0000000000000000 x15: fffffffffff=
fffff
[ 2546.712297] x14: 0000000000000001 x13: 0000000000000003 x12: ffff11b942b=
ca783
[ 2546.712910] x11: 0000000000000000 x10: 0000000000000020 x9 : 00000000000=
00000
[ 2546.713522] x8 : 00000000ffffffff x7 : ffff800083563c10 x6 : 00000000000=
00020
[ 2546.714133] x5 : ffff11b942bcb000 x4 : 0000000000000000 x3 : ffff0a00fff=
fff04
[ 2546.714752] x2 : ffff80008106bb19 x1 : ffffffffffffffff x0 : ffff11b942b=
ca791
[ 2546.715362] Call trace:
[ 2546.715962]  string+0x4c/0xfc
[ 2546.716557]  vsnprintf+0x170/0x748
[ 2546.717152]  seq_printf+0xb4/0xd0
[ 2546.717746]  show_interrupts+0x2f4/0x4e8
[ 2546.718345]  seq_read_iter+0x3bc/0x4ac
[ 2546.718940]  proc_reg_read_iter+0x84/0xd8
[ 2546.719539]  vfs_read+0x1d4/0x294
[ 2546.720137]  ksys_read+0x68/0xf4
[ 2546.720735]  __arm64_sys_read+0x1c/0x28
[ 2546.721335]  invoke_syscall+0x48/0x114
[ 2546.721934]  el0_svc_common.constprop.0+0x60/0x10c
[ 2546.722536]  do_el0_svc+0x30/0x88
[ 2546.723132]  el0_svc+0x40/0xac
[ 2546.723729]  el0t_64_sync_handler+0xc0/0xc4
[ 2546.724329]  el0t_64_sync+0x190/0x194
[ 2546.724930] Code: 91000400 110004e1 eb08009f 540000e0 (38646846)=20
[ 2546.725536] ---[ end trace 0000000000000000 ]---
[ 2546.726143] note: cat[610] exited with irqs disabled
[ 2546.726781] note: cat[610] exited with preempt_count 1

