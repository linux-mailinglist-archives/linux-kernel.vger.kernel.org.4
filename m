Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E05B3616
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIILN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiIILNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:13:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C0AA369;
        Fri,  9 Sep 2022 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662722028; x=1694258028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JbCdULcpLNTKeyruG9enleFdW1gpzUig7Itvs4b5dVc=;
  b=INsG+aeUFP0VRrFgtvRzDzvrqWY8chU4Mnk26lLnpf2S52nT4wy9WYbE
   Ta+epC9pJh7zKxulnZzFkoDwzhJj89whGrnqM4xFtjC7yiJvpNJYE16Vy
   qFpScU0pt/lWi7EMacfFwBhk9xl97BePkhtT+44ojIWSibn7t/+PA5FZR
   r/c3rtz0FVIML6i8SbwaOGn8G2C6z00riQv0pPQvsgg+q5dRYPd3HiDZS
   UHFxrV8MsVDNxriaWBqqaYi5uuQOxxD8MKHLOwrqoNEoq44UpcTi50R6Z
   xOuRzXEMzfJDLoHtFnM5h44hzegBBKjL8N4oIPto/6K3kltw7Wwkk5vbs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298255036"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298255036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:13:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="790781551"
Received: from lmongeax-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.106.181])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 04:13:39 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, seanjc@google.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/intel: Clear SGX feature bit if both SGX driver and KVM SGX are not enabled
Date:   Fri,  9 Sep 2022 23:13:31 +1200
Message-Id: <20220909111331.558936-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on platform which has SGX enabled, if CONFIG_X86_SGX is not
enabled, the X86_FEATURE_SGX bit is not cleared in init_ia32_feat_ctl().
This results in /proc/cpuinfo still showing "sgx" feature when the
kernel doesn't support SGX at all, which is not desired.

Clear SGX feature bit if both SGX driver and KVM SGX are not enabled in
init_ia32_feat_ctl().

Signed-off-by: Kai Huang <kai.huang@intel.com>
---

Hi Dave, Sean, Jarkko,

Could you help to review?  Tested on SGX (BIOS) enabled machine with
CONFIG_X86_SGX unset.

This patch is generated on latest tip/master, but it applies to
tip/x86/sgx cleanly as well.

v1 -> v2:

 - Move the check down after checking X86_FEATURE_VMX which may set
   enable_sgx_kvm to false.
 - Slightly improve changelog.
 - Change "Clear SGX bit" to "Clear SGX feature bit" in patch title.

---
 arch/x86/kernel/cpu/feat_ctl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 993697e71854..79d18caebff1 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -200,6 +200,19 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 		enable_sgx_kvm = 0;
 	}
 
+	/*
+	 * By reaching here, it is certain that:
+	 *  - CPU supports SGX.
+	 *  - SGX is enabled by BIOS.
+	 *
+	 * However if both SGX driver and KVM SGX are not enabled, just
+	 * need to clear SGX feature bit.
+	 */
+	if (!enable_sgx_driver && !enable_sgx_kvm) {
+		clear_cpu_cap(c, X86_FEATURE_SGX);
+		return;
+	}
+
 	if (!(msr & FEAT_CTL_SGX_LC_ENABLED) && enable_sgx_driver) {
 		if (!enable_sgx_kvm) {
 			pr_err_once("SGX Launch Control is locked. Disable SGX.\n");

base-commit: b8b09110cf290fdab4006b717da7a776ffb0cb73
-- 
2.37.1

