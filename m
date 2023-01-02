Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877D65B718
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjABU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjABU2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:28:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D857B7C5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691331; x=1704227331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lv2Elwe3ulVHFvJLU667O/l2EXajCGq8zg7gGeG3KKI=;
  b=D5C2n0hvUEoDpKJZMeqPVNZ1A6TJB/ygsHUZDAViwAzAsDrCbuf6YIDD
   Rf6akwjxrAosiKalIuq3Ti2BxuS5B1Sh5vHMWM4TL9J+hQM/+K9sA5CeF
   u2jQ689vLq5UNO24srQ9WzMZ9coU/i9D+34QWYLgJrGw/8+Bg8CJp4m8p
   PpXcopOPtvpDEMBj5lu6s5GvyFKdrwsnEFffDhTIzsmVze1uB3wYIQAXD
   a8R0JC9VXNGKNU+GTtz2XMb5mtM4KGevAbelIMXBd09jybRx2X0/RTMQk
   ifqhi+RSet9f+ONTtRdTLCdGXSCcRnanqgDr6FNzxDSoDHROKdgeqmT9m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322772120"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="322772120"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="654577473"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="654577473"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2023 12:28:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30DB6F4; Mon,  2 Jan 2023 22:29:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] extcon: axp288: Replace open coded acpi_dev_put()
Date:   Mon,  2 Jan 2023 22:29:19 +0200
Message-Id: <20230102202919.15925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling put_device(&adev->dev) where adev is a pointer
to an ACPI device, use specific call, i.e. acpi_dev_put().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 180be768c215..a703a8315634 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -393,7 +393,7 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		adev = acpi_dev_get_first_match_dev("INT3496", NULL, -1);
 		if (adev) {
 			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
-			put_device(&adev->dev);
+			acpi_dev_put(adev);
 			if (IS_ERR(info->id_extcon))
 				return PTR_ERR(info->id_extcon);
 
-- 
2.35.1

