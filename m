Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C371024C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjEYBVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbjEYBVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:21:16 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7812E;
        Wed, 24 May 2023 18:21:14 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1239565b3a.3;
        Wed, 24 May 2023 18:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684977673; x=1687569673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/loXn/FY0ov0dTjdes2wKdum1jZNR3HB6zIaUVrGEs=;
        b=F/Ymrb15GY7JX1ekZnHh/wL6JIiTEmc5C+ntP7VyI2Xh/IV1UNKPhQKNLCQRqINwY8
         8Fpw/l5DjBUYN9rNoriXJ7xiHvyQlNdldUNzX56ntWRYkPfmSd9SooD2g6/HVeVRdpHb
         BIMDysEzFtZhfUFsQutRiXJFp16wEEd/zkpUFNDs+EptHD+o35a4y4QiWIejXPXvesgt
         oLI2pcq2+yhU1eNNDZ633WzIRfECVoaf8nOfj7xHwtauNiblwV0mTQcYkoNOcsm6a1IH
         t165axy6GDPpMDmDjOPQ1ZNixB7lMyJK+TUYS2g3rYXCVULQqNyne+NYLxk7qDx088dk
         Q6LA==
X-Gm-Message-State: AC+VfDzNiZVYhoFO+krX3JrSXgum+lwFczUDaU9zfnKDIgTlriR0iCSM
        xAhS+rkxpYznc7uTXfYWpOOLe9heMgZ8
X-Google-Smtp-Source: ACHHUZ6z92pw+t8+HqlDL5U4dbttaMt5O7dOO1KPC/6Jm6zNP5yqCI7YU4/9qYlPtlOsiT0UXUPIFg==
X-Received: by 2002:a05:6a21:6da4:b0:10d:3ff2:4531 with SMTP id wl36-20020a056a216da400b0010d3ff24531mr4721949pzb.29.1684977673199;
        Wed, 24 May 2023 18:21:13 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id i5-20020a63e905000000b00530277f7b0fsm8474827pgh.53.2023.05.24.18.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 18:21:12 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, beaub@linux.microsoft.com
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing/user_events: Prevent same name but different args event
Date:   Thu, 25 May 2023 09:21:05 +0800
Message-Id: <20230525012105.7936-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User processes register name_args for events. If the same name but different
args event are registered. The trace outputs of second event are printed
as the first event. This is incorrect.

Return EADDRINUSE back to the user process if the same name but different args
event has being registered.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c              | 74 ++++++++++++++++---
 .../selftests/user_events/ftrace_test.c       |  6 ++
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..aacd22c1e9f8 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1741,6 +1741,46 @@ static int user_event_trace_register(struct user_event *user)
 	return ret;
 }
 
+static int compare_ftrace_field(struct ftrace_event_field *field1,
+					struct ftrace_event_field *field2)
+{
+	if (field1->offset == field2->offset &&
+	    field1->size == field2->size &&
+	    field1->is_signed == field2->is_signed &&
+	    field1->filter_type == field2->filter_type &&
+	    !strcmp(field1->name, field2->name))
+		return 0;
+	else
+		return -1;
+}
+
+static int user_event_compare_fields(struct user_event *user1,
+						struct user_event *user2)
+{
+	struct ftrace_event_field *field1, *field2;
+
+	field1 = list_first_entry(&user1->fields,
+			struct ftrace_event_field, link);
+	field2 = list_first_entry(&user2->fields,
+			struct ftrace_event_field, link);
+
+	while (&field1->link != &user1->fields &&
+			&field2->link != &user2->fields) {
+
+		if (compare_ftrace_field(field1, field2))
+			break;
+
+		field1 = list_next_entry(field1, link);
+		field2 = list_next_entry(field2, link);
+	}
+
+	if (&field1->link == &user1->fields &&
+			&field2->link == &user2->fields)
+		return 0;
+	else
+		return -EADDRINUSE;
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -1752,23 +1792,13 @@ static int user_event_parse(struct user_event_group *group, char *name,
 {
 	int ret;
 	u32 key;
-	struct user_event *user;
+	struct user_event *user, *tmp_user;
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
-	user = find_user_event(group, name, &key);
+	tmp_user = find_user_event(group, name, &key);
 	mutex_unlock(&event_mutex);
 
-	if (user) {
-		*newuser = user;
-		/*
-		 * Name is allocated by caller, free it since it already exists.
-		 * Caller only worries about failure cases for freeing.
-		 */
-		kfree(name);
-		return 0;
-	}
-
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
 
 	if (!user)
@@ -1786,6 +1816,26 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user;
 
+	if (tmp_user) {
+		/*
+		 * Prevent users form using the same name for different fields. This
+		 * can cause unexpected output for the second event.
+		 */
+		ret = user_event_compare_fields(user, tmp_user);
+
+		if (!ret) {
+			*newuser = tmp_user;
+			/*
+			 * Name is allocated by caller, free it since it already exists.
+			 * Caller only worries about failure cases for freeing.
+			 */
+			kfree(name);
+		} else
+			refcount_dec(&tmp_user->refcnt);
+
+		goto put_user;
+	}
+
 	ret = user_event_create_print_fmt(user);
 
 	if (ret)
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 7c99cef94a65..d738efd51daf 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -228,6 +228,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Multipule regitsters to same name but different args should fail */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;";
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EADDRINUSE, errno);
+
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, self->enable_fd);
-- 
2.25.1

