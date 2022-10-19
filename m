Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BAB6037A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJSBqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJSBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:46:33 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8811989CFF;
        Tue, 18 Oct 2022 18:46:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 08FDF1E80D90;
        Wed, 19 Oct 2022 09:45:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pZUlp8UY5es3; Wed, 19 Oct 2022 09:45:38 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 37E811E80D76;
        Wed, 19 Oct 2022 09:45:38 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     shuah@kernel.org, trenn@suse.com
Cc:     ray.huang@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [v2 PATCH] power: cpupower: utils: Add malloc return value check
Date:   Wed, 19 Oct 2022 09:46:14 +0800
Message-Id: <20221019014614.3120-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check and judgment statement of malloc return value.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 v2: Remove unlikely() check

 tools/power/cpupower/utils/helpers/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 36dbd0562240..083d5a6bb74e 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -139,6 +139,8 @@ void print_online_cpus(void)
 
 	str_len = online_cpus->size * 5;
 	online_cpus_str = malloc(sizeof(char) * str_len);
+	if (!online_cpus_str)
+		return;
 
 	if (!bitmask_isallclear(online_cpus)) {
 		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
@@ -157,6 +159,8 @@ void print_offline_cpus(void)
 
 	str_len = offline_cpus->size * 5;
 	offline_cpus_str = malloc(sizeof(char) * str_len);
+	if (!offline_cpus_str)
+		return;
 
 	if (!bitmask_isallclear(offline_cpus)) {
 		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
-- 
2.18.2

