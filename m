Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB86D8B59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjDFACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDFACS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:02:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E25B8E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:02:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so35972631plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680739336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C07aOKp57kwUa4gOutlV56hxiVocHKb+fdJ+0rCi1dQ=;
        b=I0nMYJaDEoWaTckbqyizqpSh02rpM8nxiOYlJb8E1cWeJvp5P7tX6Eco7NXQUlubkc
         8n4KqymG9jD3MvvGlO6afAuQY8a5sjKzLd16APh+cPTuXrl0m4/BYzO7RfU7u/GbhyuD
         Pfy0P/L6Y5jqkG5JdDJNLhWfGuCS/zdGFuX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680739336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C07aOKp57kwUa4gOutlV56hxiVocHKb+fdJ+0rCi1dQ=;
        b=liXF5hpRtR3HvPrbzNbezr043j6MCREA1baxwAzpwFSbHbUe41pr1RFMvEcuKebtxJ
         t82eGsM/SrtQX5qtFtNPW8ADEwDTGOjilrExy/cvtVbXt13/iZYJ1uVnqG/9CcpszZu6
         VP3VmhSb+Q4P5uur375uRGbHGaAGcOlTpdNg8PhpPptXPGhAzWEohzssYw63+fmNCivQ
         K7PQ9fDTwPrBShnKcxeBQ0K6HV3GLQON80bUF7xQo8DCs9dFhP7tPRtd/PoyMmkVKBWX
         Lv0mMnZpMx+y9yVrVXyt5i4qACQ7Es3N6qZ7b1WQuMcUCHfpSSRmMxIFLszlEJqypWHJ
         z/bA==
X-Gm-Message-State: AAQBX9ffXvvYfQaFPMObiBFjvX9vaMhi9J8Y41pSemK+a1vSKQXQ3Tcw
        /3gvpEr5vzN0ccF4n+ndthaHJA==
X-Google-Smtp-Source: AKy350av7nYdL+nD7pgWy5tp0i72mcX2AKBIjYG/wteYWDh9qx1OIPaYI6KjInH3+uDHh3eunKsm0g==
X-Received: by 2002:a17:90b:38cc:b0:23d:35c9:bf1c with SMTP id nn12-20020a17090b38cc00b0023d35c9bf1cmr8928921pjb.16.1680739336339;
        Wed, 05 Apr 2023 17:02:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090ad50300b00240d4521958sm1978995pju.18.2023.04.05.17.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:02:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 0/9] fortify: Add KUnit tests for runtime overflows
Date:   Wed,  5 Apr 2023 17:01:59 -0700
Message-Id: <20230405235832.never.487-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; h=from:subject:message-id; bh=jBZE555KebNg4zelKojMvq8gE9UVQ5rwEKyrU3ogBg4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkLgv/13qVhvvEB/qKSxIyLeorLH2Ci9Pm3IZ5yXHe +yK4jfmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZC4L/wAKCRCJcvTf3G3AJgXAEA CnfcU5TMOUwU2K+Ymzb9VgI3NUjtKz7eoN6UsnEmh5mWYL463/QkU3tf/jzcF52e7/Bgd3w7D94fCl Hp3JD8uQiV26mKI6xHGBzEmYAAYtfJvmjT/d4iv9ZJj7/vv5rCuEbkG3IaMw+hFVB2m0vh5radfI10 TouGHDdQF47FCoHGic7IBd8Qz4EAyg6CXMInEH8jGsfaeSlT/OVuMZDpp0GN86CO9gspg0mWtGeBAz KQNLVaPLVyDGM6WAW6dWYq8k3MLnOWdsUwZLRfpzGD3A36SrL5LDoNRE36m847mw4C6e8KiDC3L5As GybOgXcgjLlu3ZsiykBpnB/3db1j6xQk+su17zGXSV+/BHDVgwlRxRi2dGjLnchRDrsm7QTLycTZp5 QVUgKi23lEqT+DaFgYtJNc6iCftzx7Vz4TeygHaPJLwLSuGDSrnby7mLhi2HKnz/g/xy4kfzuTUlr1 iN7Yly+68uGsWx499ToVTCzNVNNoSBxdEEVned42jggKYPI2tFjBrxqcZ2cbhjGNhHukepkEE5iOXh l5rqNilqW2P/jFmiqPK3aH3Dv6bN+hQZxfqZ+z6LxtBvU4a/J0MoKWfvOgGltzZZUR7WVOz5CO6WXB M9Kf7IFYFmhg2xmKP1p1qMIRHgJ/51mjDbF0Su3QnG4364iyOeFjTlbEU/YA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds KUnit tests for the CONFIG_FORTIFY_SOURCE behavior of the
standard C string functions, and for the strcat() family of functions,
as those were updated during refactoring. Finally, fortification error
messages are improved to give more context for the failure condition.

-Kees

Kees Cook (9):
  kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
  fortify: Allow KUnit test to build without FORTIFY
  string: Add Kunit tests for strcat() family
  fortify: Add protection for strlcat()
  fortify: strcat: Move definition to use fortified strlcat()
  fortify: Split reporting and avoid passing string pointer
  fortify: Provide KUnit counters for failure testing
  fortify: Add KUnit tests for runtime overflows
  fortify: Improve buffer overflow reporting

 MAINTAINERS                                  |   1 +
 include/linux/fortify-string.h               | 204 +++--
 lib/Kconfig.debug                            |   7 +-
 lib/Makefile                                 |   1 +
 lib/fortify_kunit.c                          | 795 +++++++++++++++++++
 lib/strcat_kunit.c                           | 100 +++
 lib/string_helpers.c                         |  74 +-
 tools/objtool/check.c                        |   2 +-
 tools/testing/kunit/configs/all_tests.config |   2 +
 tools/testing/kunit/configs/arch_uml.config  |   3 +
 10 files changed, 1133 insertions(+), 56 deletions(-)
 create mode 100644 lib/strcat_kunit.c

-- 
2.34.1

