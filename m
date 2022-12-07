Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A01646177
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiLGTEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLGTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37657061D;
        Wed,  7 Dec 2022 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439843; x=1701975843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wl+VpQy08drr9NBqnU3E1h7fc0Jv5M6iFmv/BRcElOA=;
  b=Fg/8AxSXzNF2zOdNj4duFvxkvCcie9CAakBxUIG6oifZ6u1rJv66fh6Z
   oKGlVRpL7mNXG4GTnTyQSOgyElGISQ8u1zrRoZL7ed/ATmUM38I/2f3zM
   JxyCgrXO0YVYiHGP/U30nmdjURFRZoWcMzH2Qizkl9SZwznJTU9vWfH+u
   JIbGOxSNi9fyJHBbB0mrI5XmctxxkX9vU0wZqNrGQVZ5fxHgYMBSErdUg
   u42Kx7YlXLVzNNLoox3tlHyRvYWbj6Y3btgykzovJmWmP3ZpyQ1ERdFvY
   uUw0Vw9ga/8K/xnhKIWqNgceRffnrsdLuK2HYVKjjrgtXwmqouF1+rAH2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690243"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690243"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060673"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060673"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BC1A6CE; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 09/11] iio: light: tsl2563: Use dev_get_drvdata() directly in PM callbacks
Date:   Wed,  7 Dec 2022 21:03:46 +0200
Message-Id: <20221207190348.9347-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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

PM callbacks take struct device pointer as a parameter, use
dev_get_drvdata() to retrieve it instead of unneeded double
loop of referencing via i2c_get_clientdata(to_i2c_client(dev)).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index c5814545fd19..f92190fadffd 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -795,7 +795,7 @@ static void tsl2563_remove(struct i2c_client *client)
 
 static int tsl2563_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 
@@ -814,7 +814,7 @@ static int tsl2563_suspend(struct device *dev)
 
 static int tsl2563_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-- 
2.35.1

