Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E686B2370
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCILvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCILva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:51:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A90E775A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:51:22 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PXSDT3BPRzfZ5S;
        Thu,  9 Mar 2023 19:50:33 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 9 Mar
 2023 19:51:20 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <gregkh@linuxfoundation.org>, <prajnoha@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH v3] kobject: Fix global-out-of-bounds in kobject_action_type()
Date:   Thu, 9 Mar 2023 19:49:19 +0800
Message-ID: <20230309114919.63973-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Modify the judgment logic in line 87. If the length of the string
kobject_actions[action] is greater than count_first(e.g. buf is "off",
count is 3), continue the loop.
Otherwise, the match is considered successful.

This change means that our test case will be successfully parsed as an
offline event and no out-of-bounds access error will occur.

Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
v2 -> v3:
- only declare that it is the latest version of the patch, no change

v1 -> v2:
- modify the matching logic

 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..474f996895c7 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -84,7 +84,7 @@ static int kobject_action_type(const char *buf, size_t count,
 	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
 		if (strncmp(kobject_actions[action], buf, count_first) != 0)
 			continue;
-		if (kobject_actions[action][count_first] != '\0')
+		if (strlen(kobject_actions[action]) > count_first)
 			continue;
 		if (args)
 			*args = args_start;
-- 
2.17.1

