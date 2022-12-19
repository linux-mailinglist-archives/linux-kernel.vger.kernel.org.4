Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5778F650BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiLSMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiLSMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:32:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3E1EE1D;
        Mon, 19 Dec 2022 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671453106; x=1702989106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eN8P+N64P95zR91Fwvb5XL2UO1+uvpxDLZPoDQkp4Ig=;
  b=O8s7VviL+cw9tp9FrDRMaajNKt8ltgGY2Rijq1XO99LsyZG/SikFjUe0
   Cw580K0qzxISf/Tj87jAaD4uY1G5EK9067KinJKnIddsoexM3cpvttD7T
   8FUkLOCX5zs8YTch2zpvo7T1Vx+8azxxcMT+nDZslqjI6EHrchtKH+m6I
   2MkpBg4dk+ThHRZbXM95cjL3zWgDaQfsCjjXOQN1sG/o499R5Uk7VKzF4
   Hhzu5R7YtJQ5qXGe+xyqzQBi1pO7mfHEoyuOv0+iwCxEyQpPBD9Q0e9yT
   lU30fTYD4hWAArQUEy1x+5tBlm4aecgM3BCzzJE5lpMSTi99oM5BVKwZV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="299670630"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="299670630"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="896027912"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="896027912"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2022 04:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB011F7; Mon, 19 Dec 2022 14:32:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/4] pinctrl: intel: Add default case to intel_config_set_pull()
Date:   Mon, 19 Dec 2022 14:32:05 +0200
Message-Id: <20221219123208.5505-1-andriy.shevchenko@linux.intel.com>
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

For the sake of symmetry with intel_config_get_pull(), add
a default case to the outer switch.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 8181a65fb815..4b1d5a21aa68 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -758,6 +758,10 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
 		}
 
 		break;
+
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 	if (!ret)
-- 
2.35.1

