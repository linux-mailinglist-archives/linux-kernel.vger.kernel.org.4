Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00663642B18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLEPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiLEPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:11:26 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B02D2DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:11:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b16so5991594yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyRHwGs1sujZO5RfggaV9pp2Ao2COgwbgvIFOoVzGUY=;
        b=qH/lGxfFLt8XtksTK1OA2eiXjyso5sgA2kdxPo2exqLDMrHU1EPjhgDX2SZ9mkSGCu
         AI3lvyGXcXeZ+ZuDRs6pwiAhaS+UKH+l9NYYaQbEpDRrbnYaD7exOHXExiVBUzvri2lZ
         euWW54LalnUwQXtgg0Ndut+AIMVG0RaBk57bbd06DS5sOa5g2F/tEV3wrxg/xz+6xipm
         gK3ObFQbxAr5FRKxEK6uSf4fPX0EY9bvMvbaPHbRu/rVQ09PATaVEY+2Jg6REYWmEqMa
         G/3xGGKxcCJT1LZ4CSVZhpTvdmJh+A1WZwMNBX9sTs4SM74JQx0VyO9Id2xGs/89L20D
         uHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyRHwGs1sujZO5RfggaV9pp2Ao2COgwbgvIFOoVzGUY=;
        b=4nEfZkiGwKpXX97RqoszZTsXfkIK69LuUFc2H7Lx5ocUBj/PZveAHwmw8Mo9RgXS/8
         026uGyVV+456JIQrfvPZErTG/OR2TM4inh3geAHduGBegCqWnF6fYCr6ArTzchRfjHDG
         77rJQ4SLIUZyEd1DaZgaE1t2zN9TmpzVcz8g5cYrvBYu0y3gtKQQahmQ2QftlTeFyc2N
         J/eoj8wbll+sEbDCSwW5/SyNmlEdcHa5zoJYjBZ0gbYM5b8TeKTI8kBCscC5i8OwFdbo
         ZsyNeSBPI31K4R48/F93TdKPMwaRqmDxh/ZN2K+dKW16m1xR5oNU3cWUz3Y6vl+c8XfT
         N60w==
X-Gm-Message-State: ANoB5pkRbmiV/xU99M6cH5IgL8icQ1rJVMCc+NweorUfpA4OxfKh8RXb
        yWkZtSt6hFtF6DAkEnyNm4yl6uujOKQYCgwAYU0OMw==
X-Google-Smtp-Source: AA0mqf4+JIJ/rY5uOH6i3gj2zZ4mvZhSq/mvTQ0P3MHkbWIrf54rGRE08IAxaKAtO4DD/4Kz2LlWS+kU7tZHRQnxyAw=
X-Received: by 2002:a25:e749:0:b0:6f1:9eb8:76d4 with SMTP id
 e70-20020a25e749000000b006f19eb876d4mr48947486ybh.143.1670253079669; Mon, 05
 Dec 2022 07:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20221205132558.63484-1-glider@google.com> <20221205145740.694038-1-glider@google.com>
In-Reply-To: <20221205145740.694038-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Dec 2022 16:10:43 +0100
Message-ID: <CANpmjNNhdDfovyRr04nF1K5uNth1Hh+KVzBKBNJMd0VsY5WWDA@mail.gmail.com>
Subject: Re: [PATCH v2] kmsan: fix memcpy tests
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dvyukov@google.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 15:57, Alexander Potapenko <glider@google.com> wrote:
>
> Recent Clang changes may cause it to delete calls of memcpy(), if the
> source is an uninitialized volatile local.
> This happens because passing a pointer to a volatile local into memcpy()
> discards the volatile qualifier, giving the compiler a free hand to
> optimize the memcpy() call away.
>
> Use OPTIMIZER_HIDE_VAR() to hide the uninitialized var from the
> too-smart compiler.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 9a29ea2dbfb9b..eb44ef3c5f290 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -419,6 +419,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
> +       OPTIMIZER_HIDE_VAR(uninit_src);
>         memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst, sizeof(dst));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -441,6 +442,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
> +       OPTIMIZER_HIDE_VAR(uninit_src);
>         memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)dst, 4);
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -464,6 +466,7 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         kunit_info(
>                 test,
>                 "memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
> +       OPTIMIZER_HIDE_VAR(uninit_src);
>         memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
>         kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>
