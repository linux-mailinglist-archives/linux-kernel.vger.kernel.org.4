Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8994560F346
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiJ0JLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiJ0JK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529214009
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A855B82558
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C682C433C1;
        Thu, 27 Oct 2022 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861822;
        bh=icNef8V1Wwx19GOqo5GRCHNJaynBT3OZ8JCWz9XdCL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWIGtmJNdolosGku/LZRDxMGIjCIlfsFvnMMxjTsdJpwXJWWXeD0NRotiRngDYccd
         5rMlKB2aT2QXDc1buosX9Wq3hvP1huAKAYTtYXUWm8abhVgdNA5DWrvwMIxSr13E6p
         OBwvYOkgmqvktRyIq6doMXR81hJao7cA5A7RDW90noXkLgnzrUj/HqHXyVGaR0oAI+
         Yl1KiVODNGsEJ3t9gUvcn4NmnPl+RKiWl6ugFMpPPW6ghsUiZdQfYHw3KdmOpnfPhX
         sfkQyQJzb/hYF6q9GlJmffbfKlPUOIRwPQZcqwxgeEs/Svbcfemjg2q5QedXEUAPXa
         0jFqcHxOAET4A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/15] habanalabs: add an option to control watchdog timeout via debugfs
Date:   Thu, 27 Oct 2022 12:09:59 +0300
Message-Id: <20221027091007.664797-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add an option to control the timeout value for the driver's watchdog
of the reset process. The timeout represents the amount of the user
has to close his process once he gets a device reset notification from
the driver.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 7 +++++++
 drivers/misc/habanalabs/common/debugfs.c            | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index c915bf17b293..85f6d04f528b 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -91,6 +91,13 @@ Description:    Enables the root user to set the device to specific state.
                 Valid values are "disable", "enable", "suspend", "resume".
                 User can read this property to see the valid values
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/device_release_watchdog_timeout
+Date:           Oct 2022
+KernelVersion:  6.2
+Contact:        ttayar@habana.ai
+Description:    The watchdog timeout value in seconds for a device relese upon
+                certain error cases, after which the device is reset.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/dma_size
 Date:           Apr 2021
 KernelVersion:  5.13
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 48d3ec8b5c82..945c0e6758ca 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1769,6 +1769,11 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_timeout_locked_fops);
 
+	debugfs_create_u32("device_release_watchdog_timeout",
+				0644,
+				dev_entry->root,
+				&hdev->device_release_watchdog_timeout_sec);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
-- 
2.25.1

