Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD26202AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiKGWyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiKGWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7AC2935D;
        Mon,  7 Nov 2022 14:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861686; x=1699397686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUDmXJ81hZPKLSigWUAhVkXDqINWawcz+Tl9WL2UD/A=;
  b=SIC4Vk8zY3jQAK/+DRD1DbmCEvgHhRvqROTgK/w4O8GI9uazRezPI05y
   zc9o/G8O4SZ+wX9mdEd7/eWOwSrDfWLDfYhWFyqnG8QgDc9FzJeE/O0Gd
   G6rLGZCWe+cm6eV/a0Ep730lQHnxGFA1xxeZNbL7ucL9JxkPQP1N7i2ip
   1H5fyD20KnhQXDliKwbaAuL+eeIcK9VXFa2mJCq9v7WN/vlobu6QBnhHS
   ltJNIymTZEXVr6o6cdu7e7bxXmVmp3vmbUkA7dUO3yYWHK+PW332Lk+i1
   6YbMRPapMTIAk/Ew87czt7fdMAkP1jgD9SFmomlPjLKOubYbZe1rtLjKw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911822"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012955"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012955"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:45 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 02/14] platform/x86/intel/ifs: return a more appropriate Error code
Date:   Mon,  7 Nov 2022 14:53:11 -0800
Message-Id: <20221107225323.2733518-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scan_chunks_sanity_check() returns -ENOMEM if it encounters
an error while copying IFS test image from memory to Secure Memory.

Return -EIO in this scenario, as it is more appropriate.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..89ce265887ea 100644
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

