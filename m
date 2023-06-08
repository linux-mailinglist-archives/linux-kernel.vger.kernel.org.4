Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91617280DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjFHNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjFHNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE45E50;
        Thu,  8 Jun 2023 06:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E4B64D52;
        Thu,  8 Jun 2023 13:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD91C433D2;
        Thu,  8 Jun 2023 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686229503;
        bh=DwKXyrz2Sda25tozOBe/IYkYWp6HyP2bds0RpEZkD6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gt/RPaKPn4cWfUCgXLjAGfustK3MRi/CO9BiqTGB36jYrOvhEsrYcd9wUtHK82eOZ
         Qj3x+7R1NYsAK5mzKVab0A8M4rQPMrJBXZ+9TTRj9AnCFolnlONxq6AKDVE1t7CXKd
         f7NDhwMhNL3zrqfgM4zpl3QLDSUhI6c3RjsU+Hmx/OlUxfpsaPqCkwGxDY0mA9gOW1
         ZW7VxlhA6OTU42lIdu4vv0LWVygYLWvDvTSpvuJnnxc/TaFm50CWnZ2YtpGWNOFqSV
         /B7H2RAXsOsB9KfuEU61Urx9vo+/X0Q80acGtqDArip21vMZoEFiRBcYMl8rcCvRtS
         aDEaATCOVXquw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7FKT-0007wU-1m; Thu, 08 Jun 2023 15:05:29 +0200
Date:   Thu, 8 Jun 2023 15:05:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, andersson@kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Message-ID: <ZIHSGf18w7htb9o8@hovoldconsulting.com>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
 <5d6bcc6a-151e-ac21-2dd2-f72a91f562d5@linaro.org>
 <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
 <ZIHMMFtuDtvdpFAZ@hovoldconsulting.com>
 <a236e2f6-0fd7-f814-f68d-ae0a3e3dfc92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a236e2f6-0fd7-f814-f68d-ae0a3e3dfc92@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:45:22PM +0100, Srinivas Kandagatla wrote:
> On 08/06/2023 13:40, Johan Hovold wrote:

> > Looking at the above log it seems like we hit a probe deferral somewhere
> > as some resource is not available yet, and this is eventually turned
> > into a hard failure that breaks audio as the error is propagated up the
> > stack.
>=20
> I was looking at this too, And I think this change should help..
> Not tried it though

>   	ret =3D snd_soc_tplg_component_load(component, &audioreach_tplg_ops, f=
w);
> -	if (ret < 0) {
> +	if (ret < 0)
>   		dev_err(dev, "tplg component load failed%d\n", ret);
> -		ret =3D -EINVAL;
> -	}

That in itself only seems to make the problem worse with new follow-on
errors. Looks like a dereference of an error pointer in a codec driver:

[   12.086999] snd-sc8280xp sound: ASoC: adding FE link failed
[   12.087231] snd-sc8280xp sound: ASoC: topology: could not load header: -=
517
[   12.087547] qcom-apm gprsvc:service:2:1: tplg component load failed-517
[   12.088865] snd-sc8280xp sound: ASoC: failed to instantiate card -517
[   12.117093] genirq: Flags mismatch irq 289. 00002001 (HPHR PDM WD INT) v=
s. 00002001 (HPHR PDM WD INT)
[   12.117504] wcd938x_codec audio-codec: Failed to request HPHR WD interru=
pt (-16)
[   12.117664] genirq: Flags mismatch irq 290. 00002001 (HPHL PDM WD INT) v=
s. 00002001 (HPHL PDM WD INT)
[   12.117861] wcd938x_codec audio-codec: Failed to request HPHL WD interru=
pt (-16)
[   12.118010] genirq: Flags mismatch irq 291. 00002001 (AUX PDM WD INT) vs=
=2E 00002001 (AUX PDM WD INT)
[   12.118197] wcd938x_codec audio-codec: Failed to request Aux WD interrup=
t (-16)
[   12.118579] genirq: Flags mismatch irq 292. 00002001 (mbhc sw intr) vs. =
00002001 (mbhc sw intr)
[   12.118763] wcd938x_codec audio-codec: Failed to request mbhc interrupts=
 -16
[   12.122415] snd-sc8280xp sound: ASoC: Parent card not yet available, wid=
get card binding deferred
[   12.126740] Unable to handle kernel paging request at virtual address ff=
fffffffffffff8
[   12.126856] Mem abort info:
[   12.126903]   ESR =3D 0x0000000096000004
[   12.126961]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   12.127036]   SET =3D 0, FnV =3D 0
[   12.127085]   EA =3D 0, S1PTW =3D 0
[   12.127135]   FSC =3D 0x04: level 0 translation fault
[   12.127205] Data abort info:
[   12.127250]   ISV =3D 0, ISS =3D 0x00000004
[   12.127308]   CM =3D 0, WnR =3D 0
[   12.127356] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000028e41b0=
00
[   12.127445] [fffffffffffffff8] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[   12.127624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   12.127674] Modules linked in: q6apm_dai q6apm_lpass_dais snd_soc_wsa883=
x q6prm_clocks snd_q6dsp_common q6prm michael_mic cbc des_generic libdes ec=
b algif_skcipher md5 algif_hash af_alg ip6_tables xt_LOG nf_log_syslog ipt_=
REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack snd_q6apm nf_conntrack libcrc3=
2c nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter r8152 mii qrtr_mhi panel_ed=
p snd_soc_hdmi_codec venus_dec venus_enc fastrpc gpio_sbu_mux rpmsg_ctrl ap=
r videobuf2_dma_contig rpmsg_char qrtr_smd qcom_spmi_adc_tm5 videobuf2_memo=
ps snd_soc_lpass_va_macro snd_soc_lpass_tx_macro snd_soc_lpass_wsa_macro sn=
d_soc_lpass_rx_macro snd_soc_lpass_macro_common ath11k_pci qcom_pm8008_regu=
lator ath11k mac80211 venus_core pmic_glink_altmode qcom_battmgr msm libarc=
4 v4l2_mem2mem hci_uart videobuf2_v4l2 gpu_sched btqca videodev bluetooth d=
rm_display_helper cfg80211 phy_qcom_qmp_combo videobuf2_common leds_qcom_lp=
g qcom_spmi_temp_alarm drm_dp_aux_bus ecdh_generic qcom_spmi_adc5 drm_kms_h=
elper mc ecc led_class_multicolor rtc_pm8xxx mhi industrialio
[   12.127941]  qcom_pon rfkill syscopyarea snd_soc_sc8280xp reboot_mode qc=
om_vadc_common sysfillrect nvmem_qcom_spmi_sdam qcom_pm8008 snd_soc_wcd938x=
 sysimgblt snd_soc_qcom_common snd_soc_qcom_sdw videocc_sc8280xp typec phy_=
qcom_edp qcom_stats regmap_i2c snd_soc_wcd938x_sdw phy_qcom_qmp_usb pinctrl=
_sc8280xp_lpass_lpi phy_qcom_snps_femto_v2 qcom_q6v5_pas icc_bwmon soundwir=
e_qcom regmap_sdw pinctrl_lpass_lpi snd_soc_wcd_mbhc lpasscc_sc8280xp qcom_=
pil_info snd_soc_core qcom_common snd_compress qcom_glink_smem qcom_q6v5 sn=
d_pcm qcom_sysmon snd_timer icc_osm_l3 mdt_loader qrtr qcom_wdt qcom_rng sn=
d pmic_glink pdr_interface soundcore socinfo qmi_helpers pwm_bl soundwire_b=
us drm dm_mod ip_tables x_tables ipv6 pcie_qcom crc8 phy_qcom_qmp_pcie nvme=
 nvme_core hid_multitouch i2c_qcom_geni i2c_hid_of i2c_hid i2c_core
[   12.129101] CPU: 1 PID: 158 Comm: kworker/u16:7 Not tainted 6.4.0-rc5 #62
[   12.129153] Hardware name: LENOVO 21BYZ9SRUS/21BYZ9SRUS, BIOS N3HET53W (=
1.25 ) 10/12/2022
[   12.129209] Workqueue: events_unbound deferred_probe_work_func
[   12.129267] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   12.129319] pc : wcd_mbhc_start+0x28/0x380 [snd_soc_wcd_mbhc]
[   12.129381] lr : wcd938x_codec_set_jack+0x28/0x48 [snd_soc_wcd938x]
[   12.129445] sp : ffff80000a523950
[   12.129471] x29: ffff80000a523950 x28: ffff408fd176f080 x27: ffff408fd17=
6c880
[   12.129530] x26: ffffac710f2c0b20 x25: 0002000000000000 x24: 00000000fff=
ffdf4
[   12.129588] x23: ffff408fd176c880 x22: ffff408fd176d518 x21: ffff408fd17=
6f080
[   12.129645] x20: ffff408fc5c30c80 x19: fffffffffffffff0 x18: 00000000000=
00020
[   12.129701] x17: 0000000000000000 x16: ffffac710e565dac x15: fffffffffff=
fffff
[   12.129758] x14: ffff40905779741b x13: ffffffffffffffff x12: 00000000000=
00000
[   12.129814] x11: ffff409b340586f0 x10: ffffac710fbcf1e0 x9 : 00000000000=
00000
[   12.129870] x8 : ffff408fd9288700 x7 : 0000000000000000 x6 : ffff408fd77=
891a0
[   12.129926] x5 : ffff408fd176f750 x4 : 0000000000000000 x3 : ffffac70c86=
62310
[   12.132271] x2 : ffff408fd176d518 x1 : ffff408fc3480158 x0 : fffffffffff=
ffff0
[   12.133443] Call trace:
[   12.134003]  wcd_mbhc_start+0x28/0x380 [snd_soc_wcd_mbhc]
[   12.134567]  wcd938x_codec_set_jack+0x28/0x48 [snd_soc_wcd938x]
[   12.135131]  snd_soc_component_set_jack+0x28/0x8c [snd_soc_core]
[   12.135709]  qcom_snd_wcd_jack_setup+0x7c/0x19c [snd_soc_qcom_common]
[   12.136278]  sc8280xp_snd_init+0x20/0x2c [snd_soc_sc8280xp]
[   12.137080]  snd_soc_link_init+0x28/0x90 [snd_soc_core]
[   12.139427]  snd_soc_bind_card+0x628/0xbfc [snd_soc_core]
[   12.141761]  snd_soc_register_card+0xec/0x104 [snd_soc_core]
[   12.144082]  devm_snd_soc_register_card+0x4c/0xa4 [snd_soc_core]
[   12.146402]  sc8280xp_platform_probe+0xf0/0x108 [snd_soc_sc8280xp]
[   12.148694]  platform_probe+0x68/0xd8
[   12.150969]  really_probe+0x184/0x3c8
[   12.153257]  __driver_probe_device+0x7c/0x16c
[   12.155532]  driver_probe_device+0x3c/0x110
[   12.157787]  __device_attach_driver+0xbc/0x158
[   12.160056]  bus_for_each_drv+0x84/0xe0
[   12.162304]  __device_attach+0xa8/0x1d4
[   12.164518]  device_initial_probe+0x14/0x20
[   12.166716]  bus_probe_device+0xb0/0xb4
[   12.168924]  deferred_probe_work_func+0xa0/0xf4
[   12.171100]  process_one_work+0x288/0x5bc
[   12.173267]  worker_thread+0x74/0x450
[   12.175409]  kthread+0x124/0x128
[   12.177555]  ret_from_fork+0x10/0x20
[   12.179683] Code: fa401804 54001ae0 a9025bf5 aa0003f3 (f9400415)=20
[   12.181815] ---[ end trace 0000000000000000 ]---

Johan
