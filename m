Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3986F02D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbjD0I5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbjD0I5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:57:15 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF3422A;
        Thu, 27 Apr 2023 01:57:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q6V3m6RGxz4f3kj8;
        Thu, 27 Apr 2023 16:57:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHjOEpkmCsBIQ--.37560S6;
        Thu, 27 Apr 2023 16:57:10 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/3] md/raid10: fix overflow in safe_delay_store
Date:   Thu, 27 Apr 2023 16:56:11 +0800
Message-Id: <20230427085612.1346752-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230427085612.1346752-1-linan666@huaweicloud.com>
References: <20230427085612.1346752-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHjOEpkmCsBIQ--.37560S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1UKw43Zr13ZF47Jw4xWFg_yoW5Xry5pa
        n3J34Yyw4UtryfKF4IvF4DWFW5Was2qrWDt3y2k393JF4DXFs0qw1rXayF9Fy5C3yYvFy3
        Jry5JFyUuFyjyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07jYHqcUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

There is no input check when echo md/safe_mode_delay, and overflow will
occur. There is risk of overflow in strict_strtoul_scaled(), too. Fixed
it by using kstrtoul instead of parsing word one by one.

Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 66 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e344b4b3444..faffbd042925 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3767,35 +3767,51 @@ static int analyze_sbs(struct mddev *mddev)
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
+	if (result > (ULONG_MAX - decimals) / (unsigned int)int_pow(10, scale))
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
@@ -3809,10 +3825,14 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 
 	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
 		return -EINVAL;
+	if (msec > UINT_MAX)
+		return -EINVAL;
+
 	if (msec == 0)
 		mddev->safemode_delay = 0;
 	else {
 		unsigned long old_delay = mddev->safemode_delay;
+		/* HZ <= 1000, so new_delay < UINT_MAX, too */
 		unsigned long new_delay = (msec*HZ)/1000;
 
 		if (new_delay == 0)
-- 
2.31.1

