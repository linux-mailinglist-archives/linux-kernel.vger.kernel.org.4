Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8FF5FE7FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJNE3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJNE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:29:17 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4430A19C07E;
        Thu, 13 Oct 2022 21:29:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E95FF1E80D6E;
        Fri, 14 Oct 2022 12:29:10 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g1NBD0ZV7jeF; Fri, 14 Oct 2022 12:29:08 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 376C01E80D53;
        Fri, 14 Oct 2022 12:29:08 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     shuah@kernel.org
Cc:     trenn@suse.com, ray.huang@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] power: cpupower: utils: Add malloc return value check
Date:   Fri, 14 Oct 2022 12:29:11 +0800
Message-Id: <20221014042911.298308-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check and judgment statement of malloc return value.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 tools/power/cpupower/utils/helpers/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 9547b29254a7..eafdbd6d760c 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -139,6 +139,8 @@ void print_online_cpus(void)
 
 	str_len = online_cpus->size * 5;
 	online_cpus_str = (void *)malloc(sizeof(char) * str_len);
+	if (unlikely(!online_cpus_str))
+		return;
 
 	if (!bitmask_isallclear(online_cpus)) {
 		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
@@ -157,6 +159,8 @@ void print_offline_cpus(void)
 
 	str_len = offline_cpus->size * 5;
 	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
+	if (unlikely(!offline_cpus_str))
+		return;
 
 	if (!bitmask_isallclear(offline_cpus)) {
 		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
-- 
2.18.2

