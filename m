Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6504B704DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjEPMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEPMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:38:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CE170E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:38:43 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QLFzf4xH9z18LRM;
        Tue, 16 May 2023 20:34:22 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 20:38:41 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <gregkh@linuxfoundation.org>, <prajnoha@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH v5] kobject: Fix global-out-of-bounds in kobject_action_type()
Date:   Tue, 16 May 2023 20:37:19 +0800
Message-ID: <20230516123719.117137-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following c language code can trigger KASAN's global variable
out-of-bounds access error in kobject_action_type():

int main() {
    int fd;
    char *filename = "/sys/block/ram12/uevent";
    char str[86] = "offline";
    int len = 86;

    fd = open(filename, O_WRONLY);
    if (fd == -1) {
        printf("open");
        exit(1);
    }

    if (write(fd, str, len) == -1) {
        printf("write");
        exit(1);
    }

    close(fd);
    return 0;
}

Function kobject_action_type() receives the input parameters buf and count,
where count is the length of the string buf.

In the use case we provided, count is 86, the count_first is 85.
Buf points to a string with a length of 86, and its first seven
characters are "offline".
In line 87 of the code, kobject_actions[action] is the string "offline"
with the length of 7,an out-of-boundary access will appear:

kobject_actions[action][85].

Use sysfs_match_string() to replace the fragile and convoluted loop.
This function is well-tested for parsing sysfs inputs. Moreover, this
modification will not cause any functional changes.

Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
v4 -> v5:
- Fixed build errors and warnings, and retested the patch.

v3 -> v4:
- Refactor the function to be more obviously correct and readable.
---
 lib/kobject_uevent.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..1ec20a7d3d45 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -64,9 +64,8 @@ static int kobject_action_type(const char *buf, size_t count,
 			       const char **args)
 {
 	enum kobject_action action;
-	size_t count_first;
 	const char *args_start;
-	int ret = -EINVAL;
+	int i, ret = -EINVAL;
 
 	if (count && (buf[count-1] == '\n' || buf[count-1] == '\0'))
 		count--;
@@ -75,23 +74,22 @@ static int kobject_action_type(const char *buf, size_t count,
 		goto out;
 
 	args_start = strnchr(buf, count, ' ');
-	if (args_start) {
-		count_first = args_start - buf;
+	if (args_start)
 		args_start = args_start + 1;
-	} else
-		count_first = count;
 
-	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
-		if (strncmp(kobject_actions[action], buf, count_first) != 0)
-			continue;
-		if (kobject_actions[action][count_first] != '\0')
-			continue;
-		if (args)
-			*args = args_start;
-		*type = action;
-		ret = 0;
-		break;
-	}
+	/* Use sysfs_match_string() to replace the fragile and convoluted loop */
+	i = sysfs_match_string(kobject_actions, buf);
+
+	if (i < 0)
+		return ret;
+
+	action = i;
+
+	if (args)
+		*args = args_start;
+
+	*type = action;
+	ret = 0;
 out:
 	return ret;
 }
-- 
2.17.1

