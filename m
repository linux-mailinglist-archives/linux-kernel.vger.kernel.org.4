Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2670EC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjEXEQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEXEQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:16:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF72135
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:16:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f611ccd06eso3572185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684901780; x=1687493780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmEc5WqQZSUET0iAIqTOqYWxz5JMNkA9A/dk80Cv0qs=;
        b=S+Qn+hoqFZEG8uFKM605UBsf1EmfXPP9jqRifBmVuQdYuphNLciy7tnSrVPm2fSL6q
         wBCtLZ2EyAmNftkCCUksrcoVaZyQKmiw2A29N6U8yGSPvy8wdxPanaAxTiK9jvsw3jXW
         Ux8lSZMzRQ8RKQx4eJCKToDBF3lUzgxWT6egSI0MwudmLa/P1IT9bwCScd2ocMj02cbz
         tZaHPT/eeqzsaRITZ49usraNGt4O2eTtQpE4bdaTjmcXeC+/zIKP0TSmmLrtl6O9NQhu
         /2RGVINK+pXz4UpHPE26Ke8qUh3jJiwot2M6Q6DM0gvDC7on/D1EHeDjqD+0xe6Hqk/R
         WA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684901780; x=1687493780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmEc5WqQZSUET0iAIqTOqYWxz5JMNkA9A/dk80Cv0qs=;
        b=GeOV8P3EgQlxx1QVUnsSCLd5JDMRjykPB5RP350Jwnnc9KrWrslwKi4L68L6vC8n+y
         N2LnwjI4hO1Jcnu/Vb9SGQXxEUFTR/toXsnegerJ6SEgbVOSr29miGwKJUvzo2aVinT+
         gmz8IA4amwKhHYE7j7sOFbSdqodONmOVoo7ktK9rYwGK0oCEqJRvPmAmg0XHZ8ZWwRrA
         VwHf1vpWPcXu96Cv9an8ujQhuMJVnTC+RGTq4kS5sTtaTkEe02ixYykN6AumZR7cl9I1
         4wRP5ptToB6DwBqAygMnEO91xERpYMMFTzgwYtr5mLXe5qdM9R/X4WOTlYY3MN2JBjNO
         fz5A==
X-Gm-Message-State: AC+VfDxIm38ZnXyOYZrvrtCiaice7FKlRicK+bJYREX/jgKx9qdEhyBW
        PQyDgN9G8D2qC93xYcN7v9Mc/A==
X-Google-Smtp-Source: ACHHUZ5sgv/kM9nPS2QyEqyB5h4zXbGI2FZxDv2pak6TEAKlFPF4lyGgRRaL1c5ZuTxTuVmBaQNdKQ==
X-Received: by 2002:adf:f387:0:b0:309:46f5:cea7 with SMTP id m7-20020adff387000000b0030946f5cea7mr12478049wro.17.1684901779831;
        Tue, 23 May 2023 21:16:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b002f103ca90cdsm12925600wrp.101.2023.05.23.21.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:16:17 -0700 (PDT)
Date:   Wed, 24 May 2023 07:16:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jing Xu <U202112064@hust.edu.cn>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        hust-os-kernel-patches@googlegroups.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: mpt3sas: mpt3sas_debugfs: return value check of
 `mpt3sas_debugfs_root`
Message-ID: <89b963ca-52d7-4a60-9c65-dd984efca76e@kili.mountain>
References: <20230423122535.31019-1-U202112064@hust.edu.cn>
 <6e69b57c-80ae-8b6e-cb5f-9e05da46ecd6@redhat.com>
 <1484408f-f68e-4354-ab59-56af9cd1ef14@kili.mountain>
 <b7154e2c-0438-87d1-9edc-7eb1aad40cd1@hust.edu.cn>
 <81d236bb-3913-4eef-bf71-6d17535d6d79@kili.mountain>
 <892bc614-9e2e-904b-29e0-62daeb855f79@redhat.com>
 <3c4b372f-db4b-43b4-b5ab-7f4860cf6f20@kili.mountain>
 <461c6576-71df-c16a-3c4f-4691ae84064f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8IYxMzdF6qow7qm5"
Content-Disposition: inline
In-Reply-To: <461c6576-71df-c16a-3c4f-4691ae84064f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8IYxMzdF6qow7qm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 07:56:02PM +0200, Tomas Henzl wrote:
> The only thing I'd like to see is to have corrected all debugfs_create*
> and that is also optional.

Yeah.  We should fix everything in the file at once.

drivers/scsi/mpt3sas/mpt3sas_debugfs.c:102 mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:127 mpt3sas_setup_debugfs() warn: 'ioc->debugfs_root' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:137 mpt3sas_setup_debugfs() warn: 'ioc->ioc_dump' is an error pointer or valid

Ideally, someone would go through the kernel and do a mass update of
debugfs checking. CC Greg KH.  Write a good cover letter that explains
all the background.  That's how you get stuff like this merged with a
minimum fuss.  It's probably too much to ask of the HUST students.

I have 120 of these warnings and most are debugfs related.  I could
silence them but I'm hoping the iritation will make people fix it.

regards,
dan carpenter


--8IYxMzdF6qow7qm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/usb/host/max3421-hcd.c:1913 max3421_probe() warn: 'max3421_hcd->spi_thread' is an error pointer or valid
drivers/mtd/ubi/debug.c:228 ubi_debugfs_init() warn: 'dfs_rootdir' is an error pointer or valid
drivers/i2c/busses/i2c-imx.c:1392 i2c_imx_init_recovery_info() warn: 'i2c_imx->pinctrl' is an error pointer or valid
drivers/i2c/busses/i2c-at91-master.c:835 at91_init_twi_recovery_gpio() warn: 'rinfo->pinctrl' is an error pointer or valid
drivers/i2c/busses/i2c-gpio.c:268 i2c_gpio_fault_injector_init() warn: 'i2c_gpio_debug_dir' is an error pointer or valid
drivers/i2c/busses/i2c-gpio.c:273 i2c_gpio_fault_injector_init() warn: 'priv->debug_dir' is an error pointer or valid
drivers/hwmon/pmbus/adm1266.c:343 adm1266_init_debugfs() warn: 'data->debugfs_dir' is an error pointer or valid
drivers/hwmon/pmbus/ucd9000.c:515 ucd9000_init_debugfs() warn: 'data->debugfs' is an error pointer or valid
drivers/iommu/tegra-smmu.c:1059 tegra_smmu_debugfs_init() warn: 'smmu->debugfs' is an error pointer or valid
drivers/edac/xgene_edac.c:872 xgene_edac_pmd_create_debugfs_nodes() warn: 'dbgfs_dir' is an error pointer or valid
drivers/edac/xgene_edac.c:1176 xgene_edac_l3_create_debugfs_nodes() warn: 'dbgfs_dir' is an error pointer or valid
drivers/edac/thunderx_edac.c:484 thunderx_create_debugfs_nodes() warn: 'ent' is an error pointer or valid
drivers/platform/chrome/wilco_ec/core.c:130 wilco_ec_probe() warn: 'ec->debugfs_pdev' is an error pointer or valid
drivers/clk/clk-sp7021.c:607 sp7021_clk_probe() warn: 'clk_base' is an error pointer or valid
drivers/clk/clk-sp7021.c:610 sp7021_clk_probe() warn: 'pll_base' is an error pointer or valid
drivers/clk/clk-sp7021.c:613 sp7021_clk_probe() warn: 'sys_base' is an error pointer or valid
drivers/block/aoe/aoecmd.c:1259 aoe_ktstart() warn: 'task' is an error pointer or valid
drivers/block/pktcdvd.c:454 pkt_debugfs_dev_new() warn: 'pd->dfs_d_root' is an error pointer or valid
drivers/ntb/test/ntb_tool.c:1498 tool_setup_dbgfs() warn: 'tc->dbgfs_dir' is an error pointer or valid
drivers/ntb/test/ntb_perf.c:1358 perf_setup_dbgfs() warn: 'perf->dbgfs_dir' is an error pointer or valid
drivers/thermal/mediatek/lvts_thermal.c:191 lvts_debugfs_init() warn: 'lvts_td->dom_dentry' is an error pointer or valid
drivers/thermal/mediatek/lvts_thermal.c:200 lvts_debugfs_init() warn: 'dentry' is an error pointer or valid
drivers/spi/spi-dw-core.c:66 dw_spi_debugfs_init() warn: 'dws->debugfs' is an error pointer or valid
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:92 a5xx_submit_in_rb() warn: 'ptr' is an error pointer or valid
drivers/nvme/host/fault_inject.c:30 nvme_fault_inject_init() warn: 'parent' is an error pointer or valid
drivers/hid/hid-wiimote-debug.c:186 wiidebug_init() warn: 'dbg->eeprom' is an error pointer or valid
drivers/hid/hid-wiimote-debug.c:191 wiidebug_init() warn: 'dbg->drm' is an error pointer or valid
drivers/dma/xilinx/xdma.c:895 xdma_probe() warn: 'reg_base' is an error pointer or valid
drivers/media/i2c/rdacm20.c:641 rdacm20_probe() warn: 'dev->sensor' is an error pointer or valid
drivers/media/platform/aspeed/aspeed-video.c:1979 aspeed_video_debugfs_create() warn: 'debugfs_entry' is an error pointer or valid
drivers/media/platform/aspeed/aspeed-video.c:1982 aspeed_video_debugfs_create() warn: 'debugfs_entry' is an error pointer or valid
drivers/media/common/siano/smsdvb-debugfs.c:472 smsdvb_debugfs_create() warn: 'd' is an error pointer or valid
drivers/media/v4l2-core/v4l2-fwnode.c:1241 v4l2_fwnode_reference_parse_int_props() warn: 'fwnode' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6072 lpfc_debugfs_initialize() warn: 'phba->debug_multixri_pools' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6084 lpfc_debugfs_initialize() warn: 'phba->debug_cgn_buffer' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6097 lpfc_debugfs_initialize() warn: 'phba->debug_rx_monitor' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6110 lpfc_debugfs_initialize() warn: 'phba->debug_ras_log' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6357 lpfc_debugfs_initialize() warn: 'vport->debug_scsistat' is an error pointer or valid
drivers/scsi/lpfc/lpfc_debugfs.c:6368 lpfc_debugfs_initialize() warn: 'vport->debug_ioktime' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:102 mpt3sas_init_debugfs() warn: 'mpt3sas_debugfs_root' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:127 mpt3sas_setup_debugfs() warn: 'ioc->debugfs_root' is an error pointer or valid
drivers/scsi/mpt3sas/mpt3sas_debugfs.c:137 mpt3sas_setup_debugfs() warn: 'ioc->ioc_dump' is an error pointer or valid
drivers/scsi/qla2xxx/qla_dfs.c:119 qla2x00_dfs_create_rport() warn: 'fp->dfs_rport_dir' is an error pointer or valid
drivers/scsi/qla2xxx/qla_dfs.c:701 qla2x00_dfs_setup() warn: 'ha->tgt.dfs_naqp' is an error pointer or valid
drivers/scsi/qla2xxx/qla_dfs.c:708 qla2x00_dfs_setup() warn: 'vha->dfs_rport_root' is an error pointer or valid
drivers/scsi/megaraid/megaraid_sas_debugfs.c:105 megasas_init_debugfs() warn: 'megasas_debugfs_root' is an error pointer or valid
drivers/scsi/megaraid/megaraid_sas_debugfs.c:135 megasas_setup_debugfs() warn: 'instance->debugfs_root' is an error pointer or valid
drivers/scsi/megaraid/megaraid_sas_debugfs.c:147 megasas_setup_debugfs() warn: 'instance->raidmap_dump' is an error pointer or valid
drivers/mmc/core/block.c:2916 mmc_blk_add_debugfs() warn: 'md->status_dentry' is an error pointer or valid
drivers/mmc/core/block.c:2924 mmc_blk_add_debugfs() warn: 'md->ext_csd_dentry' is an error pointer or valid
drivers/nfc/nfcsim.c:340 nfcsim_debugfs_init() warn: 'nfcsim_debugfs_root' is an error pointer or valid
drivers/net/wireless/ath/ath5k/debug.c:985 ath5k_debug_init_device() warn: 'phydir' is an error pointer or valid
drivers/net/wireless/ath/ath9k/htc_drv_debug.c:494 ath9k_htc_init_debug() warn: 'priv->debug.debugfs_phy' is an error pointer or valid
drivers/net/wireless/ath/ath9k/debug.c:1423 ath9k_init_debug() warn: 'sc->debug.debugfs_phy' is an error pointer or valid
drivers/net/wireless/ath/ath6kl/debug.c:1796 ath6kl_debug_init_fs() warn: 'ar->debugfs_phy' is an error pointer or valid
drivers/net/wireless/ath/ath11k/spectral.c:954 ath11k_spectral_debug_register() warn: 'ar->spectral.scan_ctl' is an error pointer or valid
drivers/net/wireless/ath/ath11k/spectral.c:965 ath11k_spectral_debug_register() warn: 'ar->spectral.scan_count' is an error pointer or valid
drivers/net/wireless/ath/ath11k/spectral.c:976 ath11k_spectral_debug_register() warn: 'ar->spectral.scan_bins' is an error pointer or valid
drivers/net/wireless/marvell/mwifiex/debugfs.c:962 mwifiex_dev_debugfs_init() warn: 'priv->dfs_dev_dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c:553 mt7615_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/debugfs.c:112 mt76_register_debugfs_fops() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c:788 mt7996_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c:433 mt7921_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c:101 mt7603_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1221 mt7915_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c:137 mt76x02_init_debugfs() warn: 'dir' is an error pointer or valid
drivers/net/ethernet/broadcom/genet/bcmmii.c:615 bcmgenet_mii_pd_init() warn: 'phydev' is an error pointer or valid
drivers/net/ethernet/broadcom/bgmac.c:1451 bgmac_phy_connect_direct() warn: 'phy_dev' is an error pointer or valid
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:503 bnad_debugfs_init() warn: 'bna_debugfs_root' is an error pointer or valid
drivers/net/ethernet/brocade/bna/bnad_debugfs.c:515 bnad_debugfs_init() warn: 'bnad->port_debugfs_root' is an error pointer or valid
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c:338 otx2_ptp_init() warn: 'ptp_ptr->ptp_clock' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:596 mvpp2_dbgfs_c2_entry_init() warn: 'c2_entry_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:629 mvpp2_dbgfs_flow_tbl_entry_init() warn: 'flow_tbl_entry_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:649 mvpp2_dbgfs_cls_init() warn: 'cls_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:653 mvpp2_dbgfs_cls_init() warn: 'c2_dir' is an error pointer or valid
drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c:663 mvpp2_dbgfs_cls_init() warn: 'flow_tbl_dir' is an error pointer or valid
drivers/net/ethernet/marvell/sky2.c:4532 sky2_debug_init() warn: 'ent' is an error pointer or valid
drivers/net/ethernet/ti/am65-cpts.c:1154 am65_cpts_create() warn: 'cpts->ptp_clock' is an error pointer or valid
drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:291 test_vcap_xn_rule_creator() warn: '__right' is an error pointer or valid
drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:1349 vcap_api_encode_rule_test() warn: '__right' is an error pointer or valid
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1842 i40e_dbg_init() warn: 'i40e_dbg_root' is an error pointer or valid
drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:708 hns_mac_register_phydev() warn: 'phy' is an error pointer or valid
drivers/net/mdio/mdio-xgene.c:268 xgene_enet_phy_register() warn: 'phy_dev' is an error pointer or valid
drivers/mailbox/mailbox-test.c:269 mbox_test_add_debugfs() warn: 'tdev->root_debugfs_dir' is an error pointer or valid
drivers/android/binder.c:6569 binder_init() warn: 'binder_debugfs_dir_entry_root' is an error pointer or valid
drivers/base/firmware_loader/main.c:815 fw_log_firmware_info() warn: 'alg' is an error pointer or valid
drivers/soc/tegra/pmc.c:1197 tegra_powergate_debugfs_init() warn: 'pmc->debugfs' is an error pointer or valid
security/apparmor/domain.c:1184 aa_change_hat() warn: 'new' is an error pointer or valid
security/integrity/evm/evm_secfs.c:289 evm_init_xattrs() warn: 'evm_xattrs' is an error pointer or valid
security/integrity/evm/evm_secfs.c:306 evm_init_secfs() warn: 'evm_dir' is an error pointer or valid
security/integrity/evm/evm_secfs.c:311 evm_init_secfs() warn: 'evm_init_tpm' is an error pointer or valid
security/integrity/evm/evm_secfs.c:318 evm_init_secfs() warn: 'evm_symlink' is an error pointer or valid
security/keys/trusted-keys/trusted_tee.c:111 trusted_tee_seal() warn: 'reg_shm_out' is an error pointer or valid
security/keys/trusted-keys/trusted_tee.c:170 trusted_tee_unseal() warn: 'reg_shm_out' is an error pointer or valid
fs/9p/fid.h:30 v9fs_fid_clone() warn: 'fid' is an error pointer or valid
fs/9p/fid.h:30 v9fs_fid_clone() warn: 'fid' is an error pointer or valid
fs/ceph/cache.c:100 ceph_fscache_register_fs() warn: 'fsc->fscache' is an error pointer or valid
fs/erofs/fscache.c:354 erofs_fscache_register_volume() warn: 'volume' is an error pointer or valid
fs/nfsd/nfs4proc.c:377 nfsd4_create_file() warn: 'child' is an error pointer or valid
fs/nfsd/nfs3proc.c:347 nfsd3_create_file() warn: 'child' is an error pointer or valid
fs/overlayfs/readdir.c:906 ovl_dir_fsync() warn: 'realfile' is an error pointer or valid
fs/pstore/zone.c:1222 psz_init_zones() warn: 'zone' is an error pointer or valid
kernel/locking/lock_events.c:149 init_lockevent_counts() warn: 'd_counts' is an error pointer or valid
kernel/cgroup/cgroup.c:5555 css_create() warn: 'css' is an error pointer or valid
sound/soc/apple/mca.c:955 mca_pcm_new() warn: 'chan' is an error pointer or valid
sound/soc/apple/mca.c:961 mca_pcm_new() warn: 'chan' is an error pointer or valid
net/bluetooth/aosp.c:58 aosp_do_open() warn: 'skb' is an error pointer or valid
net/bluetooth/aosp.c:159 enable_quality_report() warn: 'skb' is an error pointer or valid
net/bluetooth/aosp.c:181 disable_quality_report() warn: 'skb' is an error pointer or valid
net/bluetooth/msft.c:124 read_supported_features() warn: 'skb' is an error pointer or valid
net/bluetooth/msft.c:326 msft_remove_monitor_sync() warn: 'skb' is an error pointer or valid
net/bluetooth/msft.c:442 msft_add_monitor_sync() warn: 'skb' is an error pointer or valid
lib/test_hmm.c:559 dmirror_allocate_chunk() warn: 'ptr' is an error pointer or valid
lib/test_kmod.c:320 try_one_request() warn: 'info->task_sync' is an error pointer or valid
lib/test_firmware.c:918 trigger_batched_requests_store() warn: 'req->task' is an error pointer or valid
lib/notifier-error-inject.c:86 err_inject_init() warn: 'notifier_err_inject_dir' is an error pointer or valid
lib/error-inject.c:220 ei_debugfs_init() warn: 'dir' is an error pointer or valid
lib/error-inject.c:224 ei_debugfs_init() warn: 'file' is an error pointer or valid
mm/frontswap.c:266 init_frontswap() warn: 'root' is an error pointer or valid
mm/shrinker_debug.c:133 shrinker_debugfs_scan_write() warn: 'memcg' is an error pointer or valid

--8IYxMzdF6qow7qm5--
