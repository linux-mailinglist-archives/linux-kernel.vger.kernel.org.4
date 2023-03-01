Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8C6A6537
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCACB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCACBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0062C641;
        Tue, 28 Feb 2023 18:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636075; x=1709172075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJlwSFVpT1cewwIwRvUfBxfg5OygWbxR/zFOIt+ZgzQ=;
  b=MV2yw9Uv0afad4Nu/6Pekq++YIBU1rZHij8ADogIsuWc81MUQFMmgrrj
   8T7+oNj0vUpON6b4UocgPpYZxxuLuj9LBCaQhaAzA1FSEUAmZrIdDhj8C
   kXbZOuf4+p4WEIprx3a07Xc7LfaTS1xtKjfyEXSjxpkkznvtS6Ted0bD5
   /878HbzWW+IkuhLzRFXtC87tcnN5QJQv70qHY9L02BQelAar18/tFbB+D
   z4l96G0OM2tTpwMrW3AUWpn9iQ2fagN+cBdJ3f/5V2f4KTEmBsyDJTF/1
   MUawczYITWX/jvYuoniPp6oweQgTcnBHfHHsOMnih83JnXb2PyaPL6+/t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558438"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639950"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639950"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:12 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v3 3/8] x86/include/asm/msr-index.h: Add IFS Array test bits
Date:   Tue, 28 Feb 2023 17:59:37 -0800
Message-Id: <20230301015942.462799-4-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301015942.462799-1-jithu.joseph@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define MSR bitfields for enumerating support for Array BIST test.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d3fe82c5d6b6..ad8997773ad3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -197,6 +197,8 @@
 
 /* Abbreviated from Intel SDM name IA32_INTEGRITY_CAPABILITIES */
 #define MSR_INTEGRITY_CAPS			0x000002d9
+#define MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT      2
+#define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
 
-- 
2.25.1

