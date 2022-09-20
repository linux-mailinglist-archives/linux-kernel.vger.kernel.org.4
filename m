Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4245BEB27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiITQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiITQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C296524F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F6962531
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7527C433D6;
        Tue, 20 Sep 2022 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663691743;
        bh=JiNzQhM8XzlrvxmA7lqX26ZtzWbfBJDZDlyLQ9Qps18=;
        h=From:To:Cc:Subject:Date:From;
        b=YqpKN9GhTuuH+yIaqEDa8uj1XIs7MEP138xHrkoiOoLyVcspLWFdDowIyvQUtWJdZ
         6g2BtI6rF/snTRU9p4UWEG7NpLv4Z6XzpyQk9LTyN8BjmjIpmQmMyiPGjVaoiLOuqU
         zEzWgi6FI8HcK7KLA1HUbPwfX2u8w2ZhKHHiGtbtSmMSthOedHFEAhJnH3Kat5BbPT
         FP7Z54H4JUOcZMVrsIGNKruUVAAivBNJZgIr/lxhZ+45+lkqjA1oPImy7tf6yv/5V9
         dSCZz3Sz7u5Mai4BlYgO1WHmidpK+ibmqgUIorEKPmpt3up2AxSG1R/hxPbY/I+0c+
         oNvoBwR1Z4LGw==
From:   SeongJae Park <sj@kernel.org>
To:     sj@kernel.org
Cc:     Xin Hao <xhao@linux.alibaba.com>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/damon/sysfs: return 'err' value when call kstrtoul() failed
Date:   Tue, 20 Sep 2022 16:35:30 +0000
Message-Id: <20220920025158.70293-1-xhao@linux.alibaba.com> (raw)
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Hao <xhao@linux.alibaba.com>

We had better return the 'err' value when calling kstrtoul() failed, so
the user will know why it really fails, there do little change, let it
return the 'err' value when failed.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>

---
Changes from v2
(https://lore.kernel.org/damon/20220920025158.70293-1-xhao@linux.alibaba.com/)
- Move patch changelog outside of the commit message area

Changes from v1
(https://lore.kernel.org/linux-mm/20220919170305.61335-1-sj@kernel.org/T/)
- keep the 'err' variable, and return the 'err' value when failed.

 mm/damon/sysfs.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0cca1909bf67..455215a5c059 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -58,7 +58,7 @@ static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,

 	err = kstrtoul(buf, 0, &min);
 	if (err)
-		return -EINVAL;
+		return err;

 	range->min = min;
 	return count;
@@ -83,7 +83,7 @@ static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,

 	err = kstrtoul(buf, 0, &max);
 	if (err)
-		return -EINVAL;
+		return err;

 	range->max = max;
 	return count;
@@ -291,9 +291,7 @@ static ssize_t interval_us_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->interval_us);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t high_show(struct kobject *kobj,
@@ -312,9 +310,7 @@ static ssize_t high_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->high);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t mid_show(struct kobject *kobj,
@@ -333,9 +329,7 @@ static ssize_t mid_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->mid);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t low_show(struct kobject *kobj,
@@ -354,9 +348,7 @@ static ssize_t low_store(struct kobject *kobj,
 			struct damon_sysfs_watermarks, kobj);
 	int err = kstrtoul(buf, 0, &watermarks->low);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_watermarks_release(struct kobject *kobj)
@@ -437,9 +429,7 @@ static ssize_t sz_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->sz);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t nr_accesses_permil_show(struct kobject *kobj,
@@ -458,9 +448,7 @@ static ssize_t nr_accesses_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->nr_accesses);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t age_permil_show(struct kobject *kobj,
@@ -479,9 +467,7 @@ static ssize_t age_permil_store(struct kobject *kobj,
 			struct damon_sysfs_weights, kobj);
 	int err = kstrtouint(buf, 0, &weights->age);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_weights_release(struct kobject *kobj)
@@ -1111,9 +1097,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_region, kobj);
 	int err = kstrtoul(buf, 0, &region->start);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1132,9 +1116,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_region, kobj);
 	int err = kstrtoul(buf, 0, &region->end);

-	if (err)
-		return -EINVAL;
-	return count;
+	return err ? err : count;
 }

 static void damon_sysfs_region_release(struct kobject *kobj)
@@ -1528,7 +1510,7 @@ static ssize_t sample_us_store(struct kobject *kobj,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->sample_us = us;
 	return count;
@@ -1552,7 +1534,7 @@ static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->aggr_us = us;
 	return count;
@@ -1576,7 +1558,7 @@ static ssize_t update_us_store(struct kobject *kobj,
 	int err = kstrtoul(buf, 0, &us);

 	if (err)
-		return -EINVAL;
+		return err;

 	intervals->update_us = us;
 	return count;
--
2.31.0
