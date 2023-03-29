Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F426CD25A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjC2G4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2G4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:56:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54E2D5E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:56:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5458dde029bso147104777b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680072968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6FGLc7DezyggwEDA6SlL49TwBy1ESwTS9CYC+SnZVM=;
        b=ip2ObvbwjKAThNEYJ+mAP6NxZUtLziQmG7qqimp6FSTliXsWvpp5OlH/S6qdrm6D4K
         IZicU6MzuIcQCE61oioHol6VvVAaXHIE2dhWe8vuYyDhNoqEF4mloHHEnoPtfVHcGjfO
         wyOpfLQ6H4o5KUW557F4zn4wpZzfuWs34QzeytMTnFRjkNgloAfzhWoWJ4+dReISEOZP
         1rYuW6kB2TWKMSZvrnsbDg6JDBJqvZGSBzqMLAdDCWB8oHH9sNVSUcHox19tuqORYQv+
         VXEem2/SMiKw6ug/GxM5zdBr9xY2Tv/ZorcJKFJg0KtMQRKjxshwFRGO2BOugKdYpD2h
         yDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680072968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6FGLc7DezyggwEDA6SlL49TwBy1ESwTS9CYC+SnZVM=;
        b=tNKPU5GYEWqbrh4r4rZKAMSbUQlsFXfoOvghRLhqApwc4xKPO1rrvmC0Bi+QRbOxll
         qeHu8RCK9AFItwbUZP4O4DSLzUDbZehEPD+HRdhGCrnCjJiopnwE1K8jHlal4FPv2xUc
         h51R1VMmRDMxsIrnxqc39ZLpgX6DTeHT+RC/k9SxktVgYonOadZ7U143U6blcw/4bPHD
         HqVTRFwGjO7VE2drtrmFPplddeINQz4EqIlHK2YTFAVKQTrJKsT8cQkeazXQU2SOvlzm
         2K5OF+RWUHSJI8CX6mTQ1AwUwxjyWjOA7XG832cBysgxr9FeaXZWh2SmqOkEx+qVcfKf
         cysQ==
X-Gm-Message-State: AAQBX9cneSe3rPOnKP79JujWNpzwpax4hYGzIRBPqnSZbVatEHuq7Nq6
        rRGgl6oXlYFl6BD/T9u9kDbx4Hvc11v6Sw==
X-Google-Smtp-Source: AKy350aW0oXIdid/PamI5UXVN98qdXztLtQJ5ZEohZbEr95Se93u+cliygWLulbEfIGKqnK6l7npl+MIXUEaIA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1547:b0:b46:4a5e:365f with SMTP
 id r7-20020a056902154700b00b464a5e365fmr12420681ybu.8.1680072968620; Tue, 28
 Mar 2023 23:56:08 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:55:34 +0800
In-Reply-To: <20230329065532.2122295-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230329065532.2122295-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329065532.2122295-2-davidgow@google.com>
Subject: [PATCH 2/2] drm: test: Fix 32-bit issue in drm_buddy_test
From:   David Gow <davidgow@google.com>
To:     "=?UTF-8?q?Lu=C3=ADs=20Mendes?=" <luis.p.mendes@gmail.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>
Cc:     David Gow <davidgow@google.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_buddy_test KUnit tests verify that returned blocks have sizes
which are powers of two using is_power_of_2(). However, is_power_of_2()
operations on a 'long', but the block size is a u64. So on systems where
long is 32-bit, this can sometimes fail even on correctly sized blocks.

This only reproduces randomly, as the parameters passed to the buddy
allocator in this test are random. The seed 0xb2e06022 reproduced it
fine here.

For now, just hardcode an is_power_of_2() implementation using
x & (x - 1).

Signed-off-by: David Gow <davidgow@google.com>
---

There are actually a couple of is_power_of_2_u64() implementations
already around in:
- drivers/gpu/drm/i915/i915_utils.h
- fs/btrfs/misc.h (called is_power_of_two_u64) 

So the ideal thing would be to consolidate these in one place.


---
 drivers/gpu/drm/tests/drm_buddy_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index f8ee714df396..09ee6f6af896 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -89,7 +89,8 @@ static int check_block(struct kunit *test, struct drm_buddy *mm,
 		err = -EINVAL;
 	}
 
-	if (!is_power_of_2(block_size)) {
+	/* We can't use is_power_of_2() for a u64 on 32-bit systems. */
+	if (block_size & (block_size - 1)) {
 		kunit_err(test, "block size not power of two\n");
 		err = -EINVAL;
 	}
-- 
2.40.0.348.gf938b09366-goog

