Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329B61652B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKBOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiKBO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:29:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5222B24E;
        Wed,  2 Nov 2022 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667399391; x=1698935391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Oe6SAgVHvhyllaVSMJMPlFVIjI8mku2kauEtvEtytYM=;
  b=JY+jgjp1eDgXySdR+NEtQEcZdI38311xjdfpXDnS2SsXwVFi/ynbj3Mc
   IcStlEDiarjFkNtdO6r+E/gRnHBOxfqfUQ+FbUhdBiTxgWD8J3xWHVpIA
   C5e/SssEkMlUCmT97SrczeWnRA4C9O6vzvI3QPytTVgIv7xku9p1AmpEA
   sdvpYX576rtxlQU6pUgRChXoEwSmYPfl9ZJbbqROmxDHjEJXHrClr6I8X
   Wnx4qm4Ir2hTXMAjCvKAK5MjbXk14ze6KitJcdSz25pwFhAuN4Bbwale0
   /e9f1SYe8aIUtjRz45rjjjaoqGvhWhj/XUakDepgziL/ixKUz64k8hy/0
   w==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661788800"; 
   d="scan'208";a="215319619"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 22:29:48 +0800
IronPort-SDR: rWVbES49wnoj/Km/Vsh+m8HwQxY1yXMJhipip9DZZ4DCZxIWkAlXCNI8WAeXkjnDEyel+THQS3
 kNMvu2QB0qEzkbwcB1ZK1V/S7kWQliP3W0r2rAbla2OgtUitZEXWhUtMMaOPJ3/AwHcazqfRk9
 88hv81of8FpsiJbzzhchVVqn4D7vsijbKhzh3UxCfkk3Bjac5WUDatJ/PHCT4irUCQBVH2EuY7
 ZrMh2aoJ+54kvi/EWan6AR/sQy7CwIi+gSVumEC+cEKR6vBnujFkyyg7Ve2Hd8vnnSIOKIPa/6
 kbg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 06:43:16 -0700
IronPort-SDR: mca/hKanditUY4CM+uh4QISKKESsyjvPwZK97Dddo8FbrDPZQcYGL0xa9FyoHoZOWBzTI2xg6z
 4qzht8/P3MU98j/dYFA98cRadD26Hd1zOZjK5ERQuKopY2w4MUifEF9DMdb8nWaJ7yDQp7kS90
 1Qd7qOigearIxKG52RePeuFtjAwQ/4+b9P5SyWbvLg6IRNJoGrBmrIncHgkHbcb6Ilu/oCdHmb
 mJT/Dd0Pw17BEkHhFd+6zGJ0FDIeGgZEc1Ijhu8sED+lo8gJSG1JvN6wigr7JStnGZn5tGcc0b
 AIQ=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2022 07:29:46 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 1/4] ufs: core: Remove redundant wb check
Date:   Wed,  2 Nov 2022 16:29:10 +0200
Message-Id: <1667399353-10228-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
index ee73d70..de4e7e7 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7574,10 +7574,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
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

