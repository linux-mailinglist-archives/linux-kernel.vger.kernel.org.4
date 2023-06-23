Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8073C269
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFWVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjFWVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:16:02 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD82964;
        Fri, 23 Jun 2023 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CxJuiiXcSlU+s+aK2RdCGaJm2rWe7fLo/P4JyxZmwgU=;
  b=Y+TGJl9kktgLU2LOFT6pAr8H9vMhgFCXSpYoMx6YRcy0WlnrnJFEBdQe
   GjewKrO0T9ledIQTGIKjVzV4zVvZ85studPlRFdE6P9wCS23upj1v7+Ez
   6dB3jhHWtVRstUrvr+YIJkmjkuomBWQXMGTWDsJr1kV7DBR7dSXEYFL31
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686185"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:14 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Nilesh Javali <njavali@marvell.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/26] scsi: qla2xxx: use array_size
Date:   Fri, 23 Jun 2023 23:14:55 +0200
Message-Id: <20230623211457.102544-25-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/scsi/qla2xxx/qla_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1a955c3ff3d6..72569ed6c825 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8219,7 +8219,7 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		ql_dbg(ql_dbg_init, vha, 0x0163,
 		    "-> fwdt%u template allocate template %#x words...\n",
 		    j, risc_size);
-		fwdt->template = vmalloc(risc_size * sizeof(*dcode));
+		fwdt->template = vmalloc(array_size(risc_size, sizeof(*dcode)));
 		if (!fwdt->template) {
 			ql_log(ql_log_warn, vha, 0x0164,
 			    "-> fwdt%u failed allocate template.\n", j);
@@ -8474,7 +8474,7 @@ qla24xx_load_risc_blob(scsi_qla_host_t *vha, uint32_t *srisc_addr)
 		ql_dbg(ql_dbg_init, vha, 0x0173,
 		    "-> fwdt%u template allocate template %#x words...\n",
 		    j, risc_size);
-		fwdt->template = vmalloc(risc_size * sizeof(*dcode));
+		fwdt->template = vmalloc(array_size(risc_size, sizeof(*dcode)));
 		if (!fwdt->template) {
 			ql_log(ql_log_warn, vha, 0x0174,
 			    "-> fwdt%u failed allocate template.\n", j);

