Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6265926C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiL2WRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiL2WRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:17:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B710FEB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 14:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672352250; x=1703888250;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=0Bwu8q8NcSs4olMgZzczoNf795r7NhoTTUkYK+RcF7Q=;
  b=ZSBq+/lb4rIUBzhS3X1/mMkVe9bGSM3bV+4UzB8L1F1mGWrbFf57Ir1s
   K2wX4F1ui/QkZUw10zDIikQ/8w8vAxTFFvlOKwa2QwMK+KXqkRsILBUoT
   cLocXdiTzo1cWvs8jQ41flNCZuklA+vd5HuO0e0noX44hY8FWyjDn7DIl
   rI5nC4MKMR8pwTL68O74TfQHXm5eGwPUE3uAZr8Zj5TtUQCqpmKaMhGET
   JdWJDO+n6GVrqoUHfA/M8jOEDhe//+DbmD8ZPVMBbVeiojed88xB3x/vn
   Ev7Ucc2kjtDbYPOPgjE1g/WUYv3kq7EMOPLfF4GVqX2fryQGqOZCDt6pn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="385547734"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="385547734"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 14:17:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="899094694"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="899094694"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.27.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 14:17:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 29 Dec 2022 14:17:15 -0800
Subject: [PATCH v2] checkpatch: Mark kunmap() and kunmap_atomic() deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221229-kmap-checkpatch-v2-1-919fc4d4e3c2@intel.com>
X-B4-Tracking: v=1; b=H4sIAOsRrmMC/3WNQQ6CMBBFr0K6toaOAdEV9zAspuNgJ0ghbUM0h
 Ltb2Lt8/+flrSpyEI7qXqwq8CJRJp8BToUih/7FWp6ZFZQABuCmhxFnTY5pmDGR09f6QgRI3HCl
 smUxsrYBPbndGzEmDvsxB+7lc6QeXWYnMU3he5QXs6//I4vRRte2qS31VdmU2IpP/D7TNKpu27Y
 fiGunX8cAAAA=
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672352249; l=1755;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=0Bwu8q8NcSs4olMgZzczoNf795r7NhoTTUkYK+RcF7Q=;
 b=q+zqaU3yZQLK9mLV87owPphuNImMaR2BK1Wmml93OLfYS0h5tmM/uABVHYQCv5AfOMmt9Atjauk2
 Ol+4WJUZBF0TrnGA323037ThscjkaQ+hhk+U6aN2G8twF7HCVc3b
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was suggested by Fabio that kunmap() be marked deprecated in
checkpatch.[1]  This did not seem necessary until an invalid conversion
of kmap_local_page() appeared in mainline.[2][3]  The introduction of
this bug would have been flagged with kunmap() being marked deprecated.

Add kunmap() and kunmap_atomic() to checkpatch to help prevent further
confusion.

[1] https://lore.kernel.org/all/1884934.6tgchFWduM@suse/
[2] d406d26745ab ("cifs: skip alloc when request has no pages")
[3] https://lore.kernel.org/r/20221229-cifs-kmap-v1-1-c70d0e9a53eb@intel.com

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Suggested-by: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- Add LKML and send directly to Andy and Joe (I'm still learning b4 send...)
- Link to v1: https://lore.kernel.org/r/20221229-kmap-checkpatch-v1-1-6b86bcf5080a@intel.com
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce..a6d6d7e1d0cf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -823,7 +823,9 @@ our %deprecated_apis = (
 	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
 	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
 	"kmap"					=> "kmap_local_page",
+	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
+	"kunmap_atomic"				=> "kunmap_local",
 );
 
 #Create a search pattern for all these strings to speed up a loop below

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221229-kmap-checkpatch-763cc2ace8e5

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
