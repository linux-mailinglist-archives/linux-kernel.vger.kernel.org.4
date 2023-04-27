Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387976F04E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbjD0LWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbjD0LWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:22:22 -0400
X-Greylist: delayed 78173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 04:22:21 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500F4EE7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:22:20 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MIxmm-1pXZ8b08oE-00KRYq; Thu, 27 Apr 2023 13:22:11 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Shimahara <akira215corp@gmail.com>,
        Ivan Zaentsev <ivan.zaentsev@wirenboard.ru>
Cc:     Stefan Wahren <stefan.wahren@chargebyte.com>,
        Michael Heimpold <mhei@heimpold.de>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC] w1: w1_therm: fix locking behavior in convert_t
Date:   Thu, 27 Apr 2023 13:21:52 +0200
Message-Id: <20230427112152.12313-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mXFTlYMEyuqMNvMKHHrdHh1Is3vTgLjW5BzKHiZ6Pep4b+X3AjJ
 2edpqL1cXdA7MsjPPtYlUADuhzVrFsJIQjFnV+oZ697nN84lIO++nrKpmjpNJlWTlzDVkoK
 rDqvSLq5vmTdH21q0nQqanFHTNGiXhBvCce7F9FZPEutOG00PXqw3OV88WeTUebqYplNhPt
 YvKz1js7aryNscSsoS0mQ==
UI-OutboundReport: notjunk:1;M01:P0:K1YwzZGSK34=;eXhRhPHJh04h1bzdxS3ffGL7HAp
 /ADBL6HW5GDQkCcjdcqgJvQYCs10zTCmegatxh/e7lvAGnPdBFHusYZQHMw1IxNrv5lZA26Jr
 koBfeWpL9Y2SKGvQ+FaYopJQnvlZhfJS1JmyAmp/t277gHpDQMel8EtReYWleBCswe8rDdnL5
 VLhIgjXFw1hhm/iWeQaF4AZoIBCaCTPBxpvXnJUMwO7PeCc3XL1uC8dv2nYa1BZs/dG6qqjds
 w828K6PBoRr3JUEUwbV+f1Cr7evP9o+DD/8nDkBsAz3uYzfv4/UlltrjYSnNH65wwBw4jJh+3
 a2xGJyQIlQ2ULEr1HIt64RlEIlRrRJ6DkoOSSdIMDe9uF2/INsgX3VxkqmiPZ+FiklSO5nICc
 IX+Ik0gZYDjWXgllStiN7Q4jIBfqbDR6gOMipbGnADUY+d2QVASvKXVkNujkYMleZCYpJNUNt
 7ovQd2iPIuMAph2KIyD2qGioriZyGCumy0exAZmHwHleeaTxWO+wCdt0y74Zi2t50kYAuz/If
 62UElpP9sjKL0bDE0SgbpOZAIJ6sa8IDlxZl2ysi1Hf93rNbx0JaPyjts2uNUGMETLQEF4NhC
 aokNkg3u2tiToTlRWzvWodF9AnJv1iZ+mlo70bQJTzdIYs11HYqLP0KsJMLAQqZeQftkkiaBa
 MKDaYepOmvaejFLX8fc7/wbyLVNc2gy3j4t/o8yWjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 67b392f7b8ed ("w1_therm: optimizing temperature read timings")
accidentially inverted the logic for lock handling of the bus mutex.

Before:
  pullup -> release lock before sleep
  no pullup -> release lock after sleep

After:
  pullup -> release lock after sleep
  no pullup -> release lock before sleep

This cause spurious measurements of 85 degree (powerup value) on the
Tarragon board with connected 1-w temperature sensor
(w1_therm.w1_strong_pull=0).

In the meantime a new feature for polling the conversion
completion has been integrated in these branches with
commit 021da53e65fd ("w1: w1_therm: Add sysfs entries to control
conversion time and driver features"). But this feature isn't
available for parasite power mode, so handle this separately.

Link: https://lore.kernel.org/regressions/2023042645-attentive-amends-7b0b@gregkh/T/
Fixes: 67b392f7b8ed ("w1_therm: optimizing temperature read timings")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/w1/slaves/w1_therm.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 067692626cf0..99c58bd9d2df 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1159,29 +1159,26 @@ static int convert_t(struct w1_slave *sl, struct therm_info *info)
 
 			w1_write_8(dev_master, W1_CONVERT_TEMP);
 
-			if (strong_pullup) { /*some device need pullup */
+			if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
+				ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
+				if (ret) {
+					dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
+					goto mt_unlock;
+				}
+				mutex_unlock(&dev_master->bus_mutex);
+			} else if (!strong_pullup) { /*no device need pullup */
 				sleep_rem = msleep_interruptible(t_conv);
 				if (sleep_rem != 0) {
 					ret = -EINTR;
 					goto mt_unlock;
 				}
 				mutex_unlock(&dev_master->bus_mutex);
-			} else { /*no device need pullup */
-				if (SLAVE_FEATURES(sl) & W1_THERM_POLL_COMPLETION) {
-					ret = w1_poll_completion(dev_master, W1_POLL_CONVERT_TEMP);
-					if (ret) {
-						dev_dbg(&sl->dev, "%s: Timeout\n", __func__);
-						goto mt_unlock;
-					}
-					mutex_unlock(&dev_master->bus_mutex);
-				} else {
-					/* Fixed delay */
-					mutex_unlock(&dev_master->bus_mutex);
-					sleep_rem = msleep_interruptible(t_conv);
-					if (sleep_rem != 0) {
-						ret = -EINTR;
-						goto dec_refcnt;
-					}
+			} else { /*some device need pullup */
+				mutex_unlock(&dev_master->bus_mutex);
+				sleep_rem = msleep_interruptible(t_conv);
+				if (sleep_rem != 0) {
+					ret = -EINTR;
+					goto dec_refcnt;
 				}
 			}
 			ret = read_scratchpad(sl, info);
-- 
2.34.1

