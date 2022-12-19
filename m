Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EEA650BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiLSMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiLSMmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:42:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F017E00F;
        Mon, 19 Dec 2022 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453751; x=1702989751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RTfdE9Kw7+wzicmDdsrrzv8JpM6HgptCGGcTTtg6Geg=;
  b=Gz0KhRvJfXyOeHS5OgSSV8r6ZAu/WBUEPTaGjpRVv68X4rTm0k9rOkKd
   Q5aC0JkLNYCHY5/STD49EQ3IEj+DCD6aTH6/ITiSrCWRGipDC6xsTH81h
   8kcniJqcyW71QazZ1oclH+jgKk38K7X9Ep+I8QL1RMkSEb+l+D2+mfyzd
   Ifl/YKuMBslVMP3N8F0Kk+p2saLgyqgS2J/InyOjNYMONRATl3Vl2LugC
   ywNkgkDb6xxdXmGjZ7AORApXFi3MiGssdg3HqqO8q1QtaSWV1knG9BJ+O
   5jGG1zbwgO6cgJtviU3YQ8snxTULorvpi2JsQxiuZqEpjV/wdHOVoKHaD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="320510354"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="320510354"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="681210369"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="681210369"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2022 04:42:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6378C223; Mon, 19 Dec 2022 14:42:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 7/8] pinctrl: moorefield: Convert to use new memeber in struct intel_function
Date:   Mon, 19 Dec 2022 14:42:39 +0200
Message-Id: <20221219124240.62781-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
References: <20221219124240.62781-1-andriy.shevchenko@linux.intel.com>
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

Convert driver to use generic data type and hence a new member in
the struct intel_function. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-moorefield.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-moorefield.c b/drivers/pinctrl/intel/pinctrl-moorefield.c
index e3eec671e15d..3c9a8484b442 100644
--- a/drivers/pinctrl/intel/pinctrl-moorefield.c
+++ b/drivers/pinctrl/intel/pinctrl-moorefield.c
@@ -530,7 +530,7 @@ static const char *mofld_get_function_name(struct pinctrl_dev *pctldev, unsigned
 {
 	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
 
-	return mp->functions[function].name;
+	return mp->functions[function].func.name;
 }
 
 static int mofld_get_function_groups(struct pinctrl_dev *pctldev, unsigned int function,
@@ -538,8 +538,8 @@ static int mofld_get_function_groups(struct pinctrl_dev *pctldev, unsigned int f
 {
 	struct mofld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = mp->functions[function].groups;
-	*ngroups = mp->functions[function].ngroups;
+	*groups = mp->functions[function].func.groups;
+	*ngroups = mp->functions[function].func.ngroups;
 	return 0;
 }
 
-- 
2.35.1

