Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CCF6FE58D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjEJUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjEJUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9D57ED3;
        Wed, 10 May 2023 13:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1E5464081;
        Wed, 10 May 2023 20:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B0DC433D2;
        Wed, 10 May 2023 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751784;
        bh=xKx/R8XJkJRLG03QGYpP8wHeGAmznaHWqdrhoCtth8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPLTH58+285C1f08ONFC70q1BoPYNh2hfGhcStE1RU6VUAjCTK9aRZpkJgIOHtTa/
         AUk99c+0IZbiiPIxLrbjYlBSUF625D0XVgscqE2W7hoZR3fPYknSVs/Nel/u9dQBr9
         GELP/bnlasccwZfGtBmuyqIu0TfHy+5/XCSk9qlXs7Vv3g4rP3OeuhRwe1wpvqfFD0
         NFnUq0It5JxeC6Y+rrQBLhRz37ZCACJkPQmuhhLMasOk+6xLNv2RwjFRAEhIe5b61F
         ioNLh9CIb1Y40duxuTa/dQibATfcEbH2KHDK480i2NtHIfFG7oc1RaV+6qQAhB7PRE
         rpmtbvngFIFkQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.2 5/9] soundwire: bus: Fix unbalanced pm_runtime_put() causing usage count underflow
Date:   Wed, 10 May 2023 16:49:22 -0400
Message-Id: <20230510204926.104747-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510204926.104747-1-sashal@kernel.org>
References: <20230510204926.104747-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit e9537962519e88969f5f69cd0571eb4f6984403c ]

This reverts commit
443a98e649b4 ("soundwire: bus: use pm_runtime_resume_and_get()")

Change calls to pm_runtime_resume_and_get() back to pm_runtime_get_sync().
This fixes a usage count underrun caused by doing a pm_runtime_put() even
though pm_runtime_resume_and_get() returned an error.

The three affected functions ignore -EACCES error from trying to get
pm_runtime, and carry on, including a put at the end of the function.
But pm_runtime_resume_and_get() does not increment the usage count if it
returns an error. So in the -EACCES case you must not call
pm_runtime_put().

The documentation for pm_runtime_get_sync() says:
 "Consider using pm_runtime_resume_and_get() ...  as this is likely to
 result in cleaner code."

In this case I don't think it results in cleaner code because the
pm_runtime_put() at the end of the function would have to be conditional on
the return value from pm_runtime_resume_and_get() at the top of the
function.

pm_runtime_get_sync() doesn't have this problem because it always
increments the count, so always needs a put. The code can just flow through
and do the pm_runtime_put() unconditionally.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230406134640.8582-1-rf@opensource.cirrus.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639e..4fd221d0cc818 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -571,9 +571,11 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nread_no_pm(slave, addr, count, val);
 
@@ -595,9 +597,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
 {
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
+	}
 
 	ret = sdw_nwrite_no_pm(slave, addr, count, val);
 
@@ -1565,9 +1569,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err(&slave->dev, "Failed to resume device: %d\n", ret);
+		pm_runtime_put_noidle(&slave->dev);
 		return ret;
 	}
 
-- 
2.39.2

