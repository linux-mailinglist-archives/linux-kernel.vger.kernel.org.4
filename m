Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A55BDD02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiITGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiITGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:19:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318E5D11E;
        Mon, 19 Sep 2022 23:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663654762; x=1695190762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eOSxHA6iENpubJOOFWN6159mbYl+bwBtFFHrUgRk8N4=;
  b=a9sE3D+Nslp2dmT9/BAltx3wnIt5/bIKQb+tSm9B0UViCusTyY0XSJlG
   6jup6X9CrCgMFRNwIIueAms2ztIuyyy3mcewHsjQZvtjMjY/sfTA0Dx74
   zFU9j8aYzQ0QzLsKQJEvHVhPy+OxNlb5qsr94cIkQnJxL71m41hfcB07J
   t9/V+mZoUTxaDEV8mgkTHZIQV1T3yM1EINJpK3hb4+tL0GRg5tK7lGnmF
   7OHCs0yydXvPX1LvdWghtV6x6sv+/BQda5iCprGWVW1ZsMHvfoWYIjRZ0
   /x122kFUJf//rWIQ9A5yzvEtH9IxHe1PQmRFptxXrfwyNXchfIeNKWZi+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325909657"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325909657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:19:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="794137755"
Received: from sysdebug.bj.intel.com ([10.240.193.70])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:19:19 -0700
From:   chao.qin@intel.com
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     paul.mei@intel.com, lili.li@intel.com, chao.qin@intel.com
Subject: [PATCH] powercap: intel_rapl: fix UBSAN shift-out-of-bounds issue
Date:   Tue, 20 Sep 2022 14:08:26 +0800
Message-Id: <20220920060826.3631210-1-chao.qin@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Qin <chao.qin@intel.com>

When value < time_unit, the parameter of ilog2() will be zero and
the return value is -1. u64(-1) is too large for shift exponent
and then will trigger shift-out-of-bounds:

shift exponent 18446744073709551615 is too large for 32-bit type 'int'
Call Trace:
 rapl_compute_time_window_core
 rapl_write_data_raw
 set_time_window
 store_constraint_time_window_us

Signed-off-by: Chao Qin <chao.qin@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 21d624f9f5fb..bf91248630c3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -994,6 +994,9 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
 		y = value & 0x1f;
 		value = (1 << y) * (4 + f) * rp->time_unit / 4;
 	} else {
+		if (value < rp->time_unit)
+			return 0;
+
 		do_div(value, rp->time_unit);
 		y = ilog2(value);
 		f = div64_u64(4 * (value - (1 << y)), 1 << y);
-- 
2.25.1

