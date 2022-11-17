Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0462D201
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiKQEBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiKQEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:00:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56F741992;
        Wed, 16 Nov 2022 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668657656; x=1700193656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=17CL2FjZPUEz4ImeXbJSJ2yXwkCtWsI2L+00dokYk/Q=;
  b=hyLYu78LSSWGTf/Mx3T1IiIRUCwCdkEoE1p8FucboRzLgev6GX5Vc7OW
   8ySHh9caHHKWwIMfnIkU6W1eD6S9YSGB+rIr9G7GrdIrHmRL2k25mlmAt
   oY5nWlLduIKr6RbMNBQTaR8+B64rofaxUQiWjl0tJuHgIA+C9VLYOVULH
   8SGW4Tmw/ePYd8EiKf55nzy2zBnLtt5y17GyY7E7rO4H21cdjpsHeyKY/
   U221MjObujhE5mlGMYUY0xn3l50p/pKqFBdff5/zlCySpgvrzIFUDKA/J
   BgZ8EpGM9aDjd9YNtFhi5EdqCS0UhSJIrBNs3Atp3XNBPRC12xzYlg9Yo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292455952"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292455952"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590462653"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590462653"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:55 -0800
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
Subject: [PATCH v3 02/16] platform/x86/intel/ifs: Return a more appropriate Error code
Date:   Wed, 16 Nov 2022 19:59:21 -0800
Message-Id: <20221117035935.4136738-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-1-jithu.joseph@intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scan_chunks_sanity_check() returns -ENOMEM if it encounters
an error while copying IFS test image from memory to Secure Memory.

Return -EIO in this scenario, as it is more appropriate.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

