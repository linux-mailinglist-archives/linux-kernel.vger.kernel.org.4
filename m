Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26BA7426B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2Msg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2Mse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:48:34 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601ED1FD8;
        Thu, 29 Jun 2023 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688042911;
        bh=qG4JwA7sGahIqU9edHMSgqMBFKcglDOt7Kc4egr7aYQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=JwRR0X5ExFy27NJlo0mee8Q6Dz8bnq8/D4QupcZnSN91bYGa8StQQkR2gR7LZOmRb
         22kJOc/UztDbagmFW7riZHyKKkgJWXLtdLV3DSK7ohNUWpHw412aO9KdZCgvaiPI95
         u2x+JJ6oEF3vXdR1KQs3EF04SPydPteOnzII7DOo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DE60C1281BCB;
        Thu, 29 Jun 2023 08:48:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id U_iA7cvJl8br; Thu, 29 Jun 2023 08:48:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1688042911;
        bh=qG4JwA7sGahIqU9edHMSgqMBFKcglDOt7Kc4egr7aYQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=JwRR0X5ExFy27NJlo0mee8Q6Dz8bnq8/D4QupcZnSN91bYGa8StQQkR2gR7LZOmRb
         22kJOc/UztDbagmFW7riZHyKKkgJWXLtdLV3DSK7ohNUWpHw412aO9KdZCgvaiPI95
         u2x+JJ6oEF3vXdR1KQs3EF04SPydPteOnzII7DOo=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 361D61281192;
        Thu, 29 Jun 2023 08:48:31 -0400 (EDT)
Message-ID: <23bd2eafa9b9a23e4a8a96fc0180bba9e77e42ca.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Jun 2023 08:48:28 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (ufs, pm80xx, libata-scsi, smartpqi, lpfc,
qla2xxx).  We have a couple of major core changes impacting other
systems: Command Duration Limits, which spills into block and ATA and
block level Persistent Reservation Operations, which touches block,
nvme, target and dm (both of which are added with merge commits
containing a cover letter explaining what's going on).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Abel Vesa (2):
      scsi: ufs: ufs-qcom: Switch to the new ICE API
      scsi: ufs: dt-bindings: qcom: Add ICE phandle

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel Arrow Lake

Akshat Jain (5):
      scsi: pm80xx: Log port state during HW event
      scsi: pm80xx: Log phy_id and port_id in the device registration request
      scsi: pm80xx: Print port_id in HW events
      scsi: pm80xx: Enable init logging
      scsi: pm80xx: Log some HW events by default

Avri Altman (1):
      scsi: ufs: core: Do not open code SZ_x

Azeem Shaikh (10):
      scsi: ufs: Replace all non-returning strlcpy() with strscpy()
      scsi: smartpqi: Replace all non-returning strlcpy() with strscpy()
      scsi: sym53c8xx: Replace all non-returning strlcpy() with strscpy()
      scsi: message: fusion: Replace all non-returning strlcpy() with strscpy()
      scsi: libfcoe: Replace all non-returning strlcpy() with strscpy()
      scsi: lpfc: Replace all non-returning strlcpy() with strscpy()
      scsi: qla2xxx: Replace all non-returning strlcpy() with strscpy()
      scsi: qla4xxx: Replace all non-returning strlcpy() with strscpy()
      scsi: target: Replace all non-returning strlcpy() with strscpy()
      scsi: bfa: Replace all non-returning strlcpy() with strscpy()

Bagas Sanjaya (3):
      scsi: dc395x: Documentation: Reword original driver attribution
      scsi: dc395x: Documentation: Replace non-functional twibble.org list
      scsi: MAINTAINERS: Drop DC395x list and site

Bao D. Nguyen (7):
      scsi: ufs: core: Add error handling for MCQ mode
      scsi: ufs: mcq: Use ufshcd_mcq_poll_cqe_lock() in MCQ mode
      scsi: ufs: mcq: Added ufshcd_mcq_abort()
      scsi: ufs: mcq: Add support for cleaning up MCQ resources
      scsi: ufs: mcq: Add supporting functions for MCQ abort
      scsi: ufs: core: Update the ufshcd_clear_cmds() functionality
      scsi: ufs: core: Combine 32-bit command_desc_base_addr_lo/hi

Bart Van Assche (13):
      scsi: ufs: core: Remove a ufshcd_add_command_trace() call
      scsi: ufs: core: Simplify driver shutdown
      scsi: ufs: core: Move ufshcd_wl_shutdown()
      scsi: ufs: core: Fix handling of lrbp->cmd
      scsi: ufs: core: Increase the START STOP UNIT timeout from one to ten seconds
      scsi: ufs: Ungate the clock synchronously
      scsi: ufs: Declare ufshcd_{hold,release}() once
      scsi: ufs: Conditionally enable the BLK_MQ_F_BLOCKING flag
      scsi: core: Support setting BLK_MQ_F_BLOCKING
      scsi: core: Rework scsi_host_block()
      scsi: core: Only kick the requeue list if necessary
      scsi: core: Trace SCSI sense data
      scsi: core: Use min() instead of open-coding it

Bartosz Golaszewski (1):
      scsi: dt-bindings: ufs: qcom: Add compatible for sa8775p

Bikash Hazarika (2):
      scsi: qla2xxx: Correct the index of array
      scsi: qla2xxx: Fix potential NULL pointer dereference

Changyuan Lyu (3):
      scsi: pm80xx: Add fatal error checks
      scsi: pm80xx: Add GET_NVMD timeout during probe
      scsi: pm80xx: Update PHY state after hard reset

Christophe JAILLET (4):
      scsi: qla2xxx: Drop useless LIST_HEAD
      scsi: fnic: Use vzalloc()
      scsi: virtio_scsi: Remove a useless function call
      scsi: mpi3mr: Fix the type used for pointers to bitmap

Damien Le Moal (15):
      scsi: block: Improve ioprio value validity checks
      scsi: ata: libata-scsi: Fix ata_msense_control kdoc comment
      scsi: ata: libata: Set read/write commands CDL index
      scsi: ata: libata: Add ATA feature control sub-page translation
      scsi: ata: libata-scsi: Add support for CDL pages mode sense
      scsi: ata: libata-scsi: Handle CDL bits in ata_scsiop_maint_in()
      scsi: ata: libata: Detect support for command duration limits
      scsi: sd: Set read/write command CDL index
      scsi: core: Allow enabling and disabling command duration limits
      scsi: core: Detect support for command duration limits
      scsi: core: Support Service Action in scsi_report_opcode()
      scsi: core: Support retrieving sub-pages of mode pages
      scsi: block: Introduce BLK_STS_DURATION_LIMIT
      scsi: block: Introduce ioprio hints
      scsi: block: ioprio: Clean up interface definition

Dan Carpenter (2):
      scsi: qla2xxx: Fix end of loop test
      scsi: ufs: ufs-mediatek: Delete some dead code

David Strahan (1):
      scsi: smartpqi: Add new controller PCI IDs

Don Brace (5):
      scsi: smartpqi: Update version to 2.1.22-040
      scsi: smartpqi: Update copyright to 2023
      scsi: smartpqi: Add sysfs entry for NUMA node in /sys/block/sdX/device
      scsi: smartpqi: Fix byte aligned writew for ARM servers
      scsi: smartpqi: Fix rare SAS transport memory leak

Gilbert Wu (1):
      scsi: smartpqi: Add support for RAID NCQ priority

Gustavo A. R. Silva (3):
      scsi: qla2xxx: Replace one-element array with DECLARE_FLEX_ARRAY() helper
      scsi: lpfc: Avoid -Wstringop-overflow warning
      scsi: lpfc: Replace one-element array with flexible-array member

Hannes Reinecke (2):
      scsi: sg: Increase number of devices
      scsi: bsg: Increase number of devices

Harshit Mogalapalli (1):
      scsi: mpi3mr: Use -ENOMEM instead of -1 in mpi3mr_expander_add()

Jason Yan (4):
      scsi: MAINTAINERS: Add a libsas entry
      scsi: libsas: factor out sas_check_fanout_expander_topo()
      scsi: libsas: Remove an empty branch in sas_check_parent_topology()
      scsi: libsas: Simplify sas_check_eeds()

Jinhong Zhu (1):
      scsi: qedf: Fix NULL dereference in error handling

Johannes Thumshirn (1):
      scsi: sd: sd_zbc: Use PAGE_SECTORS_SHIFT

Justin Tee (18):
      scsi: lpfc: Use struct_size() helper
      scsi: lpfc: Fix incorrect big endian type assignments in FDMI and VMID paths
      scsi: lpfc: Copyright updates for 14.2.0.13 patches
      scsi: lpfc: Update lpfc version to 14.2.0.13
      scsi: lpfc: Enhance congestion statistics collection
      scsi: lpfc: Clean up SLI-4 CQE status handling
      scsi: lpfc: Change firmware upgrade logging to KERN_NOTICE instead of TRACE_EVENT
      scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state
      scsi: lpfc: Account for fabric domain ctlr device loss recovery
      scsi: lpfc: Clear NLP_IN_DEV_LOSS flag if already in rediscovery
      scsi: lpfc: Fix use-after-free rport memory access in lpfc_register_remote_port()
      scsi: lpfc: Update lpfc version to 14.2.0.12
      scsi: lpfc: Replace blk_irq_poll intr handler with threaded IRQ
      scsi: lpfc: Add new RCQE status for handling DMA failures
      scsi: lpfc: Update congestion warning notification period
      scsi: lpfc: Match lock ordering of lpfc_cmd->buf_lock and hbalock for abort paths
      scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()
      scsi: lpfc: Fix verbose logging for SCSI commands issued to SES devices

Kees Cook (1):
      scsi: megaraid_sas: Convert union megasas_sgl to flex-arrays

Keoseong Park (2):
      scsi: ufs: core: Return earlier if ufshcd_hba_init_crypto_capabilities() fails
      scsi: ufs: core: Change the module parameter macro of use_mcq_mode

Kevin Barnett (2):
      scsi: smartpqi: Stop sending driver-initiated TURs
      scsi: smartpqi: Remove NULL pointer check

Krzysztof Kozlowski (2):
      scsi: ufs: dt-bindings: samsung,exynos: Drop unneeded quotes
      scsi: ufs: hwmon: Constify pointers to hwmon_channel_info

Lu Hongfei (1):
      scsi: ufs: wb: Add explicit flush_threshold sysfs attribute

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Martin Wilck (5):
      scsi: core: Improve warning message in scsi_device_block()
      scsi: core: Replace scsi_target_block() with scsi_block_targets()
      scsi: core: Don't wait for quiesce in scsi_device_block()
      scsi: core: Don't wait for quiesce in scsi_stop_queue()
      scsi: core: Merge scsi_internal_device_block() and device_block()

Mike Christie (18):
      scsi: target: Add block PR support to iblock
      scsi: target: Report and detect unsupported PR commands
      scsi: target: Pass struct target_opcode_descriptor to enabled
      scsi: target: Allow backends to hook into PR handling
      scsi: target: Rename sbc_ops to exec_cmd_ops
      nvme: Add pr_ops read_reservation support
      nvme: Add a nvme_pr_type enum
      nvme: Add pr_ops read_keys support
      nvme: Add helper to send pr command
      nvme: Move pr code to it's own file
      nvme: Don't hardcode the data len for pr commands
      nvme: Fix reservation status related structs
      dm: Add support for block PR read keys/reservation
      scsi: Add support for block PR read keys/reservation
      scsi: Move sd_pr_type to scsi_common
      scsi: Rename sd_pr_command
      block: Rename BLK_STS_NEXUS to BLK_STS_RESV_CONFLICT
      block: Add PR callouts for read keys and reservation

Mike McGowen (2):
      scsi: smartpqi: Remove contention for raid_bypass_cnt
      scsi: smartpqi: Map full length of PCI BAR 0

Murthy Bhat (1):
      scsi: smartpqi: Validate block layer host tag

Niklas Cassel (6):
      scsi: ata: libata: Handle completion of CDL commands using policy 0xD
      scsi: ata: libata: Change ata_eh_request_sense() to not set CHECK_CONDITION
      scsi: ata: libata-scsi: Remove unnecessary !cmd checks
      scsi: sd: Handle read/write CDL timeout failures
      scsi: core: Rename and move get_scsi_ml_byte()
      scsi: core: Allow libata to complete successful commands via EH

Niklas Schnelle (2):
      scsi: Add HAS_IOPORT dependencies
      scsi: message: fusion: Add HAS_IOPORT dependencies

Nilesh Javali (5):
      scsi: qla2xxx: Update version to 10.02.08.400-k
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
      scsi: qla2xxx: Avoid fcport pointer dereference
      scsi: qla2xxx: Array index may go out of bound
      scsi: qla2xxx: Update version to 10.02.08.300-k

Po-Wen Kao (5):
      scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_RTC quirk
      scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
      scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
      scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
      scsi: ufs: core: Remove dedicated hwq for dev command

Quinn Tran (7):
      scsi: qla2xxx: Fix buffer overrun
      scsi: qla2xxx: Wait for io return on terminate rport
      scsi: qla2xxx: Fix mem access after free
      scsi: qla2xxx: Fix hang in task management
      scsi: qla2xxx: Fix task management cmd fail due to unavailable resource
      scsi: qla2xxx: Fix task management cmd failure
      scsi: qla2xxx: Multi-que support for TMF

Randy Dunlap (11):
      scsi: docs: sym53c8xx_2: Shorten chapter heading
      scsi: docs: ncr53c8xx: Shorten chapter heading
      scsi: docs: megaraid: Clarify chapter heading
      scsi: docs: g_NCR5380: Shorten chapter heading
      scsi: docs: scsi-generic: Multiple cleanups
      scsi: docs: scsi_fc_transport: Fix typo in heading
      scsi: docs: dc395x: Shorten the chapter heading
      scsi: docs: scsi-changer: Shorten the chapter heading
      scsi: docs: arcmsr: Use a chapter heading for clarity
      scsi: docs: introduction: Multiple cleanups
      scsi: docs: Organize the SCSI documentation

Sathya Prakash (1):
      scsi: mpi3mr: Propagate sense data for admin queue SCSI I/O

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Stanley Chu (2):
      scsi: ufs: core: mcq: Fix the incorrect OCS value for the device command
      scsi: ufs: core: Combine ufshcd_mq_poll_cqe functions

Uwe Kleine-König (1):
      scsi: hisi_sas: Convert to platform remove callback returning void

Xingui Yang (2):
      scsi: hisi_sas: Fix warnings detected by sparse
      scsi: hisi_sas: Change DMA setup lock timeout to 2.5s

Yihang Li (1):
      scsi: hisi_sas: Configure initial value of some registers according to HBA model

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

zhanghui (1):
      scsi: ufs: core: Fix ufshcd_inc_sq_tail() function bug

And the diffstat:

 Documentation/ABI/testing/sysfs-block-device       |  22 +
 Documentation/ABI/testing/sysfs-driver-ufs         |  11 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  26 ++
 .../bindings/ufs/samsung,exynos-ufs.yaml           |   2 +-
 Documentation/scsi/arcmsr_spec.rst                 |   1 +
 Documentation/scsi/dc395x.rst                      |  17 +-
 Documentation/scsi/g_NCR5380.rst                   |   6 +-
 Documentation/scsi/index.rst                       |  37 +-
 Documentation/scsi/megaraid.rst                    |   6 +-
 Documentation/scsi/ncr53c8xx.rst                   |   6 +-
 Documentation/scsi/scsi-changer.rst                |   6 +-
 Documentation/scsi/scsi-generic.rst                |  53 +--
 Documentation/scsi/scsi.rst                        |  23 +-
 Documentation/scsi/scsi_fc_transport.rst           |   8 +-
 Documentation/scsi/sym53c8xx_2.rst                 |   6 +-
 MAINTAINERS                                        |  13 +-
 block/bfq-iosched.c                                |   8 +-
 block/blk-core.c                                   |   5 +-
 block/bsg.c                                        |   2 +-
 block/ioprio.c                                     |   7 +-
 drivers/ata/libata-core.c                          | 204 ++++++++-
 drivers/ata/libata-eh.c                            | 130 +++++-
 drivers/ata/libata-sata.c                          | 103 ++++-
 drivers/ata/libata-scsi.c                          | 385 ++++++++++++++---
 drivers/ata/libata.h                               |   2 +-
 drivers/md/dm.c                                    |  69 +++
 drivers/message/fusion/Kconfig                     |   2 +-
 drivers/message/fusion/mptbase.c                   |   4 +-
 drivers/message/fusion/mptctl.c                    |   2 +-
 drivers/nvme/host/Makefile                         |   2 +-
 drivers/nvme/host/core.c                           | 149 +------
 drivers/nvme/host/nvme.h                           |   2 +
 drivers/nvme/host/pr.c                             | 315 ++++++++++++++
 drivers/s390/block/dasd.c                          |   7 +-
 drivers/scsi/3w-xxxx.c                             |   4 +-
 drivers/scsi/Kconfig                               |  25 +-
 drivers/scsi/aic7xxx/Kconfig.aic79xx               |   2 +-
 drivers/scsi/aic7xxx/Kconfig.aic7xxx               |   2 +-
 drivers/scsi/aic94xx/Kconfig                       |   2 +-
 drivers/scsi/bfa/bfa_fcbuild.c                     |   4 +-
 drivers/scsi/bfa/bfa_fcs.c                         |   4 +-
 drivers/scsi/bfa/bfa_fcs_lport.c                   |  20 +-
 drivers/scsi/bfa/bfa_ioc.c                         |   2 +-
 drivers/scsi/bfa/bfa_svc.c                         |   2 +-
 drivers/scsi/bfa/bfad.c                            |  10 +-
 drivers/scsi/bfa/bfad_attr.c                       |   2 +-
 drivers/scsi/bfa/bfad_bsg.c                        |   4 +-
 drivers/scsi/bfa/bfad_im.c                         |   2 +-
 drivers/scsi/fcoe/fcoe_transport.c                 |   2 +-
 drivers/scsi/fnic/fnic_debugfs.c                   |   8 +-
 drivers/scsi/hisi_sas/hisi_sas.h                   |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c             |   7 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c             |   7 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  28 +-
 drivers/scsi/hosts.c                               |   1 +
 drivers/scsi/libsas/sas_expander.c                 | 124 +++---
 drivers/scsi/lpfc/lpfc.h                           |  65 +--
 drivers/scsi/lpfc/lpfc_attr.c                      |   4 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |   4 +-
 drivers/scsi/lpfc/lpfc_ct.c                        |  92 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   8 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  44 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  59 +--
 drivers/scsi/lpfc/lpfc_hw.h                        |  20 +-
 drivers/scsi/lpfc/lpfc_hw4.h                       |  14 +-
 drivers/scsi/lpfc/lpfc_init.c                      | 276 ++++--------
 drivers/scsi/lpfc/lpfc_logmsg.h                    |   6 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |  61 +--
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   6 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  68 ++-
 drivers/scsi/lpfc/lpfc_sli.c                       | 446 +++++++++++--------
 drivers/scsi/lpfc/lpfc_sli4.h                      |   4 +-
 drivers/scsi/lpfc/lpfc_version.h                   |   2 +-
 drivers/scsi/megaraid/Kconfig.megaraid             |   6 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   8 +-
 drivers/scsi/mpi3mr/mpi3mr.h                       |   8 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   7 +-
 drivers/scsi/mpi3mr/mpi3mr_transport.c             |   2 +-
 drivers/scsi/mvsas/Kconfig                         |   2 +-
 drivers/scsi/pcmcia/Kconfig                        |   6 +-
 drivers/scsi/pm8001/pm8001_init.c                  |  32 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |  22 +
 drivers/scsi/pm8001/pm8001_sas.h                   |   1 +
 drivers/scsi/pm8001/pm80xx_hwi.c                   | 126 ++++--
 drivers/scsi/qedf/qedf_main.c                      |   3 +-
 drivers/scsi/qla2xxx/Kconfig                       |   2 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |  13 +
 drivers/scsi/qla2xxx/qla_bsg.c                     |   6 +
 drivers/scsi/qla2xxx/qla_def.h                     |  26 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   4 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   2 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |   4 +-
 drivers/scsi/qla2xxx/qla_init.c                    | 267 ++++++++++--
 drivers/scsi/qla2xxx/qla_inline.h                  |   5 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |  36 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |  64 ++-
 drivers/scsi/qla2xxx/qla_mr.c                      |  20 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 -
 drivers/scsi/qla2xxx/qla_os.c                      | 133 +++---
 drivers/scsi/qla2xxx/qla_version.h                 |   4 +-
 drivers/scsi/qla4xxx/ql4_mbx.c                     |   8 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |  14 +-
 drivers/scsi/scsi.c                                | 171 +++++++-
 drivers/scsi/scsi_common.c                         |  46 +-
 drivers/scsi/scsi_error.c                          |  48 ++-
 drivers/scsi/scsi_lib.c                            | 137 +++---
 drivers/scsi/scsi_priv.h                           |   6 +
 drivers/scsi/scsi_scan.c                           |   3 +
 drivers/scsi/scsi_sysfs.c                          |  30 ++
 drivers/scsi/scsi_transport_fc.c                   |   2 +-
 drivers/scsi/scsi_transport_iscsi.c                |   3 +-
 drivers/scsi/scsi_transport_sas.c                  |   2 +-
 drivers/scsi/scsi_transport_srp.c                  |   6 +-
 drivers/scsi/sd.c                                  | 189 +++++++--
 drivers/scsi/sd_zbc.c                              |   2 +-
 drivers/scsi/sg.c                                  |   2 +-
 drivers/scsi/smartpqi/Kconfig                      |   2 +-
 drivers/scsi/smartpqi/smartpqi.h                   |   6 +-
 drivers/scsi/smartpqi/smartpqi_init.c              | 286 +++++++------
 drivers/scsi/smartpqi/smartpqi_sas_transport.c     |  34 +-
 drivers/scsi/smartpqi/smartpqi_sis.c               |   2 +-
 drivers/scsi/smartpqi/smartpqi_sis.h               |   2 +-
 drivers/scsi/snic/snic_disc.c                      |   2 +-
 drivers/scsi/sr.c                                  |   2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c                |   2 +-
 drivers/scsi/virtio_scsi.c                         |   4 +-
 drivers/target/iscsi/iscsi_target_parameters.c     |   4 +-
 drivers/target/iscsi/iscsi_target_util.c           |   4 +-
 drivers/target/target_core_configfs.c              |  10 +-
 drivers/target/target_core_device.c                |   6 +-
 drivers/target/target_core_file.c                  |   4 +-
 drivers/target/target_core_iblock.c                | 275 +++++++++++-
 drivers/target/target_core_pr.c                    |  79 +++-
 drivers/target/target_core_rd.c                    |   4 +-
 drivers/target/target_core_sbc.c                   |  13 +-
 drivers/target/target_core_spc.c                   | 113 +++--
 drivers/ufs/core/ufs-fault-injection.c             |   2 +-
 drivers/ufs/core/ufs-hwmon.c                       |   2 +-
 drivers/ufs/core/ufs-mcq.c                         | 296 +++++++++++--
 drivers/ufs/core/ufs-sysfs.c                       |  35 +-
 drivers/ufs/core/ufshcd-crypto.c                   |   2 +-
 drivers/ufs/core/ufshcd-priv.h                     |  27 +-
 drivers/ufs/core/ufshcd.c                          | 471 +++++++++++++--------
 drivers/ufs/core/ufshpb.c                          |   6 +-
 drivers/ufs/core/ufshpb.h                          |   2 +-
 drivers/ufs/host/Kconfig                           |   2 +-
 drivers/ufs/host/Makefile                          |   4 +-
 drivers/ufs/host/cdns-pltfrm.c                     |   1 -
 drivers/ufs/host/tc-dwc-g210-pci.c                 |  10 -
 drivers/ufs/host/tc-dwc-g210-pltfrm.c              |   1 -
 drivers/ufs/host/ufs-exynos.c                      |   3 +-
 drivers/ufs/host/ufs-hisi.c                        |  25 +-
 drivers/ufs/host/ufs-mediatek.c                    |   6 +-
 drivers/ufs/host/ufs-qcom-ice.c                    | 244 -----------
 drivers/ufs/host/ufs-qcom.c                        | 102 ++++-
 drivers/ufs/host/ufs-qcom.h                        |  32 +-
 drivers/ufs/host/ufs-sprd.c                        |   1 -
 drivers/ufs/host/ufshcd-pci.c                      |  11 +-
 drivers/ufs/host/ufshcd-pltfrm.c                   |   6 -
 drivers/ufs/host/ufshcd-pltfrm.h                   |   1 -
 include/linux/ata.h                                |  11 +-
 include/linux/blk_types.h                          |  10 +-
 include/linux/libata.h                             |  42 +-
 include/linux/nvme.h                               |  51 ++-
 include/linux/pr.h                                 |  25 ++
 include/scsi/scsi_cmnd.h                           |   5 +
 include/scsi/scsi_common.h                         |  13 +
 include/scsi/scsi_device.h                         |  20 +-
 include/scsi/scsi_host.h                           |   6 +
 include/scsi/scsi_proto.h                          |   5 +
 include/target/target_core_backend.h               |   8 +-
 include/target/target_core_base.h                  |   3 +-
 include/trace/events/scsi.h                        |  21 +-
 include/uapi/linux/ioprio.h                        | 100 ++++-
 include/ufs/ufshcd.h                               |  22 +-
 include/ufs/ufshci.h                               |  25 +-
 177 files changed, 4837 insertions(+), 2244 deletions(-)
 create mode 100644 drivers/nvme/host/pr.c
 delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c

James

