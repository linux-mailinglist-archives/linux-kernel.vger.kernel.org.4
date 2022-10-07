Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86D5F7B41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJGQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:16:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E95C069A;
        Fri,  7 Oct 2022 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1665159368;
        bh=4hqZyMT08KOdwRiv5h9sK0dqjF48mIjvbzA4CAvqTPo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=jBBkdpbAHJg+8fI4Jp5GH8z6Ax/aqtqVLMdNgkMTRdUDVf6TG4JlA0bwdDMirLhE/
         w68BzpJHZ732ChtA0GA5jNLpWg6k3W4Pn6nJ35POd/sezou55HSeVcB+pQaNGZRyW4
         cK3ew/3iINL3OyMg0Lo6WyxGNS7XNH+SSHz4Gg5A=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0D88F12806DB;
        Fri,  7 Oct 2022 12:16:08 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UM7HWofLz5C4; Fri,  7 Oct 2022 12:16:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1665159367;
        bh=4hqZyMT08KOdwRiv5h9sK0dqjF48mIjvbzA4CAvqTPo=;
        h=Message-ID:Subject:From:To:Date:From;
        b=Qxn4T7jD8MUD/j5QnIctDUBVhwuGDwzEjilC2K+xp1VIa23LyHvwRRENeVquoTiRO
         BK8H7Fs5DUCm6H/6xHJcI/uUind//eFrhZ3l/6LgAWzDx7XE76+khEecDCPJdvkldy
         2UtS9TXyX2sNHvMs0dX9+Z5JIxLagYv03nbZuUu4=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EA63012802EA;
        Fri,  7 Oct 2022 12:16:06 -0400 (EDT)
Message-ID: <3727e267ba5a03e021ba06e46a97f260dcccc3e7.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.0+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Oct 2022 12:16:04 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (qla2xxx, lpfc, ufs, hisi_sas, mpi3mr,
mpt3sas, target); the biggest change (from my biased viewpoint) being
that the mpi3mr now attached to the SAS transport class, making it the
first fusion type device to do so.   Beyond the usual bug fixing and
security class reworks, there aren't a huge number of core changes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Anil Gurumurthy (1):
      scsi: qla2xxx: Add NVMe parameters support in Auxiliary Image Status

Arthur Simchaev (1):
      scsi: ufs: core: Remove redundant function definitions from ufshcd.h

Arun Easi (5):
      scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled
      scsi: qla2xxx: Enhance driver tracing with separate tunable and more
      scsi: qla2xxx: Add debugfs create/delete helpers
      scsi: qla2xxx: Fix response queue handler reading stale packets
      scsi: qla2xxx: Revert "scsi: qla2xxx: Fix response queue handler reading stale packets"

Bradley Grove (2):
      scsi: mpt3sas: Disable MPI2_FUNCTION_FW_DOWNLOAD for ATTO devices
      scsi: mpt3sas: Add support for ATTO ExpressSAS H12xx GT devices

Christophe JAILLET (2):
      scsi: hpsa: Simplify {clear|set}_bit() parameters
      scsi: hpsa: Use the bitmap API to allocate bitmaps

Colin Ian King (5):
      scsi: qla2xxx: Fix spelling mistake "definiton" -> "definition"
      scsi: st: Remove redundant variable pointer stp
      scsi: megaraid: Remove redundant assignment to variable mfiStatus
      scsi: initio: Remove redundant assignment to pointer scb
      scsi: message: fusion: Remove redundant variable iocnum

Damien Le Moal (2):
      scsi: mpt3sas: Revert "scsi: mpt3sas: Fix ioc->base_readl() use"
      scsi: mpt3sas: Revert "scsi: mpt3sas: Fix writel() use"

Dan Carpenter (2):
      scsi: mpi3mr: Fix error code in mpi3mr_transport_smp_handler()
      scsi: mpi3mr: Fix error codes in mpi3mr_report_manufacture()

Daniil Lunev (2):
      scsi: ufs: core: Print UFSHCD capabilities in controller's sysfs node
      scsi: ufs: core: Use local_clock() for debugging timestamps

Dmitry Bogdanov (2):
      scsi: target: alua: Do not report emtpy port group
      scsi: target: core: Set MULTIP bit for se_device with multiple ports

Duoming Zhou (1):
      scsi: libsas: Fix use-after-free bug in smp_execute_task_sg()

Gaosheng Cui (2):
      scsi: target: Remove unused se_tmr_req_cache declaration
      scsi: qla2xxx: Remove unused declarations for qla2xxx

Gustavo A. R. Silva (11):
      scsi: pm8001: Replace one-element array with flexible-array member
      scsi: 3w-xxxx: Replace one-element array with flexible-array member
      scsi: hptiop: Replace one-element array with flexible-array member in struct hpt_iop_request_ioctl_command()
      scsi: hptiop: Use struct_size() helper in code related to struct hpt_iop_request_scsi_command
      scsi: hptiop: Replace one-element array with flexible-array member
      scsi: megaraid_sas: Use struct_size() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC
      scsi: megaraid_sas: Use struct_size() in code related to struct MR_FW_RAID_MAP
      scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_PD_CFG_SEQ_NUM_SYNC
      scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_DRV_RAID_MAP
      scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_FW_RAID_MAP_DYNAMIC
      scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_FW_RAID_MAP

Jack Wang (1):
      scsi: qlogicpti: Fix dma_map_sg() check

James Smart (20):
      scsi: lpfc: Update lpfc version to 14.2.0.7
      scsi: lpfc: Fix various issues reported by tools
      scsi: lpfc: Add reporting capability for Link Degrade Signaling
      scsi: lpfc: Rework FDMI attribute registration for unintential padding
      scsi: lpfc: Rework lpfc_fdmi_cmd() routine for cleanup and consistency
      scsi: lpfc: Rename mp/bmp dma buffers to rq/rsp in lpfc_fdmi_cmd
      scsi: lpfc: Update congestion mode logging for Emulex SAN Manager application
      scsi: lpfc: Move scsi_host_template outside dynamically allocated/freed phba
      scsi: lpfc: Fix multiple NVMe remoteport registration calls for the same NPort ID
      scsi: lpfc: Add missing free iocb and nlp kref put for early return VMID cases
      scsi: lpfc: Fix mbuf pool resource detected as busy at driver unload
      scsi: lpfc: Fix FLOGI ACC with wrong SID in PT2PT topology
      scsi: lpfc: Fix prli_fc4_req checks in PRLI handling
      scsi: lpfc: Copyright updates for 14.2.0.6 patches
      scsi: lpfc: Update lpfc version to 14.2.0.6
      scsi: lpfc: Remove SANDiags related code
      scsi: lpfc: Add warning notification period to CMF_SYNC_WQE
      scsi: lpfc: Rework MIB Rx Monitor debug info logic
      scsi: lpfc: Fix null ndlp ptr dereference in abnormal exit path for GFT_ID
      scsi: lpfc: Fix unsolicited FLOGI receive handling during PT2PT discovery

Jinyoung Choi (5):
      scsi: ufs: wb: Modify messages
      scsi: ufs: wb: Introduce ufshcd_is_wb_buf_flush_allowed()
      scsi: ufs: wb: Add explicit flush sysfs attribute
      scsi: ufs: wb: Change function name and parameter names
      scsi: ufs: wb: Change wb_enabled condition test

John Garry (6):
      scsi: pm8001: Fix running_req for internal abort commands
      scsi: hisi_sas: Don't send bcast events from HW during nexus HA reset
      scsi: hisi_sas: Add helper to process bcast events
      scsi: hisi_sas: Drain bcast events in hisi_sas_rescan_topology()
      scsi: hisi_sas: Clear HISI_SAS_HW_FAULT_BIT earlier
      scsi: hisi_sas: Revert change to limit max hw sectors for v3 HW

Jules Irenge (1):
      scsi: mpi3mr: Remove unnecessary cast

Kees Cook (3):
      scsi: scsi_transport_fc: Adjust struct fc_nl_event flex array usage
      scsi: aic79xx: Use __ro_after_init explicitly
      scsi: esas2r: Use flex array destination for memcpy()

Letu Ren (1):
      scsi: 3w-9xxx: Avoid disabling device if failing to enable it

Linus Torvalds (1):
      scsi: stex: Properly zero out the passthrough command structure

Lukas Bulwahn (2):
      scsi: wd33c93: Remove dead code related to the long-gone config WD33C93_PIO
      scsi: core: Make SCSI_MOD depend on BLOCK for cleaner .config files

Martin Wilck (1):
      scsi: scsi_transport_fc: Use %u for dev_loss_tmo

Mauricio Faria de Oliveira (1):
      scsi: qla2xxx: Log message "skipping scsi_scan_host()" as informational

Mike Christie (11):
      scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()
      scsi: core: Remove useless host error codes
      scsi: core: Convert scsi_decide_disposition() to use SCSIML_STAT
      scsi: core: Add error codes for internal SCSI midlayer use
      scsi: cxlflash: Drop DID_ALLOC_FAILURE use
      scsi: qla2xxx: Drop DID_TARGET_FAILURE use
      scsi: virtio_scsi: Drop DID_NEXUS_FAILURE use
      scsi: virtio_scsi: Drop DID_TARGET_FAILURE use
      scsi: uas: Drop DID_TARGET_FAILURE use
      scsi: storvsc: Drop DID_TARGET_FAILURE use
      scsi: xen: Drop use of internal host codes

Nilesh Javali (2):
      scsi: qla2xxx: Update version to 10.02.07.900-k
      scsi: qla2xxx: Define static symbols

Peter Wang (3):
      scsi: ufs: core: Allow host driver to disable wb toggling during clock scaling
      scsi: ufs: ufs-mediatek: Fix performance scaling
      scsi: ufs: ufs-mediatek: Dump more registers

Po-Wen Kao (1):
      scsi: ufs: ufs-mediatek: Support clk-scaling to optimize power consumption

Randy Dunlap (1):
      scsi: docs: Fix a typo

Saurav Kashyap (1):
      scsi: qedf: Populate sysfs attributes for vport

Shaomin Deng (1):
      scsi: target: pscsi: Remove repeated word "calling"

Sreekanth Reddy (29):
      scsi: mpi3mr: Update driver version to 8.2.0.3.0
      scsi: mpi3mr: Fix scheduling while atomic type bug
      scsi: mpi3mr: Scan the devices during resume time
      scsi: mpi3mr: Free enclosure objects during driver unload
      scsi: mpi3mr: Handle 0xF003 Fault Code
      scsi: mpi3mr: Graceful handling of surprise removal of PCIe HBA
      scsi: mpi3mr: Schedule IRQ kthreads only on non-RT kernels
      scsi: mpi3mr: Support new power management framework
      scsi: mpi3mr: Update mpi3 header files
      scsi: mpt3sas: Update driver version to 43.100.00.00
      scsi: mpt3sas: Increase cmd_per_lun to 128
      scsi: mpt3sas: Fix trace buffer registration failed
      scsi: mpt3sas: Don't change DMA mask while reallocating pools
      scsi: mpt3sas: Prevent error handler escalation when device removed
      scsi: mpi3mr: Block I/Os while refreshing target dev objects
      scsi: mpi3mr: Refresh SAS ports during soft reset
      scsi: mpi3mr: Support SAS transport class callbacks
      scsi: mpi3mr: Add framework to issue MPT transport cmds
      scsi: mpi3mr: Add SAS SATA end devices to STL
      scsi: mpi3mr: Get target object based on rphy
      scsi: mpi3mr: Add expander devices to STL
      scsi: mpi3mr: Enable STL on HBAs where multipath is disabled
      scsi: mpi3mr: Add helper functions to manage device's port
      scsi: mpi3mr: Add helper functions to retrieve device objects
      scsi: mpi3mr: Add framework to add phys to STL
      scsi: mpi3mr: Enable Enclosure device add event
      scsi: mpi3mr: Add helper functions to retrieve config pages
      scsi: mpi3mr: Add framework to issue config requests
      scsi: mpi3mr: Add config and transport related debug flags

Stanley Chu (2):
      scsi: ufs: ufs-mediatek: Provide detailed description for UIC errors
      scsi: ufs: ufs-mediatek: Remove redundant header files

Tetsuo Handa (4):
      scsi: qla2xxx: Avoid flush_scheduled_work() usage
      scsi: qla2xxx: Always wait for qlt_sess_work_fn() from qlt_stop_phase1()
      scsi: qla2xxx: Remove unused qlt_tmr_work()
      scsi: qla2xxx: Remove unused del_sess_list field

Wu Bo (1):
      scsi: core: Add I/O timeout count for SCSI device

Xuezhi Zhang (2):
      scsi: csiostor: Convert sysfs snprintf() to sysfs_emit()
      scsi: megaraid: Convert sysfs snprintf() to sysfs_emit()

wangjianli (1):
      scsi: ibmvscsi_tgt: Fix repeated words in comment

ye xingchen (2):
      scsi: lpfc: Remove unneeded result variable
      scsi: lpfc: Remove the unneeded result variable

And the diffstat:

 Documentation/ABI/testing/sysfs-driver-ufs  |   46 +
 Documentation/scsi/ChangeLog.lpfc           |    2 +-
 drivers/message/fusion/mptctl.c             |    6 +-
 drivers/scsi/3w-9xxx.c                      |    2 +-
 drivers/scsi/3w-xxxx.c                      |   14 +-
 drivers/scsi/3w-xxxx.h                      |    2 +-
 drivers/scsi/Kconfig                        |    7 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c          |    2 +-
 drivers/scsi/csiostor/csio_scsi.c           |   10 +-
 drivers/scsi/cxlflash/main.c                |    2 +-
 drivers/scsi/esas2r/atioctl.h               |    1 +
 drivers/scsi/esas2r/esas2r_ioctl.c          |    3 +-
 drivers/scsi/hisi_sas/hisi_sas.h            |    1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c       |   37 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c      |    4 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c      |    7 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      |   14 +-
 drivers/scsi/hpsa.c                         |   12 +-
 drivers/scsi/hptiop.c                       |    9 +-
 drivers/scsi/hptiop.h                       |    4 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c    |    2 +-
 drivers/scsi/initio.c                       |    2 +-
 drivers/scsi/iscsi_tcp.c                    |   73 +-
 drivers/scsi/iscsi_tcp.h                    |    3 +
 drivers/scsi/libsas/sas_expander.c          |    2 +-
 drivers/scsi/lpfc/lpfc.h                    |   37 +-
 drivers/scsi/lpfc/lpfc_attr.c               |  344 +--
 drivers/scsi/lpfc/lpfc_bsg.c                |    5 +-
 drivers/scsi/lpfc/lpfc_crtn.h               |   10 +
 drivers/scsi/lpfc/lpfc_ct.c                 | 1092 +++------
 drivers/scsi/lpfc/lpfc_debugfs.c            |   61 +-
 drivers/scsi/lpfc/lpfc_debugfs.h            |    4 +-
 drivers/scsi/lpfc/lpfc_disc.h               |    4 +-
 drivers/scsi/lpfc/lpfc_els.c                |  234 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c            |   41 +-
 drivers/scsi/lpfc/lpfc_hw.h                 |   59 +-
 drivers/scsi/lpfc/lpfc_hw4.h                |   34 +-
 drivers/scsi/lpfc/lpfc_init.c               |  436 ++--
 drivers/scsi/lpfc/lpfc_logmsg.h             |    2 +-
 drivers/scsi/lpfc/lpfc_mem.c                |   11 +-
 drivers/scsi/lpfc/lpfc_scsi.c               |   86 +-
 drivers/scsi/lpfc/lpfc_scsi.h               |    6 +-
 drivers/scsi/lpfc/lpfc_sli.c                |  273 ++-
 drivers/scsi/lpfc/lpfc_sli4.h               |    4 +-
 drivers/scsi/lpfc/lpfc_version.h            |    2 +-
 drivers/scsi/lpfc/lpfc_vmid.c               |    4 +-
 drivers/scsi/lpfc/lpfc_vport.c              |   71 -
 drivers/scsi/lpfc/lpfc_vport.h              |    6 +-
 drivers/scsi/megaraid/megaraid_mbox.c       |    4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c   |   24 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c     |    6 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h |   12 +-
 drivers/scsi/mpi3mr/Makefile                |    1 +
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h        |  171 +-
 drivers/scsi/mpi3mr/mpi/mpi30_image.h       |    6 +-
 drivers/scsi/mpi3mr/mpi/mpi30_init.h        |    5 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h         |   22 +-
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h         |    2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h         |    3 +-
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h   |    8 +-
 drivers/scsi/mpi3mr/mpi3mr.h                |  252 +-
 drivers/scsi/mpi3mr/mpi3mr_debug.h          |   27 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c             | 1032 ++++++++-
 drivers/scsi/mpi3mr/mpi3mr_os.c             |  545 ++++-
 drivers/scsi/mpi3mr/mpi3mr_transport.c      | 3291 +++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h        |    1 +
 drivers/scsi/mpt3sas/mpt3sas_base.c         |  217 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h         |   39 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c       |  124 +
 drivers/scsi/mpt3sas/mpt3sas_ctl.c          |   12 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |   21 +-
 drivers/scsi/pm8001/pm8001_hwi.c            |    4 +
 drivers/scsi/pm8001/pm8001_sas.h            |    2 +-
 drivers/scsi/qedf/qedf_main.c               |   21 +
 drivers/scsi/qla2xxx/qla_bsg.c              |    8 +-
 drivers/scsi/qla2xxx/qla_bsg.h              |    3 +-
 drivers/scsi/qla2xxx/qla_dbg.c              |   50 +-
 drivers/scsi/qla2xxx/qla_dbg.h              |   43 +
 drivers/scsi/qla2xxx/qla_def.h              |    7 +
 drivers/scsi/qla2xxx/qla_dfs.c              |   93 +
 drivers/scsi/qla2xxx/qla_edif.c             |    2 +-
 drivers/scsi/qla2xxx/qla_fw.h               |    3 +
 drivers/scsi/qla2xxx/qla_gbl.h              |   15 +-
 drivers/scsi/qla2xxx/qla_init.c             |    8 +-
 drivers/scsi/qla2xxx/qla_isr.c              |   22 +-
 drivers/scsi/qla2xxx/qla_os.c               |   49 +-
 drivers/scsi/qla2xxx/qla_target.c           |   73 +-
 drivers/scsi/qla2xxx/qla_target.h           |    6 -
 drivers/scsi/qla2xxx/qla_version.h          |    4 +-
 drivers/scsi/qlogicpti.c                    |    3 +-
 drivers/scsi/scsi_error.c                   |   18 +-
 drivers/scsi/scsi_lib.c                     |   46 +-
 drivers/scsi/scsi_priv.h                    |   11 +
 drivers/scsi/scsi_sysfs.c                   |    2 +
 drivers/scsi/scsi_transport_fc.c            |   10 +-
 drivers/scsi/st.c                           |    3 +-
 drivers/scsi/stex.c                         |   17 +-
 drivers/scsi/storvsc_drv.c                  |    2 +-
 drivers/scsi/virtio_scsi.c                  |    4 +-
 drivers/scsi/wd33c93.c                      |   60 -
 drivers/scsi/wd33c93.h                      |    5 -
 drivers/scsi/xen-scsifront.c                |    8 -
 drivers/target/target_core_alua.c           |    3 +
 drivers/target/target_core_internal.h       |    2 -
 drivers/target/target_core_pscsi.c          |    2 +-
 drivers/target/target_core_spc.c            |    6 +
 drivers/ufs/core/ufs-sysfs.c                |   85 +-
 drivers/ufs/core/ufshcd-priv.h              |   11 +
 drivers/ufs/core/ufshcd.c                   |   95 +-
 drivers/ufs/host/ufs-mediatek-trace.h       |   27 +-
 drivers/ufs/host/ufs-mediatek.c             |  205 +-
 drivers/ufs/host/ufs-mediatek.h             |    7 +
 drivers/ufs/host/ufs-qcom.c                 |    2 +-
 drivers/usb/storage/uas.c                   |    2 +-
 drivers/xen/xen-scsiback.c                  |   12 -
 include/linux/trace.h                       |   36 +-
 include/scsi/scsi_cmnd.h                    |    2 +-
 include/scsi/scsi_device.h                  |    1 +
 include/scsi/scsi_status.h                  |   12 +-
 include/uapi/scsi/scsi_netlink_fc.h         |    7 +-
 include/ufs/ufshcd.h                        |   46 +-
 122 files changed, 7786 insertions(+), 2299 deletions(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi3mr_transport.c

James


