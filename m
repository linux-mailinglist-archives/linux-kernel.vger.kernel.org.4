Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A467139ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjE1OJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE1OJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:09:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33926BC;
        Sun, 28 May 2023 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685282980; x=1716818980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cIR2fr2WmJ//GgKu/Pqss/i9kXIikU40iGweAC9yfuQ=;
  b=Sr+lEvtQqyQKDaSj0IsRTxppFFSZ+IsNi2g1H6FtOPcjX8dS1B142GMh
   feNBGvL8bmAjhLHUhGdAYHl6IOS4sUjBByJ3D2E8Ponyf174joM0Avcl9
   3YdVLKK/yau2LVVcwyCZggutst+QPs3af8/GPAvAVvE+uIgHEqdNAJmA8
   FzI+j01avGV+ohN5fByiclcUNJdMfTWcVHOO85hIcmUubAmvvu7rKzQvZ
   WNkIW4QCF+1HcLoesUw8GE/c+rOWE/n9JFijLQSbU+KY6u4ldq8m4pLF/
   3LMGhcXte+gVb4ByD7SBL/iWGjxDCdYu/Ax1D+B4UreGThijlDF0TvD/z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="357766867"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="357766867"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 07:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="699947158"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="699947158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2023 07:09:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6578924F; Sun, 28 May 2023 17:09:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray gpiod_unexport() call
Date:   Sun, 28 May 2023 17:09:38 +0300
Message-Id: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no gpiod_export() and gpiod_unexport() looks pretty much stray.
The gpiod_export() and gpiod_unexport() shouldn't be used in the code,
GPIO sysfs is deprecated. That said, simply drop the stray call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ieee802154/ca8210.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index a2d242034220..f9b10e84de06 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2855,7 +2855,6 @@ static int ca8210_interrupt_init(struct spi_device *spi)
 	);
 	if (ret) {
 		dev_crit(&spi->dev, "request_irq %d failed\n", pdata->irq_id);
-		gpiod_unexport(gpio_to_desc(pdata->gpio_irq));
 		gpio_free(pdata->gpio_irq);
 	}
 
-- 
2.40.0.1.gaa8946217a0b

