Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAF706C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjEQPFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjEQPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B8AD3B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3078c092056so629235f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335835; x=1686927835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZna8pJSuLGWyf+gz4k0SP+q2QXja3naQzgW+6vcrp4=;
        b=VOiuLe3bG4vHmfbabe07F3nlpYx08FfV/3zQLCyMZi11R5cM1HKH5T65JN6ugqyHwi
         G99lvNgNYrIk8eHNaql93JvIcv3h0iKEaBhgawogRCgZMmftz/RTh2Bf/JXFZ7nUlRzk
         EK6wmUgGQj7vyyj5mggmdbjXb8QJLmSkQc7OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335835; x=1686927835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZna8pJSuLGWyf+gz4k0SP+q2QXja3naQzgW+6vcrp4=;
        b=kytnbw/P3JT+3g/5MAfwgNdMbHu/z+8Tldwb48wrJcigwtwIS5lovgBb630slN/Dnv
         oEpWOG/YpHMRWamWB5wbQhLO8JuGH/68BJ2FYtvVdCdIkY18oBZF4URhS2L+tV+rZJ1E
         +VOrT4EkJvpXF2eV+z5xdUPXDi6rY/iI/lx/LSJFIkLd+DzB/E3wOZ8G6x7xofjqYgNn
         UPNXiCiER5sVuV5UgJ/8/OqEyKCD24Wh6ysKUilqJQ7hMSC9Nrpei540ok/a3vcUUDBZ
         2m53Kw7R6HIPntSmiEOH7p7vTt5M1nlAi3oa9mwMCCrYTJSqb7I0x3ACwuNqhKLYJYRX
         VFgA==
X-Gm-Message-State: AC+VfDymaDs8MZC+7aJjkWr9ENmeuvOZFtLvAZX2k0Pxk3Qsa0KHAiQ6
        ZaBzxQCXodTNS/wO1Ui4xMw+mAzlP6cr5i0jEhc=
X-Google-Smtp-Source: ACHHUZ6T1L/yncZ7b+WXlzAW8H3qe+guQ3irQhoWzDHtSFqs+sp2uaTY/rDwi1XNPs007HDwmTeTjg==
X-Received: by 2002:adf:ee89:0:b0:306:2979:8ab0 with SMTP id b9-20020adfee89000000b0030629798ab0mr1017312wro.24.1684335834709;
        Wed, 17 May 2023 08:03:54 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:54 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 5/5] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
Date:   Wed, 17 May 2023 17:03:21 +0200
Message-ID: <20230517150321.2890206-6-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230517150321.2890206-1-revest@chromium.org>
References: <20230517150321.2890206-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
PR_SET_MDWE prctl.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 95 ++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 91aa9c3099e7..9f08ed1b99ae 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -22,6 +22,8 @@
 
 TEST(prctl_flags)
 {
+	EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
+
 	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
@@ -33,6 +35,66 @@ TEST(prctl_flags)
 	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
 }
 
+FIXTURE(consecutive_prctl_flags) {};
+FIXTURE_SETUP(consecutive_prctl_flags) {}
+FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
+
+FIXTURE_VARIANT(consecutive_prctl_flags)
+{
+	unsigned long first_flags;
+	unsigned long second_flags;
+	bool should_work;
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, same)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.should_work = true,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = 0,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe_no_inherit)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = 0,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, can_lower_privileges)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.should_work = true,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_gain_privileges)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.should_work = false,
+};
+
+TEST_F(consecutive_prctl_flags, two_prctls)
+{
+	int ret;
+
+	EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0);
+
+	ret = prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
+	if (variant->should_work) {
+		EXPECT_EQ(ret, 0);
+	} else {
+		EXPECT_NE(ret, 0);
+	}
+}
+
 FIXTURE(mdwe)
 {
 	void *p;
@@ -45,28 +107,45 @@ FIXTURE_VARIANT(mdwe)
 {
 	bool enabled;
 	bool forked;
+	bool inherit;
 };
 
 FIXTURE_VARIANT_ADD(mdwe, stock)
 {
 	.enabled = false,
 	.forked = false,
+	.inherit = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, enabled)
 {
 	.enabled = true,
 	.forked = false,
+	.inherit = true,
 };
 
-FIXTURE_VARIANT_ADD(mdwe, forked)
+FIXTURE_VARIANT_ADD(mdwe, inherited)
 {
 	.enabled = true,
 	.forked = true,
+	.inherit = true,
 };
 
+FIXTURE_VARIANT_ADD(mdwe, not_inherited)
+{
+	.enabled = true,
+	.forked = true,
+	.inherit = false,
+};
+
+static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) *variant)
+{
+	return variant->enabled && (!variant->forked || variant->inherit);
+}
+
 FIXTURE_SETUP(mdwe)
 {
+	unsigned long mdwe_flags;
 	int ret, status;
 
 	self->p = NULL;
@@ -76,13 +155,17 @@ FIXTURE_SETUP(mdwe)
 	if (!variant->enabled)
 		return;
 
-	ret = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
+	mdwe_flags = PR_MDWE_REFUSE_EXEC_GAIN;
+	if (!variant->inherit)
+		mdwe_flags |= PR_MDWE_NO_INHERIT;
+
+	ret = prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
 	ASSERT_EQ(ret, 0) {
 		TH_LOG("PR_SET_MDWE failed or unsupported");
 	}
 
 	ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
-	ASSERT_EQ(ret, 1);
+	ASSERT_EQ(ret, mdwe_flags);
 
 	if (variant->forked) {
 		self->pid = fork();
@@ -113,7 +196,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
 TEST_F(mdwe, mmap_WRITE_EXEC)
 {
 	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_EQ(self->p, MAP_FAILED);
 	} else {
 		EXPECT_NE(self->p, MAP_FAILED);
@@ -139,7 +222,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
@@ -154,7 +237,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
-- 
2.40.1.606.ga4b1b128d6-goog

