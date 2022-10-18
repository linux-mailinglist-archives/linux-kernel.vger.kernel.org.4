Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C966035CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJRWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJRWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:24:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45CB1DEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666131848; x=1697667848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b/PwZW5cSksJCuYePx8D/2yMSEoaL9YcBi6jUK5nF3c=;
  b=EP5DkgzQQpgdYtLA82kmhqo6eMCJ+DWdtarVHI4NIVwanDNMnnUsbf5H
   R57JD5BIjXCfGKKCjZORo1Ahm8NzKtIg45gxYT6bOV7yh+CeXhhNdFTQi
   aVMZ5A7VnhrqvUy+SGoZGQqY3ThwvVNrF70R1Q9BDWyhG8sYXO3ixMkxU
   v3MRIFw8USnJ0xqw077YUy4yOBPP+dGOGRhlygNdep54Tlki1DwBlVYEF
   5NzsTPtheDauW06QrVkbK1G6aNneVKP+XnfyEkNgWGHk4sHJ/5UOMFEo2
   TEfH5hLXWF+GdisSSsimqc0xDxcoade18hYr1TXv9i4cWEk/HO8Mn9BxL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="304984890"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="304984890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="623834770"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="623834770"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2022 15:24:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, yuan.yao@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 0/1] x86/fpu: Follow up on the init_fpstate fix
Date:   Tue, 18 Oct 2022 15:13:48 -0700
Message-Id: <20221018221349.4196-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220824191223.1248-1-chang.seok.bae@intel.com>
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In short, the init_fpstate fix currently at tip's x86/urgent [6] is
incomplete for KVM. This patch follows up on that.

---

While these patches [1][2] attempt to fix the init fpstate, it results in a
fallout with KVM [3]:

The VCPU's XSAVE buffer is expanded at the time of VCPU setup [4] when any
dynamic feature is determined to be exposed via KVM_SET_CPUID.

Then, when the VCPU thread is executed [5], the xstate is copied to the
userspace via KVM_GET_XSAVE*. At the moment, the entire guest fpstate is in
init state.

But, init_fpstate has been incorrectly indicating the inclusion of
dynamic states. Subsequently, in the xstate copy loop, memory beyond the
init_fpstate looks to be referenced for the init states of dynamic
features.

The tip-merged series [1] fixes init_fpstate only. The xstate copy loop
remains to retrieve init_fpstate. Then, it will explode when a
dynamic-featured VCPU is about executed.

The included patch is to fix the copy function. It is based on the
x86/urgent branch [6].

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220824191223.1248-1-chang.seok.bae@intel.com/
[2] https://lore.kernel.org/lkml/20221011222425.866137-1-dave.hansen@linux.intel.com/
[3] https://lore.kernel.org/lkml/BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com/
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/accel/kvm/kvm-accel-ops.c#L42
[5] https://gitlab.com/qemu-project/qemu/-/blob/master/accel/kvm/kvm-accel-ops.c#L51
[6] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent

Chang S. Bae (1):
  x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

 arch/x86/kernel/fpu/xstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: 67bf6493449b09590f9f71d7df29efb392b12d25
-- 
2.17.1

