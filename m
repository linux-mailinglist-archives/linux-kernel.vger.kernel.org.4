Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8A5B3C1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiIIPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiIIPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:35:25 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AFA186;
        Fri,  9 Sep 2022 08:34:40 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1274ec87ad5so4906840fac.0;
        Fri, 09 Sep 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=X+Q+XxogE2IjpyqqxHb1Rmob5mxFBfelVSRSDl23U/0=;
        b=MYeKp/my9+idmuuuAX6U7MZeK78ZVnmx7OyeIejkqZ3YQbcjeX7m3fkstN56N7E/tj
         mYutp3pu5pBxRCvAfYMCu4xh+JQFwoQgxDCQfDliBbxH+NaRLjtVMLYoV3obdai585Xi
         zGUUYoVVwagneWDIVNlE9hhrNLl6H8ePxIXq6ZFS0zXwc8JvXPfXJILOozJc8JFZKUdR
         IcpanS+kbRJfFxUbLalKuNiptKenxQKKfMjeidH/9PXRCo3aAjjrB9BmBmXzWPEWoYUv
         K6LAcUdbHOP9Xhw5mlPXhk++L7SazZHMM4d6rk7kwnsnA6tTB+2hyJG+rnWZPX8bsn3s
         TpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X+Q+XxogE2IjpyqqxHb1Rmob5mxFBfelVSRSDl23U/0=;
        b=8NhpscRFUKxxSL3L1hHrQNafbIf3saqWg+lLAW11WX3zT+ZJTPoUCYlkTekyAxSJGS
         JFfj30E5rx3Jy6L7s1P/sBGivdlxaw+MT+4E1foh3YWds9Yp4YUVBxFMf2ZRfWlzEnIh
         6HZwYBWYlh3wQLaPWPCKJpMDjRBFX23voLtKfftC7CiiF2q9OGyFpfx1taqdLwpdhZB9
         tvtDGkLZAxvHnzTAwJDF5ZOaqjk0Y666UFjfCHDXCjTLP6WFjPU+qFkbHw6/pulrwBfh
         Pcz2l1N0rgTfJUy3PLfVX96a4/Yzr8RRqkACWZvZXessp4cUjjOzGBGObaEMAUSx8Ds3
         VBgA==
X-Gm-Message-State: ACgBeo1u4zPWy0L0JmljGgHhUYd561evVatHLvujWdsWPpQcRzjHtCEp
        oVSeHwoVNJzy8xuUwgUldR8=
X-Google-Smtp-Source: AA6agR5GUcwZAyBns5XYf1CuC9+EMdBn9OyKTc8QvLj28mLxDgG0xgaZzo/tPWTK8royTxPFOSzFuw==
X-Received: by 2002:a05:6808:152b:b0:343:ef9d:4729 with SMTP id u43-20020a056808152b00b00343ef9d4729mr3926178oiw.286.1662737625456;
        Fri, 09 Sep 2022 08:33:45 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:ed0b:fde6:d0df:8e59:d84f])
        by smtp.gmail.com with ESMTPSA id l4-20020aca1904000000b00344851ea0ddsm351759oii.56.2022.09.09.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:33:45 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: PCC: Release resources on address space setup failure path
Date:   Fri,  9 Sep 2022 12:33:19 -0300
Message-Id: <20220909153320.501347-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocated memory for the pcc_data struct doesn't get freed under an
error path in pcc_mbox_request_channel() or acpi_os_ioremap(). Also, the
PCC mailbox channel doesn't get freed under an error path in
acpi_os_ioremap().

Fixes: 77e2a04745ff8 ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
v1->v2
- Add PCC mailbox channel release to the unwind path 
- Update commit msg to reflect the addition of the mailbox free
---
 drivers/acpi/acpi_pcc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index a12b55d81209..84f1ac416b57 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -63,6 +63,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	if (IS_ERR(data->pcc_chan)) {
 		pr_err("Failed to find PCC channel for subspace %d\n",
 		       ctx->subspace_id);
+		kfree(data);
 		return AE_NOT_FOUND;
 	}
 
@@ -72,6 +73,8 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	if (!data->pcc_comm_addr) {
 		pr_err("Failed to ioremap PCC comm region mem for %d\n",
 		       ctx->subspace_id);
+		pcc_mbox_free_channel(data->pcc_chan);
+		kfree(data);
 		return AE_NO_MEMORY;
 	}
 
-- 
2.34.1

