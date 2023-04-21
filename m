Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004716EA289
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 06:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjDUECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjDUECa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 00:02:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADD40D8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 21:02:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f6da2edbdso18152967b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682049748; x=1684641748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6axHHeceCfT18Iy9/ahE+yGfyWAXleNOBhmrrlTMIXA=;
        b=Zd0eS4RY8TdnluDs8kHriFgx0zcAaGgzda+ecPw1Et8sMbW84233s0kcsmUCTayTKt
         39DD/0vEMLFYIbCGcHuT4jt4ze798iBDxMd2S3fLLChUbSRIgy+mpyNwRghxERfG4P99
         IjWMCqHQNiVOWq/PD+UCZrXGEggqdXohmrqDWxe4Ieih3oRBRMUdqqxqmnoUtrLx+n/1
         BouKZBgAliqQHTUnk3uYUrDnuaNLcr8tePVKUT+ioVQet42AlbT/j5rgQs08w9IN0enO
         Er1Lb6UWBKGses/tebvlTvtE3HimYo+gq6GNVxhgXro6kYyHyDbh6t6FbT/jNJslfK/a
         ICfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682049748; x=1684641748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6axHHeceCfT18Iy9/ahE+yGfyWAXleNOBhmrrlTMIXA=;
        b=Isk69JI6pOoxyZ+h0FtXrfIzvhenZg8+++P8VcqG7lKlKcJnSm7OOdKxmhiCRx3SMO
         R3T5Q3+eC8VuH442SbVvbD5K/RSc+HZjBY82mYWUGhbML720w78a0BhgdFPCmyiHwDEw
         wObxGRghBVpD9F49zNzfRrZxVCGAu/hTAJcuWeh7GMMmWvFHyMIMN26Vukt6YZvkl6A3
         +q8dZkLKTDyej5Q3CWCj/w8vGJgbPcud4UPHMTs+PY9hT85MsdO1Fupyctmm5HppLMQQ
         L4rZMKS2ufhhcjlnnUlHXD3G4/3FpVKBGgM4QHX39AZLW0V4naRy2Ji35xkMvd5YessB
         z4Tg==
X-Gm-Message-State: AAQBX9ek19SsXuRJQRVq7DJp2TUXJpsbJJkeY1F2bapGmfVIC932o43l
        stTVUoDHJi8zMQO/WD0odZtuXXPtP+Fyzw==
X-Google-Smtp-Source: AKy350ajLMrF+3r3keuCLx0Vo4kxs32IK/Or+s0nVILEcr/GOQ1BqLQokRn267/2EXkLouihy9RC8iKSvytUiQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:b61e:0:b0:54f:17b6:f30a with SMTP id
 u30-20020a81b61e000000b0054f17b6f30amr593605ywh.4.1682049748345; Thu, 20 Apr
 2023 21:02:28 -0700 (PDT)
Date:   Fri, 21 Apr 2023 12:02:16 +0800
In-Reply-To: <20230421040218.2156548-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421040218.2156548-2-davidgow@google.com>
Subject: [PATCH v3 2/4] Documentation: kunit: Note that assertions should not
 be used in cleanup
From:   David Gow <davidgow@google.com>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As assertions abort the test cleanup process, they should be avoided
from within a suite's exit function, or from within resource 'free'
functions. Unlike with initialisation or main test execution, no further
cleanup will be performed after a failed assertion, potentially causing
a leak of resources.

Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230419085426.1671703-2-davidgow@google.com/

This patch was introduced in v2.

---
 Documentation/dev-tools/kunit/usage.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9faf2b4153fc..9f720f1317d3 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -121,6 +121,12 @@ there's an allocation error.
    ``return`` so they only work from the test function. In KUnit, we stop the
    current kthread on failure, so you can call them from anywhere.
 
+.. note::
+   Warning: There is an exception to the above rule. You shouldn't use assertions
+   in the suite's exit() function, or in the free function for a resource. These
+   run when a test is shutting down, and an assertion here prevents further
+   cleanup code from running, potentially leading to a memory leak.
+
 Customizing error messages
 --------------------------
 
-- 
2.40.0.634.g4ca3ef3211-goog

