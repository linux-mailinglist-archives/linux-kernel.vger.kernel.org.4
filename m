Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F172228C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjFEJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFEJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:48:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E12BD;
        Mon,  5 Jun 2023 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685958495; x=1717494495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5BHkuJL29yFojqC18SXx1Au4LfrMLiOdhfB3KfcEDlI=;
  b=bo6P382Fd3V8TOxHVNV0qBDa7iDs+se9mmxmaLvyeNVpcFwq3bVgSP6z
   LAdMb5hLJMgJDyARrDWcfx/MIZkiXbIem6EztdyF6X9y0dFdty5fnmPEM
   2Xcy9YDQE8OezkE7UnJBGzcdMc1e+1VD6TrQxrnoCMGRVB0eFWDyxqS6d
   ouDB6Q4MLQnTKyTiMal5+GXDibKBMvSOWXFJeGV0+85a45emLoxmuI0I8
   y7RwD5m2AnWnRpBQMERdeKsCp/N6y81FFWx2Wy88rxBAUtHuIbO/GBGdb
   1RWjQnnWolv6K/FoTuD/Dw1iFUklW23gVnha7VBf4EKKtC+5g2Sb9oaAz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="419873411"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="419873411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 02:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="659020263"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="659020263"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orsmga003.jf.intel.com with ESMTP; 05 Jun 2023 02:48:12 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, chuck.lever@oracle.com
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH 66/69] ynl: fix nested policy attribute type
Date:   Mon,  5 Jun 2023 11:46:17 +0200
Message-Id: <20230605094617.3564079-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nested attribute is used, generated type in the netlink policy
is NLA_NEST, which is wrong as there is no such type. Fix be adding
`ed` sufix for policy generated for 'nest' type attribute.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 tools/net/ynl/ynl-gen-c.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 28afb0846143..89603866d4a0 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -113,7 +113,10 @@ class Type(SpecAttr):
         return '{ .type = ' + policy + ', }'
 
     def attr_policy(self, cw):
-        policy = c_upper('nla-' + self.attr['type'])
+        if (self.attr['type'] == 'nest'):
+            policy = c_upper('nla-' + self.attr['type'] + 'ed')
+        else:
+            policy = c_upper('nla-' + self.attr['type'])
 
         spec = self._attr_policy(policy)
         cw.p(f"\t[{self.enum_name}] = {spec},")
-- 
2.31.1

