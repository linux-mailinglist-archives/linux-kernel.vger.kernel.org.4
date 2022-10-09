Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500B05F8DD5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJIUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJIUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 16:21:39 -0400
X-Greylist: delayed 175 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 13:21:37 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DED1A83D;
        Sun,  9 Oct 2022 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665346716;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AQ5tRKniKZUmoOnhRKBBg6EOdWGzLqH8T9IBoyUqMwI=;
    b=kQTKxjsrMTRQJORxnETedZjmnD0bC/JMpBWg2Rn58IX6x4FO2DZ4z1a9uskMXhkEUw
    6L0qVjrOeBRuo9BZuzl2S5ca8O22rzain5kOMhJbqhBngzS/u/Rm+79qtPo9g9t51ZDb
    jDQSMJ8Voeqv4FB4mzc7XOMTdevniR7xUEKjCJHEAg8EJHnYgXJPh7QbBNvrbfqrVy0x
    /5Pe8HA2M5rlcJsc+ftvgPVXStdFbHKQbfyVqQAfevCxLES8eBklWuJ6zDSK4i2QuI9B
    hJYrxRLx3wYb3/QhSVZFthj+ZgjNjvpQjBTWpOLPs6gRzBfe0+Lz7mwAu/9Jitus9IE7
    SAFA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1h3Wv4Xa/LRChhKO/8hvJt7KzgdI0oSHjzSB"
X-RZG-CLASS-ID: mo01
Received: from linux.speedport.ip
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id z90a05y99KIadXw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 9 Oct 2022 22:18:36 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] scsi: ufs: core: Remove unnecessary if statement
Date:   Sun,  9 Oct 2022 22:18:08 +0200
Message-Id: <20221009201809.495207-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009201809.495207-1-beanhuo@iokpp.de>
References: <20221009201809.495207-1-beanhuo@iokpp.de>
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

