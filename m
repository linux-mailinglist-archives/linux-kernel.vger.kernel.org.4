Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40926638F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjAJF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjAJF4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A076309
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330156; x=1704866156;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PgZ+tC6s+LeyPcVLVfrm/1TfwJMKnT9ckR2VquXmX5s=;
  b=I3YHNNZ68EJDaoIK8CQRvswPdAfWWrngU5vTLu+25N36hRk3SzbgL+Qm
   sNWise+0fN8jUcEmhSs7xzPH9RP2oxzNDkF/+egUMmVca16x6hLpBrpKI
   m4NvbJI9L3kp5B8fEOypiQIOFNpNOeLnTbuL8L46v85KJkLEJHzfUvKke
   fga+eQ2men2O1P6r+tiYYMMhXsXbT4P38CeU5fYVITO8UTL31p+IHTt5v
   wkc67S2g5cRqjneeS/EQdMBkhJ6KoVTRP+YgLVU1l/PQqWVwnNx5rpVIj
   3pl2Vs/tOMhVlUYDxj4i3665I6i2dV22n5jukycuYp0EHgzmYP9XF3UdK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289969"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483753"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483753"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 6/7] x86/cpu: Set LASS as pinning sensitive CR4 bit
Date:   Mon,  9 Jan 2023 21:52:03 -0800
Message-Id: <20230110055204.3227669-7-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Security protection features are pinning sensitive.
LASS comes with an effort for security concerns.
Therefore, add it to the set of pinning sensitive
bits

Signed-off-by: Yian Chen <yian.chen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index efc7c7623968..e224cbaf7866 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -432,7 +432,7 @@ static __always_inline void setup_lass(struct cpuinfo_x86 *c)
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-	X86_CR4_FSGSBASE | X86_CR4_CET;
+	X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_LASS;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
-- 
2.34.1

