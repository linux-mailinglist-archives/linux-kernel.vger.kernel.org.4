Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BE650B88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLSM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLSM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:26:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355BE0BB;
        Mon, 19 Dec 2022 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671452792; x=1702988792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8DM36Nl3cDaVWS6vYwyGYZCukVD/CWTYUa4Oa4NhRTk=;
  b=FXQMlHUrRem7i6R87YzgN+ILhi/2cK6Bv6UKGKt/+wltKNxmneeCDUFz
   4FiyBkBp7P5a3YiIkQDXvH1hZjzUMB2VmYlPBxbxCMfEiqbXnD78oRjTX
   9hQ+QYF/hTGDJQfeabmGCkuDZ6ogq+l1UmaCzI+Zvpnj887YHc/H5z6At
   XRbwEmGQNaIH91k7C93KdnnTdN4tITeTo93SHdnxzx48ZlR/sEz73o7ld
   iB191isUJhWjJ/fVaIjNvCopl46SsAnHXTOL7KSeAuMHCopuGdePGgEh9
   avJPDyN0DDEfno4CoVy5vAX0CkY5GAydfXTizt9MNGSygZ+vD4sgGsXDG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="319382683"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="319382683"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 04:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="628283705"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="628283705"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2022 04:26:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23C515CB; Mon, 19 Dec 2022 14:26:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 13/17] pinctrl: lewisburg: Replace LBG_COMMUNITY() by INTEL_COMMUNITY_SIZE()
Date:   Mon, 19 Dec 2022 14:26:39 +0200
Message-Id: <20221219122643.3513-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
References: <20221219122643.3513-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use INTEL_COMMUNITY_SIZE() common macro instead custom LBG_COMMUNITY().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lewisburg.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lewisburg.c b/drivers/pinctrl/intel/pinctrl-lewisburg.c
index ad4b446d588e..7aac1bbde2e9 100644
--- a/drivers/pinctrl/intel/pinctrl-lewisburg.c
+++ b/drivers/pinctrl/intel/pinctrl-lewisburg.c
@@ -21,17 +21,7 @@
 #define LBG_GPI_IE	0x110
 
 #define LBG_COMMUNITY(b, s, e)				\
-	{						\
-		.barno = (b),				\
-		.padown_offset = LBG_PAD_OWN,		\
-		.padcfglock_offset = LBG_PADCFGLOCK,	\
-		.hostown_offset = LBG_HOSTSW_OWN,	\
-		.is_offset = LBG_GPI_IS,		\
-		.ie_offset = LBG_GPI_IE,		\
-		.gpp_size = 24,				\
-		.pin_base = (s),			\
-		.npins = ((e) - (s) + 1),		\
-	}
+	INTEL_COMMUNITY_SIZE(b, s, e, 24, 3, LBG)
 
 /* Lewisburg */
 static const struct pinctrl_pin_desc lbg_pins[] = {
-- 
2.35.1

