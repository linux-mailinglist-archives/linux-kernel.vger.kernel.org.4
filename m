Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68725E6CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIVUJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiIVUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:08:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF78E7E1D;
        Thu, 22 Sep 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877313; x=1695413313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=APb2LiHwFZJrqIKUHw/Hp/TgOVz7B3k99VkTBnRFohc=;
  b=Vm9KPrDB/xdxu/c+RAkxccar8o5gdSpVlOGoMDN+k29r0GA/97ReIo4B
   0ZIMwNV2A6s/YaoEEeNYMbRZjL8Tb0Oq/iKCaQozHowFNnwRcLnPVr7CJ
   EzGhCOSxWFwaWrHXDWAtejMOn4J6wz0yc68CtPOKdVdM4Ma4lLEwKl49R
   V28ksy1+4sTxPrircrYu1VcarPwbkT3qU4Ja2zFwjC8Byq2HKnd19wtCN
   Bi+s5IIdKAWYFbRooj0BijVMRinq0duEM1zD7wnZTpS2h5iIJw57A37NX
   0Blbftgn3fkobXbDei/3ordwMlP3u+x937WvPzBakxQL2AqfSuxjy/5De
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362221581"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362221581"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571117143"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 13:08:15 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 4/4] Documentation/x86: Explain the state component permission for guests
Date:   Thu, 22 Sep 2022 12:58:10 -0700
Message-Id: <20220922195810.23248-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922195810.23248-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 23b1c9f3efb2..ae5c69e48b11 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -143,3 +143,32 @@ entry if the feature is in its initial configuration.  This differs from
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
+ same semantics for the guest permission. While providing a similar
+ functionality, this comes with a constraint. Permission is frozen when the
+ first VCPU is created. Any attempt to change permission after that point
+ is going to be rejected. So, the permission has to be requested before the
+ first VCPU creation.
+
+Note that some VMMs may have already established a set of supported state
+components. These options are not presumed to support any particular VMM.
-- 
2.17.1

