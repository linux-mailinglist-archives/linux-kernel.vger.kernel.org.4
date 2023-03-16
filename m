Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDE6BC32C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCPBQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPBQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:16:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6135241
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678929378; x=1710465378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mruBbeYEYvS76q1If3LbzUoj9KfnmiBSODHrmLNTmvM=;
  b=iilkL7BGtT74+gVd2fCte5Gcyr2ay5q21uHDaH8N1dl8i+NigrVukcXQ
   sbliYd4wVFWPGFmFnfQ9yYD3wxxrDpDYDvuQskbVQ8i5Us6x+B1xbkOTj
   ZdX6er1suIkuANO28Wgh9MpwXAh2AVXmrJKZbLzr08DkWIiaIV1k1k/h5
   oNiA2BgkkAnyfDGS8dz8b8FjT+x+z5SdDOrGRZ59MpH/uRZRmkTf3+7O6
   E7XjHQqm5ZXGypXDLCadtShz0TUsKuHAzpP2Nb/TXJe4HHFIUzWrcdHgB
   TPAdxjHqbEBNf8PeV2qWoNW0crOYj5fEIgTw+THFKHPvExXmet1H417xj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340224484"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340224484"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 18:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925547207"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925547207"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 18:16:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: stream: restore cumulative bus bandwidth when compute_params callback failed
Date:   Thu, 16 Mar 2023 09:30:41 +0800
Message-Id: <20230316013041.1008003-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

The _sdw_prepare_stream function just returns the error code when
compute_params callback failed.
The cumulative bus bandwidth will keep the value and won't be decreased
by sdw_deprepare_stream function.
We should restore the value of cumulative bus bandwidth when
compute_params callback failed.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8c6da1739e3d..136b6850a3f0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1369,7 +1369,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 			if (ret < 0) {
 				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
-				return ret;
+				goto restore_params;
 			}
 		}
 
-- 
2.25.1

