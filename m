Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCA62E1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiKQQ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiKQQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129C7EC9D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668702199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cyDL4+z/yermooQ3P75yfpkM/v8t6MVyClGTSqgleeQ=;
        b=CwRrfcXGY9umpgIMoNjiAOAT06/TlhUMj87DU60Of2ifJBuQBDBjS32fDXoZkdU0F8yD1u
        zTkir8/KR2W0P7D1SFK+AFeMrIGniPcBTxamBM/iyeMevLNCBqaPjoz06onldJHy0rHwIs
        SgCnkW4v5kBKJbhg1Twx1uhFKKelmeY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-46Ska1MxOYmQVzB_nlcx0A-1; Thu, 17 Nov 2022 11:23:15 -0500
X-MC-Unique: 46Ska1MxOYmQVzB_nlcx0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1CBE858F13;
        Thu, 17 Nov 2022 16:23:14 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-237.bos.redhat.com [10.18.17.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A34202166B46;
        Thu, 17 Nov 2022 16:23:14 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, pauld@redhat.com
Subject: [PATCH] coretemp: Check for null before removing sysfs attrs
Date:   Thu, 17 Nov 2022 11:23:13 -0500
Message-Id: <20221117162313.3164803-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If coretemp_add_core() gets an error then pdata->core_data[indx]
is already NULL and has been kfreed. Don't pass that to
sysfs_remove_group() as that will crash in sysfs_remove_group().

[Shortened for readability]
[91854.020159] sysfs: cannot create duplicate filename '/devices/platform/coretemp.0/hwmon/hwmon2/temp20_label'
<cpu offline>
[91855.126115] BUG: kernel NULL pointer dereference, address: 0000000000000188
[91855.165103] #PF: supervisor read access in kernel mode
[91855.194506] #PF: error_code(0x0000) - not-present page
[91855.224445] PGD 0 P4D 0
[91855.238508] Oops: 0000 [#1] PREEMPT SMP PTI
...
[91855.342716] RIP: 0010:sysfs_remove_group+0xc/0x80
...
[91855.796571] Call Trace:
[91855.810524]  coretemp_cpu_offline+0x12b/0x1dd [coretemp]
[91855.841738]  ? coretemp_cpu_online+0x180/0x180 [coretemp]
[91855.871107]  cpuhp_invoke_callback+0x105/0x4b0
[91855.893432]  cpuhp_thread_fun+0x8e/0x150
...

Fix this by checking for NULL first.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: linux-hwmon@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 8bf32c6c85d9..30a19d711f89 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -533,6 +533,10 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
 {
 	struct temp_data *tdata = pdata->core_data[indx];
 
+	/* if we errored on add then this is already gone */
+	if (!tdata)
+		return;
+
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-- 
2.31.1

