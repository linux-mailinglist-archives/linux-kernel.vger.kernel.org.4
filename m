Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A101C707C39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjERIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjERIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:39:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92431BE9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:39:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed51b0so1996978276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684399139; x=1686991139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k09SwZ0B843M7hzpK5Qk20c0ZsPOaztHq3ds70w84Ac=;
        b=vnqcwkGYGPFsg9Zw/C4wrRWoRxTjw9RrDrLzotAhYpmOuTUO7rj38F0+YNmWSN+H0k
         JGx31FEd3AnjuoyVMv9ih8lsPUTZUoZCt+dLHEanU9CN1/585218J970kCLia5JDJFAY
         YtxP7Wk9S3bGa4YEBol4rDz+ESgEmZuEUuNXOAiwvgV/ElJam1ozyTcJ4V8S++Yy8DTl
         Pva13wqc3v+uSZIJ8MfJ2CEXM99InX6Be/ax6GI4pv9jVOb5TOfrtAUx/nLtVV6LQz9i
         WrZizdZLdQLn8jJcEtKvdgHDiA+4t7QuwCcd8avUEEewp/oWXJZAr+Z052k/hE3Gij8g
         Tzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399139; x=1686991139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k09SwZ0B843M7hzpK5Qk20c0ZsPOaztHq3ds70w84Ac=;
        b=i1kjx0TJJsBg1m93DXuOLEcxG0WWqLzO88kGs+z7So+pk0U3ml7sNqtChjtttdwwnG
         jfxWs1CqAgZiNN7TaAIP5ZdFYzIc+V7IJpK1KtyVL36Nfd51tmMfm6tB1vVvkoriCnL6
         MN+2a1M1FO3KHk+5Dy78KRSmiI5ck7Q6E3UjHXIqx9VXXz+qObnTXuuPbcTljJh/ZTdf
         9wRyv7yvt2Hpgzt0wi6Hcc/NlRWaVZ4V6vIkROLzINHjAgILgA5/s+ugDLqSALTMk1XC
         nuuoX5A3gPumvevD0nokbchC1Gpiv9vb8+rNN8FvkU2yLozQTuPAoq2cQhpPP8hFuil1
         nbag==
X-Gm-Message-State: AC+VfDyh7iUjx0ZDEzZ5sz6ucvaJyvCph5dRZw0ZjRRLV7jtINvHqR19
        Pjxst2Qe4p48hVGJR3qizSziECL2Ad4SDw==
X-Google-Smtp-Source: ACHHUZ7FjnfU/n1fmILQPuKNeQT21ChgWCVMqtw0aYEkvYR8FeoV/nw/X2OF+1YjBkjnlkqNh5bdDfUNeFfLJQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:99c4:0:b0:ba8:ab65:ef39 with SMTP id
 q4-20020a2599c4000000b00ba8ab65ef39mr268701ybo.4.1684399139428; Thu, 18 May
 2023 01:38:59 -0700 (PDT)
Date:   Thu, 18 May 2023 16:38:44 +0800
In-Reply-To: <20230518083849.2631178-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230518083849.2631178-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230518083849.2631178-2-davidgow@google.com>
Subject: [PATCH v2 2/4] kunit: executor_test: Use kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have the kunit_add_action() function, we can use it to implement
kfree_at_end() and free_subsuite_at_end() without the need for extra
helper functions.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20230421084226.2278282-3-davidgow@google.com/
- Use the kunit_action_t typedef

Changes since RFCv2:
https://lore.kernel.org/linux-kselftest/20230331080411.981038-3-davidgow@google.com/
- Don't use the no-longer-extant kunit_defer_func_t typedef.
- Don't pass a GFP pointer in.


---
 lib/kunit/executor_test.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 0cea31c27b23..ce6749af374d 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -125,11 +125,6 @@ kunit_test_suites(&executor_test_suite);
 
 /* Test helpers */
 
-static void kfree_res_free(struct kunit_resource *res)
-{
-	kfree(res->data);
-}
-
 /* Use the resource API to register a call to kfree(to_free).
  * Since we never actually use the resource, it's safe to use on const data.
  */
@@ -138,8 +133,10 @@ static void kfree_at_end(struct kunit *test, const void *to_free)
 	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
 	if (IS_ERR_OR_NULL(to_free))
 		return;
-	kunit_alloc_resource(test, NULL, kfree_res_free, GFP_KERNEL,
-			     (void *)to_free);
+
+	kunit_add_action(test,
+			(kunit_action_t *)kfree,
+			(void *)to_free);
 }
 
 static struct kunit_suite *alloc_fake_suite(struct kunit *test,
-- 
2.40.1.698.g37aff9b760-goog

