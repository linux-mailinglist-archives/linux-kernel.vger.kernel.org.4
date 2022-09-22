Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE15E6D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIVU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIVU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:57:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B110AB27;
        Thu, 22 Sep 2022 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1663880228;
        bh=3c1251MbYAYeP1Aj1gKZxrClFdNw2kDmGsEK8qXCXFQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=KhwK3PIZ/pUcExHHvC01S3BsQSyQxzioKuYpjMx6DhnJ2OiekPebDtsikwPT9OuL2
         sFYe5tL9lGYgqrASyOvGWKnY/dNV+tbT+KLtRe5JTQA4ZpF7qqfpPFuR0HWUeCpQ/u
         ZQ97NnfyPWJD9ntnzNYZR8/lfjteAx0FyWgWNfOM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7B48C12888B5;
        Thu, 22 Sep 2022 16:57:08 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mf4IfM0RzzKe; Thu, 22 Sep 2022 16:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1663880228;
        bh=3c1251MbYAYeP1Aj1gKZxrClFdNw2kDmGsEK8qXCXFQ=;
        h=Message-ID:Subject:From:To:Date:From;
        b=KhwK3PIZ/pUcExHHvC01S3BsQSyQxzioKuYpjMx6DhnJ2OiekPebDtsikwPT9OuL2
         sFYe5tL9lGYgqrASyOvGWKnY/dNV+tbT+KLtRe5JTQA4ZpF7qqfpPFuR0HWUeCpQ/u
         ZQ97NnfyPWJD9ntnzNYZR8/lfjteAx0FyWgWNfOM=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C5B6D12888AF;
        Thu, 22 Sep 2022 16:57:07 -0400 (EDT)
Message-ID: <72da0a69339074e2bad5295fe54a291c1e5cd206.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.0-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 22 Sep 2022 16:57:06 -0400
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

Three small and pretty obvious fixes, all in drivers.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Letu Ren (1):
      scsi: qedf: Fix a UAF bug in __qedf_probe()

Rafael Mendonca (1):
      scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix return value check of dma_get_required_mask()

And the diffstat:

 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 drivers/scsi/qedf/qedf_main.c       | 5 -----
 drivers/scsi/qla2xxx/qla_target.c   | 4 +++-
 3 files changed, 4 insertions(+), 7 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 565339a0811d..331e896d8225 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2993,7 +2993,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 
 	if (ioc->is_mcpu_endpoint ||
 	    sizeof(dma_addr_t) == 4 || ioc->use_32bit_dma ||
-	    dma_get_required_mask(&pdev->dev) <= 32)
+	    dma_get_required_mask(&pdev->dev) <= DMA_BIT_MASK(32))
 		ioc->dma_mask = 32;
 	/* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
 	else if (ioc->hba_mpi_version_belonged > MPI2_VERSION)
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 3d6b137314f3..bbc4d5890ae6 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3686,11 +3686,6 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 err1:
 	scsi_host_put(lport->host);
 err0:
-	if (qedf) {
-		QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_DISC, "Probe done.\n");
-
-		clear_bit(QEDF_PROBING, &qedf->flags);
-	}
 	return rc;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 62666df1a59e..4acff4e84b90 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2151,8 +2151,10 @@ static int __qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 
 	abort_cmd = ha->tgt.tgt_ops->find_cmd_by_tag(sess,
 				le32_to_cpu(abts->exchange_addr_to_abort));
-	if (!abort_cmd)
+	if (!abort_cmd) {
+		mempool_free(mcmd, qla_tgt_mgmt_cmd_mempool);
 		return -EIO;
+	}
 	mcmd->unpacked_lun = abort_cmd->se_cmd.orig_fe_lun;
 
 	if (abort_cmd->qpair) {

