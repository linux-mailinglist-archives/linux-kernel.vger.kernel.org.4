Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70A5FF451
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJNUJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJNUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44DF1DA365
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778168; x=1697314168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prjILCsmaaEeMhSyb/xyEwNWAEoJRilUniPUTT9n6aI=;
  b=eb3CSEsVJsgiDzIHq/kSC3YSlPnS9gk2z67DJ21BX3DNi1HeEGWnpvFB
   xiAGOY7HLhqpDc23vZfNGx+ckh60SanczgZtnd4YNeqDvmmiUZLdnvVUE
   2AIpib+oC4u0GroGNtUN5kR9SIgvI+iAOsvX6/xvmZqOTppqaPdmhf3qx
   f3CvWrpLCInTIdt7UzCGSqKvpqOTel6C2EUpzKX/X9PsKmBqfecu0hFtf
   F7s/m1+xVQUDceRi21XzolttthxhpnsqLCT6MPOM+U2bwr3D9Y5X4FWWb
   iQp+Ewy11WOO0MEGZS1U9qhhLDzFP9GDaWh4AfUdVCME51l+JOwF3GQfv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202156"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870148"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870148"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:27 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 04/13] x86/x2apic: Support x2apic self IPI with NMI_VECTOR
Date:   Fri, 14 Oct 2022 13:09:04 -0700
Message-Id: <20221014200913.14644-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

X2APIC architecture introduced a dedicated register for sending self-IPI.
Though highly optimized for performance, its semantics limit the delivery
mode to fixed mode.  NMI vector is not supported, this created an
inconsistent behavior between X2APIC and others.

This patch adds support for X2APIC NMI_VECTOR by fall back to the slower
ICR method.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/apic/x2apic_phys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..5f533b76adf6 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -149,7 +149,11 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
 
 void x2apic_send_IPI_self(int vector)
 {
-	apic_write(APIC_SELF_IPI, vector);
+	if (vector == NMI_VECTOR)
+		apic->send_IPI_mask(cpumask_of(smp_processor_id()),
+				    NMI_VECTOR);
+	else
+		apic_write(APIC_SELF_IPI, vector);
 }
 
 static struct apic apic_x2apic_phys __ro_after_init = {
-- 
2.34.1

