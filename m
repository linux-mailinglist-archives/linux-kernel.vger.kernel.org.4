Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8781F64BE17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiLMUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiLMUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:46:01 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD271402A;
        Tue, 13 Dec 2022 12:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670964357;
        bh=wkOEaRoar0f3VODmtfmpr2wYNhRJFaNhTTQrbuCkEiM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=gUgy8qjEOp5tXAM7o04UuMRNJ2T3HBpIVTN31PZ8/3x/rkXaIC44aHrlfsLhNE6fw
         3vfUCEEHGjy/RmPQanA4O7nS2ynEKzjaAGHflNpD4D6IOHZRXa5ZepFzM7JD92+eFE
         TqwKPT/w18/bTewcU7k5OF7jOXY8WJ2Qp0p353Yw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D2A9E1284D2A;
        Tue, 13 Dec 2022 15:45:57 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s9OrZnzFCNmS; Tue, 13 Dec 2022 15:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670964357;
        bh=wkOEaRoar0f3VODmtfmpr2wYNhRJFaNhTTQrbuCkEiM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=gUgy8qjEOp5tXAM7o04UuMRNJ2T3HBpIVTN31PZ8/3x/rkXaIC44aHrlfsLhNE6fw
         3vfUCEEHGjy/RmPQanA4O7nS2ynEKzjaAGHflNpD4D6IOHZRXa5ZepFzM7JD92+eFE
         TqwKPT/w18/bTewcU7k5OF7jOXY8WJ2Qp0p353Yw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 33A4F1282CC1;
        Tue, 13 Dec 2022 15:45:57 -0500 (EST)
Message-ID: <b2e824bbd1e40da64d2d01657f2f7a67b98919fb.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.1+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Dec 2022 15:45:55 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
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

Updates to the usual drivers (target, ufs, smartpqi, lpfc).  There are
some core changes, mostly around reworking some of our user context
assumptions in device put and moving some code around.  The remaining
updates are bug fixes and minor changes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Anastasia Kovaleva (3):
      scsi: target: core: Change the way target_xcopy_do_work() sets restiction on max I/O
      scsi: target: core: Make hw_max_sectors store the sectors amount in blocks
      scsi: target: core: Send max transfer length in blocks

Bart Van Assche (27):
      scsi: ufs: core: Fix the polling implementation
      scsi: device_handler: alua: Call scsi_device_put() from non-atomic context
      scsi: device_handler: alua: Revert "Move a scsi_device_put() call out of alua_check_vpd()"
      scsi: qla2xxx: Fix set-but-not-used variable warnings
      scsi: bfa: Rework bfad_reset_sdev_bflags()
      scsi: bfa: Convert bfad_reset_sdev_bflags() from a macro into a function
      scsi: alua: Move a scsi_device_put() call out of alua_rtpg_select_sdev()
      scsi: alua: Move a scsi_device_put() call out of alua_check_vpd()
      scsi: ufs: core: Introduce ufshcd_abort_all()
      scsi: ufs: Fix a deadlock between PM and the SCSI error handler
      scsi: ufs: Introduce the function ufshcd_execute_start_stop()
      scsi: ufs: Track system suspend / resume activity
      scsi: ufs: Try harder to change the power mode
      scsi: ufs: Reduce the START STOP UNIT timeout
      scsi: ufs: Use 'else' in ufshcd_set_dev_pwr_mode()
      scsi: ufs: Remove an outdated comment
      scsi: core: Support failing requests while recovering
      scsi: core: Change the return type of .eh_timed_out()
      scsi: core: Fix a race between scsi_done() and scsi_timeout()
      scsi: core: Release SCSI devices synchronously
      scsi: core: Remove the put_device() call from scsi_device_get()
      scsi: ufs: Simplify ufshcd_set_dev_pwr_mode()
      scsi: core: Rework scsi_single_lun_run()
      scsi: core: Introduce a new list for SCSI proc directory entries
      scsi: core: Fail host creation if creating the proc directory fails
      scsi: esas2r: Introduce scsi_template_proc_dir()
      scsi: esas2r: Initialize two host template members implicitly

Bean Huo (3):
      scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs nodes
      scsi: ufs: core: Clean up ufshcd_slave_alloc()
      scsi: ufs: core: Revert "WB is only available on LUN #0 to #7"

ChanWoo Lee (6):
      scsi: ufs: ufs-mediatek: Remove unnecessary return code
      scsi: ufs: ufs-mediatek: Modify the return value
      scsi: ufs: ufs-mediatek: Remove unneeded code
      scsi: ufs: core: Fix unnecessary operation for early return
      scsi: ufs: core: Switch 'check_for_bkops' to bool
      scsi: ufs: core: Separate function name and message

Chen Zhongjin (2):
      scsi: fcoe: Fix transport not deattached when fcoe_if_init() fails
      scsi: efct: Fix possible memleak in efct_device_init()

Christophe JAILLET (1):
      scsi: target: Use kstrtobool() instead of strtobool()

Colin Ian King (8):
      scsi: libfc: Remove redundant variable ev_qual
      scsi: lpfc: Remove redundant pointer 'lp'
      scsi: target: core: Remove unused variable 'unit_serial_len'
      scsi: csiostor: Remove unused variable 'n'
      scsi: qla2xxx: Remove unused variable 'found_devs'
      scsi: BusLogic: Remove variable 'adapter_count'
      scsi: message: fusion: Remove variable 'where'
      scsi: pcmcia: nsp_cs: Remove unused variable i

Dmitry Bogdanov (6):
      scsi: target: core: Dynamically set DPO and FUA in usage_bits
      scsi: target: core: Check emulate_3pc for RECEIVE COPY
      scsi: target: core: Add emulate_rsoc attribute
      scsi: target: core: Dynamic opcode support in RSOC
      scsi: target: core: Add list of opcodes for RSOC
      scsi: target: core: Add support for RSOC command

Don Brace (3):
      scsi: smartpqi: Change version to 2.1.20-035
      scsi: smartpqi: Initialize feature section info
      scsi: smartpqi: Convert to host_tagset

Gaosheng Cui (1):
      scsi: snic: Fix possible UAF in snic_tgt_create()

Gilbert Wu (1):
      scsi: smartpqi: Add controller cache flush during rmmod

Gleb Chesnokov (2):
      scsi: qla2xxx: Initialize vha->unknown_atio_[list, work] for NPIV hosts
      scsi: qla2xxx: Remove duplicate of vha->iocb_work initialization

Gustavo A. R. Silva (1):
      scsi: bfa: Replace one-element array with flexible-array member

Harshit Mogalapalli (3):
      scsi: scsi_debug: Fix a warning in resp_report_zones()
      scsi: scsi_debug: Fix a warning in resp_verify()
      scsi: scsi_debug: Fix a warning in resp_write_scat()

Igor Pylypiv (2):
      scsi: pm80xx: Remove unused reset_in_progress flag logic
      scsi: pm8001: Remove pm8001_tag_init()

Jason Yan (8):
      scsi: libsas: Use sas_phy_match_port_addr() instead of open coding it
      scsi: libsas: Use sas_phy_addr_match() instead of open coding it
      scsi: libsas: Use sas_phy_match_dev_addr() instead of open coding it
      scsi: hisi_sas: Use sas_find_attathed_phy_id() instead of open coding it
      scsi: mvsas: Use sas_find_attached_phy_id() instead of open coding it
      scsi: pm8001: Use sas_find_attached_phy_id() instead of open coding it
      scsi: libsas: Introduce sas_find_attached_phy_id() helper
      scsi: libsas: Introduce SAS address comparison helpers

Jiapeng Chong (2):
      scsi: qedf: Remove set but unused variable 'page'
      scsi: target: Remove the unused function transport_lba_64_ext()

Jie Zhan (5):
      scsi: libsas: Do not export sas_ata_wait_after_reset()
      scsi: hisi_sas: Fix SATA devices missing issue during I_T nexus reset
      scsi: libsas: Add smp_ata_check_ready_type()
      scsi: Revert "scsi: hisi_sas: Don't send bcast events from HW during nexus HA reset"
      scsi: Revert "scsi: hisi_sas: Drain bcast events in hisi_sas_rescan_topology()"

Jilin Yuan (1):
      scsi: NCR5380: Fix repeated words in comment

John Garry (15):
      scsi: core: Use SCSI_SCAN_INITIAL in do_scsi_scan_host()
      scsi: core: Use SCSI_SCAN_RESCAN in __scsi_add_device()
      scsi: MAINTAINERS: Make Xiang Chen HiSilicon SAS controller driver maintainer
      scsi: pm8001: Drop !task check in pm8001_abort_task()
      scsi: mvsas: Use sas_task_find_rq() for tagging
      scsi: mvsas: Delete mvs_tag_init()
      scsi: pm8001: Use sas_task_find_rq() for tagging
      scsi: hisi_sas: Put reserved tags in lower region of tagset
      scsi: hisi_sas: Use sas_task_find_rq()
      scsi: libsas: Add sas_task_find_rq()
      scsi: libsas: Update SATA dev FIS in sas_ata_task_done()
      scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
      scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
      scsi: pm8001: Modify task abort handling for SATA task
      scsi: libsas: Add sas_ata_device_link_abort()

Justin Tee (10):
      scsi: lpfc: Update lpfc version to 14.2.0.9
      scsi: lpfc: Fix crash involving race between FLOGI timeout and devloss handler
      scsi: lpfc: Fix MI capability display in cmf_info sysfs attribute
      scsi: lpfc: Correct bandwidth logging during receipt of congestion sync WCQE
      scsi: lpfc: Fix WQ|CQ|EQ resource check
      scsi: lpfc: Update lpfc version to 14.2.0.8
      scsi: lpfc: Create a sysfs entry called lpfc_xcvr_data for transceiver info
      scsi: lpfc: Log when congestion management limits are in effect
      scsi: lpfc: Fix hard lockup when reading the rx_monitor from debugfs
      scsi: lpfc: Set sli4_param's cmf option to zero when CMF is turned off

Keoseong Park (2):
      scsi: ufs: core: Remove check_upiu_size() from ufshcd.h
      scsi: ufs: core: Refactor ufshcd_hba_enable()

Kevin Barnett (2):
      scsi: smartpqi: Change sysfs raid_level attribute to N/A for controllers
      scsi: smartpqi: Correct max LUN number

Kirill A. Shutemov (1):
      scsi: sg: Fix get_user() in call sg_scsi_ioctl()

Kumar Meiyappan (1):
      scsi: smartpqi: Correct device removal for multi-actuator devices

Maurizio Lombardi (2):
      scsi: target: core: Fix hard lockup when executing a compare-and-write command
      scsi: target: iscsi: Fix a race condition between login_work and the login thread

Mike McGowen (1):
      scsi: smartpqi: Add new controller PCI IDs

Nathan Chancellor (1):
      scsi: elx: libefc: Fix second parameter type in state callbacks

Peter Wang (1):
      scsi: ufs: core: Print events for WLUN suspend and resume failures

Shang XiaoJing (1):
      scsi: ipr: Fix WARNING in ipr_init()

Shin'ichiro Kawasaki (1):
      scsi: sd: Use 16-byte SYNCHRONIZE CACHE on ZBC devices

Thomas Gleixner (1):
      scsi: lpfc: Remove linux/msi.h include

Wenchao Hao (3):
      scsi: core: Do not increase scsi_device's iorequest_cnt if dispatch failed
      scsi: core: Increase scsi_device's iodone_cnt in scsi_timeout()
      scsi: iscsi: Rename iscsi_set_param() to iscsi_if_set_param()

Xingui Yang (3):
      scsi: hisi_sas: Modify v3 HW SATA disk error state completion processing
      scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
      scsi: hisi_sas: Move slot variable definition in hisi_sas_abort_task()

Xiu Jianfeng (1):
      scsi: lpfc: Use memset_startat() helper

Yang Yingliang (5):
      scsi: scsi_debug: Fix possible name leak in sdebug_add_host_helper()
      scsi: fcoe: Fix possible name leak when device_register() fails
      scsi: hpsa: Fix possible memory leak in hpsa_add_sas_device()
      scsi: hpsa: Fix error handling in hpsa_add_sas_host()
      scsi: mpt3sas: Fix possible resource leaks in mpt3sas_transport_port_add()

Yu Zhe (1):
      scsi: megaraid_sas: Fix some spelling mistakes in comment

Yuan Can (1):
      scsi: hpsa: Fix possible memory leak in hpsa_init_one()

And the diffstat:

 Documentation/scsi/scsi_eh.rst               |   7 +-
 MAINTAINERS                                  |   2 +-
 drivers/message/fusion/mptctl.c              |   2 -
 drivers/message/fusion/mptsas.c              |   8 +-
 drivers/scsi/BusLogic.c                      |   6 +-
 drivers/scsi/NCR5380.c                       |   2 +-
 drivers/scsi/bfa/bfa_fc.h                    |   2 +-
 drivers/scsi/bfa/bfad_bsg.c                  |  29 +
 drivers/scsi/bfa/bfad_im.h                   |  26 -
 drivers/scsi/csiostor/csio_wr.c              |   3 +-
 drivers/scsi/device_handler/scsi_dh_alua.c   |  65 +-
 drivers/scsi/elx/efct/efct_driver.c          |   1 +
 drivers/scsi/elx/libefc/efclib.h             |   6 +-
 drivers/scsi/esas2r/esas2r_main.c            |  19 +-
 drivers/scsi/fcoe/fcoe.c                     |   1 +
 drivers/scsi/fcoe/fcoe_sysfs.c               |  19 +-
 drivers/scsi/hisi_sas/hisi_sas.h             |   1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c        | 109 ++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c       |  53 +-
 drivers/scsi/hosts.c                         |   3 +-
 drivers/scsi/hpsa.c                          |   9 +-
 drivers/scsi/ipr.c                           |  10 +-
 drivers/scsi/libfc/fc_disc.c                 |   3 -
 drivers/scsi/libiscsi.c                      |  26 +-
 drivers/scsi/libsas/sas_ata.c                |  47 +-
 drivers/scsi/libsas/sas_expander.c           |  44 +-
 drivers/scsi/libsas/sas_init.c               |   3 -
 drivers/scsi/libsas/sas_internal.h           |  23 +
 drivers/scsi/lpfc/lpfc_attr.c                | 120 +++-
 drivers/scsi/lpfc/lpfc_crtn.h                |   3 +
 drivers/scsi/lpfc/lpfc_els.c                 | 169 ++++-
 drivers/scsi/lpfc/lpfc_hbadisc.c             |  36 +-
 drivers/scsi/lpfc/lpfc_hw4.h                 |   5 +-
 drivers/scsi/lpfc/lpfc_init.c                |  16 +-
 drivers/scsi/lpfc/lpfc_sli.c                 |  31 +-
 drivers/scsi/lpfc/lpfc_sli4.h                |   1 +
 drivers/scsi/lpfc/lpfc_version.h             |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c    |   7 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c  |   8 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c     |   2 +
 drivers/scsi/mvsas/mv_defs.h                 |   1 +
 drivers/scsi/mvsas/mv_init.c                 |  11 +-
 drivers/scsi/mvsas/mv_sas.c                  |  59 +-
 drivers/scsi/mvsas/mv_sas.h                  |   8 +-
 drivers/scsi/mvumi.c                         |   4 +-
 drivers/scsi/pcmcia/nsp_cs.c                 |   4 +-
 drivers/scsi/pm8001/pm8001_hwi.c             | 186 +-----
 drivers/scsi/pm8001/pm8001_init.c            |  14 +-
 drivers/scsi/pm8001/pm8001_sas.c             |  54 +-
 drivers/scsi/pm8001/pm8001_sas.h             |  18 +-
 drivers/scsi/pm8001/pm80xx_hwi.c             | 200 +-----
 drivers/scsi/qedf/qedf_main.c                |   3 -
 drivers/scsi/qla2xxx/qla_def.h               |  22 +-
 drivers/scsi/qla2xxx/qla_init.c              |  10 +-
 drivers/scsi/qla2xxx/qla_inline.h            |   4 +-
 drivers/scsi/qla2xxx/qla_os.c                |   5 +-
 drivers/scsi/qla2xxx/qla_target.c            |   3 +
 drivers/scsi/qla4xxx/ql4_os.c                |   8 +-
 drivers/scsi/scsi.c                          |  12 +-
 drivers/scsi/scsi_debug.c                    |  11 +-
 drivers/scsi/scsi_error.c                    |  42 +-
 drivers/scsi/scsi_ioctl.c                    |   2 +-
 drivers/scsi/scsi_lib.c                      |  43 +-
 drivers/scsi/scsi_priv.h                     |   6 +-
 drivers/scsi/scsi_proc.c                     | 137 +++-
 drivers/scsi/scsi_scan.c                     |   5 +-
 drivers/scsi/scsi_sysfs.c                    |  22 +-
 drivers/scsi/scsi_transport_fc.c             |   7 +-
 drivers/scsi/scsi_transport_iscsi.c          |   4 +-
 drivers/scsi/scsi_transport_srp.c            |   8 +-
 drivers/scsi/sd.c                            |  16 +-
 drivers/scsi/sd_zbc.c                        |   3 +-
 drivers/scsi/smartpqi/smartpqi.h             |   5 +-
 drivers/scsi/smartpqi/smartpqi_init.c        | 164 +++--
 drivers/scsi/snic/snic_disc.c                |   3 +
 drivers/scsi/storvsc_drv.c                   |   4 +-
 drivers/scsi/virtio_scsi.c                   |   4 +-
 drivers/target/iscsi/iscsi_target_nego.c     |  12 +-
 drivers/target/target_core_configfs.c        |  49 +-
 drivers/target/target_core_device.c          |   1 +
 drivers/target/target_core_fabric_configfs.c |   3 +-
 drivers/target/target_core_file.c            |   1 -
 drivers/target/target_core_iblock.c          |   4 +-
 drivers/target/target_core_sbc.c             |  30 +-
 drivers/target/target_core_spc.c             | 934 ++++++++++++++++++++++++++-
 drivers/target/target_core_xcopy.c           | 103 +--
 drivers/target/target_core_xcopy.h           |   2 +-
 drivers/ufs/core/ufs-sysfs.c                 |  21 +-
 drivers/ufs/core/ufshcd-priv.h               |   6 +-
 drivers/ufs/core/ufshcd.c                    | 368 ++++++-----
 drivers/ufs/core/ufshpb.c                    |  16 +-
 drivers/ufs/host/ufs-mediatek.c              |  15 +-
 include/scsi/libiscsi.h                      |   2 +-
 include/scsi/libsas.h                        |  24 +-
 include/scsi/sas_ata.h                       |  13 +-
 include/scsi/scsi_cmnd.h                     |   3 +-
 include/scsi/scsi_device.h                   |   2 +-
 include/scsi/scsi_host.h                     |  32 +-
 include/scsi/scsi_proto.h                    |  10 +
 include/scsi/scsi_transport_fc.h             |   2 +-
 include/scsi/scsi_transport_srp.h            |   2 +-
 include/target/target_core_base.h            |  19 +-
 include/ufs/ufshcd.h                         |  11 +-
 103 files changed, 2535 insertions(+), 1191 deletions(-)

James

