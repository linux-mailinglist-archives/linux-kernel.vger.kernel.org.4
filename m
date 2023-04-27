Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC66EFE28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbjD0ADo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbjD0ADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:03:41 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF73AAA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:03:37 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-2f831f6e175so4289526f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682553815; x=1685145815;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PVGkNH8SAKHyU4ewQ+OfZZlAvgFTi0J5Tx9tCjECJi0=;
        b=qq6MyjDBvDrT46K2IB42/jAKgB5xhC8HvE5DZGK6hjyPBDDtneGzvHyIYbiwGccGv5
         fJyFSWaUyl+mcymLHIZXLyZ9O00lQ5+oShA7w3pNNGC+wVICXFtDNPp6cphy0PNc82Ud
         6u2f51op1AZXjuqdYzWF7LRo7djpIUC9DZ4O24zazkV5r3oJH5NVUIy9jsFgolizBHf7
         FXIh2ietB3cwNX3Nsyp/2/V3hSeRjVqxjEUrwrVy7b1myoeVkTcEQI6E+dVdV4Qlqhs1
         zPSzQK1zZHyALmBO8HKeNzgTPwiEFlTuZeT2F89+mNY6ikG2mUkJzZFozRaufOG/Oz6v
         J2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682553815; x=1685145815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVGkNH8SAKHyU4ewQ+OfZZlAvgFTi0J5Tx9tCjECJi0=;
        b=BqSJKgYAt8HOPX66k0rCOXcRyL4g0h4j6J+gRYNM5WHqvM1o7wChtuswp/hP2+k/J7
         fjP9uws7+TubpfMeaxyYLSU1mOZ0xe5i76GmStsZWYQ+g39isWXA4lHPp5JmJLCT9Xyw
         yLxL9l5VTuzrd0xe6fJzZeuMOLm0SOIZjv0kQaXzBklLuSLfuTFc1BowteYjcLhV9LCU
         SZZouipJCgszMExLns7MvsST1wNkfUW8Ntu2OcsVMHHMUkXYI9D1S7ObkFRbYBP0uU/K
         m7+DKEh8/rpDYE/GBCstHHYYpfWe1V2ccO0TVA1a8xK3l9OTsBFcLs7xcAtOSbGiDTVk
         480Q==
X-Gm-Message-State: AAQBX9cw2d4COJlrZu+qbXt/gBoKpgj32V+sZns0TV68W1lS9mUgSEbW
        1JPu2arTf7a/nHChPDASeqjM5BoEk0Y+ZXM=
X-Google-Smtp-Source: AKy350Zw3Ute47L0gD1VFsgVF3P9E6084pjj//BU9w/HxIMThvUdu2T/A5FcAwwZgKBhKGFsopfcfb4Ipsod/Ek=
X-Received: from palandroid.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:350f])
 (user=biswarupp job=sendgmr) by 2002:a5d:4fcd:0:b0:2f8:5130:522e with SMTP id
 h13-20020a5d4fcd000000b002f85130522emr2823320wrw.8.1682553815546; Wed, 26 Apr
 2023 17:03:35 -0700 (PDT)
Date:   Thu, 27 Apr 2023 00:01:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427000152.1407471-1-biswarupp@google.com>
Subject: [PATCH] Call input_set_timestamp for events injected using uinput
From:   Biswarup Pal <biswarupp@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Biswarup Pal <biswarupp@google.com>, kernel-team@android.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, uinput doesn't use the input_set_timestamp API, so any
event injected using uinput is not accurately timestamped in terms of
measuring when the actual event happened. Hence, call the
input_set_timestamp API from uinput in order to provide a more
accurate sense of time for the event. Propagate only the timestamps
which are a) positive, b) within a pre-defined offset (10 secs) from
the current time, and c) not in the future.

Signed-off-by: Biswarup Pal <biswarupp@google.com>
---
 drivers/input/misc/uinput.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index f2593133e524..d98212d55108 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -33,6 +33,7 @@
 #define UINPUT_NAME		"uinput"
 #define UINPUT_BUFFER_SIZE	16
 #define UINPUT_NUM_REQUESTS	16
+#define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
 
 enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
 
@@ -569,11 +570,40 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
 	return retval;
 }
 
+/*
+ * Returns true if the given timestamp is valid (i.e., if all the following
+ * conditions are satisfied), false otherwise.
+ * 1) given timestamp is positive
+ * 2) it's within the allowed offset before the current time
+ * 3) it's not in the future
+ */
+static bool is_valid_timestamp(const ktime_t timestamp)
+{
+	ktime_t zero_time;
+	ktime_t current_time;
+	ktime_t min_time;
+	ktime_t offset;
+
+	zero_time = ktime_set(0, 0);
+	if (ktime_compare(zero_time, timestamp) >= 0)
+		return false;
+
+	current_time = ktime_get();
+	offset = ktime_set(UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS, 0);
+	min_time = ktime_sub(current_time, offset);
+
+	if (ktime_after(min_time, timestamp) || ktime_after(timestamp, current_time))
+		return false;
+
+	return true;
+}
+
 static ssize_t uinput_inject_events(struct uinput_device *udev,
 				    const char __user *buffer, size_t count)
 {
 	struct input_event ev;
 	size_t bytes = 0;
+	ktime_t timestamp;
 
 	if (count != 0 && count < input_event_size())
 		return -EINVAL;
@@ -588,6 +618,10 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 		if (input_event_from_user(buffer + bytes, &ev))
 			return -EFAULT;
 
+		timestamp = ktime_set(ev.input_event_sec, ev.input_event_usec * NSEC_PER_USEC);
+		if (is_valid_timestamp(timestamp))
+			input_set_timestamp(udev->dev, timestamp);
+
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
 		cond_resched();
-- 
2.40.1.495.gc816e09b53d-goog

