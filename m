Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E80645150
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLGBlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGBlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:41:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A827CDD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:41:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so17854881ybf.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Unq0oaIP1izyBHDyANhzvk3o6bylMiCSbnwmSBSymc=;
        b=tcxWvDemf99X1nyEvPiFORjiBouuxhzHCMm7alI8B0zCANk9aRzhmUj4PiX2rJoUCD
         hJJrySoPkaSABe5Nv69YkwCV3QRiwulTFGw37RXHvnvdoeHF9UvmRi024G7G84Bt2viK
         ecQFXyF6nCfuusEpLbOZfDiEQbNAy2ETjaaL+jsQHxm1/3MMr+bC1KfUvoamwccH7cLP
         Wwee/qrR5pMX/3Wy4yVm3GU+UTbkiEGXY1jQwyNAFMHKIyMoIExUA5kmkJ4ro7A7dE6u
         XBZcUWDDXW8UtEgoPqknJnOS6aqAftwn8vCe+oCw2aiJ22rxD+xFW8GeXFU0f7FP3ZV6
         qciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Unq0oaIP1izyBHDyANhzvk3o6bylMiCSbnwmSBSymc=;
        b=fyaygspOO1G1U4MXRRQ3DIcH4gAD/pEqH4vM5KEMaFp6dvwtR746bH7wunqgQ1aIMl
         9NVo65WQgvS6b5vkwr4Ruf49w+3d5vi9a5LBMuHDH5SC9PtMKeznIfAr6VOkfjCjN6Eq
         zQHHkYWXFdUWY3ANK9JlsgTxxa6gnUlITgTIHtJt4TV/pr8hPKFpr2Q6kZWT+a628k3V
         V5UeqhWlMYzTl0lvkOp52RtunxV3QIalTUyUErGo6tE3ZKaJrRqvpILSsIv9QZYJjuZg
         8iUHdaTmobZ3UkfRRGu3aOEQj0Ff8A0G6fIaf3EutfPLtPpAx7pBgypjxQBStZ2J8YlH
         1/wQ==
X-Gm-Message-State: ANoB5pnhA2ooXMWL+dcoH/PvWfnQJFo3cY/xCCjo2wC2gpmTRLCTo2AS
        HdwwQrjOk9lJIJ/IkSvusnbwFRXtSw==
X-Google-Smtp-Source: AA0mqf4cdaPx0B0tVMcAf1xNRAB/QGITQng5Lwwi7o+J7dzh5sxGHpKiF2zW1y4tA5aMH/iMieifTF64Nw==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:b886:0:b0:700:b6ef:34a9 with SMTP id
 w6-20020a25b886000000b00700b6ef34a9mr10791907ybj.527.1670377260763; Tue, 06
 Dec 2022 17:41:00 -0800 (PST)
Date:   Wed,  7 Dec 2022 01:40:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207014024.340230-1-rmoar@google.com>
Subject: [PATCH v3 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, john.johansen@canonical.com
Cc:     skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in order to test a static function, tests must be included in the
same translation unit as the function. However, this can cause issues with
including implementation and test code in the same file. As an alternative,
the first patch in this series creates a macro that will set a function to
be static or not depending on whether CONFIG_KUNIT is enabled. This allows
the function to be visible during testing and static otherwise.

As an example, the current status quo to test static functions is:

=== test.c ===

static void test_case(struct kunit *test)
{
  KUNIT_EXPECT_EQ(test, my_func_to_test(), 2);
}

Then the tests are included in the implementation file as a workaround to
the issue of testing static functions:

=== implementation.c ===

static int my_func_to_test() {...}
...
#include "test.c"

Instead, the function could be defined with this new macro:

=== implementation.c ===

VISIBLE_IF_KUNIT int my_func_to_test() {...}

The first patch also creates a macro that will export a symbol into a kunit
testing namespace only if CONFIG_KUNIT is enabled. This follows the logic
above and allows symbols to be conditionally exported based on the testing
status.

The second patch in the series updates the policy_unpack test in AppArmor
to show an example of how to use both of these macros in order to address
the issue of testing static functions. Additionally, the patch allows the
policy_unpack test to be built as a module.

Changes since v2:
 - Add mention of namespacing symbols to the commit message of the
   second patch.
 - Change module name in the second patch from policy_unpack_test to
   apparmor_policy_unpack_test.

Changes since v1:
 - Changed the namespace of exported symbols for the apparmor
   policy_unpack_test by adding the aa_ prefix.
 - Separated the documentation comments for macros in
   include/kunit/visibility.h.
 - Changed copyright date and author for include/kunit/visibility.h.

Rae Moar (2):
  kunit: add macro to allow conditionally exposing static symbols to
    tests
  apparmor: test: make static symbols visible during kunit testing

 include/kunit/visibility.h                |  33 +++
 security/apparmor/Kconfig                 |   4 +-
 security/apparmor/Makefile                |   3 +
 security/apparmor/include/policy_unpack.h |  50 +++++
 security/apparmor/policy_unpack.c         | 238 ++++++++++------------
 security/apparmor/policy_unpack_test.c    |  69 ++++---
 6 files changed, 229 insertions(+), 168 deletions(-)
 create mode 100644 include/kunit/visibility.h


base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

