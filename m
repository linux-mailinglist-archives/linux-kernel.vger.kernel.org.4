Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920796EE80C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjDYTLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjDYTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:11:20 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87BD83D0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:11:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef36d814a5so196781cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682449877; x=1685041877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+el9HnAEkjAwcIZXHJipWv7CnhoGdX3eWtO34Q1+csc=;
        b=wl+vbZqUf4Yzyu94qIYHS4scGC2UaPSsAE+Cqii5fIizO2OMMc1SWJ43+ZAxE2swGJ
         EZ1gZf6yYAvLPReAH8Pb5Y3ySeOatOMV5reJCTVgW5KnV/5SbZObLyc0DqR0MHiFg5+W
         5jr9+hcp7BzWyw/wQOOhfKI6k8ni81GLy7HYKR8XOI49+39Ss0WhyFdXGVVAVCIP46/l
         QC5kXL46bjn2Ngu8ulJ7t5D7G5L0Kh2ThOx7N2z0pEP1++SLjPiycvmjSOofZZ9dSx05
         /Qp6bK4njzmgztK9/o1nJrLlroHVAspinRKFceiinQJSpWOdWJhMYYpcK4rgZjsTqSe1
         /1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449877; x=1685041877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+el9HnAEkjAwcIZXHJipWv7CnhoGdX3eWtO34Q1+csc=;
        b=RhK0dLyid3GZny1+Ki+yarozZuHNS5h5E1qOoBD1bP1NaSMz9EDI1UWM1li3sOjZcf
         5ZbE2JLMaE+AyMVXlwTedXOOWIgX25qahukKCo3mZVWenky3zE/Fc3FAYrFu7tVZ6mCE
         TZUyCYquv0+0jSLgerbFoT8rkRxx6+QGfdpvqWXIWQeN6lkaY0YxXPJrzGXuOD4YtzRM
         o+Rva3BLxNkbEAY3v2Fa0lX7r75VPIilEzt3nb8DiFn5cMtnACcI1ewYTZkfc+n0N6O4
         rPSekRHFosVwla0pJHW+jGILsaVUxsZf9XelNldiyGqN0xIAUIdRjVqinBd4OvX5GlAC
         ivcQ==
X-Gm-Message-State: AC+VfDx51UBMMJuCtVPBiz/gCF2jL7JWZT7oKWgPHz76IX2F4PhrmJqm
        vPGvesT0Ayi5Nab2kI0cnAvkZsFl/41ART3mPjdnyboS6AtQy0SVs7Y=
X-Google-Smtp-Source: ACHHUZ5gyvxZ6/VVecCj50kIZMLvP7Q2BZmfrPDjXDGiWXdqIWJieT6NtYd2TO+kGzqAXo/D43kOvGkphSCa9OAEXJ8=
X-Received: by 2002:ac8:4e89:0:b0:3de:b0b0:557c with SMTP id
 9-20020ac84e89000000b003deb0b0557cmr44534qtp.18.1682449876862; Tue, 25 Apr
 2023 12:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com> <20230421040218.2156548-4-davidgow@google.com>
In-Reply-To: <20230421040218.2156548-4-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 25 Apr 2023 15:11:04 -0400
Message-ID: <CA+GJov4+-u3fnqDWCgsp8EjGkm2efbqtaqMFq+_0pWpTnfkurw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kunit: example: Provide example exit functions
To:     David Gow <davidgow@google.com>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 12:02=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> Add an example .exit and .suite_exit function to the KUnit example
> suite. Given exit functions are a bit more subtle than init functions
> (due to running in a different kthread, and running even after tests or
> test init functions fail), providing an easy place to experiment with
> them is useful.
>
> Signed-off-by: David Gow <davidgow@google.com>

Hi David!

I have reviewed this patch and the overall changes to the cleanup
structure. It looks good to me (other than that kernel test robot
error). Nice to see an example of how to use exit functions in our
example test.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>
> This patch was introduced in v3.
>
> ---
>  lib/kunit/kunit-example-test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index cd8b7e51d02b..24315c882b31 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -41,6 +41,16 @@ static int example_test_init(struct kunit *test)
>         return 0;
>  }
>
> +/*
> + * This is run once after each test case, see the comment on
> + * example_test_suite for more information.
> + */
> +static void example_test_exit(struct kunit *test)
> +{
> +       kunit_info(test, "cleaning up\n");
> +}
> +
> +
>  /*
>   * This is run once before all test cases in the suite.
>   * See the comment on example_test_suite for more information.
> @@ -52,6 +62,16 @@ static int example_test_init_suite(struct kunit_suite =
*suite)
>         return 0;
>  }
>
> +/*
> + * This is run once after all test cases in the suite.
> + * See the comment on example_test_suite for more information.
> + */
> +static void example_test_exit_suite(struct kunit_suite *suite)
> +{
> +       kunit_info(suite, "exiting suite\n");
> +}
> +
> +
>  /*
>   * This test should always be skipped.
>   */
> @@ -211,7 +231,9 @@ static struct kunit_case example_test_cases[] =3D {
>  static struct kunit_suite example_test_suite =3D {
>         .name =3D "example",
>         .init =3D example_test_init,
> +       .exit =3D example_test_exit,
>         .suite_init =3D example_test_init_suite,
> +       .suite_exit =3D example_test_exit_suite,
>         .test_cases =3D example_test_cases,
>  };
>
> --
> 2.40.0.634.g4ca3ef3211-goog
>
