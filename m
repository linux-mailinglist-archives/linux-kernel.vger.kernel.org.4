Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E0607FED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJUUkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJUUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C994454C;
        Fri, 21 Oct 2022 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384794; x=1697920794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYEJTVshqR8fRd94F4Nb8k1S6Du/B4ywdW9auP0/9mk=;
  b=DAKBs9rH+VWwfyq5r30EwICGxhm0Nr1F/3fWMvLjqVXPAvDmBNU2X4Lt
   AfYfDsWEQiwMWXh8TmD2YIlYgmARtWUt5lZABQWMSUI8YrO3epqGL6+6z
   oh2D8iiPqbeT0nNGwXDsotZncEX+OaEUdHFrPSBg7wD1UZhmj782WNXSz
   uqO7d3k0pd+TzjTWa6QWob/DwLwBht6lnOCccqDkHobSPVBnZYcL8yVGJ
   DschG8+nOoJxo0iI39QgZZcQwkD4k0kHYRKHBGXBqZ7CeEPebzi8kqcPX
   rC8MpF67Mz91yuJK1tTMn6/gIiYgbeY+kDxJXLDdNkFyaolqG2gr+W+aT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161174"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161174"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701001"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701001"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 03/14] platform/x86/intel/ifs: return a more appropriate Error code
Date:   Fri, 21 Oct 2022 13:34:02 -0700
Message-Id: <20221021203413.1220137-4-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scan_chunks_sanity_check() was returning -ENOMEM if it encounters
an error while copying IFS test image from memory to Secure Memory.

Return -EIO in this scenario, as it is more appropriate.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index ebaa1d6a2b18..b88db0765311 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -157,8 +157,10 @@ static int scan_chunks_sanity_check(struct device *dev)
 		INIT_WORK(&local_work.w, copy_hashes_authenticate_chunks);
 		schedule_work_on(cpu, &local_work.w);
 		wait_for_completion(&ifs_done);
-		if (ifsd->loading_error)
+		if (ifsd->loading_error) {
+			ret = -EIO;
 			goto out;
+		}
 		package_authenticated[curr_pkg] = 1;
 	}
 	ret = 0;
-- 
2.25.1

