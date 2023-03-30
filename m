Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F956D0152
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjC3KeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjC3KeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:34:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29661B8;
        Thu, 30 Mar 2023 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680172451; x=1711708451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whE1JWEEIbCYvxtx8pgmTqwGvrhSLFpbgGUYD65V//Q=;
  b=k3heUWsEIVlShvxiwZrU36to/WTqMen83G9hwqTTEfr1ON6lYYDGtbYo
   lxph9q8Awx9UNc3CT3Mcwp12WO0BGayHhn6w9wSp1Bx1Sj1kYHz3IUTgq
   5TJxSZpLt2Tqn5DEs6O8nkyks/DHNOZKErTGjTVjDxA9de0FixR3AGTvN
   uWdSYX/KsRadGDsjZeBMLRkyoaRiygaudFRTKHeGBBiZZsWOG6o/dJw1O
   svRgHpJEOHCJ60zX9sgAqa597Cpa7/AbQ0Y+qWvWDLBzwglocN97t8cxS
   phNXtWmXHbbVrRxEZr9N72MiojIv3ejqn7oJiME+fgOAmz8sOe9IbMtaP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368910798"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="368910798"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634832283"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="634832283"
Received: from junjiech-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.213.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:34:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, peter.ganzhorn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (coretemp) Delete an obsolete comment
Date:   Thu, 30 Mar 2023 18:33:46 +0800
Message-Id: <20230330103346.6044-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330103346.6044-1-rui.zhang@intel.com>
References: <20230330103346.6044-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refinement of tjmax value retrieved from MSR_IA32_TEMPERATURE_TARGET
has been changed for several times.

Now, the raw value from MSR is used without refinement. Thus remove the
obsolete comment.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index fe3d4d0dcbed..eba94f68585a 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -282,10 +282,6 @@ static int get_tjmax(struct temp_data *tdata, struct device *dev)
 			dev_warn(dev, "Unable to read TjMax from CPU %u\n", tdata->cpu);
 	} else {
 		val = (eax >> 16) & 0xff;
-		/*
-		 * If the TjMax is not plausible, an assumption
-		 * will be used
-		 */
 		if (val)
 			return val * 1000;
 	}
-- 
2.25.1

