Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0657E5B40A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiIIU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiIIU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:26:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C0128C09;
        Fri,  9 Sep 2022 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662755142; x=1694291142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XqLKA3MmjgworvdcvPYyVZ8zmzETc51MsjZvmPVofAk=;
  b=XzLCS96C9mf5FjOB1vXos6sTZYwBfzaHvs3ruW91Ln0jBV+DDdqn//Vi
   pWsyT1NafEwq8G59gUD1P16WAM/47krcPmxu0x92hX7AkJFLfOww2T4i6
   cZ+r+cazbo2Tcexv0VAlav0EteMhRQioGCxyUE5j6OdYy0YAEJXJ5RMSb
   7t3Fib8gxo+pEo5t0Qa3698wAvNLYGCFFjK2N0uox9eoWsYfJjKFapjgU
   ko0/W4m1ShsJVzyRfb0GDbWQzzZ5ui0f2DASIV59Im1MW9nlz1cq/kiAV
   y4ArWgkWg/V3C2bhePkZTMSZ1S4bjm4MzAoQeLBSjXlZEvVvRZMiOlQc0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280584706"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="280584706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="611163005"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2022 13:25:36 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v4 4/4] Documentation/x86: Explain the state component permission for guests
Date:   Fri,  9 Sep 2022 13:15:40 -0700
Message-Id: <20220909201540.17705-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909201540.17705-1-chang.seok.bae@intel.com>
References: <20220909201540.17705-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 980fe2fddcff ("x86/fpu: Extend fpu_xstate_prctl() with guest
permissions") extends a couple of arch_prctl(2) options for VCPU threads.
Add description for them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Reviewed-by: Yang Zhong <yang.zhong@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes from v1:
* Add the reason for the guest options (Dave Hansen).
* Add a note to allude some VMM policy, i.e. KVM_X86_XCOMP_GUEST_SUPP.
* Move it in the separate section.

Note the correspondent attributes were also proposed for the KVM API. But,
it was seen as inessential:
    https://lore.kernel.org/lkml/20220823231402.7839-1-chang.seok.bae@intel.com/
---
 Documentation/x86/xstate.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index f7aad2241d32..fd7b5333bd70 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -141,3 +141,32 @@ entry if the feature is in its initial configuration.  This differs from
 non-dynamic features which are always written regardless of their
 configuration.  Signal handlers can examine the XSAVE buffer's XSTATE_BV
 field to determine if a features was written.
+
+Dynamic features for virtual machines
+-------------------------------------
+
+The permission for the guest state component needs to be managed separately
+from the host, as they are exclusive to each other. A coupled of options
+are extended to control the guest permission:
+
+-ARCH_GET_XCOMP_GUEST_PERM
+
+ arch_prctl(ARCH_GET_XCOMP_GUEST_PERM, &features);
+
+ ARCH_GET_XCOMP_GUEST_PERM is a variant of ARCH_GET_XCOMP_PERM. So it
+ provides the same semantics and functionality but for the guest
+ components.
+
+-ARCH_REQ_XCOMP_GUEST_PERM
+
+ arch_prctl(ARCH_REQ_XCOMP_GUEST_PERM, feature_nr);
+
+ ARCH_REQ_XCOMP_GUEST_PERM is a variant of ARCH_REQ_XCOMP_PERM. It has the
+ same semantics for the guest permission. While providing a similiar
+ functionality, this comes with a constraint. Permission is frozen when the
+ first VCPU is created. Any attempt to change permission after that point
+ is going to be rejected. So, the permission has to be requested before the
+ first VCPU creation.
+
+Note that some VMMs may have already established a set of supported state
+components. These options are not presumed to support any particular VMM.
-- 
2.17.1

