Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E955F43C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJDM7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJDM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:57:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389AC05;
        Tue,  4 Oct 2022 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664888075; x=1696424075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=34fkB9PiTMeL4NylLu89W/O34IlUWd9gKTytveVgpEw=;
  b=USJ8fVleKVc5WNBO7Qo9fuS3IkfHA43fPWhj4gQRSXBm2KjgnsMH4eNn
   iTh0Ht6iWeP1EehBlAqvX8ijUHcOEeDs2ptpF3+WHgI3IUXE8C/PlS+eD
   +hIV2um6Oto79HTf/HcuqTpS6xwCRSNXzhWbw+3vnjaFpshlDLzNBOkB6
   wTNW2Cc8gjAjIo36FRlV0G+ky0vXQXZ8pnTU5eDIuB0ZXIafKuIn11fjW
   vYE+bIvF+ukCFQdoWjFjzmysnoTOxQEjMfkKt8ft+IdL0wQWz4/sgkWhF
   dQedKBvS6ADpQdgDeqrx7VcxxFB82rWkwVjCb6/aTYuNhAhEAFj1Vy2HS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304444151"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="304444151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 05:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="575017691"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="575017691"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 05:54:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1031C17E; Tue,  4 Oct 2022 15:54:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/1] pinctrl: st: Avoid using of_node member of struct gpio_chip
Date:   Tue,  4 Oct 2022 15:54:49 +0300
Message-Id: <20221004125449.67679-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The of_node member of the struct gpio_chip is obsoleted and
shouldn't be used. It will be removed in the future.

Replace its use in st_pctl_dt_calculate_pin() by comparing
the fwnode pointers.

Fixes: e75729b2f63f ("pinctrl: st: stop abusing of_get_named_gpio()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index cf7f9cbe6044..ac24d07338a4 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1175,7 +1175,7 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
 
 	for (i = 0; i < info->nbanks; i++) {
 		chip = &info->banks[i].gpio_chip;
-		if (chip->of_node == np) {
+		if (chip->fwnode == of_fwnode_handle(np)) {
 			if (offset < chip->ngpio)
 				retval = chip->base + offset;
 			break;
-- 
2.35.1

