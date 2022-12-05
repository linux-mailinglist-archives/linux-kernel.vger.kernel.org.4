Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2E642AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLEO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLEO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:57:47 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1AA5F87
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:57:45 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso7551980ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAXOrsESrx0CdS4Q6xjLBDZXEnUh9Z0PdR9s8BvDppo=;
        b=ql5DAtYvnEvQAuv1Vg7O2uFk4TDOneX6PiWFdn5sm1InzCNwvuD+TNu80xbOhaLWHW
         Kvk1qtNKOg8fKGE3QXew2wXaYc8ycPvXrANWjCCd6ex5xA+DB3Y5q93zNpwpOls2gwld
         anNWOtm9lLhQZOroxXTd+g4keYF1LDsVuM7xDLI06sS0v/Y5oGzPWdxHKHKRCV2ChM9O
         uBPzDJ6wPAse5H7pHJZ7TKkYMa6hIxfPSxJE7VK9spAx121eufzZ7nwsvX6Y0rub+P4D
         S2z1c4BdZxeN14kHFjNYlDXY3fdCX+gD4ICa7gmRa1e/T3Uhg0Ooh64dOUMktMvGlqhD
         MD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAXOrsESrx0CdS4Q6xjLBDZXEnUh9Z0PdR9s8BvDppo=;
        b=QqcGKrxJBqxzOnQBbUQXUW8if+ZAC6YZNn1oU5pK+LKTm+nkzsXOY6qUug5HVM7nEe
         +QEPDDssfX1bGruCQokwHx3Lobt7H5hA0SpTscjnnaHeEjTHoONyeRSN2PDrsgZb78RB
         jQhhoSf5yu7f6udYlDmMr8dCR2M9BL6R92rtKxhRljN3ACti+Q2LyBEYUDNI6206/eOV
         v4Z+1TkgOg77dDSb09lLVc7EMJa2HS3GdJFm8xb0sMcieyJvLmIae8PJ7m7u6v0ODzTw
         0DczeoKu8fVKAuUvYi3XCfjHbFWMTRJ9etEkNP/UkTsJA6fbC2kifh40I2pNgg1+x11E
         nvHQ==
X-Gm-Message-State: ANoB5plHoy97eaMGMJnBeewhYfx9a8fX7bVt3A+HvaWhfWUap/sOjB3D
        +gPuaN6B93z7I2nJpJyYHdgUsIzyDd4=
X-Google-Smtp-Source: AA0mqf7bLMTQFhWrdBJoIGa4xIjQbS5vJ9zm/mLC5/L9i1Mul32aXXmMdyPekGrKbIbgzqqPfdvdgJT7y9o=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:961a:360d:6816:d7ba])
 (user=glider job=sendgmr) by 2002:a05:6402:2948:b0:463:bc31:2604 with SMTP id
 ed8-20020a056402294800b00463bc312604mr73708091edb.32.1670252264258; Mon, 05
 Dec 2022 06:57:44 -0800 (PST)
Date:   Mon,  5 Dec 2022 15:57:40 +0100
In-Reply-To: <20221205132558.63484-1-glider@google.com>
Mime-Version: 1.0
References: <20221205132558.63484-1-glider@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205145740.694038-1-glider@google.com>
Subject: [PATCH v2] kmsan: fix memcpy tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        elver@google.com, dvyukov@google.com, linux-mm@kvack.org
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

Recent Clang changes may cause it to delete calls of memcpy(), if the
source is an uninitialized volatile local.
This happens because passing a pointer to a volatile local into memcpy()
discards the volatile qualifier, giving the compiler a free hand to
optimize the memcpy() call away.

Use OPTIMIZER_HIDE_VAR() to hide the uninitialized var from the
too-smart compiler.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 9a29ea2dbfb9b..eb44ef3c5f290 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -419,6 +419,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
+	OPTIMIZER_HIDE_VAR(uninit_src);
 	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -441,6 +442,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
+	OPTIMIZER_HIDE_VAR(uninit_src);
 	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
@@ -464,6 +466,7 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
+	OPTIMIZER_HIDE_VAR(uninit_src);
 	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

