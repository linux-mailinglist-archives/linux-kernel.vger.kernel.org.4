Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B8702EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbjEONty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjEONth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:49:37 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866F1BF4;
        Mon, 15 May 2023 06:49:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QKghn6zFFz4f3p1T;
        Mon, 15 May 2023 21:49:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7NoOGJkNcUBJg--.7104S6;
        Mon, 15 May 2023 21:49:31 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH OLK-5.10 v3 2/4] md/raid10: fix overflow in safe_delay_store
Date:   Mon, 15 May 2023 21:48:06 +0800
Message-Id: <20230515134808.3936750-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230515134808.3936750-1-linan666@huaweicloud.com>
References: <20230515134808.3936750-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7NoOGJkNcUBJg--.7104S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZryxtF4UCF1rAF18KrWxWFg_yoW5CFW8pa
        93t34YyrWUJ34SyFs2vF1DWFy5Wrn2qrWUt3y2krWfXFZrXFs0qw1rJF4FvFy5CrWUZF13
        Jr45AFyUur1jvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU89L05UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

There is no input check when echo md/safe_mode_delay and overflow will
occur. There is risk of overflow in strict_strtoul_scaled(), too. Fix it
by using kstrtoul instead of parsing word one by one.

Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 76 +++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e344b4b3444..5bba071ea907 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3767,56 +3767,76 @@ static int analyze_sbs(struct mddev *mddev)
  */
 int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 {
-	unsigned long result = 0;
-	long decimals = -1;
-	while (isdigit(*cp) || (*cp == '.' && decimals < 0)) {
-		if (*cp == '.')
-			decimals = 0;
-		else if (decimals < scale) {
-			unsigned int value;
-			value = *cp - '0';
-			result = result * 10 + value;
-			if (decimals >= 0)
-				decimals++;
-		}
-		cp++;
-	}
-	if (*cp == '\n')
-		cp++;
-	if (*cp)
+	unsigned long result = 0, decimals = 0;
+	char *pos, *str;
+	int rv;
+
+	str = kmemdup_nul(cp, strlen(cp), GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	pos = strchr(str, '.');
+	if (pos) {
+		int cnt = scale;
+
+		*pos = '\0';
+		while (isdigit(*(++pos))) {
+			if (cnt) {
+				decimals = decimals * 10 + *pos - '0';
+				cnt--;
+			}
+		}
+		if (*pos == '\n')
+			pos++;
+		if (*pos) {
+			kfree(str);
+			return -EINVAL;
+		}
+		decimals *= int_pow(10, cnt);
+	}
+
+	rv = kstrtoul(str, 10, &result);
+	kfree(str);
+	if (rv)
+		return rv;
+
+	if (result > div64_u64(ULONG_MAX - decimals, int_pow(10, scale)))
 		return -EINVAL;
-	if (decimals < 0)
-		decimals = 0;
-	*res = result * int_pow(10, scale - decimals);
-	return 0;
+	*res = result * int_pow(10, scale) + decimals;
+
+	return rv;
 }
 
 static ssize_t
 safe_delay_show(struct mddev *mddev, char *page)
 {
-	int msec = (mddev->safemode_delay*1000)/HZ;
-	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
+
+	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
 }
 static ssize_t
 safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 {
 	unsigned long msec;
+	int ret;
 
 	if (mddev_is_clustered(mddev)) {
 		pr_warn("md: Safemode is disabled for clustered mode\n");
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	ret = strict_strtoul_scaled(cbuf, &msec, 3);
+	if (ret < 0)
+		return ret;
+	if (msec > UINT_MAX)
 		return -EINVAL;
+
 	if (msec == 0)
 		mddev->safemode_delay = 0;
 	else {
-		unsigned long old_delay = mddev->safemode_delay;
-		unsigned long new_delay = (msec*HZ)/1000;
+		unsigned int old_delay = mddev->safemode_delay;
+		/* HZ <= 1000, so new_delay < UINT_MAX, too */
+		unsigned int new_delay = DIV64_U64_ROUND_UP(msec * HZ, 1000);
 
-		if (new_delay == 0)
-			new_delay = 1;
 		mddev->safemode_delay = new_delay;
 		if (new_delay < old_delay || old_delay == 0)
 			mod_timer(&mddev->safemode_timer, jiffies+1);
-- 
2.31.1

