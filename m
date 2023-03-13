Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18BA6B80A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCMSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCMSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C225B81;
        Mon, 13 Mar 2023 11:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EA29B811E0;
        Mon, 13 Mar 2023 18:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C7EC4339C;
        Mon, 13 Mar 2023 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732204;
        bh=7dR6cgnoc5L5P7fViXWBZ/SR4m9IirhaXpa6nNyHMUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HRDHQyIUW6F//NrwkovKrkyEyPTWHsGMf1FPjZf6MyMnk7UjvPitAncqoHS9PtjS
         lJKQXZcblP9+4QO2xqW3MTrVU9mlJ5RkjHDdX77pKt2KVCEEQ/DDVdKiOhEWEdmqyl
         S0GXPBaMO3REmPNhZO/0K1POiRfFkPtpc1QkxgEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 05/36] platform/x86: intel-uncore-freq: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:28:47 +0100
Message-Id: <20230313182918.1312597-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=gregkh@linuxfoundation.org; h=from:subject; bh=7dR6cgnoc5L5P7fViXWBZ/SR4m9IirhaXpa6nNyHMUE=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82WVuLWdOs8k7r5U84VfcscL86aEZjNVOp2KM6q99D awQvnOjI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbCZcUwP+3jldVJH+buKn/1 qdlTKcqyi73eh2HBMccEJ+bJ+zIUq998O9e2z+iRY95zAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 .../intel/uncore-frequency/uncore-frequency-common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index cb24de9e97dc..1a300e14f350 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -224,9 +224,15 @@ int uncore_freq_common_init(int (*read_control_freq)(struct uncore_data *data, u
 	uncore_write = write_control_freq;
 	uncore_read_freq = read_freq;
 
-	if (!uncore_root_kobj)
-		uncore_root_kobj = kobject_create_and_add("intel_uncore_frequency",
-							    &cpu_subsys.dev_root->kobj);
+	if (!uncore_root_kobj) {
+		struct device *dev_root = bus_get_dev_root(&cpu_subsys);
+
+		if (dev_root) {
+			uncore_root_kobj = kobject_create_and_add("intel_uncore_frequency",
+								  &dev_root->kobj);
+			put_device(dev_root);
+		}
+	}
 	if (uncore_root_kobj)
 		++uncore_instance_count;
 	mutex_unlock(&uncore_lock);
-- 
2.39.2

