Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F76AA0D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCCVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCCVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:04:04 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64455518;
        Fri,  3 Mar 2023 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677877442;
        bh=WoO0Bqf5MBHWnFkl0pYBsJoWNPnKj0x7VmHjL+JUdm0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=sF/WBtxBmi+FIMdyaf48+YIrrCDK2AM8KGjGtZt+7kXGTyCKBLKI+CF2biX5fIQCN
         JfpCMr72zE5H3BkPOaSOpvTq66Bn9cyEjxc5IUPBVC1M6Gl2hnvnjO/u1XCSwFu2tP
         89RMnE/4Z9P6AZ5KwZox/Z8kzPwHj+b6cmxaLDos=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7613B1286104;
        Fri,  3 Mar 2023 16:04:02 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5DQEw4PN9eoz; Fri,  3 Mar 2023 16:04:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677877442;
        bh=WoO0Bqf5MBHWnFkl0pYBsJoWNPnKj0x7VmHjL+JUdm0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=sF/WBtxBmi+FIMdyaf48+YIrrCDK2AM8KGjGtZt+7kXGTyCKBLKI+CF2biX5fIQCN
         JfpCMr72zE5H3BkPOaSOpvTq66Bn9cyEjxc5IUPBVC1M6Gl2hnvnjO/u1XCSwFu2tP
         89RMnE/4Z9P6AZ5KwZox/Z8kzPwHj+b6cmxaLDos=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C027912860A2;
        Fri,  3 Mar 2023 16:04:01 -0500 (EST)
Message-ID: <24e8a84979c4ac65ddc2d41ecb0d1d53412a7d39.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 6.2+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Mar 2023 16:03:59 -0500
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

Updates that missed the first pull, mostly because of needing more soak
time.  Driver updates (zfcp, ufs, mpi3mr, plus two ipr bug fixes), an
enclosure services (ses) update (mostly bug fixes) and other minor bug
fixes and changes.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Adrien Thierry (1):
      scsi: ufs: core: Initialize devfreq synchronously

Arnd Bergmann (1):
      scsi: ipr: Work around fortify-string warning

Asutosh Das (1):
      scsi: ufs: mcq: Fix incorrectly set queue depth

Bart Van Assche (6):
      scsi: ufs: core: Simplify ufshcd_execute_start_stop()
      scsi: ufs: core: Rely on the block layer for setting RQF_PM
      scsi: core: Extend struct scsi_exec_args
      scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
      scsi: core: Fix a source code comment
      scsi: ufs: Make the TC G210 driver dependent on CONFIG_OF

Benjamin Block (3):
      scsi: zfcp: Trace when request remove fails after qdio send fails
      scsi: zfcp: Change the type of all fsf request id fields and variables to u64
      scsi: zfcp: Make the type for accessing request hashtable buckets size_t

Bo Liu (1):
      scsi: lpfc: Fix double word in comments

Deepak R Varma (1):
      scsi: ipr: Make ipr_probe_ioa_part2() return void

Fengnan Chang (1):
      scsi: sd: Remove unused sd_cdb_cache

James Bottomley (1):
      scsi: ses: Don't attach if enclosure has no components

Jesper Juhl (3):
      scsi: cxgbi: Remove unneeded version.h include
      scsi: qedi: Remove unneeded version.h include
      scsi: mpi3mr: Remove unneeded version.h include

Kees Cook (1):
      scsi: mpi3mr: Replace 1-element array with flex-array

Muneendra (1):
      scsi: scsi_transport_fc: Add an additional flag to fc_host_fpin_rcv()

Shin'ichiro Kawasaki (4):
      scsi: mpi3mr: Fix missing mrioc->evtack_cmds initialization
      scsi: mpi3mr: Use number of bits to manage bitmap sizes
      scsi: mpi3mr: Remove unnecessary memcpy() to alltgt_info->dmi
      scsi: mpi3mr: Fix issues in mpi3mr_get_all_tgt_info()

Tomas Henzl (5):
      scsi: mpi3mr: Fix an issue found by KASAN
      scsi: ses: Fix slab-out-of-bounds in ses_intf_remove()
      scsi: ses: Fix possible desc_ptr out-of-bounds accesses
      scsi: ses: Fix possible addl_desc_ptr out-of-bounds accesses
      scsi: ses: Fix slab-out-of-bounds in ses_enclosure_data_process()

Xingui Yang (1):
      scsi: sd: Update DIX config every time sd_revalidate_disk() is called

Yangtao Li (1):
      scsi: ufs: ufs-mediatek: Guard power management functions with CONFIG_PM

And the diffstat:

 drivers/s390/scsi/zfcp_dbf.c           | 46 ++++++++++++++++-
 drivers/s390/scsi/zfcp_def.h           |  6 +--
 drivers/s390/scsi/zfcp_ext.h           |  5 +-
 drivers/s390/scsi/zfcp_fsf.c           | 22 ++++----
 drivers/s390/scsi/zfcp_qdio.h          |  2 +-
 drivers/s390/scsi/zfcp_reqlist.h       | 26 +++++-----
 drivers/s390/scsi/zfcp_scsi.c          |  2 +-
 drivers/scsi/cxgbi/libcxgbi.h          |  1 -
 drivers/scsi/hosts.c                   |  4 +-
 drivers/scsi/ipr.c                     | 54 +++++++++-----------
 drivers/scsi/lpfc/lpfc_attr.c          | 10 ++--
 drivers/scsi/lpfc/lpfc_els.c           |  4 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c       |  2 +-
 drivers/scsi/lpfc/lpfc_init.c          |  4 +-
 drivers/scsi/lpfc/lpfc_mbox.c          |  4 +-
 drivers/scsi/lpfc/lpfc_nvmet.c         |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c           |  2 +-
 drivers/scsi/mpi3mr/mpi3mr.h           | 11 +---
 drivers/scsi/mpi3mr/mpi3mr_app.c       | 28 ++++-------
 drivers/scsi/mpi3mr/mpi3mr_fw.c        | 75 ++++++++++++---------------
 drivers/scsi/mpi3mr/mpi3mr_os.c        |  4 ++
 drivers/scsi/mpi3mr/mpi3mr_transport.c |  2 +-
 drivers/scsi/qedi/qedi_dbg.h           |  1 -
 drivers/scsi/qla2xxx/qla_isr.c         |  2 +-
 drivers/scsi/scsi_lib.c                |  1 +
 drivers/scsi/scsi_transport_fc.c       | 10 ++--
 drivers/scsi/sd.c                      | 29 +++--------
 drivers/scsi/sd_dif.c                  | 10 ++--
 drivers/scsi/ses.c                     | 64 ++++++++++++++++-------
 drivers/ufs/core/ufshcd.c              | 92 +++++++++++++++++-----------------
 drivers/ufs/host/Kconfig               |  2 +-
 drivers/ufs/host/ufs-mediatek.c        |  2 +
 include/scsi/scsi_device.h             |  1 +
 include/scsi/scsi_transport_fc.h       |  4 +-
 include/uapi/scsi/scsi_bsg_mpi3mr.h    |  8 +--
 include/ufs/ufshcd.h                   |  1 +
 36 files changed, 291 insertions(+), 252 deletions(-)

James


