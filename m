Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66C74EB36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGKJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGKJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:55:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85612A8;
        Tue, 11 Jul 2023 02:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689069357; x=1720605357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eu5iZ0jjghh5xc/XHtgk1oWVm52GiK/SZSOg8TCA4+s=;
  b=azkGVysXlg4gN1eMvJK3KYT/shC4DYFoEGMAjdBTD8D606Ity/0axVFw
   By/aQRvqMq9vA4NScvufyM4lg0BUnWk8w1AddaIWNH88t+p1t70WLfM6N
   4ODj9YO4Wr2gYamxh7JG4sdddCYwlMpWwev4dphw7+rsJkqEJXM2IV79B
   lHtEN7ZzLBRcS2eo5kG2C+befgLGh+kJCjFA5X6W59dA9eSLYHw6EnFP2
   n9bdjW/pjfEs+jC34TCgmwuZiWv9Dx/HzZyDKBc1mrsEx7GyrSe9ebr00
   +Dy4wB1IwBP0LG/I3IEZHSzdfanKM50GbeteDfaIDdguOqhgOrHQ8Obei
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349385344"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="349385344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 02:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="1051723761"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="1051723761"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 02:55:31 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, chuck.lever@oracle.com
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum attribute
Date:   Tue, 11 Jul 2023 11:53:23 +0200
Message-Id: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attribute is enum type and marked as multi-attr, the netlink respond
is not parsed, fails with stack trace:
File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 600, in dump
  return self._op(method, vals, dump=True)
File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 586, in _op
  rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 453, in _decode
  self._decode_enum(rsp, attr_spec)
File "/root/arek/linux-dpll/tools/net/ynl/lib/ynl.py", line 410, in _decode_enum
  value = enum.entries_by_val[raw - i].name
TypeError: unsupported operand type(s) for -: 'list' and 'int'
error: 1

Allow succesfull parse of multi-attr enums by decoding and assigning their
names into response in the _decode_enum(..) function.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/lib/ynl.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 3b343d6cbbc0..553d82dd6382 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -407,7 +407,14 @@ class YnlFamily(SpecFamily):
                 raw >>= 1
                 i += 1
         else:
-            value = enum.entries_by_val[raw - i].name
+            if attr_spec.is_multi:
+                for index in range(len(raw)):
+                    if (type(raw[index]) == int):
+                        enum_name = enum.entries_by_val[raw[index] - i].name
+                        rsp[attr_spec['name']][index] = enum_name
+                return
+            else:
+                value = enum.entries_by_val[raw - i].name
         rsp[attr_spec['name']] = value
 
     def _decode_binary(self, attr, attr_spec):
-- 
2.37.3

