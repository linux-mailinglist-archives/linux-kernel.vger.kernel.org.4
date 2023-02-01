Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FDA686159
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjBAINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBAINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:13:40 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252E2DE5E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:13:37 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id XCP00028;
        Wed, 01 Feb 2023 16:13:28 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.16; Wed, 1 Feb 2023 16:13:30 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] bus: fsl-mc: convert sysfs snprintf and sprintf to sysfs_emit
Date:   Wed, 1 Feb 2023 03:13:25 -0500
Message-ID: <20230201081325.3076-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2023201161328752161c5949808f696663622567243de
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 36cb091a33b4..94facaedf0b5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -174,7 +174,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
+	return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
 		       mc_dev->obj_desc.type);
 }
 static DEVICE_ATTR_RO(modalias);
@@ -201,7 +201,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.27.0

