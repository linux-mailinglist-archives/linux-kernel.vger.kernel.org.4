Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56FA69FD01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjBVUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:31:18 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B936FDA;
        Wed, 22 Feb 2023 12:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677097874;
        bh=MB2LZtzkBJ6ub5UtBqAbNL4ncirHjUWCKT14dX41MCE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=HPT/ZQUDRS7F9JH0OXCwuYqc49uDL4oaz6ZM8gH57rzUDYVde03nsRZthctsFtyoz
         vlsdj44qsDX3wS83iyG0WpZDHwaQrB042CsEEe32W8bXHlYYstfC6rElHHbThKm+aq
         hIjfkimudkEj9YuvepgRNlx3PALYO0uZFNxDhTIU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4C41B1286B3E;
        Wed, 22 Feb 2023 15:31:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hylh4WCSized; Wed, 22 Feb 2023 15:31:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677097874;
        bh=MB2LZtzkBJ6ub5UtBqAbNL4ncirHjUWCKT14dX41MCE=;
        h=Message-ID:Subject:From:To:Date:From;
        b=HPT/ZQUDRS7F9JH0OXCwuYqc49uDL4oaz6ZM8gH57rzUDYVde03nsRZthctsFtyoz
         vlsdj44qsDX3wS83iyG0WpZDHwaQrB042CsEEe32W8bXHlYYstfC6rElHHbThKm+aq
         hIjfkimudkEj9YuvepgRNlx3PALYO0uZFNxDhTIU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9EEC61286B1A;
        Wed, 22 Feb 2023 15:31:13 -0500 (EST)
Message-ID: <838f8d602c321a86f829344f07c5681d371134f1.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.2+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Feb 2023 15:31:12 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (ufs, lpfc, qla2xxx, libsas).  The major
core change is a rework to remove the two helpers around
scsi_execute_cmd and use it as the only submission interface along with
other minor fixes and updates.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Abel Vesa (2):
      scsi: ufs: qcom: dt-bindings: Add SM8550 compatible string
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW version major 5

Alim Akhtar (2):
      scsi: MAINTAINERS: Add entry for Exynos UFS driver
      scsi: ufs: ufs: Remove duplicate entry

Andrew Halaney (4):
      scsi: ufs: ufs-qcom: Use dev_err() where possible
      scsi: ufs: ufs-qcom: Remove usage of dbg_print_en
      scsi: ufs: ufs-qcom: Clean up dbg_register_dump
      scsi: ufs: ufs-qcom: Drop unnecessary NULL checks

Anjana Hari (1):
      scsi: ufs: core: Add hibernation callbacks

Arnd Bergmann (2):
      scsi: ufs: qcom: fix platform_msi_domain_free_irqs() reference
      scsi: qla2xxx: Fix printk() format string

Arthur Simchaev (4):
      scsi: ufs: core: Remove ufshcd_map_desc_id_to_length()
      scsi: ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl()
      scsi: ufs: core: Remove redundant desc_size variable from hba
      scsi: ufs: core: Remove redundant wb check

Arun Easi (1):
      scsi: qla2xxx: Fix DMA-API call trace on NVMe LS requests

Asutosh Das (15):
      scsi: ufs: core: mcq: Enable multi-circular queue
      scsi: ufs: core: mcq: Add completion support in poll
      scsi: ufs: mcq: Add completion support of a CQE
      scsi: ufs: core: Prepare for completion in MCQ
      scsi: ufs: core: mcq: Find hardware queue to queue request
      scsi: ufs: core: Prepare ufshcd_send_command() for MCQ
      scsi: ufs: core: mcq: Use shared tags for MCQ mode
      scsi: ufs: core: mcq: Configure operation and runtime interface
      scsi: ufs: core: mcq: Allocate memory for MCQ mode
      scsi: ufs: core: mcq: Calculate queue depth
      scsi: ufs: core: mcq: Configure resource regions
      scsi: ufs: core: mcq: Add support to allocate multiple queues
      scsi: ufs: core: Defer adding host to SCSI if MCQ is supported
      scsi: ufs: core: Introduce multi-circular queue capability
      scsi: ufs: core: Probe for EXT_IID support

Bart Van Assche (6):
      scsi: ufs: core: Fix kernel-doc syntax
      scsi: ufs: core: Enable DMA clustering
      scsi: ufs: exynos: Fix the maximum segment size
      scsi: ufs: exynos: Fix DMA alignment for PAGE_SIZE != 4096
      scsi: ufs: core: Pass the clock scaling timeout as an argument
      scsi: ufs: core: Reduce the clock scaling latency

Bean Huo (10):
      scsi: ufs: core: bsg: Fix cast to restricted __be16 warning
      scsi: core: Fix invisible definition compilation warning
      scsi: ufs: core: bsg: Fix sometimes-uninitialized warnings
      scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg
      scsi: ufs: core: Pass EHS length into ufshcd_prepare_req_desc_hdr()
      scsi: ufs: core: Advanced RPMB detection
      scsi: ufs: core: Split ufshcd_map_sg()
      scsi: ufs: bsg: Clean up ufs_bsg_request()
      scsi: ufs: bsg: Remove unnecessary length checkup
      scsi: ufs: bsg: Let result in struct ufs_bsg_reply be signed int

Bjorn Andersson (1):
      scsi: ufs: core: Limit DMA alignment check

Can Guo (3):
      scsi: ufs: qcom: Add MCQ ESI config vendor specific ops
      scsi: ufs: core: mcq: Add Event Specific Interrupt enable and config functions
      scsi: ufs: core: Add Event Specific Interrupt configuration vendor specific ops

Christophe JAILLET (1):
      scsi: ufs: core: Fix an error handling path in ufshcd_read_desc_param()

Dan Carpenter (1):
      scsi: libsas: Fix an error code in sas_ata_add_dev()

Deepak R Varma (3):
      scsi: qla2xxx: Simplify if condition evaluation
      scsi: qla2xxx: Use a variable for repeated mem_size computation
      scsi: pm8001: Use sysfs_emit() in show function callbacks

Eric Biggers (1):
      scsi: ufs: core: Allow UFS host drivers to override the sg entry size

Fabio M. De Francesco (2):
      scsi: ipr: Replace kmap() with kmap_local_page()
      scsi: ips: Replace kmap_atomic() with kmap_local_page()

Greg Kroah-Hartman (1):
      scsi: snic: Fix memory leak with using debugfs_lookup()

Gustavo A. R. Silva (1):
      scsi: smartpqi: Replace one-element array with flexible-array member

Jason Yan (5):
      scsi: libsas: Factor out sas_ex_add_dev()
      scsi: libsas: Factor out sas_ata_add_dev()
      scsi: libsas: Remove useless dev_list delete in sas_ex_discover_end_dev()
      scsi: libsas: Change the coding style of sas_discover_sata()
      scsi: libsas: Move sas_get_ata_command_set() up to save the declaration

Jiapeng Chong (1):
      scsi: qla2xxx: Remove the unused variable wwn

Jiasheng Jiang (1):
      scsi: aic94xx: Add missing check for dma_map_single()

Johan Hovold (1):
      scsi: ufs: qcom: dt-bindings: Allow 'dma-coherent' property

Justin Tee (12):
      scsi: lpfc: Copyright updates for 14.2.0.10 patches
      scsi: lpfc: Update lpfc version to 14.2.0.10
      scsi: lpfc: Introduce new attention types for lpfc_sli4_async_fc_evt() handler
      scsi: lpfc: Reinitialize internal VMID data structures after FLOGI completion
      scsi: lpfc: Fix use-after-free KFENCE violation during sysfs firmware write
      scsi: lpfc: Exit PRLI completion handling early if ndlp not in PRLI_ISSUE state
      scsi: lpfc: Remove duplicate ndlp kref decrement in lpfc_cleanup_rpis()
      scsi: lpfc: Remove redundant clean up code in disable_vport()
      scsi: lpfc: Set max DMA segment size to HBA supported SGE length
      scsi: lpfc: Resolve miscellaneous variable set but not used compiler warnings
      scsi: lpfc: Replace outdated strncpy() with strscpy()
      scsi: lpfc: Fix space indentation in lpfc_xcvr_data_show()

Kees Cook (5):
      scsi: aacraid: Allocate cmd_priv with scsicmd
      scsi: megaraid_sas: Add flexible array member for SGLs
      scsi: uapi: Replace 0-length array with flexible array
      scsi: mvumi: Replace 1-element arrays with flexible array members
      scsi: 3w-sas: Replace 1-element arrays with flexible array members

Manivannan Sadhasivam (11):
      scsi: MAINTAINERS: Add myself as the maintainer for Qcom UFS drivers
      scsi: ufs: ufs-qcom: Add support for finding max gear on new platforms
      scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device
      scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
      scsi: ufs: core: Add support for reinitializing the UFS device
      scsi: ufs: core: Add reinit_notify() callback
      scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
      scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
      scsi: ufs: ufs-qcom: Use bitfields where appropriate
      scsi: ufs: ufs-qcom: Remove unnecessary WARN_ON()
      scsi: ufs: ufs-qcom: Remove unnecessary goto statements

Mason Zhang (1):
      scsi: ufs: core: Fix device management cmd timeout flow

Mike Christie (15):
      scsi: core: Remove scsi_execute_req()/scsi_execute() functions
      scsi: cxlflash: Convert to scsi_execute_cmd()
      scsi: target: target_core_pscsi: Convert to scsi_execute_cmd()
      scsi: virtio_scsi: Convert to scsi_execute_cmd()
      scsi: sr: Convert to scsi_execute_cmd()
      scsi: ses: Convert to scsi_execute_cmd()
      scsi: zbc: Convert to scsi_execute_cmd()
      scsi: sd: Convert to scsi_execute_cmd()
      scsi: spi: Convert to scsi_execute_cmd()
      scsi: core: Convert to scsi_execute_cmd()
      scsi: scsi_dh: Convert to scsi_execute_cmd()
      scsi: ch: Convert to scsi_execute_cmd()
      scsi: hwmon: drivetemp: Convert to scsi_execute_cmd()
      scsi: ata: libata-scsi: Convert to scsi_execute_cmd()
      scsi: core: Add struct for args to execution functions

Nilesh Javali (3):
      scsi: qla2xxx: Update version to 10.02.08.200-k
      scsi: qla2xxx: Update version to 10.02.08.100-k
      scsi: qla2xxx: Fix IOCB resource check warning

Paul Menzel (1):
      scsi: mpt3sas: Demote log level for trace buffer allocation to info

Quinn Tran (14):
      scsi: qla2xxx: edif: Fix clang warning
      scsi: qla2xxx: edif: Reduce memory usage during low I/O
      scsi: qla2xxx: edif: Fix stall session after app start
      scsi: qla2xxx: edif: Fix performance dip due to lock contention
      scsi: qla2xxx: Relocate/rename vp map
      scsi: qla2xxx: Remove dead code (GNN ID)
      scsi: qla2xxx: Remove dead code (GPNID)
      scsi: qla2xxx: Remove dead code
      scsi: qla2xxx: Fix erroneous link down
      scsi: qla2xxx: Remove unintended flag clearing
      scsi: qla2xxx: Fix stalled login
      scsi: qla2xxx: Fix exchange oversubscription for management commands
      scsi: qla2xxx: Fix exchange oversubscription
      scsi: qla2xxx: Fix link failure in NPIV environment

Randy Dunlap (4):
      scsi: Documentation: Correct spelling
      scsi: Documentation: Correct spelling
      scsi: target: Documentation: Correct spelling
      scsi: elx: libefc_sli: Use "/*" for non-kernel-doc comment

Saurav Kashyap (1):
      scsi: qla2xxx: Remove increment of interface err cnt

Shreyas Deodhar (2):
      scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called
      scsi: qla2xxx: Check if port is online before sending ELS

Tom Rix (1):
      scsi: qla2xxx: Make qla_trim_buf() and __qla_adjust_buf() static

Tomas Henzl (1):
      scsi: mpt3sas: Fix a memory leak

Zhe Wang (2):
      scsi: ufs: ufs-unisoc: Add support for Unisoc UFS host controller
      scsi: ufs: dt-bindings: Add document for Unisoc UFS host controller

And the diffstat:

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |   4 +
 .../devicetree/bindings/ufs/sprd,ums9620-ufs.yaml  |  79 ++
 Documentation/scsi/ChangeLog.lpfc                  |  36 +-
 Documentation/scsi/ChangeLog.megaraid              |   8 +-
 Documentation/scsi/ChangeLog.megaraid_sas          |   4 +-
 Documentation/scsi/ChangeLog.ncr53c8xx             |  16 +-
 Documentation/scsi/ChangeLog.sym53c8xx             |  14 +-
 Documentation/scsi/ChangeLog.sym53c8xx_2           |  10 +-
 Documentation/scsi/ncr53c8xx.rst                   |   4 +-
 Documentation/scsi/sym53c8xx_2.rst                 |   2 +-
 Documentation/scsi/tcm_qla2xxx.rst                 |   2 +-
 Documentation/scsi/ufs.rst                         |   2 +-
 Documentation/target/tcmu-design.rst               |   2 +-
 MAINTAINERS                                        |  14 +
 drivers/ata/libata-scsi.c                          |  23 +-
 drivers/hwmon/drivetemp.c                          |  11 +-
 drivers/scsi/3w-sas.c                              |  12 +-
 drivers/scsi/3w-sas.h                              |   4 +-
 drivers/scsi/aacraid/aachba.c                      |   5 +-
 drivers/scsi/aic94xx/aic94xx_task.c                |   3 +
 drivers/scsi/ch.c                                  |  30 +-
 drivers/scsi/cxlflash/superpipe.c                  |  34 +-
 drivers/scsi/cxlflash/vlun.c                       |  32 +-
 drivers/scsi/device_handler/scsi_dh_alua.c         |  26 +-
 drivers/scsi/device_handler/scsi_dh_emc.c          |  13 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c        |  22 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c         |  12 +-
 drivers/scsi/elx/libefc_sli/sli4.c                 |   2 +-
 drivers/scsi/ipr.c                                 |   9 +-
 drivers/scsi/ips.c                                 |  11 +-
 drivers/scsi/libsas/sas_ata.c                      |  88 ++-
 drivers/scsi/libsas/sas_discover.c                 |   6 -
 drivers/scsi/libsas/sas_expander.c                 | 125 +--
 drivers/scsi/lpfc/lpfc.h                           |   4 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |  63 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |   4 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  33 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  17 +-
 drivers/scsi/lpfc/lpfc_hw4.h                       |   7 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  94 ++-
 drivers/scsi/lpfc/lpfc_scsi.c                      |   8 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |  83 +-
 drivers/scsi/lpfc/lpfc_sli4.h                      |   5 +-
 drivers/scsi/lpfc/lpfc_version.h                   |   6 +-
 drivers/scsi/lpfc/lpfc_vmid.c                      |  41 +-
 drivers/scsi/lpfc/lpfc_vport.c                     |  16 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h        |   5 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   3 +
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                 |   2 +-
 drivers/scsi/mvumi.c                               |   4 +-
 drivers/scsi/mvumi.h                               |   6 +-
 drivers/scsi/pm8001/pm8001_ctl.c                   |  46 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   5 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   9 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  51 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |  10 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  96 ++-
 drivers/scsi/qla2xxx/qla_edif.h                    |   2 +
 drivers/scsi/qla2xxx/qla_edif_bsg.h                |  15 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |  18 +-
 drivers/scsi/qla2xxx/qla_gs.c                      | 407 ----------
 drivers/scsi/qla2xxx/qla_init.c                    |  97 +--
 drivers/scsi/qla2xxx/qla_inline.h                  | 110 ++-
 drivers/scsi/qla2xxx/qla_iocb.c                    | 107 ++-
 drivers/scsi/qla2xxx/qla_isr.c                     |   9 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   8 +-
 drivers/scsi/qla2xxx/qla_mid.c                     | 302 ++++++-
 drivers/scsi/qla2xxx/qla_nvme.c                    |  38 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  61 +-
 drivers/scsi/qla2xxx/qla_target.c                  | 106 +--
 drivers/scsi/qla2xxx/qla_target.h                  |   1 -
 drivers/scsi/qla2xxx/qla_version.h                 |   6 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                 |  13 +-
 drivers/scsi/scsi.c                                |  12 +-
 drivers/scsi/scsi_ioctl.c                          |   7 +-
 drivers/scsi/scsi_lib.c                            |  78 +-
 drivers/scsi/scsi_scan.c                           |  26 +-
 drivers/scsi/scsi_transport_spi.c                  |  31 +-
 drivers/scsi/sd.c                                  |  83 +-
 drivers/scsi/sd_zbc.c                              |   8 +-
 drivers/scsi/ses.c                                 |  14 +-
 drivers/scsi/smartpqi/smartpqi.h                   |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |   3 +-
 drivers/scsi/snic/snic_debugfs.c                   |   4 +-
 drivers/scsi/sr.c                                  |  11 +-
 drivers/scsi/sr_ioctl.c                            |  17 +-
 drivers/scsi/virtio_scsi.c                         |   4 +-
 drivers/target/target_core_pscsi.c                 |  12 +-
 drivers/ufs/core/Makefile                          |   2 +-
 drivers/ufs/core/ufs-mcq.c                         | 431 ++++++++++
 drivers/ufs/core/ufs_bsg.c                         | 144 ++--
 drivers/ufs/core/ufshcd-priv.h                     | 109 ++-
 drivers/ufs/core/ufshcd.c                          | 863 ++++++++++++++++-----
 drivers/ufs/core/ufshpb.c                          |   4 +-
 drivers/ufs/host/Kconfig                           |  19 +-
 drivers/ufs/host/Makefile                          |   1 +
 drivers/ufs/host/ufs-exynos.c                      |  10 +-
 drivers/ufs/host/ufs-qcom.c                        | 548 +++++++++----
 drivers/ufs/host/ufs-qcom.h                        |  97 +--
 drivers/ufs/host/ufs-sprd.c                        | 458 +++++++++++
 drivers/ufs/host/ufs-sprd.h                        |  85 ++
 include/scsi/libsas.h                              |   1 -
 include/scsi/sas_ata.h                             |  20 +
 include/scsi/scsi_device.h                         |  38 +-
 include/uapi/scsi/scsi_bsg_fc.h                    |   2 +-
 include/uapi/scsi/scsi_bsg_ufs.h                   |  48 +-
 include/ufs/ufs.h                                  |  37 +-
 include/ufs/ufshcd.h                               | 194 ++++-
 include/ufs/ufshci.h                               |  76 +-
 include/ufs/unipro.h                               |   1 -
 111 files changed, 4236 insertions(+), 1849 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/sprd,ums9620-ufs.yaml
 create mode 100644 drivers/ufs/core/ufs-mcq.c
 create mode 100644 drivers/ufs/host/ufs-sprd.c
 create mode 100644 drivers/ufs/host/ufs-sprd.h

James

