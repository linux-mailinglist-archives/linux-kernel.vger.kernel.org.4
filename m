Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D996F707D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjEDRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjEDRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8940F5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4000ec71dso5859385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683220211; x=1685812211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3QYW4dMv2fssbqcmbr7kPwxf8O4yB5nA1oU7n1NpuI=;
        b=D7x4fa+X6qIEzk2IbZ+D0fz5GhTgakeCXE+E81V7L4crHzOUgGASrNmikW+8iJh6Lp
         M1n6L4lENTLNeOLhBvCOq7Kq+mXd93sRdO8S61OdMearQDPJkCAv7Q+7Bh7n2mXiDfYh
         UHQAZtPHV+bXdXq/fi6Bp3nU8BvBD8blOwy0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220211; x=1685812211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3QYW4dMv2fssbqcmbr7kPwxf8O4yB5nA1oU7n1NpuI=;
        b=V/TMsV1WulG7aZDtECXvG5RR2zLZfUNPdYncgt8jIkZR447AxrGGsEaKKnb6KCSJFN
         vbIXWV9m0dw9FS09a7/O7R1EWkjVU7p5XlVrEKDfIGw2YOeW8cK810Bp1Xmfwn6l/jON
         bdq1NbcS5zxt6haTf1cRZ8PfQ/Hpyo+722NTrNGePU8EdJDNrF+VkUGyxOO0vzD1UGxW
         L6uE2JzCSoq0RHfewwq9Nh7DkNjNGZEJL9nxKZnTJTNPdAexCHWsG380htY92wfzeuL2
         cGtDGJ1urnB8AYSOgb06JhFh3sptk/+12avnk0FjHiXA0+GTkq0TY1yllFpcVd+ILgoc
         BTiw==
X-Gm-Message-State: AC+VfDwakvdgZ1KGCuEH8GMAdpSVU8RBV8zEHSByCR1dsqQGsoAeOWjA
        qB2TeoLrITT1Qwte+L3vtLRD+tuoRKkmZYwaY+s=
X-Google-Smtp-Source: ACHHUZ7sjcdpMxdHjUAJRoWkPdEa2XxXYPE4S9LIyfl8w/5h6/1ytolBNPYIlZqeNzyAuvye4I8eIQ==
X-Received: by 2002:a1c:740d:0:b0:3ef:6819:b2ad with SMTP id p13-20020a1c740d000000b003ef6819b2admr265910wmc.37.1683220210796;
        Thu, 04 May 2023 10:10:10 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:c740:f74d:132c:ca99])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm5447895wmq.26.2023.05.04.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:10:10 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, nd@arm.com, broonie@kernel.org,
        szabolcs.nagy@arm.com, Florent Revest <revest@chromium.org>
Subject: [PATCH 2/4] kselftest: vm: Fix mdwe's mmap_FIXED test case
Date:   Thu,  4 May 2023 19:09:40 +0200
Message-ID: <20230504170942.822147-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230504170942.822147-1-revest@chromium.org>
References: <20230504170942.822147-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.40.1.495.gc816e09b53d-goog

