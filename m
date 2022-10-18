Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E0602075
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJRBcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJRBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:32:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51AD88;
        Mon, 17 Oct 2022 18:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666056770; x=1697592770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HU32EIXN4wgKHTDbR87eVWv30iu9Y/xR0IE3CNJy6TU=;
  b=FkCoaLILXtiWxzkcweXlG4iLlbrBtpyQPYYIUM96XWjTU6aZI6MKtIYN
   syAPf1spXfqRzq9MB3prPfSUHtx+DFPMqGnbBM+Qw9iDiomehvWNWTnYn
   MnIhLDrf0Ss0MlDqtX0riqrB1LjwJPky3VQuEfOhJoSz6zs8DQ3ICiuPs
   4h84lddVQMD26cbD9X9ehNKOUt0TGwBQR57tTOHa1HpxAygRuc7R5fsYg
   l023NO8X9S4fzCu9XJU7d3VQ2WCCph8L4QTA52MPpJNYAyB1p/gn5bCRL
   V1LO/FJGdCHQuVU5w3+sq46nShPRPcZg9kYLwX4vTySuCkVEvhEE3zaaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392267428"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392267428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:32:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="770986851"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="770986851"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 18:32:49 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Date:   Tue, 18 Oct 2022 09:39:06 +0800
Message-Id: <20221018013906.3890007-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable CONFIG_PROVE_RCU and built modules, the following
error appear:

ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!

This commit fix it by exporting the srcu_check_nmi_safety().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 382236dd5e46..bcd629f5f902 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 	}
 	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
 }
+EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
 #endif /* CONFIG_PROVE_RCU */
 
 /*
-- 
2.25.1

