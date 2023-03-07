Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C06AD782
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCGGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCGGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:40:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBC59E5C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:40:01 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PW5MX480gzSkNx;
        Tue,  7 Mar 2023 14:36:56 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 14:39:59 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <gregkh@linuxfoundation.org>, <prajnoha@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH] kobject: Fix global-out-of-bounds in kobject_action_type()
Date:   Tue, 7 Mar 2023 14:37:57 +0800
Message-ID: <20230307063757.247430-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
    int len = 0x56;

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

Modify the comparison logic to determine whether count_first is equal to
the length of string kobject_actions[action]. This can fix the problem.

Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..668346bd28fa 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -84,7 +84,7 @@ static int kobject_action_type(const char *buf, size_t count,
 	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
 		if (strncmp(kobject_actions[action], buf, count_first) != 0)
 			continue;
-		if (kobject_actions[action][count_first] != '\0')
+		if (strlen(kobject_actions[action]) != count_first)
 			continue;
 		if (args)
 			*args = args_start;
-- 
2.17.1

