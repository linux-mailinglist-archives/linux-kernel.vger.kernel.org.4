Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4F639A57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK0MIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiK0MIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:08:39 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E91F58D;
        Sun, 27 Nov 2022 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669550918; x=1701086918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=75GDcWeYFm4s2MbG7gQ8RmCsAaThd9t4d2RHpt+ClUs=;
  b=F/GtxqMS/tAsAO2efcMAN7A70u5hJPvJOUfmhbQnxPMfl2lYu9ujXazA
   Vt/UHPA81aQDashPVOnTOKxV6KzaiNull3MOhvkztmd+NaXVjbsyqdQIk
   U+BgIqIbmH3wHH74+ajIqDHH2UNi91PmZ3rrWBQC8/zsWkJeXadFcyhQi
   bxheDYXvrUbxjh3IQEcRskUrW8dL/dZHhJEjm7LunfsEWFwdyL/6VoFws
   IVof1Zzf11o6vgZTaRMWKhbdO311Ws85w3jVLcyOp3G9q7IRpCng32myi
   Aq4XySFdq6k2nDY/Z0AnvOH8nnzMDFB85T2fGiuNrfmjslnq7uMbJ7pmx
   A==;
X-IronPort-AV: E=Sophos;i="5.96,198,1665417600"; 
   d="scan'208";a="215510877"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 20:08:38 +0800
IronPort-SDR: m3OX4jdsP+PJuxOYN8/7ipVEVbvT7SPl3vPuPEhDaclXEoAu9kR2v1XQo/da26vRO+9xmHhwkH
 Te3xwES7g5zlVzxci6blKyBX+Mf5wShm+LEQRDchArsJkLdq7bm736kNqDmwu9BtjzR3JZhexf
 zsP/fVe+/WVxs5wy1AvEZ1KlHgQFS3r+Y84jULDMqqsuGixot6okhVDQ/TsNysUUdxGrP9622c
 X8C7fkj907+N34nNzLc73rcisi+nYHKkHsNzoE62u/m+dGYRyPRHgB6+m3NzGfQJA1XGgXTqZQ
 CPo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2022 03:27:21 -0800
IronPort-SDR: enN28DogBfknoLA0qZp0UOZaLW7FtW1xpgg/jiPlkwgEr0kWJRM2L4BNJxH1Dhg7jsXY7LxW2H
 eAQfDATREmkQCgYhsZljp8WRuG7YD4MA+3RXkpIHI1oNvx6LHHZ+oSb5PgP/VWJyeLtuaVcdeX
 axFKOGQ7d4DOOTKD/3mPA3vgU7pZI5N4W2+LgaT4kxXf8u37TLqZQ8wpa4KfHVYdOsCvhEoZIh
 mMQ1X243omhwx03/ntmlUnjias2Opv48znUu9h58yVuBY2Nk6pOXonDWpHUXubIdvaDC8cKqGs
 HIo=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2022 04:08:36 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v4 1/4] ufs: core: Remove redundant wb check
Date:   Sun, 27 Nov 2022 14:08:27 +0200
Message-Id: <1669550910-9672-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
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

Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2dbe249..2e47c69 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7608,10 +7608,6 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
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

