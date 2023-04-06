Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364C6D9260
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjDFJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjDFJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:11:49 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDC198
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:11:49 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h198so1686888ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680772308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8kd1BcfwPPSqwXTX0SEVb5soTBP6qJhq+QXHtHsYn9Y=;
        b=a++H6iu7o/Cl0qisj3TeHIvqYQ1G2yInrxtOqcuj+73vykQfjPOzZ59oE+o6MpUfHl
         cDN/C2oe8jFPpaPIx9kvb6uUaSDAfhswh1ZaMcmOTDLfjgcQTTipom/KagLe1f0rkHA6
         SD2rv1EGBznEj8ImNCMljoM8bbpFMaZwyx+xflXOCue5CXK0N1O3NyaHoD2yhfDcqe+M
         g0LUPutgX7NXar8Mvq+ekBGjq4c5wS6Vwc2OCkts5qGym2W2480J1OcJp7RYRBmeUKDS
         yd5+xcCSU/NjiCQsmoxoFJaCA/SShUWYlOosVPErN5dGrPPOGoPBRCJb2Uv5q7wSYrjQ
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kd1BcfwPPSqwXTX0SEVb5soTBP6qJhq+QXHtHsYn9Y=;
        b=cD0RlNXQdMCm3HpX/OMnqYxWl2gj85aUUQXPUA5SA9KKpvd0gJUfQ0aQZO5iThxfc3
         ornR9j2TBY8McF50hr0bJC0VGJbp8EEuw99/HYFk3BzG64vuG2QqlytZCf0BRz/sXSaF
         33AKmfuVe+UQC4fxm7/R6+E2CSXaW+XBA5aIV6hQbO/YeoMoSisUqfg3lnfDbugo3t/l
         yacHeT+XvRgu73YJFoAKoQZCcvHX8obY1FnWHI9I89MTYT6qM1Tu6FR4Bzh9IkMzLSSi
         jA1KtvcSqFBOOF5xYb+5kc0iZeBHtsrfFBZh4VJdeDA6Ww5KYXyMQyVVY0RV01iwI7DE
         hziQ==
X-Gm-Message-State: AAQBX9dTrGqhIIqzd9+jNw3K7yJoggO09xmOd/fmDxN+di0HXdPlHPvH
        OnMDhiBw7bVPIW1Kf29A1tl8dXl2E5+A6cEQwtBLSQ==
X-Google-Smtp-Source: AKy350b28nJPi9ZcNpz1lgIyJkEGuXrdiEoRKs9W2DQ6woHEVVBrHw/uP2w9Z5Xq5GatvTwKypwven4PIvdIbUXNXPo=
X-Received: by 2002:a25:2786:0:b0:b75:760a:966b with SMTP id
 n128-20020a252786000000b00b75760a966bmr1576483ybn.23.1680772308148; Thu, 06
 Apr 2023 02:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-3-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-3-keescook@chromium.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 6 Apr 2023 11:11:09 +0200
Message-ID: <CAG_fn=V-3yxPihQdt+OJuOfF6sBuNvQ2OQfYNZak1xbx6viU2w@mail.gmail.com>
Subject: Re: [PATCH 3/9] string: Add Kunit tests for strcat() family
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
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
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void strncat_test(struct kunit *test)
> +{
> +       char dest[8];
> +
> +       /* Destination is terminated. */
> +       memset(dest, 0, sizeof(dest));
> +       KUNIT_EXPECT_EQ(test, strlen(dest), 0);
> +       /* Empty copy of size 0 does nothing. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +       /* Empty copy of size 1 does nothing too. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +       /* Copy of max 0 characters should do nothing. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "");
> +
> +       /* 4 characters copied in, even if max is 8. */
> +       KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) == dest);
> +       KUNIT_EXPECT_STREQ(test, dest, "four");
> +       KUNIT_EXPECT_EQ(test, dest[5], '\0');

Maybe also add a test case for strncat(dest, "four", 4) that checks
that the fourth byte of dest is not 0?
