Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E37113C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjEYSch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbjEYSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E0E4F;
        Thu, 25 May 2023 11:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604DB6487C;
        Thu, 25 May 2023 18:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03418C433D2;
        Thu, 25 May 2023 18:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039538;
        bh=HoD8pfnSJ9bfKM/4PbrabivCPKLDimTR4j8uvKoaaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIl5viWTcT3sM9QJ1uQDIfr15Y5ZodWe6RL1GZ1+/jHqOkQoViLluXf2JDNapYxQs
         WlpBxczvyNiIrZlNKxC+XojnFUOGg+Q40S0CH+yjGkqFId69Mfs/1w9hrm2Xlev+o2
         6qDKoQE3UQmg6bjsxvpQa7xheumSmdxZgX8EhQ+FveMtlcUfphUpLVnftgZWtAUbls
         KxgLDQEbaLMHN58Yxmua6H7VX3N/VTovMGwERmFuFP7IOwLQ+aB4exErCPMgFlR8HQ
         wtTvJMBAvvF7rWxU8wu4AKOGrlKtlCesxjf//aoaSzrUWwCIkIzdaN4c7OVgjd1skA
         79xuwVXecgBdA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, trenn@suse.com,
        shuah@kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 06/67] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Thu, 25 May 2023 14:30:43 -0400
Message-Id: <20230525183144.1717540-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit e652be0f59d4ba4d5c636b1f7f4dcb73aae049fa ]

The sysfs_get_enabled() opened file processor not closed,
may cause a file handle leak.
Putting error handling and resource cleanup code together
makes the code easy to maintain and read.
Removed the unnecessary else if branch from the original
function, as it should return an error in cases other than '0'.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/lib/powercap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 0ce29ee4c2e46..a7a59c6bacda8 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -40,25 +40,34 @@ static int sysfs_get_enabled(char *path, int *mode)
 {
 	int fd;
 	char yes_no;
+	int ret = 0;
 
 	*mode = 0;
 
 	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return -1;
+	if (fd == -1) {
+		ret = -1;
+		goto out;
+	}
 
 	if (read(fd, &yes_no, 1) != 1) {
-		close(fd);
-		return -1;
+		ret = -1;
+		goto out_close;
 	}
 
 	if (yes_no == '1') {
 		*mode = 1;
-		return 0;
+		goto out_close;
 	} else if (yes_no == '0') {
-		return 0;
+		goto out_close;
+	} else {
+		ret = -1;
+		goto out_close;
 	}
-	return -1;
+out_close:
+	close(fd);
+out:
+	return ret;
 }
 
 int powercap_get_enabled(int *mode)
-- 
2.39.2

