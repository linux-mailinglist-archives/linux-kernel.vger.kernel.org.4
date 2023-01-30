Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F6681CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjA3VkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjA3VkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04011727
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114814; x=1706650814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdG1GGA8W0DfnPFwDcohOqulqfW3saP77d/Ow4pY9zI=;
  b=KNTZ9IGxF0iuFD3oUdMIY02uE6iRC9MsJXJY5Khs8hbwe4wgOO7weLpu
   1wwdPGPRjCCfGIhphPK4YYhoOhjGLudy5PW5tTuwJLQ92k2orEtg+wxR5
   IdCAThhuFhbqYHPdnEKsnpFOaj1W2tExpmGdSQgvW3h84gk9EQqOjC59m
   kD02y9abNJWRVNf5ROwRGULrmE4b+JBgf6/5HSZD7rDqc5Yb7EjulYFbc
   5H0k0IkgLBVyqTeL/xXmMq+yOY+WTneH7TV+6VkNLj8yiYwFIuU0KO7om
   E1XlWtIf+Ni4wyRvYi9MMRdiQECWjvhR7piM6B2R/ywqGOqSjb3QPJ7m9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955492"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955492"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571860"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571860"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Patch v3 Part2 2/9] x86/microcode: Report invalid writes to reload sysfs file
Date:   Mon, 30 Jan 2023 13:39:48 -0800
Message-Id: <20230130213955.6046-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130213955.6046-1-ashok.raj@intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Semantics of the microcode reload file are only defined if a "1" is
written. But the code silently treats any other unsigned integer as a
successful write even though no actions are performed to load microcode.

Report those erroneous writes back to user.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 1c6831b8b244..e4b4dfcf2d18 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -476,11 +476,8 @@ static ssize_t reload_store(struct device *dev,
 	ssize_t ret;
 
 	ret = kstrtoul(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	if (val != 1)
-		return size;
+	if (ret || val != 1)
+		return -EINVAL;
 
 	cpus_read_lock();
 
-- 
2.37.2

