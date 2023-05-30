Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5375C716F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjE3VS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjE3VS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:18:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B0CD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:18:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae141785bso4134442f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685481532; x=1688073532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A32IOzcEKwKIBVEgCaUo2EnZJwnzRUHq87fukwKgcUI=;
        b=tV25uxS/RMVVpvkdoc0NHYEy+lpZo3Nnfh4ERYCMwadP+8fKvojEL7o0Y6aV1vi0nV
         spZE0Vet4yQjv3Mmx3UcaEeMDvkz/n8riVMj6y7c9QIMXVyoyUNPY2IV3i8U8z0GlW7d
         gxbq+7T2iH/TKALahGu1rmbGgOQHbhPJ30UxGmb+DQc9K4LkVduGPpoFZjk4yPlEMb5t
         OJZ3R/WuuoJBs1aRhp00jZ2syX+mmN1J9YaOQtUZrpO8mhGYHvhgg1mZvviCuiusuiHl
         aMeAVkoMVCsKzVp27zypSlc0Zu+TevFLO4m0jFDxDsOI2vTAKxxPTH7deZcp8tjN+mhU
         e9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481532; x=1688073532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A32IOzcEKwKIBVEgCaUo2EnZJwnzRUHq87fukwKgcUI=;
        b=QdWOvB3lBw2v25Jqx6zIQg1XqcDD8XsZI/1ZUnTH7A5CEtP0LI14ES7dD2xJjM03yD
         4CQhI2Cj5PImQGPtRYBW5GLv783wbj1sm2pmPPXceVV9/RN86nNJTTtKT6lO2dj/9vPR
         o52F4HPlpXJarWBQKXcgnaY2u196eWSn6t+r/VEI6QWcm7GR2huRM2jwCEyEvS5B6wry
         dpLMjTFNmjqIzcEW0YWKvwJARFYrKDMC/HR0MrlOODzJLLvNmpGo4y4C7sJv0L+07vKB
         uejLtXn+7+CbQloeWZf9qqU0ftEYv6lKXyyDVkmET4yi4rYMK6hDHmNJlS+rFXMv7IDa
         k5sw==
X-Gm-Message-State: AC+VfDzEkCb+uYZcW+v3b3xJ9B4er7GccO640QbAo10t0lFS1La8mExq
        cl6pkk1kwT4IhCX3JY5tRkD+YF/8cqgigdQFCRb2aQ==
X-Google-Smtp-Source: ACHHUZ5TO5J2GQ75Yar2RMHUtCn5i0cwCQ4ONQb1u+YmK0xHzBF/1UWDBVO5NeKINB6xiu8r1VORP/WeEkTjGy26RDs=
X-Received: by 2002:a5d:44ca:0:b0:309:54b6:33b0 with SMTP id
 z10-20020a5d44ca000000b0030954b633b0mr2538848wrr.44.1685481531854; Tue, 30
 May 2023 14:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <20230519001709.2563-15-tj@kernel.org>
In-Reply-To: <20230519001709.2563-15-tj@kernel.org>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Tue, 30 May 2023 14:18:40 -0700
Message-ID: <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

> @@ -6234,6 +6256,7 @@ static inline void wq_watchdog_init(void) { }
>   */
>  void __init workqueue_init_early(void)
>  {
> +       struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
>         int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
>         int i, cpu;
>
> @@ -6248,6 +6271,22 @@ void __init workqueue_init_early(void)
>         wq_update_pod_attrs_buf = alloc_workqueue_attrs();
>         BUG_ON(!wq_update_pod_attrs_buf);
>
> +       /* initialize WQ_AFFN_SYSTEM pods */
> +       pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
> +       pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);
> +       pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
> +       BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
> +
> +       BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[0], GFP_KERNEL, NUMA_NO_NODE));
> +
> +       wq_update_pod_attrs_buf = alloc_workqueue_attrs();
> +       BUG_ON(!wq_update_pod_attrs_buf);
> +

Looks like allocation for wq_update_pod_attrs_buf is already being
done in the preceding code block.

I am trying to evaluate this series to see if it helps with the
scheduling delays we have seen in EROFS.
In addition to the panic and fix reported by Prateek [0], I am having
stability issues only with the series applied.
I am testing with Pixel 6 and android-mainline kernel [1]

The panic seems to be in the context of kworker for events_unbound wq.
The only significant change directly to events_unbound wq was in patch [2]

@@ -6399,7 +6335,7 @@ void __init workqueue_init_early(void)
  system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
  system_long_wq = alloc_workqueue("events_long", 0, 0);
  system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
-    WQ_UNBOUND_MAX_ACTIVE);
+    WQ_MAX_ACTIVE);
  system_freezable_wq = alloc_workqueue("events_freezable",
       WQ_FREEZABLE, 0);
  system_power_efficient_wq = alloc_workqueue("events_power_efficient",

Panic log:
[  316.386684][  T115] Unable to handle kernel paging request at
virtual address ffffffd2745a0160
[  316.386936][  T115] Mem abort info:
[  316.387027][  T115]   ESR = 0x0000000096000007
[  316.387137][  T115]   EC = 0x25: DABT (current EL), IL = 32 bits
[  316.387284][  T115]   SET = 0, FnV = 0
[  316.387378][  T115]   EA = 0, S1PTW = 0
[  316.387475][  T115]   FSC = 0x07: level 3 translation fault
[  316.387606][  T115] Data abort info:
[  316.387694][  T115]   ISV = 0, ISS = 0x00000007
[  316.387804][  T115]   CM = 0, WnR = 0
[  316.387897][  T115] swapper pgtable: 4k pages, 39-bit VAs,
pgdp=0000000081dec000
[  316.388071][  T115] [ffffffd2745a0160] pgd=10000009d83ff003,
p4d=10000009d83ff003, pud=10000009d83ff003, pmd=10000009d83fb003,
pte=0000000000000000
[  316.388491][  T115] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
[  316.388765][  T115] debug-snapshot dss: core register saved(CPU:2)
[  316.388993][  T115] debug-snapshot dss: ECC error check erridr_el1.num = 0x2
[  316.389260][  T115] debug-snapshot dss: ERRSELR_EL1.SEL = 0, NOT
Error, ERXSTATUS_EL1 = 0x0
[  316.389578][  T115] debug-snapshot dss: ERRSELR_EL1.SEL = 1, NOT
Error, ERXSTATUS_EL1 = 0x0
[  316.389898][  T115] debug-snapshot dss: context saved(CPU:2)
[  316.390112][  T115] item - log_kevents is disabled
[  316.390300][  T115] Modules linked in: sec_touch(OE) ftm5(OE)
bcmdhd4389(OE) goog_touch_interface(OE) snd_soc_cs40l2x(OE)
haptics_cs40l2x(OE) google_dock(OE) lwis(OE) panel_boe_nt37290(OE)
panel_samsung_s6e3hc4(OE) panel_samsung_s6e3hc3_c10(OE)
panel_samsung_s6e3fc3_p10(OE) stmvl53l1(OE) slg51000_core(OE)
slg51000_regulator(OE) pinctrl_slg51000(OE) nfc mac802154
ieee802154_socket ieee802154_6lowpan ieee802154 nhc_udp nhc_routing
nhc_mobility nhc_ipv6 nhc_hop nhc_fragment nhc_dest 6lowpan diag tipc
mac80211 l2tp_ppp l2tp_core hidp rfcomm can_gw can_bcm can_raw can
cfg80211 8021q btsdio hci_uart btqca btbcm bluetooth ftdi_sio
usbserial cdc_acm r8153_ecm aqc111 cdc_ncm cdc_eem cdc_ether
ax88179_178a asix usbnet r8152 rtl8150 pptp pppox ppp_mppe ppp_deflate
bsd_comp ppp_generic slhc slcan vcan can_dev mii libarc4 bigocean(OE)
st33spi(OE) st54spi(OE) st21nfc(OE) nitrous(OE) rfkill
exynos_reboot(OE) heatmap(OE) touch_bus_negotiator(OE)
touch_offload(OE) aoc_alsa_dev(OE) aoc_alsa_dev_util(OE)
aoc_uwb_platform_drv(OE)
[  316.390708][  T115]  aoc_uwb_service_dev(OE) aoc_channel_dev(OE)
aoc_control_dev(OE) aoc_char_dev(OE) aoc_core(OE) mailbox_wc(OE)
audiometrics(OE) snd_soc_cs35l41_i2c(OE) snd_soc_cs35l41_spi(OE)
snd_soc_cs35l41(OE) snd_soc_wm_adsp(OE) max20339(OE) pca9468(OE)
p9221(OE) max77759_charger(OE) max77729_charger(OE) max77729_uic(OE)
max77729_pmic(OE) max1720x_battery(OE) overheat_mitigation(OE)
google_cpm(OE) google_dual_batt_gauge(OE) google_charger(OE)
google_battery(OE) google_bms(OE) abrolhos(OE) mali_kbase(OE)
mali_pixel(OE) panel_samsung_s6e3hc3(OE) panel_samsung_sofef01(OE)
panel_samsung_s6e3fc3(OE) panel_samsung_s6e3hc2(OE)
panel_samsung_emul(OE) panel_samsung_drv(OE) exynos_drm(OE)
arm_memlat_mon(OE) governor_memlat(OE) memlat_devfreq(OE)
exynos_acme(OE) s3c2410_wdt(OE) trusty_virtio(OE) trusty_test(OE)
trusty_log(OE) trusty_irq(OE) gs101_spmic_thermal(OE) gpu_cooling(OE)
debug_reboot(OE) smfc(OE) exynos_mfc(OE) i2c_exynos5(OE)
rtc_s2mpg10(OE) keycombo(OE) goodixfp(OE) usbc_cooling_dev(OE)
tcpci_max77759(OE)
[  316.393987][  T115]  max77759_contaminant(OE) bc_max77759(OE)
max77759_helper(OE) tcpci_fusb307(OE) slg46826(OE) usb_psy(OE)
usb_f_dm1(OE) usb_f_dm(OE) xhci_exynos(OE) ufs_exynos_gs(OE)
s2mpg1x_gpio(OE) bcm47765(OE) sscoredump(OE) sbb_mux(OE) gsc_spi(OE)
g2d(OE) samsung_iommu(OE) samsung_iommu_group(OE) exyswd_rng(OE)
exynos_tty(OE) max77826_gs_regulator(OE) boot_control_sysfs(OE)
exynos_seclog(OE) dbgcore_dump(OE) pixel_stat_mm(OE)
pixel_stat_sysfs(OE) sysrq_hook(OE) hardlockup_debug(OE) eh(OE)
cp_thermal_zone(OE) cpif(OE) bts(OE) exynos_dit(OE) cpif_page(OE)
boot_device_spi(OE) bcm_dbg(OE) exynos_bcm_dbg_dump(OE) gsa_gsc(OE)
slc_acpm(OE) slc_pmon(OE) slc_dummy(OE) acpm_mbox_test(OE)
exynos_devfreq(OE) exynos_dm(OE) slc_pt(OE) power_stats(OE)
exynos_pd_dbg(OE) pixel_em(OE) gs_thermal(OE) google_bcl(OE)
i2c_acpm(OE) s2mpg11_regulator(OE) s2mpg10_regulator(OE) odpm(OE)
s2mpg10_powermeter(OE) s2mpg10_mfd(OE) s2mpg11_powermeter(OE)
pmic_class(OE) s2mpg11_mfd(OE) exynos_cpuhp(OE) pixel_boot_metrics(OE)
exynos_adv_tracer_s2d(OE)
[  316.397483][  T115]  keydebug(OE) exynos_coresight_etm(OE)
exynos_ecc_handler(OE) exynos_coresight(OE) exynos_debug_test(OE)
pixel_debug_test(OE) ehld(OE) sjtag_driver(OE) exynos_adv_tracer(OE)
gsa(OE) trusty_ipc(OE) samsung_dma_heap(OE) trusty_core(OE)
samsung_secure_iova(OE) deferred_free_helper(OE) page_pool(OE)
hardlockup_watchdog(OE) debug_snapshot_debug_kinfo(OE)
debug_snapshot_qd(OE) debug_snapshot_sfrdump(OE) exynos_pd(OE)
dwc3_exynos_usb(OE) gvotable(OE) clk_exynos_gs(OE) pcie_exynos_gs(OE)
exynos_pm(OE) acpm_flexpmu_dbg(OE) pcie_exynos_gs101_rc_cal(OE)
shm_ipc(OE) spi_s3c64xx(OE) samsung_dma(OE) pl330(OE) s2mpu(OE)
logbuffer(OE) itmon(OE) exynos_cpupm(OE) exynos_mct(OE) cmupmucal(OE)
exynos_pm_qos(OE) gs_acpm(OE) kernel_top(OE) dss(OE)
pixel_suspend_diag(OE) systrace(OE) ect_parser(OE) gs_chipid(OE)
pinctrl_exynos_gs(OE) phy_exynos_mipi(OE) phy_exynos_mipi_dsim(OE)
exynos_pmu_if(OE) phy_exynos_usbdrd_super(OE) exynos_pd_el3(OE)
arm_dsu_pmu(E) softdog(E) pps_gpio(E) i2c_dev(E) spidev(E) sg(E)
at24(E) zram zsmalloc
[  316.404101][  T115] CPU: 2 PID: 115 Comm: kworker/u24:2 Tainted: G
      W  OE      6.3.0-mainline-maybe-dirty #1
[  316.404491][  T115] Hardware name: Oriole DVT (DT)
[  316.404678][  T115] Workqueue: events_unbound idle_cull_fn
[  316.404882][  T115] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[  316.405176][  T115] pc : available_idle_cpu+0x20/0x60
[  316.405368][  T115] lr : select_task_rq_fair+0x1d0/0x17d8
[  316.405574][  T115] sp : ffffffc008dfbb40
[  316.405728][  T115] x29: ffffffc008dfbc10 x28: 0000000000000000
x27: 0000000000000008
[  316.406028][  T115] x26: 0000000000000000 x25: 0000000000000001
x24: 0000000000000008
[  316.406323][  T115] x23: 0000000000000000 x22: 0000000000000400
x21: 0000000000000000
[  316.406623][  T115] x20: 0000000000000008 x19: ffffff8800812380
x18: ffffffc008cdf040
[  316.406925][  T115] x17: 00000000aa3494c0 x16: 00000000aa3494c0
x15: 0000000000019ed5
[  316.407221][  T115] x14: 0000000000000001 x13: 000000000001a2d5
x12: 0000000000000010
[  316.407521][  T115] x11: 0000000000000400 x10: de8448a6b7c5d500 x9
: ffffffd27459f6c0
[  316.407822][  T115] x8 : ffffffd27459f6c0 x7 : 0000000000008080 x6
: 0000000000000000
[  316.408118][  T115] x5 : ffffff894f35c590 x4 : 0000646e756f626e x3
: 0000000000000008
[  316.408418][  T115] x2 : 0000000000000001 x1 : ffffff8800812380 x0
: 0000000000000008
[  316.408724][  T115] Call trace:
[  316.408842][  T115]  available_idle_cpu+0x20/0x60
[  316.409020][  T115]  try_to_wake_up+0x4ec/0x85c
[  316.409190][  T115]  wake_up_process+0x18/0x28
[  316.409359][  T115]  wake_dying_workers+0x5c/0xe8
[  316.409539][  T115]  idle_cull_fn+0xdc/0x11c
[  316.409705][  T115]  process_scheduled_works+0x208/0x45c
[  316.409905][  T115]  worker_thread+0x22c/0x31c
[  316.410074][  T115]  kthread+0x114/0x1c0
[  316.410229][  T115]  ret_from_fork+0x10/0x20
[  316.410399][  T115] Code: b00105c9 911b0129 f8605908 8b090108 (f9455109)
[  316.410651][  T115] ---[ end trace 0000000000000000 ]---
[  316.410853][  T115] Kernel panic - not syncing: Oops: Fatal exception
[  316.411097][  T115] SMP: stopping secondary CPUs

Do you think the change in patch [2] could be related?

Thanks,
Sandeep.

[0] https://lore.kernel.org/all/30625cdd-4d61-594b-8db9-6816b017dde3@amd.com/
[1] https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline
[2] https://lore.kernel.org/all/20230519001709.2563-10-tj@kernel.org/
