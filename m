Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9C64A9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiLLVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiLLVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:49:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A11A06C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670881787; x=1702417787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ULDXAwAAFmxVHF7z/2+d10TwMuCrsH3Q+pw4ZUvRKJU=;
  b=LhSVdDwEr6tXaeS1t/nj7DTL9lPCYdip0Lh7xhEQ8NMciW1i9CwR4oio
   TB8DQJfCobxBbLSE65QznB6fu3kdk9pUe1GxBpfaNiorc84LoWrIPL2t/
   UOh2rSdYnRsY0OOAfmw0oasOfJzm8Sr5OM7TzSNsfh30+95K+aCAN72Sa
   I1Q2Np2+szRTYQ6rhCiCTZ/8Pazk+VzsQj4e9ZxE4zV+2N9hu+f7JT3u+
   xFmh+JM2sHHCms9HMfcfTUs5T1LGexl60huPTv5J3gBggTWOR46d/hqLN
   gJuB6uvS01kq6iGP+u2Esoj6sDmOOYOroltsrT1vqLKCI9N8+KdmOtbt6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="318002832"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="318002832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 13:49:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737135058"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="737135058"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 13:49:45 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus-fixup:upon error print return values of send and receive
Date:   Mon, 12 Dec 2022 23:49:33 +0200
Message-Id: <20221212214933.275434-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

For easier debugging, upon error, print also return values
from __mei_cl_recv() and __mei_cl_send() functions.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 6df7679d9739..92c0930cc742 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -151,7 +151,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
-		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
+		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd ret = %d\n", ret);
 		return ret;
 	}
 
@@ -163,7 +163,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 		 * Should be at least one version block,
 		 * error out if nothing found
 		 */
-		dev_err(&cldev->dev, "Could not read FW version\n");
+		dev_err(&cldev->dev, "Could not read FW version ret = %d\n", bytes_recv);
 		return -EIO;
 	}
 
@@ -380,7 +380,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), 0,
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
-		dev_err(bus->dev, "Could not send IF version cmd\n");
+		dev_err(bus->dev, "Could not send IF version cmd ret = %d\n", ret);
 		return ret;
 	}
 
@@ -395,7 +395,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, &vtag,
 				   0, 0);
 	if (bytes_recv < 0 || (size_t)bytes_recv < if_version_length) {
-		dev_err(bus->dev, "Could not read IF version\n");
+		dev_err(bus->dev, "Could not read IF version ret = %d\n", bytes_recv);
 		ret = -EIO;
 		goto err;
 	}
-- 
2.38.1

