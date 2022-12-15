Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23A64DB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLOMrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLOMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCF732B91
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671108246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=f/TLVNnRLwvO822nGsYI0P3m2dy78HMtEXDUfQIOSkg=;
        b=HnyO3gxv0uSR3ZpCOVk8iqg6KIX/G++kh2APi4MnEgAWL8/mwfDr7EtXvxjAHyR/J4E0pq
        1e+OY1NjcsPZ/KL3IpUL9F2zygx2SCxPZRbRM7v2KEab58F1eE6Iu6E9zXdryaJVKb+7SQ
        JkfwcUD0p9I7oCq697O2gU3e8MqlNlE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-w-sJ6HzoN2OKJc2tTi5yEw-1; Thu, 15 Dec 2022 07:43:50 -0500
X-MC-Unique: w-sJ6HzoN2OKJc2tTi5yEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C373806072;
        Thu, 15 Dec 2022 12:43:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E51175AD;
        Thu, 15 Dec 2022 12:43:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E42574041664A; Thu, 15 Dec 2022 09:42:24 -0300 (-03)
Date:   Thu, 15 Dec 2022 09:42:24 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated CPUs
Message-ID: <Y5sWMEG0xCl9bgEi@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The coretemp driver uses rdmsr_on_cpu calls to read
MSR_IA32_PACKAGE_THERM_STATUS/MSR_IA32_THERM_STATUS registers,
which contain information about current core temperature.

For certain low latency applications, the RDMSR interruption exceeds    
the applications requirements.

So disable reading of crit_alarm and temp files via /sys, in case
CPU isolation is enabled.

Temperature information from the housekeeping cores should be
sufficient to infer die temperature.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 9bee4d33fbdf..30a35f4130d5 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -27,6 +27,7 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
+#include <linux/sched/isolation.h>
 
 #define DRVNAME	"coretemp"
 
@@ -121,6 +122,10 @@ static ssize_t show_crit_alarm(struct device *dev,
 	struct platform_data *pdata = dev_get_drvdata(dev);
 	struct temp_data *tdata = pdata->core_data[attr->index];
 
+
+	if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
+		return -EINVAL;
+
 	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 	mutex_unlock(&tdata->update_lock);
@@ -158,6 +163,8 @@ static ssize_t show_temp(struct device *dev,
 
 	/* Check whether the time interval has elapsed */
 	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
+		if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
+			return -EINVAL;
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Ignore the valid bit. In all observed cases the register




