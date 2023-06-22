Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9537393E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFVAhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFVAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE21996
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687394208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnY7DyJzG9u4tj8u43HUsl2yxKZDOEzNFGoyTY9ZN9E=;
        b=JDLg7nKdQKg/0qSrLO2QEDbLWQGp4BimwcVoFEoMPfXVoaMx4FYSpelqQJkzTMaBCbm5pa
        hJgkh2NWpla+DGyVaTxFPCfzbJrPwBdjv2Nl7/i3GkPAxUfwC+Dp+zyd4WhR0m0JxanbgI
        Aib0xdpKIVBy5zHXaMrpwknFi8RBgYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-8lweGLeKPVGsRXDFNdxTew-1; Wed, 21 Jun 2023 20:36:44 -0400
X-MC-Unique: 8lweGLeKPVGsRXDFNdxTew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9663B805AF6;
        Thu, 22 Jun 2023 00:36:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1D12112132C;
        Thu, 22 Jun 2023 00:36:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to x86_spec_ctrl_current
Date:   Wed, 21 Jun 2023 20:36:02 -0400
Message-Id: <20230622003603.1188364-3-longman@redhat.com>
In-Reply-To: <20230622003603.1188364-1-longman@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
0 in order disable IBRS. However, the new MSR value isn't reflected
in x86_spec_ctrl_current which is at odd with the other code that
keep track of its state in that percpu variable. Fix that by updating
x86_spec_ctrl_current percpu value to always match the content of the
SPEC_CTRL MSR.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/idle/intel_idle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index aa2d19db2b1d..07fa23707b3c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -181,13 +181,17 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	u64 spec_ctrl = spec_ctrl_current();
 	int ret;
 
-	if (smt_active)
+	if (smt_active) {
+		__this_cpu_write(x86_spec_ctrl_current, 0);
 		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 
 	ret = __intel_idle(dev, drv, index);
 
-	if (smt_active)
+	if (smt_active) {
 		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		__this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
+	}
 
 	return ret;
 }
-- 
2.31.1

