Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17792706C19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEQPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjEQPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F482A5E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30935d343f7so842653f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335829; x=1686927829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfh3GE7IWMNsnxpLZpSEij25ZLJGjbedQ1hG+0yiDYk=;
        b=TBK4OSB65hONFNWvZypUGnx7S8WLlWfYWTq7/K+E9K+S8Su0GdBk6u6iGCqrsSrKG7
         GqW6tBLQWziSzCi6z0EemnxyB+m/nKMEsmMfHGQ51NphG3FFy8IWI/ZDoiWu+0+j9qHS
         J3G4o2dX78bFaRnun6CZnrH+uMpsoOvIf6WsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335829; x=1686927829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cfh3GE7IWMNsnxpLZpSEij25ZLJGjbedQ1hG+0yiDYk=;
        b=ib6wl0f2FvtGY1nj9JvbDSDiTYJU0nvwqwptWY7YmsEE/fpuvNVDGdP9GFKYkR1Cap
         oyzlZ/OTkG55tGC55NRxwJEAH9pCDLgqVm41KaWLUfwE3eKMOAgVhAxcoMY410nkxZ+T
         oQWjnkJKxoWUEblzHz6e9gI4+9L3gSRDAlWL8Y+4cykrAaPpQo1TUajoqNkG5nI/HDYd
         S2mVjN6acHOiqQqQydLIDPX2PirVix7RGy4KL3l1vMSufFF50tHyO9AQv7rBPU4n+c5b
         pSJ6JfiFA7/8LB0VXZS+K2HnZb6N/ng/D7P14jMMa//GR0r//Aah62gnLQSrNiZhd0wa
         00XQ==
X-Gm-Message-State: AC+VfDxqKAKF4InlAL3CbQatS7K3BLzfJaevbUj/7WSECpoYvohuoefu
        jBgmEj+GKToUSGDEjwtJnoYLP3zmHhOtyRqyd4w=
X-Google-Smtp-Source: ACHHUZ4BRxwoghBUU+IFL+ZJtsWoSYF2p3g8nvOhl3yyyU/th6R/Oov+Ul9D08ODS1HBQAF1HRdzMA==
X-Received: by 2002:adf:fa03:0:b0:2f9:4fe9:74bb with SMTP id m3-20020adffa03000000b002f94fe974bbmr791746wrr.40.1684335828943;
        Wed, 17 May 2023 08:03:48 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:48 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Date:   Wed, 17 May 2023 17:03:18 +0200
Message-ID: <20230517150321.2890206-3-revest@chromium.org>
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
2.40.1.606.ga4b1b128d6-goog

