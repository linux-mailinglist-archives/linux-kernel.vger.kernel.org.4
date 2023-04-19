Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795D6E7587
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjDSIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjDSIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:41:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4E7685
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:41:41 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q1Z4c2tXtz8xNb;
        Wed, 19 Apr 2023 16:40:48 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Apr
 2023 16:41:39 +0800
Message-ID: <365eddac-2d20-4f8d-072a-f868c4398a9e@huawei.com>
Date:   Wed, 19 Apr 2023 16:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230309114919.63973-1-xiafukun@huawei.com>
 <ZAnTxeyk3PhPFAww@kroah.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <ZAnTxeyk3PhPFAww@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/9 20:40, Greg KH wrote:>>
>> Modify the judgment logic in line 87. If the length of the string
>> kobject_actions[action] is greater than count_first(e.g. buf is "off",
>> count is 3), continue the loop.
>> Otherwise, the match is considered successful.
>>
>> This change means that our test case will be successfully parsed as an
>> offline event and no out-of-bounds access error will occur.
> 
> Yes, but what other test cases did you run on this to verify it works?
> Given that your previous version broke previously working inputs I need
> a lot of validation and proof that this change will also not break
> anything.
> 

> 
> I'm sorry, but as I said before, I'm still not convinced that this is
> correct.  Why does this solve the problem?  Shouldn't the length check
> come before we try to compare the string so that strncmp() doesn't have
> to give a false-positive if the string is too small?
> 

The string "buf" needs to be compared in sequence with the string array
defined below to confirm a match with one of them, and the length of these
strings ranges from 3 to 7. Checking the length of "buf" in advance still
cannot avoid the situation mentioned in this patch(e.g. buf is "off",count is 3)

static const char *kobject_actions[] = {
	[KOBJ_ADD] =		"add",
	[KOBJ_REMOVE] =		"remove",
	[KOBJ_CHANGE] =		"change",
	[KOBJ_MOVE] =		"move",
	[KOBJ_ONLINE] =		"online",
	[KOBJ_OFFLINE] =	"offline",
	[KOBJ_BIND] =		"bind",
	[KOBJ_UNBIND] =		"unbind",
};

> And really, this whole function is very hard to follow, is there any
> chance you can refactor it to be more obviously correct and readable?
> What about taking advantage of the well-tested string functions we
> already have for parsing sysfs inputs, like sysfs_match_string()?
> 

As for using sysfs_match_string() to refactor this code,
do you think whether the following modification methods are suitable and clear?

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..5fce99c3cb8b 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -66,7 +66,7 @@ static int kobject_action_type(const char *buf, size_t count,
        enum kobject_action action;
        size_t count_first;
        const char *args_start;
-       int ret = -EINVAL;
+       int i, ret = -EINVAL;

        if (count && (buf[count-1] == '\n' || buf[count-1] == '\0'))
                count--;
@@ -81,17 +81,16 @@ static int kobject_action_type(const char *buf, size_t count,
        } else
        } else
                count_first = count;

-       for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
-               if (strncmp(kobject_actions[action], buf, count_first) != 0)
-                       continue;
-               if (kobject_actions[action][count_first] != '\0')
-                       continue;
-               if (args)
-                       *args = args_start;
-               *type = action;
-               ret = 0;
-               break;
-       }
+    /* Use sysfs_match_string() to replace the fragile and convoluted loop */
+       i = sysfs_match_string(kobject_actions, buf);
+       if (i < 0)
+               return ret;
+       action = kobject_action(i);
+       if (args)
+               *args = args_start;
+       *type = action;
+       ret = 0;
+
 out:
        return ret;
 }

> thanks,
> 
> greg k-h

Also, I apologize for my previous top-posting behavior.
Considering that I am a novice in the kernel field,
I hope you can forgive me a lot.
