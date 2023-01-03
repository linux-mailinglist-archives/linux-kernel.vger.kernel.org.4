Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0265C2BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjACPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjACPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:04:57 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327B11168;
        Tue,  3 Jan 2023 07:04:55 -0800 (PST)
Received: from ersatz.molgen.mpg.de (v097.vpnx.molgen.mpg.de [141.14.14.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A973160293A85;
        Tue,  3 Jan 2023 16:04:52 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, it+linux-scsi@molgen.mpg.de,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: Demote log level for trace buffer allocation to info
Date:   Tue,  3 Jan 2023 16:04:37 +0100
Message-Id: <20230103150438.45922-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with the controller below

    01:00.0 Serial Attached SCSI controller [0107]: Broadcom / LSI Fusion-MPT 12GSAS/PCIe Secure SAS38xx [1000:00e6]

Linux logs the error below:

    $ dmesg --level=err | grep mpt
    [    7.647675] mpt3sas_cm0: Trace buffer memory 2048 KB allocated

This state does not denote an error condition (and also no warning), so
demote the level from error to info.

Cc: it+linux-scsi@molgen.mpg.de
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 0d8b1e942ded..efdb8178db32 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -1884,7 +1884,7 @@ mpt3sas_enable_diag_buffer(struct MPT3SAS_ADAPTER *ioc, u8 bits_to_register)
 			    diag_register.requested_buffer_size>>10);
 		else if (ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE]
 		    & MPT3_DIAG_BUFFER_IS_REGISTERED) {
-			ioc_err(ioc, "Trace buffer memory %d KB allocated\n",
+			ioc_info(ioc, "Trace buffer memory %d KB allocated\n",
 			    diag_register.requested_buffer_size>>10);
 			if (ioc->hba_mpi_version_belonged != MPI2_VERSION)
 				ioc->diag_buffer_status[
-- 
2.39.0

