Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F136C777F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCXFsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCXFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:48:19 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F396AC65B;
        Thu, 23 Mar 2023 22:48:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BD26B1A00993;
        Fri, 24 Mar 2023 13:48:21 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0jiyeAf8B0HH; Fri, 24 Mar 2023 13:48:21 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B64651A00931;
        Fri, 24 Mar 2023 13:48:20 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] base: power: main: remove unnecessary (void*) conversions
Date:   Sun, 26 Mar 2023 06:19:35 +0800
Message-Id: <20230325221935.3943-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=3.8 required=5.0 tests=DATE_IN_FUTURE_24_48,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/base/power/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c50139207794..f85f3515c258 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -679,7 +679,7 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = device_resume_noirq(dev, pm_transition, true);
@@ -816,7 +816,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 
 static void async_resume_early(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = device_resume_early(dev, pm_transition, true);
@@ -980,7 +980,7 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 static void async_resume(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = device_resume(dev, pm_transition, true);
@@ -1269,7 +1269,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_noirq(dev, pm_transition, true);
@@ -1450,7 +1450,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_late(dev, pm_transition, true);
@@ -1727,7 +1727,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 
 static void async_suspend(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend(dev, pm_transition, true);
-- 
2.18.2

