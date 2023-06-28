Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7A740857
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjF1C1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjF1C1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9D30F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687919170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8muOLQZOqYIt0AXw5AwHSZNzvtGahSAcJ6J89ycjrQY=;
        b=RY2BkXOrev2o6EFWwe7z6r5z7cyNfA/fzHCDuEK7yed9UlOt55ztd6cO0RVE2Pr8hPuK4q
        1PrEI7rX0DSfsa2WXj1+PF+1L4QX3ufpDbHQuI44qWwb/jLfAXXrmV5RRGav7X/Ak9FLOw
        6FdQm6ej0kzfVTXsxl+rYQJp0AA14ng=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-dHO9L9VOPSKr01eVYl-oxg-1; Tue, 27 Jun 2023 22:26:06 -0400
X-MC-Unique: dHO9L9VOPSKr01eVYl-oxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2467380662D;
        Wed, 28 Jun 2023 02:26:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F129B200BA86;
        Wed, 28 Jun 2023 02:26:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/4] intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
Date:   Tue, 27 Jun 2023 22:25:53 -0400
Message-Id: <20230628022554.1638318-4-longman@redhat.com>
In-Reply-To: <20230628022554.1638318-1-longman@redhat.com>
References: <20230628022554.1638318-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to 0
in order disable IBRS. However, the new MSR value isn't reflected in
x86_spec_ctrl_current which is at odd with the other code that keep track
of its state in that percpu variable.  Use the new __update_spec_ctrl()
to have the x86_spec_ctrl_current percpu value properly updated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 34201d7ef33e..e32ff09051af 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -182,12 +182,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		__update_spec_ctrl(0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		__update_spec_ctrl(spec_ctrl);
 
 	return ret;
 }
-- 
2.31.1

