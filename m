Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39F6F707B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEDRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEDRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333762D62
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f315735514so71889565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683220209; x=1685812209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTHDgvve2rlDjfEENOqXxQ+73XcCxja6nWFDNUvgskk=;
        b=TLY8hWANkz5dJ2crHOy+zJ3/fsXy3K91NDqWzUUpWFnWsc5AvwcKHembAMeXUVfNXl
         6aHNKialveKSsvzkPszrvlNeMUCPp2K6hCxbxuo99eVWUuZP9iSacZWOKIfONAsoKL8i
         GjDtmWIGIo7DVSqPDWi7y6KDAWwPrZSeph3cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220209; x=1685812209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTHDgvve2rlDjfEENOqXxQ+73XcCxja6nWFDNUvgskk=;
        b=DfKrZtOm5qZpwBugBYsYQ8WBgLK1ji01Kg7N3GVbgj5tQprstxfc7jKMpOuI9UkDSk
         aUGScNghSQA5k6b4zfL5HEDYuoJ7qhNX7BFeytzid38Wd+Hk+z/dfmO6avbGrwYeh6K0
         NpvHcOa1qqzHwlVL7jjFaApNwwY4Hktc5kKOhdYrxH4iQWooSFmlNTHfcEO/+kQtG1/o
         J1WUBVUVB/cQbdOh1T0bYEg8zPF+RON8qzOas94m/TvsL0Ryx+QnfK8ZEquImLIWlrgV
         19mhhZj88lfyHKm5WRnu6iVmanaw+vVn5PXt0RYmYgSxMqD5WvU0PrtiaDIdy8CadFiS
         PYzw==
X-Gm-Message-State: AC+VfDybLOCxAp9EamphbuAhrohh4dFViIlDl8fuYAkKMuI35+AbKmRR
        2Ftw2HO3mJgu7Yz0uRGZH6yGyWeS2E1NdfedwBU=
X-Google-Smtp-Source: ACHHUZ5d0xPnrxlco6YHlUieIkIKj1ECQng329XaF4Xna4iIv1YyKwG/0ZE08ILoIyqxfnt2ijSqiA==
X-Received: by 2002:a05:600c:3555:b0:3f1:89de:7e51 with SMTP id i21-20020a05600c355500b003f189de7e51mr262426wmq.12.1683220209275;
        Thu, 04 May 2023 10:10:09 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:c740:f74d:132c:ca99])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm5447895wmq.26.2023.05.04.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:10:08 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, nd@arm.com, broonie@kernel.org,
        szabolcs.nagy@arm.com, Florent Revest <revest@chromium.org>
Subject: [PATCH 1/4] kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
Date:   Thu,  4 May 2023 19:09:39 +0200
Message-ID: <20230504170942.822147-2-revest@chromium.org>
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
2.40.1.495.gc816e09b53d-goog

