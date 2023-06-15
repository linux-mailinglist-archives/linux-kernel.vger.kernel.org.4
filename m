Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE86731A29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344473AbjFONhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344388AbjFONgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE002D5F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F026C63904
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BBC433CB;
        Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7A-000TpB-1W;
        Thu, 15 Jun 2023 09:34:16 -0400
Message-ID: <20230615133416.288344909@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-linus][PATCH 08/15] selftests/user_events: Add perf self-test for empty arguments events
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

Tests to ensure events that has empty arguments can input trace record
correctly when using perf.

Link: https://lkml.kernel.org/r/20230606062027.1008398-5-sunliming@kylinos.cn

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../testing/selftests/user_events/perf_test.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index e97f24ab6e2f..8b09be566fa2 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -189,6 +189,59 @@ TEST_F(user, perf_write) {
 	ASSERT_EQ(0, self->check);
 }
 
+TEST_F(user, perf_empty_events) {
+	struct perf_event_attr pe = {0};
+	struct user_reg reg = {0};
+	struct perf_event_mmap_page *perf_page;
+	int page_size = sysconf(_SC_PAGESIZE);
+	int id, fd;
+	__u32 *val;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__test_event";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
+
+	/* Register should work */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+	ASSERT_EQ(0, self->check);
+
+	/* Id should be there */
+	id = get_id();
+	ASSERT_NE(-1, id);
+
+	pe.type = PERF_TYPE_TRACEPOINT;
+	pe.size = sizeof(pe);
+	pe.config = id;
+	pe.sample_type = PERF_SAMPLE_RAW;
+	pe.sample_period = 1;
+	pe.wakeup_events = 1;
+
+	/* Tracepoint attach should work */
+	fd = perf_event_open(&pe, 0, -1, -1, 0);
+	ASSERT_NE(-1, fd);
+
+	perf_page = mmap(NULL, page_size * 2, PROT_READ, MAP_SHARED, fd, 0);
+	ASSERT_NE(MAP_FAILED, perf_page);
+
+	/* Status should be updated */
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
+
+	/* Ensure write shows up at correct offset */
+	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+					sizeof(reg.write_index)));
+	val = (void *)(((char *)perf_page) + perf_page->data_offset);
+	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
+
+	munmap(perf_page, page_size * 2);
+	close(fd);
+
+	/* Status should be updated */
+	ASSERT_EQ(0, self->check);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
-- 
2.39.2
