Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF844607FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJUUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJUUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526304B4A0;
        Fri, 21 Oct 2022 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384795; x=1697920795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYLjCtMe0oKlNW4X9hQ8u/gqYqo3txjMxVWcMyx5Mts=;
  b=hmHuL0p0PItkjcY0317FAIeReGiLShImli/kkzMlwuGORcaNuUk3Tz5c
   4WqHGGo42TFRU3OG15bnXJ/Rs01/igV85qqDBk4p8PyH/8aBl3jsvHQqc
   g2WBS5dIZzv0cdw7IMzNCtVMRJlTno7+TdbSXPihCD6gJVTROIR1KnSnD
   zTe7XDHbO26lXQBDbMbamUyfrDP0od/7IbwNeBUnydqS6nJElnOhcswWd
   y7Or3LEttEt7Uj6ObTd2krwkt4satONyRHN1Xei0mihXIcT/UUHsPPRJA
   cr9eVaGSH3VW5X1hBJa0m1AD305M2JrnYDK7SXs64jOrrPMOreZMggHWf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161179"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735701014"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735701014"
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
Subject: [PATCH 06/14] x86/microcode/intel: Use appropriate type in microcode_sanity_check()
Date:   Fri, 21 Oct 2022 13:34:05 -0700
Message-Id: <20221021203413.1220137-7-jithu.joseph@intel.com>
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

The data type of print_err parameter used by microcode_sanity_check()
is int. In prepration for exporting this function, to be used by
the IFS driver, Convert it to a more appropriate bool type for readability.

No functional change intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f0cc60d92dfc..5473b094baee 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -164,7 +164,7 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, int print_err)
+static int microcode_sanity_check(void *mc, bool print_err)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
@@ -282,7 +282,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, 0) < 0)
+		    microcode_sanity_check(data, false) < 0)
 			break;
 
 		size -= mc_size;
@@ -821,7 +821,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, 1) < 0) {
+		    microcode_sanity_check(mc, true) < 0) {
 			break;
 		}
 
-- 
2.25.1

