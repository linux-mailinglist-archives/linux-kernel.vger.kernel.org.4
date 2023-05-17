Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB2706C17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjEQPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjEQPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124329ECC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso598225f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335827; x=1686927827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7ff2T9SWyCTsi5ruehr0chbFAgRla4S02ez1WlmA+w=;
        b=kGPLMlrayHP1gkVYlmuR+aicFY/HlsmqbrMGUNf9veQEKPQqXMfCmsxUskzCN5t4z9
         edI4hy/vkfueZyS+EvxWMN3BNzLs82IMkIZoa4eWel4ucQjUbPcYjaApd5sC90zM3Bad
         WpnVorrZEg2iClzBo2gfsPxFa8/oL9nrPRdLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335827; x=1686927827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7ff2T9SWyCTsi5ruehr0chbFAgRla4S02ez1WlmA+w=;
        b=aURl/y3Q4+Jmxwb23dGld6N/ukX6kx5nbHUV737w8S8yfCI0/pxW3lMF3HjBW9fqHh
         W/aiYuQEHO5pEUGD+EXOgD5Ttx3hYj1Pp3LLTqD+Je4wwZH7N3773I7j29FPxs/BPcrt
         fxMZsYIwuZ2ZYzf+vbKyAza8OQwlL3eXPY3tXa/jI+0K6dFEVu3gRNfbsr07xzqxyce9
         4wgFHyQRvJ5X5Ui6KGHeYX8SUWmPOOrGOuw7xVXRgABDnkYvKczO35SFaXWW8hovJuV0
         E257uHL60iffTDW2Qak4zlSVBWF9YTUpGR3kxKl3HX82Yid7jhiQGUw+xlQ1uFXwoffF
         CrFw==
X-Gm-Message-State: AC+VfDxFBUVw0Swpd69OC0q/PdUREvOaAJsLo11/sprJHbqtjHvtqcC4
        2lmvfD5iY0ffD3GAHrPIeMLhT/n7r6wkCcnZqr8=
X-Google-Smtp-Source: ACHHUZ458WHZp8Liew7hGyfMAszvI+njNJrZTZ/BWAYiJZqoHN7xubyHs+mrEk/V9ZdgY6C7yyILRQ==
X-Received: by 2002:adf:f109:0:b0:306:342a:6a01 with SMTP id r9-20020adff109000000b00306342a6a01mr880226wro.47.1684335826853;
        Wed, 17 May 2023 08:03:46 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:45 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 1/5] kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
Date:   Wed, 17 May 2023 17:03:17 +0200
Message-ID: <20230517150321.2890206-2-revest@chromium.org>
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
2.40.1.606.ga4b1b128d6-goog

