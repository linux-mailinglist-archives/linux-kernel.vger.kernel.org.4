Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAF6A9A22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjCCPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCCPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:01:08 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EC1B31F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:01:05 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id o32so2589321vsv.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677855665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/aydHlOGXKxNYbYaenvW8HmCoQRPXb5oRnbMkROWhOQ=;
        b=bnJsE3al7F/RO9m51MPgi2ERltvgIHmY3BwnOpTMfY8okcF+CuyqyoOGVgeMv0E01h
         HXpdUM2aeqqCi1Vbkh8+g7Fr8BM8dLYuuFaUoT21xoq/nSPjMAPV9YjIyQbO2/ipcZji
         tZEwk3QzrA0BWGSofmiip0gUnJqLgUr7ddsPMG6KhBe7ExO1z9FIrDyEER4HkpL5Blx5
         pMwQHBD+Fje/n64jMGXBo4rCOorK+FwanBW6qivMWH4CGBLQ4KtI6XUC0PLI2QpdFNzp
         biSQIXpAPbJwe6UWiMKTk7/uj3AzMgDwq7Sr9jgtP1dECB9i7miICAeuG+DAod09GLYB
         iYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677855665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aydHlOGXKxNYbYaenvW8HmCoQRPXb5oRnbMkROWhOQ=;
        b=tqQ4PuKJb0qEYJ9eWpv3vcn5TfqLsCGK0jblxHfFogeD9AcxeDj85JetDBiFJ2FAgI
         5i8pMshJyotDxnSpjUp2Hc2rJjOBsJkQklAM1HxZlfuQoqg2Sh0EJzOov+9CfxZUmp4q
         H6MgIEphkvPpUwTlerauuqhSvEObCdbwa6iN0UVuNuAk7b3bjicNuPT1YdI4lZxPz1ry
         FrLowvl20mKzQqZGSOvaJWXJNjuGnZXVaHgYFpQKhKSGQWh/VI49sRrwEVzw1ieUWZPD
         iNRBzmCGqHgneeFZ7Ua2GtY0C98Zx9TK2Ny38puEuOdmJldwpvp2t/dQPzccXBY5Iguc
         04fA==
X-Gm-Message-State: AO0yUKXPzgnKtKu4Drl1XVN9/hvRBrWRznsFlCRzhgGtTEFIolLfjXUM
        /t7XLevDXu/17jRONO+NAcb+C2NN0PE4ffGI24IPvQ==
X-Google-Smtp-Source: AK7set/RkZE52X8hXrT87mL7tsH8Ud2NJPTAIssq3Zbq99pa0twgioMqqdfGMF7xbJEDXUOP/f22VTcdwXuLy5dfT88=
X-Received: by 2002:a05:6102:243:b0:415:82c8:8753 with SMTP id
 a3-20020a056102024300b0041582c88753mr1347560vsq.1.1677855664805; Fri, 03 Mar
 2023 07:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com> <20230303141433.3422671-4-glider@google.com>
In-Reply-To: <20230303141433.3422671-4-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Mar 2023 16:00:28 +0100
Message-ID: <CANpmjNP8OaOvY02VHqy3JMeDxVzfHguZG8PHhMOKKPjK-Q73Bg@mail.gmail.com>
Subject: Re: [PATCH 4/4] kmsan: add memsetXX tests
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com
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

On Fri, 3 Mar 2023 at 15:14, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Add tests ensuring that memset16()/memset32()/memset64() are
> instrumented by KMSAN and correctly initialize the memory.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> v2:
>  - drop a redundant parameter of DEFINE_TEST_MEMSETXX()

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index aeddfdd4f679f..7095d3fbb23ac 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -504,6 +504,25 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/* Generate test cases for memset16(), memset32(), memset64(). */
> +#define DEFINE_TEST_MEMSETXX(size)                                          \
> +       static void test_memset##size(struct kunit *test)                   \
> +       {                                                                   \
> +               EXPECTATION_NO_REPORT(expect);                              \
> +               volatile uint##size##_t uninit;                             \
> +                                                                            \
> +               kunit_info(test,                                            \
> +                          "memset" #size "() should initialize memory\n"); \
> +               DO_NOT_OPTIMIZE(uninit);                                    \
> +               memset##size((uint##size##_t *)&uninit, 0, 1);              \
> +               kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
> +               KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
> +       }
> +
> +DEFINE_TEST_MEMSETXX(16)
> +DEFINE_TEST_MEMSETXX(32)
> +DEFINE_TEST_MEMSETXX(64)
> +
>  static noinline void fibonacci(int *array, int size, int start)
>  {
>         if (start < 2 || (start == size))
> @@ -550,6 +569,9 @@ static struct kunit_case kmsan_test_cases[] = {
>         KUNIT_CASE(test_memcpy_aligned_to_aligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned),
>         KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
> +       KUNIT_CASE(test_memset16),
> +       KUNIT_CASE(test_memset32),
> +       KUNIT_CASE(test_memset64),
>         KUNIT_CASE(test_long_origin_chain),
>         {},
>  };
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230303141433.3422671-4-glider%40google.com.
