Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440AC74756C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGDPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGDPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF47E54
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313fb7f0f80so6339744f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485034; x=1691077034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLVIku7SViX3h+Lcl0E/1oJd3wDCllnW/4/cStAOVU8=;
        b=JOEPaz3vnVicEmuh0M2bGeQ1kl3GzOWIF49GpZl60KzO+GPWcT5dbD+wvseGGR0wpF
         IxOhrzyb0mInXy8d4183tOtH9SMwjHJhP23A8fyQrPc/56y0fXEdeGOra4JIsTvrhDEV
         wdGE+jVfHMmym/en2jJSDy3V5xHMkHz6rdQqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485034; x=1691077034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLVIku7SViX3h+Lcl0E/1oJd3wDCllnW/4/cStAOVU8=;
        b=XYT7+FwE5PS0sdDRVttelkLM3NC82f8D8IrxqfR3f7abV+v/dHsEILZqj37bzIo4RR
         bQCgNqoa4+57CqfOq+L8AivDrJwO2ZK751tYFzW5FlIwD1wPyA0jX66voeeipF0Vo6rn
         XvYGRAxIOSmthMhgLA7nZ2D/8HtdpG+zLuxlEUMBtZPjgRT+k/SUChegcFq2YaVl4zTi
         ScCCX/jYx5/qDgVQP1m8Ut59z9JE0gciQQXPXIq2Wk0aKzMPgVG8pnz682uSx1egiNAa
         XXRz42dfQK2E6lk6a+Ku/2W6ALmvFcQhoXO0QUoqJ4Mu3jfXk30wGoNW05y+6lN9oGCu
         PPMA==
X-Gm-Message-State: ABy/qLZ8AvheEEdUdJqXXDlE+8/tLyEds0Q/seCA6Qe5qOaCneeTd+np
        KqJzZuerfHunuiPBnyPUXble9lc/bjKgEH/U3TI=
X-Google-Smtp-Source: APBJJlGPcUUIL7rFhoXERgudOfZJobL4dZUD8SGmsqpar9eStx2K5Uf+A1VwfXk9CRgRtCCc2GDieQ==
X-Received: by 2002:a5d:6392:0:b0:314:37a2:5900 with SMTP id p18-20020a5d6392000000b0031437a25900mr5264050wru.14.1688485034312;
        Tue, 04 Jul 2023 08:37:14 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:13 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 5/5] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
Date:   Tue,  4 Jul 2023 17:36:29 +0200
Message-ID: <20230704153630.1591122-6-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230704153630.1591122-1-revest@chromium.org>
References: <20230704153630.1591122-1-revest@chromium.org>
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

Check that:
- it can't be set without PR_SET_MDWE
- MDWE flags can't be unset
- when set, PR_SET_MDWE doesn't propagate to children

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 98 ++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 91aa9c3099e7..7bfc98bf9baa 100644
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
@@ -33,6 +35,69 @@ TEST(prctl_flags)
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
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_no_inherit)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_enable_no_inherit)
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
+
+		ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
+		ASSERT_EQ(ret, variant->second_flags);
+	} else {
+		EXPECT_NE(ret, 0);
+	}
+}
+
 FIXTURE(mdwe)
 {
 	void *p;
@@ -45,28 +110,45 @@ FIXTURE_VARIANT(mdwe)
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
@@ -76,13 +158,17 @@ FIXTURE_SETUP(mdwe)
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
@@ -113,7 +199,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
 TEST_F(mdwe, mmap_WRITE_EXEC)
 {
 	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_EQ(self->p, MAP_FAILED);
 	} else {
 		EXPECT_NE(self->p, MAP_FAILED);
@@ -139,7 +225,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
@@ -154,7 +240,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
-- 
2.41.0.255.g8b1d071c50-goog

