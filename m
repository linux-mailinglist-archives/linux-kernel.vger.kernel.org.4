Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5E7077F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjERCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjERCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:18:48 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B82213B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:18:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75773a7bd66so169714185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684376326; x=1686968326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+pMaJ78vDhX/WJumeumdh2Ew8rPwZqh+d939UbVmCI=;
        b=laThT9KmuWwvZ+2Yoy5xsTan07ApYzz/BleFpSz8wK9Si/Q7ltWEJAFVbUqtOZ4D6L
         TMd2/Y9xWpgxsYsAa9xV49mMbN1y6fwgjT/pKe1dU8Islleu93aNaPSMOLxKyhX/jNrJ
         4p5p9XM83q3qupRwXWj+wCh1LxpyNLzARQFWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376326; x=1686968326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+pMaJ78vDhX/WJumeumdh2Ew8rPwZqh+d939UbVmCI=;
        b=K3OeF0vr2oLnSIO/gnKDUC7NTKrph7kaq0jaXLhwwqz8nAYDsjsD1wqfKdX1rPM5mD
         IYohXIuGKJkjTmBfs86x+MCNOkmO0mI9N3Cj8qbSpr5pyzIlulgewWfobr7N8dRm5+MR
         jNj8I32lncFBnS0vf5UL6dfb98LHOuYA47TARJj+V0bhdjkwoKd3PphT1g1xFKlwfcEZ
         EBXE2BsfdRGsY6J9HjUvhgVUjxl7ZyFNnTB9e+rlQeGRjN3dkjiB7+YYjfk3Zy9V74f4
         IZE0s8h/0R3uebEF7OBQcanf1cLdlhbu/xt418xN9lA2GB6XYLgomj7WJmwMF8jUvUmx
         J6JA==
X-Gm-Message-State: AC+VfDy4Jtao9CZfeuIwvM6RZ+evQbn63mADOuchhAVfmReJwqdUdNIg
        MnuABAt7/UNyWh4R4Ep4g35LiIClvjtfMj5epxQ=
X-Google-Smtp-Source: ACHHUZ6UnCuj5Nq3VC1ze3Rr3HeldoNEZzJlJJp6jYqyiOJjllcKquWS6RDoPMf5upFCbGWuS1xJyg==
X-Received: by 2002:ac8:59cf:0:b0:3f5:315f:5c19 with SMTP id f15-20020ac859cf000000b003f5315f5c19mr3147223qtf.62.1684376326582;
        Wed, 17 May 2023 19:18:46 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b007577ccf566asm85082qki.93.2023.05.17.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 19:18:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 3/4] selftests: mm: Add a test for mutually aligned moves > PMD size
Date:   Thu, 18 May 2023 02:18:24 +0000
Message-ID: <20230518021825.712742-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230518021825.712742-1-joel@joelfernandes.org>
References: <20230518021825.712742-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test case to check if a PMD-alignment optimization
successfully happens.

I add support to make sure there is some room before the source mapping,
otherwise the optimization to trigger PMD-aligned move will be disabled
as the kernel will detect that a mapping before the source exists and
such optimization becomes impossible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 6822d657f589..6304eb0947a3 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -44,6 +44,7 @@ enum {
 	_1MB = 1ULL << 20,
 	_2MB = 2ULL << 20,
 	_4MB = 4ULL << 20,
+	_5MB = 5ULL << 20,
 	_1GB = 1ULL << 30,
 	_2GB = 2ULL << 30,
 	PMD = _2MB,
@@ -235,6 +236,11 @@ static void *get_source_mapping(struct config c)
 	unsigned long long mmap_min_addr;
 
 	mmap_min_addr = get_mmap_min_addr();
+	/*
+	 * For some tests, we need to not have any mappings below the
+	 * source mapping. Add some headroom to mmap_min_addr for this.
+	 */
+	mmap_min_addr += 10 * _4MB;
 
 retry:
 	addr += c.src_alignment;
@@ -434,7 +440,7 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
 	return 0;
 }
 
-#define MAX_TEST 13
+#define MAX_TEST 14
 #define MAX_PERF_TEST 3
 int main(int argc, char **argv)
 {
@@ -500,6 +506,10 @@ int main(int argc, char **argv)
 	test_cases[12] = MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
 				   "2GB mremap - Source PUD-aligned, Destination PUD-aligned");
 
+	/* Src and Dest addr 1MB aligned. 5MB mremap. */
+	test_cases[13] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+				  "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
+
 	perf_test_cases[0] =  MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
 					"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
 	/*
-- 
2.40.1.606.ga4b1b128d6-goog

