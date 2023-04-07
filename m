Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73E6DB42D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDGT12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:27:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E5BB95
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:27:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so4241111pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680895640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu3dx+Zfk7gIiLRJSnMfXUW5bNiNhV3WSuApT75nJdg=;
        b=aXbwo/mNtK34pKA9pfABop4HM/6mbfsUOMDA7T87TNEAPPXZcLFDTkdioJZeeCFhmc
         9p4Zf9fwkAiJsF+fAwoBefIf9f19BhlSy2vcLDUWU5mfk/UahEhvSXWEfMJQo+syb8DM
         qSIHHmW++y45EQokgGeFObegvO5Ol/S+BNQho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu3dx+Zfk7gIiLRJSnMfXUW5bNiNhV3WSuApT75nJdg=;
        b=FmUQhcN/cLpVdgviTi+XKS1YAwwivALlwS0n2PJOqSqLWSM8R4LqaaTo15Sipz37H2
         Wf7pnhSEexN92hffq830nmjBPCsopCzFB/H4VGTI3wOM2WhCTtokConMRJaX+dsQqp4F
         SgpN5Y/QgXpVOLuScnx2XXUaot621MPKd4gO3zysGwNT6TrSRYsdCI3tcnMvmaLYtOU3
         4N2RJve9BmOR3czbd12oDaph+WhUBoHfve18XcI7x7yIbv0400Wljx//yFSpi6WnCQpz
         q9qHEBZmUbrGkw44CCFN3B7f7uJg9IJkr6nE5h0pFJJ7nYxx1SzFgDWVD+md0CW5b4zA
         721A==
X-Gm-Message-State: AAQBX9eHB3kdDSuDWS+tvjHdeKC3D57LDVrNlvyf3zrDVMA4MmNKRpn+
        ThUmmzSSMOYSATxwrjumZ6V4tQ==
X-Google-Smtp-Source: AKy350Z4bqJcVylH3caT6XDtNNwRMnZoCSPaG50rLicnPHmBrLiyzww9IBEF98IesLn0UiUqnBLreQ==
X-Received: by 2002:a17:903:1c9:b0:1a5:153f:2442 with SMTP id e9-20020a17090301c900b001a5153f2442mr3877038plh.52.1680895640003;
        Fri, 07 Apr 2023 12:27:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902784400b001a0763fa8d6sm1493300pln.98.2023.04.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:27:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Andy Shevchenko" <andy@kernel.org>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        "Puyou Lu" <puyou.lu@gmail.com>, "Mark Brown" <broonie@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "David Gow" <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Sander Vanheule" <sander@svanheule.net>,
        "Eric Biggers" <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Daniel Latypov" <dlatypov@google.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH v2 00/10] fortify: Add KUnit tests for runtime overflows
Date:   Fri,  7 Apr 2023 12:27:06 -0700
Message-Id: <20230407191904.gonna.522-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; h=from:subject:message-id; bh=vvIOMtmmSuqLt1XEtyLD1Bm0GMeh4viDL6QKhNTcpmw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkMG6TIg3fRVWwqBJQQ1q94yOb7y1oa6PnzfTQK+Fq 6fbzrkiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZDBukwAKCRCJcvTf3G3AJrbqD/ oC3ncHOoEFp7lDWC4Amm4O5jH78WF3GLd9EaKL1Bb4WH8VcG3DCfDNsqeGlIvKZLWNzyOK9P/W4h2p YaTInxAvOlGqKE7R7Bj2ho1mkOrqID8cm8UQ3iwBAquQOo7RLC31iKgNHyZXqudm2jDvouNkxog05/ crmcv7lKB1wBP0FbA+TXPPGnrTCQAiCuHH7XUirf/m/ajefQG3QfbeQXn740ErdSEnA1gmVx5D/AiD VMRni5G+uKT1Pqr9GlIJzZKE2U1Sq/bRcKZBGRG4658HjSNAf29hZyH/Z0CkO/mm160K+4gU+GXp61 /Ib8xRsGxexJs5Jg5Kr+LuA6ABSwBEIZsSPQ66vGg3MrKCCLxRdsFfklJwsaJsaNX60ZZoo2Om6x5E xAKQl7q5V8P023eW0AiB/y7PwPsVPrpwf8BYvK1+xjK2GBDwMpiwy1CovB+QdzkRTvZ5H7Q54GxylF tP0y8UOqw9PP2EIg4XfaIkhDUijwGpCccEQtSC2EwPKftQhICAnRm5I1piQ1+QQzcGm68zuiqHTG7M 2G4HOmHFJ9vR6T6xU2b/t9CCyEHxHT0shq7j2WkO/INQt2ihL+HD7NO9fcH/NhiT5pxnmPmP4rfWEE ZCyiBX0HqsexOSPEbIcuqAa4FdyLulOMQd5sHkFwfRlCppGM2Pj1g8Zb3LyA==
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

v2:
- fix From/SoB
- strcat: force non-const length arguments (lkp)
- fix x86 and arm fortify_panic prototypes (lkp)
- move test-skip to init function (dlatypov)
- constify p_size, q_size everywhere (miguel)
- enum-ify, string-ify, bit-ify function name passing (aleksander & andy)
v1: https://lore.kernel.org/lkml/20230405235832.never.487-kees@kernel.org/

Kees Cook (10):
  kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
  fortify: Allow KUnit test to build without FORTIFY
  string: Add Kunit tests for strcat() family
  fortify: Use const variables for __member_size tracking
  fortify: Add protection for strlcat()
  fortify: strcat: Move definition to use fortified strlcat()
  fortify: Split reporting and avoid passing string pointer
  fortify: Provide KUnit counters for failure testing
  fortify: Add KUnit tests for runtime overflows
  fortify: Improve buffer overflow reporting

 MAINTAINERS                                  |   1 +
 arch/arm/boot/compressed/misc.c              |   2 +-
 arch/x86/boot/compressed/misc.c              |   2 +-
 include/linux/fortify-string.h               | 257 +++++--
 lib/Kconfig.debug                            |   7 +-
 lib/Makefile                                 |   1 +
 lib/fortify_kunit.c                          | 731 +++++++++++++++++++
 lib/strcat_kunit.c                           | 104 +++
 lib/string_helpers.c                         |  26 +-
 tools/objtool/check.c                        |   2 +-
 tools/testing/kunit/configs/all_tests.config |   2 +
 tools/testing/kunit/configs/arch_uml.config  |   3 +
 12 files changed, 1059 insertions(+), 79 deletions(-)
 create mode 100644 lib/strcat_kunit.c

-- 
2.34.1

