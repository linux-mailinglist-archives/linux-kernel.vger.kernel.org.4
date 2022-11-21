Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275E63288D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiKUPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:39 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD5B49;
        Mon, 21 Nov 2022 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669045599; x=1700581599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=P0JKaqQLlBDEhwnEa2zE84r6kTN62SJX3jVSRfcurYc=;
  b=LZpCYQj6vn068wHfvhcYTegN31FlOj1LR3gUvS5I7/5yjWv4cJLpR7cY
   ctRRzVHcdOEnoLdk+0UUmEYpnb1oBBLMWLmKRB0+TH3w0AU2ch0vGJ0lu
   Oh+7uxIFiaPzuQf+JngpigbMaYkEXwcNbTua/yWatv+ArsW43B4kB5AF9
   zHWF/BkTMQySTIiOCHSAs2x/8yKoNJYWqiGDIMDN6EXSOgEd8hB7fYz5K
   NJLUQYb50iJ6jYKVr08IQ4GIwKG4L2cvwnTnwdoj1/mh9nkmEsWaeqbwP
   0rIpTKx4/aUzgxlxB+M7LAZfs2bR67L99mx6AgH6lHkR6+8IpJJ1aaFG1
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="215054343"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 23:46:39 +0800
IronPort-SDR: aSjkjFCODP7q8j80rqGo+w+jDQzBw9Gtg6whAkc1aFlb3FAblA6zWLSqW3gZb7z9SwKCSU/j49
 GMMFS7mc4MBJvxbMjzyKrwii6u7I7+tAutnJkfY3DPx46occrLsujNEunxyZTxXhtpB5pm9222
 R0sBMVZxDT0URs0vJygbne2GgPYivKOcYEVDPT6BICHuZxLaKsbaMTMFg2gKWgacplqpff3W9S
 0T06CyNZuHc1VHezMEGwwi4zvN0+hhPMYjCObbwHJHUcQUtnu7H6cEMW1kVgwncal95jl6CzdF
 TgI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 06:59:44 -0800
IronPort-SDR: jQ2VJ109PTVex2cBC3mAWMMToSs+gPICYly53T2m9suaUpuduGQbIDym2yvP5BSbUBWHr2HHeH
 jyLdzy/cVOvX/zZDyfGvdH4LH6nOhI0eBfsNApAZHvxmvtQX3DloEVXWgWbVNGUmfSHSGaUwn0
 OXD0ZqA5UMroNdbC4VnrQFmvn/baZwxNx9oHbUV2hgNyxSn1w6XzLYRdfJBG1yJXEua05LCCNd
 dme6q3BesHVAs6jEdUNs64ABejyEr5zouZnefLynKtIVzlIVoeevj1ZstmBKTZ5NFanidgZcJu
 BW8=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2022 07:46:38 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v3 1/4] ufs: core: Remove redundant wb check
Date:   Mon, 21 Nov 2022 17:46:27 +0200
Message-Id: <1669045590-26101-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to use the extended-feature field in the device descriptor,
as an indication that the device supports ufs2.2 or later.
Remove that as this check is specifically done few lines above.

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 768cb49..301fda0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7584,10 +7584,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
 		goto wb_disabled;
 
-	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
-	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
-		goto wb_disabled;
-
 	ext_ufs_feature = get_unaligned_be32(desc_buf +
 					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
 
-- 
2.7.4

