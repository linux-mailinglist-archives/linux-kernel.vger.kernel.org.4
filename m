Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059B9688C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBCBfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBCBff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:35:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C39841A0;
        Thu,  2 Feb 2023 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675388134; x=1706924134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=71piuBCEe2+vVRwtacCxx8j39fJadVo2ugu2BE7Iu/4=;
  b=UvpZVXcVPellXE/DBbyOa8H/FEkvigWvHkr6CAR449zS2MnS2/x/5nUa
   k26BkvFvQtG5JxGEuYmGA1FRTRW9XzIoSFZcMm5UWgFKQisLll2K7z0xn
   idLmzESMSStjIhlN1A7ylePg8rTmvdLn36gsXj5Z8MLO/hf9mNmiF+wEI
   iU31ZT7PxL0TX6iWOq/Jw1qaZ8BZBEaa4zE2EsYKQHywrYl9pgusA0vRw
   g+d4jnb2udm2UU+AFE37vw9jKSogYf4XMpqC8SMqqvf7VrUccEmRgC9ER
   tyaxWQkq2InYW/TjvYGBUgpcCyNg9iAbDPuC/HfQiEX4/HUAaINdP+zaw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="414836810"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="414836810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:35:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697900501"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="697900501"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:35:15 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcutorture: Create nocb tasks only for CONFIG_RCU_NOCB_CPU=y kernels
Date:   Fri,  3 Feb 2023 09:40:21 +0800
Message-Id: <20230203014021.3408798-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
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

When setting nocbs_nthreads to start rcutorture test with a non-zero value,
the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=n
kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
meaningless for torture_type is non-rcu.

This commit therefore add member can_nocbs_toggle to rcu_torture_ops
structure to avoid unnecessary nocb tasks creation.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 297da28ce92d..d01127e0e8cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3708,6 +3708,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.25.1

