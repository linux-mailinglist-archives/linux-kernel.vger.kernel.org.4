Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0DB5F9BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJJJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiJJJaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:30:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0632C2A;
        Mon, 10 Oct 2022 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665394189;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AQ5tRKniKZUmoOnhRKBBg6EOdWGzLqH8T9IBoyUqMwI=;
    b=kRigBIBokwu9NBNDu61CcYa5HSdPB+wX9r5SloGwIPeZYeoIXhdSkUduAgZq6+aTR+
    zjFDAAU5lz2tCsiEBswmGIDMW//H/kcutSgjosnIlQSGTBiO0jMA9rLGF5hAW1f1tFiL
    ZeoD+11dA8syA7HRvR5uTbda98yIsDQMyE1btNmiFNvB2CdK/340JjokB495REzxQlyP
    o/QsoDm+f9TZNPOC/+81VuBwgPHZPI8bF4MWAjOCWV0thQ0mM2KzRzpoqiDoOY1xK0ms
    PwPZN4dAnyAAU8TPnnCfKp1abbMISKduzHTsNSwZcYgpp2nSRaqaRjwo/pj2clDrykJ4
    oZVw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo01
Received: from linux.micron.com
    by smtp.strato.de (RZmta 48.2.0 AUTH)
    with ESMTPSA id zad98cy9A9Tm0DC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 Oct 2022 11:29:48 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
Date:   Mon, 10 Oct 2022 11:29:36 +0200
Message-Id: <20221010092937.520013-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010092937.520013-1-beanhuo@iokpp.de>
References: <20221010092937.520013-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

LUs with WB potential support are properly checked in ufshcd_wb_probe()
before calling ufshcd_read_unit_desc_param(), so remove this unnecessary
if-checkup in ufs_is_valid_unit_desc_lun() to match its function definition.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufshcd-priv.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f68ca33f6ac7..2457b005101a 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -300,9 +300,6 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info,
 		pr_err("Max General LU supported by UFS isn't initialized\n");
 		return false;
 	}
-	/* WB is available only for the logical unit from 0 to 7 */
-	if (param_offset == UNIT_DESC_PARAM_WB_BUF_ALLOC_UNITS)
-		return lun < UFS_UPIU_MAX_WB_LUN_ID;
 	return lun == UFS_UPIU_RPMB_WLUN || (lun < dev_info->max_lu_supported);
 }
 
-- 
2.34.1

