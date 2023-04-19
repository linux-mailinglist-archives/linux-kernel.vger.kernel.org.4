Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA076E75B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjDSIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjDSIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:54:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A39BB80
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:54:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d132-20020a254f8a000000b00b868826cdfeso6036612ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681894477; x=1684486477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtKdQL060Yw/1K7e9ydb0dOQvyHGNeqc0Foxtu26QeI=;
        b=QGG9O8x8XvxtEgvh3W5bVpurqntEm7UdQlqHEtD69PL2bltf0siMC7wMCw41Dhj6P+
         Jdn56bP9YkotX8mGPsIzmVX1U5PKJnCzv5qSADujeSG0lI9k+/k4y2Alj4jIIsrHmse3
         QRCjhyky38iNE/EbTWQjA4xl/D66MIEMRxRZ8oMtV+0fHSiC41mDBGnwc9u6kvBbaMrb
         LRUBh0He2c5zp7+b4+ZQgRp5NiAeSXW1vpk6C/pHZYyEEXDpn8EmssMvq8u1rC7NuA7E
         ZVM1HZ6OWIicM9XxWcdqZmRlCucLoyreFT16rlK7wct6DtI7JMGryewkDf23mm0eFilk
         muYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681894477; x=1684486477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtKdQL060Yw/1K7e9ydb0dOQvyHGNeqc0Foxtu26QeI=;
        b=ARSMisY4vaUemsnMk5E5MAbv+KlybsPI5k/pTnkXpvfObHiMnRzwhsEKCidXpEhh7x
         tz6GJJ9eJNQBuIaHspCYCQvyIN3aoGj1PO2/wUtPft7hPX7aD1p1YXm5Y+2H49AEDbYv
         Y9YdxR/ArtOmdHLwxI66V/2mBaC4cilhUSjYpgBmNZ2pjAnZfAUZ9ccvXXF0vECX7xeT
         VMFVBGEFYyAMDuv0d+yen/SSMy/875oEqoR+SQ7ewMiTM7IeKDoUIT9udwPlRgfSRcCJ
         t+r4CRf3oLHZwy2r21m87x4uDWq8bjbwpaxEhxcqE3WMfDLCL3bYzH3RXxkfwobhvpmE
         ecAg==
X-Gm-Message-State: AAQBX9cbS02LSnmXfZXC39DEw/fKV586VzWBkMsBugqystRWvkp3ptQv
        sJNIkMykZiI9Y0KHuQFhZENa1eMtVHZ1JQ==
X-Google-Smtp-Source: AKy350b8nDZXE4llL9sEg/LKd73vVSzjIuT6+GWy/LxpPO0DKOI73YZ94zWlP31MS/VEPo5jDxFm6zk/tQd8mA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:764d:0:b0:52e:e095:d840 with SMTP id
 j13-20020a81764d000000b0052ee095d840mr1691645ywk.0.1681894476855; Wed, 19 Apr
 2023 01:54:36 -0700 (PDT)
Date:   Wed, 19 Apr 2023 16:54:25 +0800
In-Reply-To: <20230419085426.1671703-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230419085426.1671703-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419085426.1671703-2-davidgow@google.com>
Subject: [PATCH v2 2/3] Documentation: kunit: Note that assertions should not
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

This patch is new in v2.

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

