Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E2D6AF139
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjCGSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjCGSlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:41:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55705AB0B7;
        Tue,  7 Mar 2023 10:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E185ECE1C5D;
        Tue,  7 Mar 2023 18:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB53C4339B;
        Tue,  7 Mar 2023 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678213731;
        bh=s1okTGIMaAIY9nZ5e8wO0yRssC1n4ZF/qmfPWCwZ6dM=;
        h=From:To:Cc:Subject:Date:From;
        b=kY7wjfPIyzksxdVq43zVu33obwVSkcW6mn8YmiJMErydBmSdwQojgdp+L5cNg84QJ
         YmC5EPBaNhICC9TGChTfqygz7G8TeJXT7D01LFdxVmwJVhEJSna0DGAUGimirlNr4p
         TSadofqjcYHyVgXWvgJzuyRYyatRLgELpOdLTxEJaMDhqDWPo668b7MK+1PX1BITar
         nPMmzgyWtGS7sUdF1LC2mU1dwcbAen7qxUMhEfjCh34U8b9MAviGqvwKS+jxGDybw+
         8RonpWsfvzotU2AJzRRV6PCodcv5zqxFKp6UsLmTh9+DO+/oVxG/4sTPq/hCKAViE4
         RDqQPgC/wPsMA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Don Brace <don.brace@microchip.com>,
        James Smart <james.smart@broadcom.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Raghava Aditya Renukunta <raghavaaditya.renukunta@pmcs.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Tomas Henzl <thenzl@redhat.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com
Subject: [PATCH 00/10] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Tue,  7 Mar 2023 12:28:32 -0600
Message-Id: <20230307182842.870378-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
which appeared in v6.0, the PCI core has enabled PCIe error reporting for
all devices during enumeration.

Remove driver code to do this and remove unnecessary includes of
<linux/aer.h> from several other drivers.

Bjorn Helgaas (10):
  scsi: aacraid: Drop redundant pci_enable_pcie_error_reporting()
  scsi: arcmsr: Remove unnecessary aer.h include
  scsi: be2iscsi: Drop redundant pci_enable_pcie_error_reporting()
  scsi: bfa: Drop redundant pci_enable_pcie_error_reporting()
  scsi: csiostor: Remove unnecessary aer.h include
  scsi: hpsa: Remove unnecessary pci_disable_pcie_error_reporting()
    comment
  scsi: lpfc: Drop redundant pci_enable_pcie_error_reporting()
  scsi: mpt3sas: Drop redundant pci_enable_pcie_error_reporting()
  scsi: qla2xxx: Drop redundant pci_enable_pcie_error_reporting()
  scsi: qla4xxx: Drop redundant pci_enable_pcie_error_reporting()

 drivers/scsi/aacraid/linit.c         |  3 -
 drivers/scsi/arcmsr/arcmsr_hba.c     |  1 -
 drivers/scsi/be2iscsi/be_main.c      |  9 ---
 drivers/scsi/be2iscsi/be_main.h      |  1 -
 drivers/scsi/bfa/bfad.c              |  6 --
 drivers/scsi/bfa/bfad_drv.h          |  1 -
 drivers/scsi/csiostor/csio_init.c    |  1 -
 drivers/scsi/hpsa.c                  |  1 -
 drivers/scsi/lpfc/lpfc.h             |  2 -
 drivers/scsi/lpfc/lpfc_attr.c        | 96 ++++++++--------------------
 drivers/scsi/lpfc/lpfc_init.c        |  1 -
 drivers/scsi/lpfc/lpfc_sli.c         | 55 ----------------
 drivers/scsi/mpt3sas/mpt3sas_base.c  |  5 --
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  1 -
 drivers/scsi/qla2xxx/qla_def.h       |  1 -
 drivers/scsi/qla2xxx/qla_os.c        |  6 --
 drivers/scsi/qla4xxx/ql4_def.h       |  1 -
 drivers/scsi/qla4xxx/ql4_os.c        |  4 --
 18 files changed, 27 insertions(+), 168 deletions(-)

-- 
2.25.1

