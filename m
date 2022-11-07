Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2D6202BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiKGWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiKGWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B31571D;
        Mon,  7 Nov 2022 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861687; x=1699397687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9L4yTAcmbDrd8Wtf0AHUAz+/qaAhDmvRMsfLMW5DI0M=;
  b=Qd/I8lbYgrP7VLxd+crsq3YA+4cxOBiFlk+JYPLPEMapMkbE68ltwEgS
   yHdlgoNwkn3Cwd6qCuuZW60ys8yYNfbQSihIS9wIn79Yb2Ml70rcxmCMS
   7RlcFVwczpZOBZmn/c+aHMpRJ1V51qscF8sPXTG0DvzTeuj9yfpM+Qnof
   EPXDDsHYtiYtesQd3B4cS7n+iFy5rrmU5Lh9+o0wr+sIBFjc957p4weEd
   GPxrjGNJExe/Xzf4vEuxjOtGSz8Tcbf87bnW+LYxTGsthnqZxhgisYmQu
   PyOSgQnT9SViiXwZDSBhc9abULaH7CyRypAPqcJUvSVE+42ex5M5ngzsf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911831"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911831"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012979"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012979"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:46 -0800
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
Subject: [PATCH v2 07/14] x86/microcode/intel: Use a reserved field for metasize
Date:   Mon,  7 Nov 2022 14:53:16 -0800
Message-Id: <20221107225323.2733518-8-jithu.joseph@intel.com>
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

Intel is using microcode file format for IFS test images too.

IFS test images use one of the existing reserved fields in microcode
header to indicate the size of the region in the file allocated for
metadata structures.

In prepration for this, rename first of the existing reserved fields
in microcode header to metasize. In subsequent patches IFS specific
code will make use of this field while parsing IFS images.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/include/asm/microcode_intel.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 6626744c577b..0ff4545f72d2 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,8 @@ struct microcode_header_intel {
 	unsigned int            pf;
 	unsigned int            datasize;
 	unsigned int            totalsize;
-	unsigned int            reserved[3];
+	unsigned int            metasize;
+	unsigned int            reserved[2];
 };
 
 struct microcode_intel {
-- 
2.25.1

