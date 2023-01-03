Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACD565C24F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjACOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjACOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:53:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E31EE2D;
        Tue,  3 Jan 2023 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672757606; x=1704293606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nmgA4X1w0YFqP1zuZHiRaCJZkppNc/Hvf0BjeUCElGU=;
  b=l9Nm0Vl5FmA4DihuHORdFsyJBVoZKCyAvxOlVCn3zYdt/5sxnUl6nuzC
   DbEaQ88iHxYrbAw2P/qDapIxCjTHwr5j1kiZk4Pk6oUEsfY/49rrQXBgi
   TZj+QoXtmCgg48P2pE7cW4e7sqgqdxgXQGPvpYqpHsprkMRcTO/O4FNq9
   t+Sp7w7Q2XlfiWLMOgV2pFemGhakEhZMIi12Ia0Fw09mPYa5aHTUnQz1+
   jHQJBVq6qh4/iJK2ah4NCCok/4FNqepGrM8/gApF1u+KqOVkUOFaPhBHI
   KoP8f9Z/I4zEM34IkqqigRWNNU+Ral49EZdrEPvq4Hbk9pB8gudn81+VA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309443930"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="309443930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604832048"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604832048"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 06:53:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D0EAF4; Tue,  3 Jan 2023 16:53:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] thermal: qcom-spmi-adc-tm5: Use asm intead of asm-generic
Date:   Tue,  3 Jan 2023 16:53:39 +0200
Message-Id: <20230103145339.40501-1-andriy.shevchenko@linux.intel.com>
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

There is no point to specify asm-generic for the unaligned.h.
Drop the 'generic' suffix.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index ff47fc9ac9c5..31164ade2dd1 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -18,7 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/thermal.h>
-#include <asm-generic/unaligned.h>
+
+#include <asm/unaligned.h>
 
 #include "../thermal_hwmon.h"
 
-- 
2.35.1

