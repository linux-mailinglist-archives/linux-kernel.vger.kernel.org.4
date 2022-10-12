Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7905FC38C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJLKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJLKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:11:30 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6772BC09A4;
        Wed, 12 Oct 2022 03:10:47 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5FD6D1E80D32;
        Wed, 12 Oct 2022 18:10:56 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ObQc2tPT1UaK; Wed, 12 Oct 2022 18:10:53 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id ABD711E80D6E;
        Wed, 12 Oct 2022 18:10:53 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     trenn@suse.com, shuah@kernel.org, ray.huang@amd.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] power: cpupower: utils: Optimize print_online_cpus and print_offline_cpus function
Date:   Wed, 12 Oct 2022 18:10:39 +0800
Message-Id: <20221012101039.3142-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Remove the initialization assignment of variables, and they will be
assigned first.
2. Remove the mandatory conversion of returned value of malloc function,
which returns void* type.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..36dbd0562240 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -134,11 +134,11 @@ void get_cpustate(void)
  */
 void print_online_cpus(void)
 {
-	int str_len = 0;
-	char *online_cpus_str = NULL;
+	int str_len;
+	char *online_cpus_str;
 
 	str_len = online_cpus->size * 5;
-	online_cpus_str = (void *)malloc(sizeof(char) * str_len);
+	online_cpus_str = malloc(sizeof(char) * str_len);
 
 	if (!bitmask_isallclear(online_cpus)) {
 		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
@@ -152,11 +152,11 @@ void print_online_cpus(void)
  */
 void print_offline_cpus(void)
 {
-	int str_len = 0;
-	char *offline_cpus_str = NULL;
+	int str_len;
+	char *offline_cpus_str;
 
 	str_len = offline_cpus->size * 5;
-	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
+	offline_cpus_str = malloc(sizeof(char) * str_len);
 
 	if (!bitmask_isallclear(offline_cpus)) {
 		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
-- 
2.18.2

