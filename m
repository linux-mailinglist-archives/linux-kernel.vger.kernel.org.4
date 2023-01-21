Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A399867626C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAUAbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjAUAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:31:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35C1E0504;
        Fri, 20 Jan 2023 16:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674261057; x=1705797057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Ev3PbBoQTPu++s79dlTb8COWuPsvkK7r7MmlVY0+IpE=;
  b=TREhDKDdzzEQ021DnCxcIpiK26fvYpeXAIKtwIUoRXTBd2OObS+loWOn
   HejAwWsvDWne8Na3WATnIMIZcBqnDCfUHlRDdh0K2JQGfrk/DuEml2adl
   tvwh6oOmN/+eKgDpmNb+claWAVK/f4Uj7LQ46p0hWpWl9xQd6LQSxFDrs
   pRtbtol4Hatm3pdqhDH3RSQ/+vOhz8xjWS7ckURbdTUufEpoZWUFjTyhH
   b1kqPDMsYEXxh6RAWSai8uattHl4fPEbdFZgqEjPtw7UnREU0BCfTyEuH
   1UtY4nTT4q8zsxZDAryl6DLl1hmmkLBDpdlE4crBvXbkHh4qs1yJeRmDC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="305404597"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="305404597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="784729479"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="784729479"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 16:30:15 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@linux.intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 RESEND 0/4] Documentation/x86: Improve the AMX documentation
Date:   Fri, 20 Jan 2023 16:18:56 -0800
Message-Id: <20230121001900.14900-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922195810.23248-1-chang.seok.bae@intel.com>
References: <20220922195810.23248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a resend of the previous posting [1]. They are rebased on the
current tip master.

Looks like the below changes are still helpful for users as I had to
reference the pending series to some folks:

(1) The AMX-enabling code example is expected to clarify the steps.
(2) Along with that, a couple of ABI constants may be useful for users.
(3) Also, describing the motivation will provide the context of this.
(4) Lastly, the description of new guest options is added as missing.

If they are acceptable, I will follow up on the arch_prctl(2) documentation
[2] to update based on this.

These patches can be also found in this repository:
  git://github.com/intel/amx-linux.git amx-doc

And the compiled preview is available here:
  https://htmlpreview.github.io/?https://github.com/intel/amx-linux/doc-web/x86/xstate.html

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220922195810.23248-1-chang.seok.bae@intel.com/
[2] arch_prctl(2): https://man7.org/linux/man-pages/man2/arch_prctl.2.html

Chang S. Bae (4):
  Documentation/x86: Explain the purpose for dynamic features
  x86/arch_prctl: Add AMX feature numbers as ABI constants
  Documentation/x86: Add the AMX enabling example
  Documentation/x86: Explain the state component permission for guests

 Documentation/x86/xstate.rst      | 100 ++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |   3 +
 2 files changed, 103 insertions(+)


base-commit: 1642cea9d9ab82b596857eea14bf6e04806a6c5a
-- 
2.17.1

