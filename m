Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99861551A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiKAWe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiKAWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F3E2D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b62so4285454pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+sHrlQ9qvuRyCEzJ8tyDL/yT5sTtV33z7B4OVR3Ags=;
        b=VWzODwGPwt0P786JMKNB4yVGgg435fbGV5qvF0tmnQZII/lvioB+5rfM0gRtBFapW1
         B2Vt/r/3hyQ6HQ0e22x8QpWlhQo6UZ3+azXSonzC2/wasN2zwz6Ey6tb0roh7kfcuc/7
         hHSrSR8gSyYdmcN4l4vDBHr21bm8P7XgVPAcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+sHrlQ9qvuRyCEzJ8tyDL/yT5sTtV33z7B4OVR3Ags=;
        b=Xqyrx1rMZLzeaczbXynACtaZo20Li7OGELMIPerbqWD5XwTPHs9fAL7tNkulzDAh91
         n1ewTgS7b2mnPgDodm6n7agdRNze8sMx705sVntxJjderrG4Ydospfs755LAHS13zjRi
         hdSjWB7tYg18TdYCQYbc0Iwj0/5+WEiCTbGByaL5dZ8krar8Tn9KXO4gA5TZnF5IWcUA
         mlOJQMJZ/0U6TEsPqsxYfqyR9opZ+ST2G+LOz8QajPwijD2gQRiPGxlNdudbB2GCzufd
         iCqIRDc1a7kIRjGXbNTiwlmJRDVQI4OT3qCpHpdyqI9utEzt8uAisNDvL9iOU/9Qs/kQ
         H91Q==
X-Gm-Message-State: ACrzQf0OqbpO8O+sK1n6FNFnsa8LlREzMv4cyZIzcpVm67EMREF7azkb
        mpdTUe/uBCGjSW9fWi0pCop+qQ==
X-Google-Smtp-Source: AMsMyM7KiRxTvIICY6tEp0nx3mTQFcRJ7O18gSx0rrAXVMG55RZwUpbOc9W4hmimCcTWvdvZUIHzEQ==
X-Received: by 2002:a05:6a00:27a0:b0:566:9cd9:3843 with SMTP id bd32-20020a056a0027a000b005669cd93843mr21970210pfb.17.1667342003085;
        Tue, 01 Nov 2022 15:33:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b0018658badef3sm6866072plg.232.2022.11.01.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:33:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 0/6] slab: Provide full coverage for __alloc_size attribute
Date:   Tue,  1 Nov 2022 15:33:08 -0700
Message-Id: <20221101222520.never.109-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; h=from:subject:message-id; bh=4rGBtaTvxIM2S2/tPru2D68sOkXB0OX8taEZHOLdk5A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjYZ6paKyWzltjIhIG7H0wMcmkzTKNPFcf0RIsjPcQ vls+JumJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2GeqQAKCRCJcvTf3G3AJmhaD/ 4lXpEd5+FSEkLBgnULLWUZaf/s6kJlkkyVtXxDxiohZtDko1Y9Yu0jvxNCapl+fgMWJsyBOYbL/5d2 iqO0XLVzGMc3Wy0jJy2o8POCopW0DuxqjTM9z9CLYyn6pMwxfR4QiybtO2tH9yHSB1SqrmKpgelEBH jlWY4WdZt1HbAq6wyHDBVI4NTdjwn5Xs5GgS72fBWIDTvU/uOGN9geVRMqtSTl9PjvhR0kbqOn7D25 xB9m4nxsVeFeTTwr59srXsuYsuJYiCemNooObZdDbWRg7/MvfHZ0Gn6Po6sfLGLiuiLg/N1UiQN6fr vrtMR34lGGmcZ3toePjh4MQHyOc+s8rKaV+BuqdRIY1WnRK8nvK9UonxkUcqGob7oIKFYnTJHDEDpf qJYd3ITuoSUySrEJWRwkNa/dG0wmrvIglpQintfD9RnQVBtjRxohxctq8FW4OAZBPZzNzHrOWtEwyS aT/7I0wSnAe7UZDWYdMcyqL9E08/LjpdrROOA9CcIVfm404TmVSLHf0k3SWwAeFit5m7dltTbMkB1l ixOhSpcykpLXjZX/hjXIgO6io8YXBIIutYlKqQ+tqmgIkWysbCniABDcKM/1kBiHLbZRtoUXdCFITI q7HqFyGHCAORZNT5JeGUETatf9l8xz5PKo7T8MobhoxhzcN8FIqIy00fThig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series to work around a deficiency in GCC (>=11) and Clang
(<16) where the __alloc_size attribute does not apply to inlines. :(
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

This manifests as reduced overflow detection coverage for many allocation
sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was
not actually being propagated to __builtin_dynamic_object_size(). In
addition to working around the issue, expand use of __alloc_size (and
__realloc_size) to more places and provide KUnit tests to validate all
the covered allocator APIs.

-Kees

Kees Cook (6):
  slab: Clean up SLOB vs kmalloc() definition
  slab: Remove special-casing of const 0 size allocations
  slab: Provide functional __alloc_size() hints to kmalloc_trace*()
  string: Add __realloc_size hint to kmemdup()
  driver core: Add __alloc_size hint to devm allocators
  kunit/fortify: Validate __alloc_size attribute results

 include/linux/device.h         |   7 +-
 include/linux/fortify-string.h |   2 +-
 include/linux/slab.h           |  36 ++---
 include/linux/string.h         |   2 +-
 lib/Makefile                   |   1 +
 lib/fortify_kunit.c            | 255 +++++++++++++++++++++++++++++++++
 mm/slab_common.c               |  14 ++
 7 files changed, 296 insertions(+), 21 deletions(-)

-- 
2.34.1

