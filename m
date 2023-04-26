Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D66EFBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjDZUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:37:07 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400C2D48;
        Wed, 26 Apr 2023 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1682541362;
        bh=tRBpCwkVQzdozlZmcLHXzJAO2fLHHHcvTiNSBf3TJ3M=;
        h=Message-ID:Subject:From:To:Date:From;
        b=e091EwWVHGpYFVwUBEj/OADzCkjFdyQNLAPE29SPKUhO/4sGs2qCGHE18K7eRSbVO
         SiFGY/4udi+sdVdonFShrL+st+pij32XylqwVTtV9ppT2lDKXZwIT/rEJNykydzJoR
         8ODwUvs+G+VP/6fnRX2mAxjorjlL/BTY9B0Ngtj8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A3C7E1280BBF;
        Wed, 26 Apr 2023 16:36:02 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id IcIYdG-EwQYH; Wed, 26 Apr 2023 16:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1682541362;
        bh=tRBpCwkVQzdozlZmcLHXzJAO2fLHHHcvTiNSBf3TJ3M=;
        h=Message-ID:Subject:From:To:Date:From;
        b=e091EwWVHGpYFVwUBEj/OADzCkjFdyQNLAPE29SPKUhO/4sGs2qCGHE18K7eRSbVO
         SiFGY/4udi+sdVdonFShrL+st+pij32XylqwVTtV9ppT2lDKXZwIT/rEJNykydzJoR
         8ODwUvs+G+VP/6fnRX2mAxjorjlL/BTY9B0Ngtj8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EC9C11280523;
        Wed, 26 Apr 2023 16:36:01 -0400 (EDT)
Message-ID: <8f12f4923557bccfe40aa50c01b1154946b82669.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.3+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Apr 2023 16:35:59 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (megaraid_sas, scsi_debug, lpfc, target,
mpi3mr, hisi_sas, arcmsr).  The major core change is the constification
of the host templates (which touches everything) along with other minor
fixups and clean ups.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Adrian Hunter (1):
      scsi: ufs: ufs-pci: Add support for Intel Lunar Lake

Adrien Thierry (1):
      scsi: ufs: core: Add soft dependency on governor_simpleondemand

Andy Shevchenko (1):
      scsi: fnic: Switch to use %ptTs

Arnd Bergmann (1):
      scsi: hisi_sas: Work around build failure in suspend function

Asutosh Das (3):
      scsi: ufs: mcq: Use active_reqs to check busy in clock scaling
      scsi: ufs: mcq: qcom: Clean the return path of ufs_qcom_mcq_config_resource()
      scsi: ufs: mcq: qcom: Fix passing zero to PTR_ERR

Avri Altman (2):
      scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()
      scsi: ufs: mcq: Annotate ufshcd_inc_sq_tail() appropriately

Bart Van Assche (83):
      scsi: usb: uas: Declare two host templates and host template pointers const
      scsi: ufs: Declare SCSI host template const
      scsi: target: tcm-loop: Declare SCSI host template const
      scsi: rts5208: Declare SCSI host template const
      scsi: xen-scsifront: Declare SCSI host template const
      scsi: wd719x: Declare SCSI host template const
      scsi: virtio-scsi: Declare SCSI host template const
      scsi: sym53c8xx: Declare SCSI host template const
      scsi: stex: Declare SCSI host template const
      scsi: snic: Declare SCSI host template const
      scsi: smartpqi: Declare SCSI host template const
      scsi: sgiwd93: Declare SCSI host template const
      scsi: qlogicpti: Declare SCSI host template const
      scsi: qla2xxx: Declare SCSI host template const
      scsi: qla1280: Declare SCSI host template const
      scsi: ps3rom: Declare SCSI host template const
      scsi: ppa: Declare SCSI host template const
      scsi: pmcraid: Declare SCSI host template const
      scsi: pcmcia-pm8001: Declare SCSI host template const
      scsi: pcmcia-sym53c500: Declare SCSI host template const
      scsi: nsp32: Declare SCSI host template const
      scsi: myrs: Declare SCSI host template const
      scsi: myrb: Declare SCSI host template const
      scsi: mvumi: Declare SCSI host template const
      scsi: mvsas: Declare SCSI host template const
      scsi: mvme147: Declare SCSI host template const
      scsi: mpt3sas: Declare SCSI host template const
      scsi: mpi3mr: Declare SCSI host template const
      scsi: mesh: Declare SCSI host template const
      scsi: megaraid: Declare SCSI host template const
      scsi: mac53c94: Declare SCSI host template const
      scsi: iscsi: Declare SCSI host template const
      scsi: isci: Declare SCSI host template const
      scsi: ipr: Declare SCSI host template const
      scsi: initio: Declare SCSI host template const
      scsi: imm: Declare SCSI host template const
      scsi: ibmvfc: Declare SCSI host template const
      scsi: hptiop: Declare SCSI host template const
      scsi: hpsa: Declare SCSI host template const
      scsi: hisi_sas: Declare SCSI host template const
      scsi: gvp11: Declare SCSI host template const
      scsi: NCR5380: Declare SCSI host template const
      scsi: fdomain: Declare SCSI host template const
      scsi: qedf: Declare host template const
      scsi: fnic: Declare host template const
      scsi: fcoe: Declare SCSI host template const
      scsi: esp_scsi: Declare SCSI host template const
      scsi: esas2r: Declare SCSI host template const
      scsi: elx: efct: Declare SCSI host template const
      scsi: dmx3191d: Declare SCSI host template const
      scsi: dc395x: Declare SCSI host template const
      scsi: atp870u: Declare SCSI host template const
      scsi: powertec: Declare SCSI host template const
      scsi: oak: Declare SCSI host template const
      scsi: eesox: Declare SCSI host template const
      scsi: cumana: Declare SCSI host template const
      scsi: aha1740: Declare SCSI host template const
      scsi: arxescsi: Declare SCSI host template const
      scsi: acornscsi: Declare SCSI host template const
      scsi: arcmsr: Declare SCSI host template const
      scsi: aic94xx: Declare SCSI host template const
      scsi: aha1542: Declare SCSI host template const
      scsi: aha152x: Declare SCSI host template const
      scsi: advansys: Declare SCSI host template const
      scsi: aacraid: Declare SCSI host template const
      scsi: a3000: Declare SCSI host template const
      scsi: a2091: Declare SCSI host template const
      scsi: a100u2w: Declare SCSI host template const
      scsi: BusLogic: Declare SCSI host template const
      scsi: 3w-xxxx: Declare SCSI host template const
      scsi: 3w-sas: Declare SCSI host template const
      scsi: 3w-9xxx: Declare SCSI host template const
      scsi: zfcp: Declare SCSI host template const
      scsi: message: fusion: Declare SCSI host template members const
      scsi: RDMA/srp: Declare the SCSI host template const
      scsi: firewire: sbp2: Declare the SCSI host template const
      scsi: ata: Declare SCSI host templates const
      scsi: core: Declare SCSI host template pointer members const
      scsi: core: Declare most SCSI host template pointers const
      scsi: qla2xxx: Refer directly to the qla2xxx_driver_template
      scsi: ufs: core: Set the residual byte count
      scsi: ufs: core: Disable the reset settle delay
      scsi: core: Fix a procfs host directory removal regression

Bjorn Helgaas (10):
      scsi: qla4xxx: Drop redundant pci_enable_pcie_error_reporting()
      scsi: qla2xxx: Drop redundant pci_enable_pcie_error_reporting()
      scsi: mpt3sas: Drop redundant pci_enable_pcie_error_reporting()
      scsi: lpfc: Drop redundant pci_enable_pcie_error_reporting()
      scsi: hpsa: Remove unnecessary pci_disable_pcie_error_reporting() comment
      scsi: csiostor: Remove unnecessary aer.h include
      scsi: bfa: Drop redundant pci_enable_pcie_error_reporting()
      scsi: be2iscsi: Drop redundant pci_enable_pcie_error_reporting()
      scsi: arcmsr: Remove unnecessary aer.h include
      scsi: aacraid: Drop redundant pci_enable_pcie_error_reporting()

Chandrakanth Patil (3):
      scsi: megaraid_sas: Driver version update to 07.725.01.00-rc1
      scsi: megaraid_sas: Add crash dump mode capability bit in MFI capabilities
      scsi: megaraid_sas: Update max supported LD IDs to 240

Damien Le Moal (1):
      scsi: core: Improve scsi_vpd_inquiry() checks

Dan Carpenter (1):
      scsi: ufs: ufs-qcom: Remove impossible check

Daniel Wagner (1):
      scsi: qla2xxx: Add option to disable FC2 Target support

Danila Chernetsov (1):
      scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS

Dmitry Bogdanov (16):
      scsi: target: iscsi: Handle abort for WRITE_PENDING cmds
      scsi: target: iscsit: Free cmds before session free
      scsi: target: Add virtual remote target
      scsi: efct: Remove default fabric ops callouts
      scsi: qla2xxx: Remove default fabric ops callouts
      scsi: xen-scsiback: Remove default fabric ops callouts
      scsi: vhost-scsi: Remove default fabric ops callouts
      scsi: usb: gadget: f_tcm: Remove default fabric ops callouts
      scsi: target: fcoe: Remove default fabric ops callouts
      scsi: target: sbp: Remove default fabric ops callouts
      scsi: target: loop: Remove default fabric ops callouts
      scsi: ibmvscsit: Remove default fabric ops callouts
      scsi: infiniband: srpt: Remove default fabric ops callouts
      scsi: target: Add default fabric ops callouts
      scsi: target: core: Add RTPI attribute for target port
      scsi: target: core: Add RTPI field to target port

Enze Li (1):
      scsi: sr: Simplify the sr_open() function

Geert Uytterhoeven (1):
      scsi: cxlflash: s/semahpore/semaphore/

Gustavo A. R. Silva (1):
      scsi: target: uapi: Replace fake flex-array with flexible-array member

Harshit Mogalapalli (1):
      scsi: scsi_debug: Fix missing error code in scsi_debug_init()

Jakob Koschel (1):
      scsi: lpfc: Avoid usage of list iterator variable after loop

Jason Yan (1):
      scsi: libsas: Abort all in-flight requests when device is gone

Jerry Snitselaar (1):
      scsi: mpt3sas: Don't print sense pool info twice

Jiapeng Chong (2):
      scsi: hpsa: Remove unused variable transMethod
      scsi: be2iscsi: Remove unused variable internal_page_offset

Joel Selvaraj (1):
      scsi: core: Add BLIST_SKIP_VPD_PAGES for SKhynix H28U74301AMR

John Garry (22):
      scsi: scsi_debug: Drop sdebug_queue
      scsi: scsi_debug: Only allow sdebug_max_queue be modified when no shosts
      scsi: scsi_debug: Use scsi_host_busy() in delay_store() and ndelay_store()
      scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
      scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in sdebug_blk_mq_poll()
      scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
      scsi: scsi_debug: Use scsi_block_requests() to block queues
      scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
      scsi: scsi_debug: Change shost list lock to a mutex
      scsi: scsi_debug: Don't iter all shosts in clear_luns_changed_on_target()
      scsi: scsi_debug: Fix check for sdev queue full
      scsi: scsi_debug: Add poll mode deferred completions to statistics
      scsi: scsi_debug: Get command abort feature working again
      scsi: scsi_debug: Drop sdebug_dev_info.num_in_q
      scsi: scsi_debug: Drop check for num_in_q exceeding queue depth
      scsi: scsi_debug: Drop scsi_debug_host_reset() device NULL pointer check
      scsi: scsi_debug: Drop scsi_debug_bus_reset() NULL pointer checks
      scsi: scsi_debug: Drop scsi_debug_target_reset() NULL pointer checks
      scsi: scsi_debug: Drop scsi_debug_device_reset() NULL pointer checks
      scsi: scsi_debug: Drop scsi_debug_abort() NULL pointer checks
      scsi: scsi_debug: Stop setting devip->sdbg_host twice
      scsi: scsi_debug: Don't hold driver host struct pointer in host->hostdata[]

Jun Chen (1):
      scsi: lpfc: Silence an incorrect device output

Justin Tee (11):
      scsi: lpfc: Copyright updates for 14.2.0.11 patches
      scsi: lpfc: Update lpfc version to 14.2.0.11
      scsi: lpfc: Revise lpfc_error_lost_link() reason code evaluation logic
      scsi: lpfc: Skip waiting for register ready bits when in unrecoverable state
      scsi: lpfc: Correct used_rpi count when devloss tmo fires with no recovery
      scsi: lpfc: Defer issuing new PLOGI if received RSCN before completing REG_LOGIN
      scsi: lpfc: Record LOGO state with discovery engine even if aborted
      scsi: lpfc: Fix lockdep warning for rx_monitor lock when unloading driver
      scsi: lpfc: Reorder freeing of various DMA buffers and their list removal
      scsi: lpfc: Prevent lpfc_debugfs_lockstat_write() buffer overflow
      scsi: lpfc: Check kzalloc() in lpfc_sli4_cgn_params_read()

Kang Chen (1):
      scsi: hisi_sas: Check devm_add_action() return value

Krzysztof Kozlowski (3):
      scsi: ufs: hisi: Drop of_match_ptr() for ID table
      scsi: ufs: exynos: Drop of_match_ptr() for ID table
      scsi: ufs: qcom: Add __maybe_unused to OF ID table

Lee Duncan (1):
      scsi: core: Add BLIST_NO_VPD_SIZE for some VDASD

Lizhe (2):
      scsi: target: tcm_loop: Remove redundant driver match function
      scsi: scsi_debug: Remove redundant driver match function

Maurizio Lombardi (2):
      scsi: target: core: Fix invalid memory access
      scsi: target: iscsi: Fix an error message in iscsi_check_key()

Michael Kelley (1):
      scsi: storvsc: Handle BlockSize change in Hyper-V VHD/VHDX file

Mike Christie (7):
      scsi: target: iscsit: Fix TAS handling during conn cleanup
      scsi: target: Fix multiple LUN_RESET handling
      scsi: target: iscsit: Stop/wait on cmds during conn close
      scsi: target: iscsit: isert: Alloc per conn cmd counter
      scsi: target: Pass in cmd counter to use during cmd setup
      scsi: target: Move cmd counter allocation
      scsi: target: Move sess cmd counter to new struct

Nilesh Javali (1):
      scsi: qla2xxx: Perform lockless command completion in abort path

Quinn Tran (1):
      scsi: qla2xxx: Synchronize the IOCB count to be in order

Ranjan Kumar (16):
      scsi: mpi3mr: Use IRQ save variants of spinlock to protect chain frame allocation
      scsi: mpt3sas: Remove HBA BIOS version in the kernel log
      scsi: mpi3mr: Update driver version to 8.4.1.0.0
      scsi: mpi3mr: Update copyright year
      scsi: mpi3mr: Fix W=1 compilation warnings
      scsi: mpi3mr: Update MPI Headers to revision 27
      scsi: mpi3mr: Avoid escalating to higher level reset when target is removed
      scsi: mpi3mr: Modify MUR timeout value to 120 seconds
      scsi: mpi3mr: Fix admin queue memory leak upon soft reset
      scsi: mpi3mr: Successive VD delete and add causes FW fault
      scsi: mpi3mr: Bad drive in topology results kernel crash
      scsi: mpi3mr: NVMe command size greater than 8K fails
      scsi: mpi3mr: Return proper values for failures in firmware init path
      scsi: mpi3mr: Wait for diagnostic save during controller init
      scsi: mpi3mr: Driver unload crashes host when enhanced logging is enabled
      scsi: mpi3mr: ioctl timeout when disabling/enabling interrupt

Rob Herring (1):
      scsi: qlogicpti: sun_esp: Use of_property_read_bool() for boolean properties

Roman Bolshakov (2):
      scsi: target: core: Drop device-based RTPI
      scsi: target: core: Use RTPI from target port

Shin'ichiro Kawasaki (1):
      scsi: sd: Fix wrong zone_write_granularity value during revalidate

Shuchang Li (1):
      scsi: lpfc: Fix ioremap issues in lpfc_sli4_pci_mem_setup()

Stanley Chu (1):
      scsi: core: Clean up struct ufs_saved_pwr_info

Tetsuo Handa (2):
      scsi: message: fusion: Avoid flush_scheduled_work() usage
      scsi: message: fusion: Remove unused sas_persist_task work

Tom Rix (6):
      scsi: qla4xxx: Remove unused 'count' variable
      scsi: snic: Remove unused 'xfer_len' variable
      scsi: qedf: Remove unused 'num_handled' variable
      scsi: scsi_transport_fc: Remove unused 'desc_cnt' variable
      scsi: target: core: Remove unused 'prod_len' variable
      scsi: be2iscsi: Make some variables static

Tomas Henzl (9):
      scsi: mpt3sas: Fix an issue when driver is being removed
      scsi: megaraid_sas: Fix crash after a double completion
      scsi: megaraid_sas: Fix fw_crash_buffer_show()
      scsi: mpi3mr: Fix expander node leak in mpi3mr_remove()
      scsi: mpi3mr: Fix memory leaks in mpi3mr_init_ioc()
      scsi: mpi3mr: Fix sas_hba.phy memory leak in mpi3mr_remove()
      scsi: mpi3mr: Fix mpi3mr_hba_port memory leak in mpi3mr_remove()
      scsi: mpi3mr: Fix config page DMA memory leak
      scsi: mpi3mr: Fix throttle_groups memory leak

Wenchao Hao (1):
      scsi: mpt3sas: Fix NULL pointer access in mpt3sas_transport_port_add()

Xiang Chen (4):
      scsi: hisi_sas: Add device attribute experimental_iopoll_q_cnt for v3 hw
      scsi: hisi_sas: Sync complete queue for poll queue
      scsi: hisi_sas: Add poll support for v3 hw
      scsi: hisi_sas: Add function complete_v3_hw()

Xingui Yang (2):
      scsi: hisi_sas: Handle NCQ error when IPTT is valid
      scsi: hisi_sas: Grab sas_dev lock when traversing the members of sas_dev.list

Yihang Li (2):
      scsi: hisi_sas: Exit suspend state when usage count is greater than 0
      scsi: hisi_sas: Ensure all enabled PHYs up during controller reset

Yu Kuai (1):
      scsi: scsi_dh_alua: Fix memleak for 'qdata' in alua_activate()

Zheng Wang (1):
      scsi: message: mptlan: Fix use after free bug in mptlan_remove() due to race condition

Ziqi Chen (2):
      scsi: ufs: core: Add trace event for MCQ
      scsi: ufs: core: Print trs for pending requests in MCQ mode

ching Huang (5):
      scsi: arcmsr: Update driver version
      scsi: arcmsr: Add driver proc_name
      scsi: arcmsr: Fix reading empty buffer length
      scsi: arcmsr: Fix ADAPTER_TYPE_B 64-bit DMA compatibility issue
      scsi: arcmsr: Deprecate using arcmsr_pci_unmap_dma()

And the diffstat:

 Documentation/scsi/scsi_mid_low_api.rst        |   2 +-
 drivers/ata/acard-ahci.c                       |   2 +-
 drivers/ata/ahci.c                             |   2 +-
 drivers/ata/ahci.h                             |   2 +-
 drivers/ata/ahci_brcm.c                        |   2 +-
 drivers/ata/ahci_ceva.c                        |   2 +-
 drivers/ata/ahci_da850.c                       |   2 +-
 drivers/ata/ahci_dm816.c                       |   2 +-
 drivers/ata/ahci_dwc.c                         |   2 +-
 drivers/ata/ahci_imx.c                         |   2 +-
 drivers/ata/ahci_mtk.c                         |   2 +-
 drivers/ata/ahci_mvebu.c                       |   2 +-
 drivers/ata/ahci_platform.c                    |   2 +-
 drivers/ata/ahci_qoriq.c                       |   2 +-
 drivers/ata/ahci_seattle.c                     |   2 +-
 drivers/ata/ahci_st.c                          |   2 +-
 drivers/ata/ahci_sunxi.c                       |   2 +-
 drivers/ata/ahci_tegra.c                       |   2 +-
 drivers/ata/ahci_xgene.c                       |   2 +-
 drivers/ata/ata_generic.c                      |   2 +-
 drivers/ata/ata_piix.c                         |   6 +-
 drivers/ata/libahci.c                          |   4 +-
 drivers/ata/libahci_platform.c                 |   2 +-
 drivers/ata/libata-core.c                      |   4 +-
 drivers/ata/libata-scsi.c                      |   2 +-
 drivers/ata/libata-sff.c                       |   8 +-
 drivers/ata/libata.h                           |   2 +-
 drivers/ata/pata_acpi.c                        |   2 +-
 drivers/ata/pata_ali.c                         |   2 +-
 drivers/ata/pata_amd.c                         |   2 +-
 drivers/ata/pata_arasan_cf.c                   |   2 +-
 drivers/ata/pata_artop.c                       |   2 +-
 drivers/ata/pata_atiixp.c                      |   2 +-
 drivers/ata/pata_atp867x.c                     |   2 +-
 drivers/ata/pata_buddha.c                      |   2 +-
 drivers/ata/pata_cmd640.c                      |   2 +-
 drivers/ata/pata_cmd64x.c                      |   2 +-
 drivers/ata/pata_cs5520.c                      |   2 +-
 drivers/ata/pata_cs5530.c                      |   2 +-
 drivers/ata/pata_cs5535.c                      |   2 +-
 drivers/ata/pata_cs5536.c                      |   2 +-
 drivers/ata/pata_cypress.c                     |   2 +-
 drivers/ata/pata_efar.c                        |   2 +-
 drivers/ata/pata_ep93xx.c                      |   2 +-
 drivers/ata/pata_falcon.c                      |   2 +-
 drivers/ata/pata_ftide010.c                    |   2 +-
 drivers/ata/pata_gayle.c                       |   2 +-
 drivers/ata/pata_hpt366.c                      |   2 +-
 drivers/ata/pata_hpt37x.c                      |   2 +-
 drivers/ata/pata_hpt3x2n.c                     |   2 +-
 drivers/ata/pata_hpt3x3.c                      |   2 +-
 drivers/ata/pata_icside.c                      |   2 +-
 drivers/ata/pata_imx.c                         |   2 +-
 drivers/ata/pata_isapnp.c                      |   2 +-
 drivers/ata/pata_it8213.c                      |   2 +-
 drivers/ata/pata_it821x.c                      |   2 +-
 drivers/ata/pata_ixp4xx_cf.c                   |   2 +-
 drivers/ata/pata_jmicron.c                     |   2 +-
 drivers/ata/pata_legacy.c                      |   2 +-
 drivers/ata/pata_macio.c                       |   2 +-
 drivers/ata/pata_marvell.c                     |   2 +-
 drivers/ata/pata_mpc52xx.c                     |   2 +-
 drivers/ata/pata_mpiix.c                       |   2 +-
 drivers/ata/pata_netcell.c                     |   2 +-
 drivers/ata/pata_ninja32.c                     |   2 +-
 drivers/ata/pata_ns87410.c                     |   2 +-
 drivers/ata/pata_ns87415.c                     |   2 +-
 drivers/ata/pata_octeon_cf.c                   |   2 +-
 drivers/ata/pata_of_platform.c                 |   2 +-
 drivers/ata/pata_oldpiix.c                     |   2 +-
 drivers/ata/pata_opti.c                        |   2 +-
 drivers/ata/pata_optidma.c                     |   2 +-
 drivers/ata/pata_parport/pata_parport.c        |   2 +-
 drivers/ata/pata_pcmcia.c                      |   2 +-
 drivers/ata/pata_pdc2027x.c                    |   2 +-
 drivers/ata/pata_pdc202xx_old.c                |   2 +-
 drivers/ata/pata_piccolo.c                     |   2 +-
 drivers/ata/pata_platform.c                    |   4 +-
 drivers/ata/pata_pxa.c                         |   2 +-
 drivers/ata/pata_radisys.c                     |   2 +-
 drivers/ata/pata_rb532_cf.c                    |   2 +-
 drivers/ata/pata_rdc.c                         |   2 +-
 drivers/ata/pata_rz1000.c                      |   2 +-
 drivers/ata/pata_sc1200.c                      |   2 +-
 drivers/ata/pata_sch.c                         |   2 +-
 drivers/ata/pata_serverworks.c                 |   6 +-
 drivers/ata/pata_sil680.c                      |   2 +-
 drivers/ata/pata_sis.c                         |   2 +-
 drivers/ata/pata_sl82c105.c                    |   2 +-
 drivers/ata/pata_triflex.c                     |   2 +-
 drivers/ata/pata_via.c                         |   2 +-
 drivers/ata/pdc_adma.c                         |   2 +-
 drivers/ata/sata_dwc_460ex.c                   |   2 +-
 drivers/ata/sata_fsl.c                         |   2 +-
 drivers/ata/sata_highbank.c                    |   2 +-
 drivers/ata/sata_inic162x.c                    |   2 +-
 drivers/ata/sata_mv.c                          |   4 +-
 drivers/ata/sata_nv.c                          |   8 +-
 drivers/ata/sata_promise.c                     |   2 +-
 drivers/ata/sata_qstor.c                       |   2 +-
 drivers/ata/sata_rcar.c                        |   2 +-
 drivers/ata/sata_sil.c                         |   2 +-
 drivers/ata/sata_sil24.c                       |   2 +-
 drivers/ata/sata_sis.c                         |   2 +-
 drivers/ata/sata_svw.c                         |   2 +-
 drivers/ata/sata_sx4.c                         |   2 +-
 drivers/ata/sata_uli.c                         |   2 +-
 drivers/ata/sata_via.c                         |   2 +-
 drivers/ata/sata_vsc.c                         |   2 +-
 drivers/firewire/sbp2.c                        |   4 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c       |   4 +-
 drivers/infiniband/ulp/isert/ib_isert.c        |   4 +-
 drivers/infiniband/ulp/srp/ib_srp.c            |   2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c          |  33 -
 drivers/message/fusion/mptbase.h               |   1 -
 drivers/message/fusion/mptfc.c                 |   2 +-
 drivers/message/fusion/mptlan.c                |   2 +
 drivers/message/fusion/mptsas.c                |   2 +-
 drivers/message/fusion/mptscsih.c              |   1 -
 drivers/message/fusion/mptspi.c                |   2 +-
 drivers/s390/scsi/zfcp_scsi.c                  |   2 +-
 drivers/scsi/3w-9xxx.c                         |   3 +-
 drivers/scsi/3w-sas.c                          |   3 +-
 drivers/scsi/3w-xxxx.c                         |   2 +-
 drivers/scsi/BusLogic.c                        |   4 +-
 drivers/scsi/a100u2w.c                         |   2 +-
 drivers/scsi/a2091.c                           |   2 +-
 drivers/scsi/a3000.c                           |   2 +-
 drivers/scsi/aacraid/linit.c                   |   5 +-
 drivers/scsi/advansys.c                        |   2 +-
 drivers/scsi/aha152x.c                         |   4 +-
 drivers/scsi/aha1542.c                         |   5 +-
 drivers/scsi/aha1740.c                         |   2 +-
 drivers/scsi/aic94xx/aic94xx_init.c            |   2 +-
 drivers/scsi/am53c974.c                        |   2 +-
 drivers/scsi/arcmsr/arcmsr.h                   |   3 +-
 drivers/scsi/arcmsr/arcmsr_hba.c               |  24 +-
 drivers/scsi/arm/acornscsi.c                   |   2 +-
 drivers/scsi/arm/arxescsi.c                    |   2 +-
 drivers/scsi/arm/cumana_1.c                    |   2 +-
 drivers/scsi/arm/cumana_2.c                    |   2 +-
 drivers/scsi/arm/eesox.c                       |   2 +-
 drivers/scsi/arm/oak.c                         |   2 +-
 drivers/scsi/arm/powertec.c                    |   2 +-
 drivers/scsi/atp870u.c                         |   4 +-
 drivers/scsi/be2iscsi/be_cmds.c                |   2 -
 drivers/scsi/be2iscsi/be_main.c                |  29 +-
 drivers/scsi/be2iscsi/be_main.h                |   1 -
 drivers/scsi/bfa/bfad.c                        |   6 -
 drivers/scsi/bfa/bfad_drv.h                    |   1 -
 drivers/scsi/bnx2i/bnx2i_iscsi.c               |   4 +-
 drivers/scsi/csiostor/csio_init.c              |   1 -
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c             |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c                  |   2 +-
 drivers/scsi/cxgbi/libcxgbi.h                  |   2 +-
 drivers/scsi/cxlflash/superpipe.c              |   2 +-
 drivers/scsi/cxlflash/vlun.c                   |   2 +-
 drivers/scsi/dc395x.c                          |   2 +-
 drivers/scsi/device_handler/scsi_dh_alua.c     |   6 +-
 drivers/scsi/dmx3191d.c                        |   2 +-
 drivers/scsi/elx/efct/efct_lio.c               |  20 -
 drivers/scsi/elx/efct/efct_xport.c             |   2 +-
 drivers/scsi/esas2r/esas2r_main.c              |   2 +-
 drivers/scsi/esp_scsi.c                        |   2 +-
 drivers/scsi/esp_scsi.h                        |   2 +-
 drivers/scsi/fcoe/fcoe.c                       |   2 +-
 drivers/scsi/fdomain.c                         |   2 +-
 drivers/scsi/fnic/fnic_main.c                  |   2 +-
 drivers/scsi/fnic/fnic_trace.c                 |  17 +-
 drivers/scsi/g_NCR5380.c                       |   4 +-
 drivers/scsi/gvp11.c                           |   2 +-
 drivers/scsi/hisi_sas/hisi_sas.h               |  11 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c          | 152 +++-
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c         |  10 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c         |  10 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c         | 194 ++++-
 drivers/scsi/hosts.c                           |   7 +-
 drivers/scsi/hpsa.c                            |   9 +-
 drivers/scsi/hptiop.c                          |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                 |   2 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c       |  30 -
 drivers/scsi/imm.c                             |   2 +-
 drivers/scsi/initio.c                          |   2 +-
 drivers/scsi/ipr.c                             |   2 +-
 drivers/scsi/isci/init.c                       |   2 +-
 drivers/scsi/iscsi_tcp.c                       |   4 +-
 drivers/scsi/jazz_esp.c                        |   2 +-
 drivers/scsi/libiscsi.c                        |   2 +-
 drivers/scsi/libsas/sas_discover.c             |  29 +
 drivers/scsi/lpfc/lpfc.h                       |   2 -
 drivers/scsi/lpfc/lpfc_attr.c                  | 102 +--
 drivers/scsi/lpfc/lpfc_bsg.c                   |   4 +-
 drivers/scsi/lpfc/lpfc_crtn.h                  |   2 +
 drivers/scsi/lpfc/lpfc_ct.c                    |   8 +-
 drivers/scsi/lpfc/lpfc_debugfs.c               |   9 +-
 drivers/scsi/lpfc/lpfc_els.c                   |  50 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c               |  39 +-
 drivers/scsi/lpfc/lpfc_hw.h                    |  14 +-
 drivers/scsi/lpfc/lpfc_init.c                  |  19 +-
 drivers/scsi/lpfc/lpfc_nvme.c                  |   6 +-
 drivers/scsi/lpfc/lpfc_sli.c                   |  95 +--
 drivers/scsi/lpfc/lpfc_sli4.h                  |  19 +
 drivers/scsi/lpfc/lpfc_version.h               |   2 +-
 drivers/scsi/mac53c94.c                        |   2 +-
 drivers/scsi/mac_esp.c                         |   2 +-
 drivers/scsi/megaraid.c                        |   3 +-
 drivers/scsi/megaraid/megaraid_mbox.c          |   2 +-
 drivers/scsi/megaraid/megaraid_sas.h           |  12 +-
 drivers/scsi/megaraid/megaraid_sas_base.c      |   4 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c        |   2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c    |   7 +-
 drivers/scsi/mesh.c                            |   2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h           | 112 ++-
 drivers/scsi/mpi3mr/mpi/mpi30_image.h          |   2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_init.h           |  23 +-
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h            |   2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_pci.h            |   6 +-
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h            |   2 +-
 drivers/scsi/mpi3mr/mpi/mpi30_transport.h      |   4 +-
 drivers/scsi/mpi3mr/mpi3mr.h                   |  20 +-
 drivers/scsi/mpi3mr/mpi3mr_app.c               |   9 +-
 drivers/scsi/mpi3mr/mpi3mr_debug.h             |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                |  96 ++-
 drivers/scsi/mpi3mr/mpi3mr_os.c                | 111 ++-
 drivers/scsi/mpi3mr/mpi3mr_transport.c         |  22 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c            |  20 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c           |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c       |  14 +-
 drivers/scsi/mvme147.c                         |   2 +-
 drivers/scsi/mvsas/mv_init.c                   |   2 +-
 drivers/scsi/mvumi.c                           |   2 +-
 drivers/scsi/myrb.c                            |   2 +-
 drivers/scsi/myrs.c                            |   2 +-
 drivers/scsi/nsp32.c                           |   2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c             |   4 +-
 drivers/scsi/pm8001/pm8001_init.c              |   2 +-
 drivers/scsi/pmcraid.c                         |   2 +-
 drivers/scsi/ppa.c                             |   2 +-
 drivers/scsi/ps3rom.c                          |   2 +-
 drivers/scsi/qedf/qedf_main.c                  |   4 +-
 drivers/scsi/qedi/qedi_gbl.h                   |   2 +-
 drivers/scsi/qedi/qedi_iscsi.c                 |   2 +-
 drivers/scsi/qla1280.c                         |   2 +-
 drivers/scsi/qla2xxx/qla_def.h                 |   1 -
 drivers/scsi/qla2xxx/qla_gbl.h                 |   3 +-
 drivers/scsi/qla2xxx/qla_init.c                |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c                 |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                 |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                  |  31 +-
 drivers/scsi/qla2xxx/qla_target.c              |   3 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c             |  14 -
 drivers/scsi/qla4xxx/ql4_def.h                 |   1 -
 drivers/scsi/qla4xxx/ql4_isr.c                 |   2 -
 drivers/scsi/qla4xxx/ql4_os.c                  |   4 -
 drivers/scsi/qlogicpti.c                       |  13 +-
 drivers/scsi/scsi.c                            |  14 +-
 drivers/scsi/scsi_debug.c                      | 983 +++++++++++--------------
 drivers/scsi/scsi_devinfo.c                    |   4 +-
 drivers/scsi/scsi_error.c                      |  16 +-
 drivers/scsi/scsi_scan.c                       |   3 +
 drivers/scsi/scsi_sysfs.c                      |   6 +-
 drivers/scsi/scsi_transport_fc.c               |   3 +-
 drivers/scsi/sd.c                              |   7 +-
 drivers/scsi/sd_zbc.c                          |   8 -
 drivers/scsi/sgiwd93.c                         |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c          |   2 +-
 drivers/scsi/snic/snic_main.c                  |   2 +-
 drivers/scsi/snic/snic_scsi.c                  |   7 +-
 drivers/scsi/sr.c                              |   7 +-
 drivers/scsi/stex.c                            |   2 +-
 drivers/scsi/storvsc_drv.c                     |  16 +
 drivers/scsi/sun3x_esp.c                       |   2 +-
 drivers/scsi/sun_esp.c                         |   4 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c            |   4 +-
 drivers/scsi/virtio_scsi.c                     |   2 +-
 drivers/scsi/wd719x.c                          |   2 +-
 drivers/scsi/xen-scsifront.c                   |   2 +-
 drivers/scsi/zorro_esp.c                       |   2 +-
 drivers/staging/rts5208/rtsx.c                 |   2 +-
 drivers/target/Kconfig                         |   1 +
 drivers/target/Makefile                        |   1 +
 drivers/target/iscsi/iscsi_target.c            |  51 +-
 drivers/target/iscsi/iscsi_target_login.c      |   7 +
 drivers/target/iscsi/iscsi_target_parameters.c |  12 +-
 drivers/target/loopback/tcm_loop.c             |  50 +-
 drivers/target/sbp/sbp_target.c                |  31 -
 drivers/target/target_core_alua.c              |   4 +-
 drivers/target/target_core_configfs.c          |  94 ++-
 drivers/target/target_core_device.c            |  44 +-
 drivers/target/target_core_fabric_configfs.c   |  47 +-
 drivers/target/target_core_internal.h          |   4 +-
 drivers/target/target_core_pr.c                |   8 +-
 drivers/target/target_core_spc.c               |   7 +-
 drivers/target/target_core_stat.c              |   6 +-
 drivers/target/target_core_tmr.c               |  26 +-
 drivers/target/target_core_tpg.c               |  73 +-
 drivers/target/target_core_transport.c         | 199 +++--
 drivers/target/target_core_xcopy.c             |  23 +-
 drivers/target/tcm_fc/tcm_fc.h                 |   1 -
 drivers/target/tcm_fc/tfc_cmd.c                |   5 -
 drivers/target/tcm_fc/tfc_conf.c               |  15 -
 drivers/target/tcm_remote/Kconfig              |   8 +
 drivers/target/tcm_remote/Makefile             |   2 +
 drivers/target/tcm_remote/tcm_remote.c         | 268 +++++++
 drivers/target/tcm_remote/tcm_remote.h         |  20 +
 drivers/ufs/core/ufshcd-priv.h                 |   1 +
 drivers/ufs/core/ufshcd.c                      | 134 ++--
 drivers/ufs/host/ufs-exynos.c                  |   2 +-
 drivers/ufs/host/ufs-hisi.c                    |   2 +-
 drivers/ufs/host/ufs-qcom.c                    |  12 +-
 drivers/ufs/host/ufshcd-pci.c                  |   1 +
 drivers/usb/gadget/function/f_tcm.c            |  35 +-
 drivers/usb/image/microtek.c                   |   2 +-
 drivers/usb/storage/uas.c                      |   2 +-
 drivers/usb/storage/usb.c                      |   2 +-
 drivers/usb/storage/usb.h                      |   2 +-
 drivers/vhost/scsi.c                           |  31 -
 drivers/xen/xen-scsiback.c                     |  30 -
 include/linux/ahci_platform.h                  |   2 +-
 include/linux/ata_platform.h                   |   2 +-
 include/linux/libata.h                         |  10 +-
 include/linux/raid_class.h                     |   2 +-
 include/scsi/libfc.h                           |   2 +-
 include/scsi/libiscsi.h                        |   2 +-
 include/scsi/scsi_device.h                     |   2 +
 include/scsi/scsi_devinfo.h                    |   6 +-
 include/scsi/scsi_host.h                       |   4 +-
 include/target/iscsi/iscsi_target_core.h       |   1 +
 include/target/target_core_base.h              |  21 +-
 include/target/target_core_fabric.h            |  15 +-
 include/trace/events/ufs.h                     |  22 +-
 include/uapi/linux/target_core_user.h          |   2 +-
 include/ufs/ufshcd.h                           |   9 +-
 333 files changed, 2486 insertions(+), 1939 deletions(-)
 create mode 100644 drivers/target/tcm_remote/Kconfig
 create mode 100644 drivers/target/tcm_remote/Makefile
 create mode 100644 drivers/target/tcm_remote/tcm_remote.c
 create mode 100644 drivers/target/tcm_remote/tcm_remote.h

Regards,

James

