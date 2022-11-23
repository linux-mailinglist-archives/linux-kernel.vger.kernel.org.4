Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E26355C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiKWJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiKWJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:22:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B48D10613D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p18-20020a170902a41200b00188e87d0f04so13484083plq.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ8JuQS8X9t3i4zrgE/S0Ri9wo/GkYIgsNIx6OEFr5o=;
        b=DEp8BSTd9VIwtnULP6VzWamTubDDP1gDZgCtUL3t/6x4ArdhrAAY+23qy7pz5jAyW9
         hLlIbnT90c1Tcw3JhR6bcFVLBaJXvv/TICLht+RD563Od8KYY0M9H7AwOaE8hkyi+4P4
         lAEpAQvnKj8LcQZvAPh5ONRxCteCpkOxZFqu2HI97mVrs24uh8gbeIWiwFXqbA01HNIQ
         oqzk4l0p28W4KMTCuTNQqh+eKppRX/STqk/GYhGQ3ygXEegrR4ifdKGyGqXuYdDqtcK/
         YrKqTZIheFyOuQXeSjmaXlXOKUutxGa8Ub6CnWuSRIBjbAKKxVKbtELfuCSM/AFejFol
         ekRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ8JuQS8X9t3i4zrgE/S0Ri9wo/GkYIgsNIx6OEFr5o=;
        b=qtg3ts27UoFDaQRZp9Lko7qLMiBnJqyq+78sgNbojvgw7LFQcvpjvYue65XnkSq1Kc
         otdGVOlGeFSORxNRIV+QScKCX899KXDzb/jtyl/xhSYtMqaS17hs/ncKFvsst89ABy0N
         1kSXTPgJEZ2fns9IpXOf202F1lQv1S+R481TdHXwZNPnQXbmlu07werKvz/GFPZotsvM
         bcqcEw7N7e39SbIHARR0InHCEI7myyq0Ukn5rxS1IEtuNsUb9En4fYC1rgBJU5RdpVZe
         O7kylnKR2+3vkjrNLttq8xmr5KGtidaHSfHiEPolK2r0yABwuLdqjvNKZ8kTp8e5jAFE
         saVg==
X-Gm-Message-State: ANoB5pmA7t0Lg/M6A4b94tPk0CusBT7cTd83lYmo0iPkcdfEiloZpPVj
        OoRo4VRiue2zfQImo8Qfze8MuKFC6NUe9SG6
X-Google-Smtp-Source: AA0mqf7lNnDk3AMn4WDks5KSg+GBb6+n4WUj4qBI2dF5jmITLTNcCXXmiBK6oEulkWnC0jyWRsCxudd0bBgcirOa
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f2c5:b0:189:1cc3:802a with SMTP
 id h5-20020a170902f2c500b001891cc3802amr9596140plc.56.1669195304144; Wed, 23
 Nov 2022 01:21:44 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:21:31 +0000
In-Reply-To: <20221123092132.2521764-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123092132.2521764-3-yosryahmed@google.com>
Subject: [PATCH v2 2/3] selftests: cgroup: refactor proactive reclaim code to reclaim_until()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code that drives writing to memory.reclaim (retrying, error
handling, etc) from test_memcg_reclaim() to a helper called
reclaim_until(), which proactively reclaims from a memcg until its
usage reaches a certain value.

This will be used in a following patch in another test.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 8833359556f3..d4182e94945e 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
 	return ret;
 }
 
+/* Reclaim from @memcg until usage reaches @goal_usage */
+static bool reclaim_until(const char *memcg, long goal_usage)
+{
+	char buf[64];
+	int retries = 5;
+	int err;
+	long current, to_reclaim;
+
+	/* Nothing to do here */
+	if (cg_read_long(memcg, "memory.current") <= goal_usage)
+		return true;
+
+	while (true) {
+		current = cg_read_long(memcg, "memory.current");
+		to_reclaim = current - goal_usage;
+
+		/*
+		 * We only keep looping if we get -EAGAIN, which means we could
+		 * not reclaim the full amount. This means we got -EAGAIN when
+		 * we actually reclaimed the requested amount, so fail.
+		 */
+		if (to_reclaim <= 0)
+			break;
+
+		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
+		err = cg_write(memcg, "memory.reclaim", buf);
+		if (!err) {
+			/*
+			 * If writing succeeds, then the written amount should have been
+			 * fully reclaimed (and maybe more).
+			 */
+			current = cg_read_long(memcg, "memory.current");
+			if (!values_close(current, goal_usage, 3) && current > goal_usage)
+				break;
+			return true;
+		}
+
+		/* The kernel could not reclaim the full amount, try again. */
+		if (err == -EAGAIN && retries--)
+			continue;
+
+		/* We got an unexpected error or ran out of retries. */
+		break;
+	}
+	return false;
+}
+
 /*
  * This test checks that memory.reclaim reclaims the given
  * amount of memory (from both anon and file, if possible).
@@ -653,8 +700,7 @@ static int test_memcg_reclaim(const char *root)
 {
 	int ret = KSFT_FAIL, fd, retries;
 	char *memcg;
-	long current, expected_usage, to_reclaim;
-	char buf[64];
+	long current, expected_usage;
 
 	memcg = cg_name(root, "memcg_test");
 	if (!memcg)
@@ -705,41 +751,8 @@ static int test_memcg_reclaim(const char *root)
 	 * Reclaim until current reaches 30M, this makes sure we hit both anon
 	 * and file if swap is enabled.
 	 */
-	retries = 5;
-	while (true) {
-		int err;
-
-		current = cg_read_long(memcg, "memory.current");
-		to_reclaim = current - MB(30);
-
-		/*
-		 * We only keep looping if we get EAGAIN, which means we could
-		 * not reclaim the full amount.
-		 */
-		if (to_reclaim <= 0)
-			goto cleanup;
-
-
-		snprintf(buf, sizeof(buf), "%ld", to_reclaim);
-		err = cg_write(memcg, "memory.reclaim", buf);
-		if (!err) {
-			/*
-			 * If writing succeeds, then the written amount should have been
-			 * fully reclaimed (and maybe more).
-			 */
-			current = cg_read_long(memcg, "memory.current");
-			if (!values_close(current, MB(30), 3) && current > MB(30))
-				goto cleanup;
-			break;
-		}
-
-		/* The kernel could not reclaim the full amount, try again. */
-		if (err == -EAGAIN && retries--)
-			continue;
-
-		/* We got an unexpected error or ran out of retries. */
+	if (!reclaim_until(memcg, MB(30)))
 		goto cleanup;
-	}
 
 	ret = KSFT_PASS;
 cleanup:
-- 
2.38.1.584.g0f3c55d4c2-goog

