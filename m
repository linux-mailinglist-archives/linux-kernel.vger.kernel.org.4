Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625C747569
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGDPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGDPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216F1B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314313f127fso3214290f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485029; x=1691077029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beswSwVGAkwwt+hvsxKunV4bjZ5oFhW4HtgFlCfoMD8=;
        b=im9v3tz+dDQKllRZMfAl2CXof/kWuglwbcaU6I+/SM3taNN9W0TM7sI67nnkl3lDSX
         9evAJPoxo2Tv50rEz5lihIj5frPU3Hxo1Et5ixkKvTNtQhQyTA6xiirfJK5+I7SVGHC2
         vJhjhWvhzJTSHRPd/yK9QTQbknde3VwTLbMWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485029; x=1691077029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beswSwVGAkwwt+hvsxKunV4bjZ5oFhW4HtgFlCfoMD8=;
        b=MpG+8JekEMy0pHYzBEZv+2XuIVtA/n0sm91DryhRltOz/JaIUifUDLq0lSi3CccjLd
         7EwsoCsAcKyxl/m36SiyVz9UWyKUaEnjcmc7pS0i6bKiXgI1BPA4hVDJl56s6OKP7Vp4
         xNAbvah6h3QDzb4xckM115a7WAtDUgqTg34yCutXbHct0u4RlUNkAJUmNVInZRtB7nLi
         U8djlMy2vH16JaBjDcorYbth385YLowGNqv4xOeOyn9VVRpki9tb8ZBCCKfwXjktWmZG
         zTcStHtqZuhG2q9l2UrC8WA5+BgyqcTfTRtMA1POhe3fsUg1T4amwBwKuagNV2Xz/QER
         fP9w==
X-Gm-Message-State: ABy/qLY0bet3RijTbkuXboK2VQkt2DWkRiMZywCx+d69CQHx1qc2GmNR
        IKERAT2CrOV3uBdJnSWAC7Ppt+jRI/WTJy8A3vs=
X-Google-Smtp-Source: APBJJlGdWcugyCLxuhlb72LvzlOj5uz7Xrz2PmeD25M8SMc8R/B4axzPNqhXW2AizS/HJbijddnx2A==
X-Received: by 2002:a5d:4950:0:b0:313:f7f1:e34c with SMTP id r16-20020a5d4950000000b00313f7f1e34cmr11728009wrs.60.1688485028942;
        Tue, 04 Jul 2023 08:37:08 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:08 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Date:   Tue,  4 Jul 2023 17:36:26 +0200
Message-ID: <20230704153630.1591122-3-revest@chromium.org>
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

I checked with the original author, the mmap_FIXED test case wasn't
properly tested and fails. Currently, it maps two consecutive (non
overlapping) pages and expects the second mapping to be denied by MDWE
but these two pages have nothing to do with each other so MDWE is
actually out of the picture here.

What the test actually intended to do was to remap a virtual address
using MAP_FIXED. However, this operation unmaps the existing mapping and
creates a new one so the va is backed by a new page and MDWE is again
out of the picture, all remappings should succeed.

This patch keeps the test case to make it clear that this situation is
expected to work.

Signed-off-by: Florent Revest <revest@chromium.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
---
 tools/testing/selftests/mm/mdwe_test.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index d0954c657feb..91aa9c3099e7 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
 	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
 	ASSERT_NE(self->p, MAP_FAILED);
 
-	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
+	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
+	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
 		 self->flags | MAP_FIXED, 0, 0);
-	if (variant->enabled) {
-		EXPECT_EQ(p, MAP_FAILED);
-	} else {
-		EXPECT_EQ(p, self->p);
-	}
+	EXPECT_EQ(p, self->p);
 }
 
 TEST_F(mdwe, arm64_BTI)
-- 
2.41.0.255.g8b1d071c50-goog

