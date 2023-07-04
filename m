Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BE747568
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGDPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGDPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445171B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so6394889f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485027; x=1691077027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v5lGibnAF/heTsoRNB1jAJr0Wc+6STg6A/2r7lAh8k=;
        b=Z1/poYmW45cjv7LNYkKB69NwMZFwnZvKh4vFG+6k08+f3spLw+mSSsETwE1tgZbMD1
         HKU7aZ1QKyT4aOvcP8fHNQn8gTaqeG/F0VlqaCbQYBQXuAmW0OSwQa/XQQti57AVxQCe
         p79ZfZDYrSgg8pFr2OcW+0iCZO/Excu3e9VeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485027; x=1691077027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v5lGibnAF/heTsoRNB1jAJr0Wc+6STg6A/2r7lAh8k=;
        b=Yj33gVUmkyjpJ6gCzjFkgPppjKMkAde98R6UzisrzRZG/RUf4zAxZTRdY9OgYvP1qr
         8TUumgAZq9FpA7mPDmBHAHlxQnK28KGuKEB5xkYYrr8KpFMqJAaDrLaPo3FvRSIrQ+cI
         zerBaCvDDClX8ih1Wuo0mwk5tWBJkmEPOnXunXlchP1WPQ034luvJAjTIoUsqq+G2V38
         1UJay8pgEVAbLy5XfejIzvS8yYaPicyxAObG2RbVwT+KK7HS0uuVLTPQtp9f06B3K/Sl
         C2+jZ0P7oaNnChFcn535yEYlyEYKY8TEhF6DNB5hT5NoRnaFRDdGJVTA0ulrFgV52uqT
         1rcg==
X-Gm-Message-State: ABy/qLZExW4S+fMbTKoKl6Sk2WVHlGVhPLNsy2We/tUV6PANlesIcSgz
        VQSuOVGgQb2sTma8bZgDlcscuYz3kCNWVHA76cg=
X-Google-Smtp-Source: APBJJlF4ddN4NnLSebE8v9sNmpNAPwAbxVyqwdoBjPzfy26Qv0Li1SwR3xWjrXbxRNN2kNlT3NSVuA==
X-Received: by 2002:adf:cd0a:0:b0:314:10d8:b482 with SMTP id w10-20020adfcd0a000000b0031410d8b482mr10533375wrm.65.1688485027313;
        Tue, 04 Jul 2023 08:37:07 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:06 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 1/5] kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
Date:   Tue,  4 Jul 2023 17:36:25 +0200
Message-ID: <20230704153630.1591122-2-revest@chromium.org>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index bc91bef5d254..d0954c657feb 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -49,19 +49,19 @@ FIXTURE_VARIANT(mdwe)
 
 FIXTURE_VARIANT_ADD(mdwe, stock)
 {
-        .enabled = false,
+	.enabled = false,
 	.forked = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, enabled)
 {
-        .enabled = true,
+	.enabled = true,
 	.forked = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, forked)
 {
-        .enabled = true,
+	.enabled = true,
 	.forked = true,
 };
 
-- 
2.41.0.255.g8b1d071c50-goog

