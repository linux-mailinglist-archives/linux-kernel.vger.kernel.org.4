Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9F6EDB57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDYFsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:48:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60865269E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 22:48:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so3957865a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682401693; x=1684993693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skAOStOjSkbytxKLF9Zg4CyWjog+NUMJCRRfuuj2XtM=;
        b=hoj3WaRZOHUueEDpaU6cueGgjDKhz9oqitzETCkETB/tb7vh4YluPdKV6eNX4mzIfn
         xTs+y+67ovbFD4r8v0B5gnXq8/hZR3GuDecfMrxIlPSDWv3ZSOm9PP/RmQJVXBT/yaSA
         e/V99oLyJJJo1GBg9tyu1dLyJJex7mkYPH8C18OUCHsvoSmtWIFi5OhQWIswBrENLR9V
         9nMLf/1gvMCF7PCwu+IozBp8SnC50xOyiT2ftsr8kzx3o9F/2Wd3Km3mQpUuqrGMCySC
         5JN0Pb5g5MzM6SSUw8Kro7fEB4DNSL8nyKF0n3DYiOo0VXHG9MeMuNl1vS4yLPK2LGMx
         TUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682401693; x=1684993693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skAOStOjSkbytxKLF9Zg4CyWjog+NUMJCRRfuuj2XtM=;
        b=aTGLNyti7H8uSlvTK3za118js1Vf5HHQ8K4/XfSlhbzuE4wWK7iYSfMDrpqkG6rGwX
         Ec0LxIbnGyPgu4HR+n5Xq1bXKj6tMP0hA1BmzZ+6wqdVOqNge38LwZOoCkVQHN45Rb6f
         9Rpd7K9465gKs+peAQorDqFSoQL8z74zL1/CkuJRg2OvO6P/EmTX07UuTB1i2ah9/R/R
         /xskardVID/xRzUt85qGWz8YNx5B9Bdls+L5/EZNRp4hvZOb4tB3BKiflIUYy8F1Akep
         SFOXUBYuAWGlJoshKJ1KWZ43CGFR+OiGgQ+9hHTc8SyX53x66KhMsRfSBNLcdck5w/FJ
         lqkA==
X-Gm-Message-State: AAQBX9cnXhlECMoA4L3NLio/V/1oB7at27IqWBHFKG62orWftGRznRL1
        bYX1QnChTvkk0pcFFljvUUqS++km0Qz8xJxbJpL8Rg==
X-Google-Smtp-Source: AKy350Zxt0NknJR9vR5IgfGPb0XYeUkWhsfKP0aardwf0jDrkEAYP7pSIrdZ9SWCS8lYdH8OVYG8UEOMpFwALnprTsU=
X-Received: by 2002:a17:90b:4ac9:b0:234:ba34:71bf with SMTP id
 mh9-20020a17090b4ac900b00234ba3471bfmr16050177pjb.1.1682401693373; Mon, 24
 Apr 2023 22:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com> <20230421040218.2156548-3-davidgow@google.com>
In-Reply-To: <20230421040218.2156548-3-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Tue, 25 Apr 2023 11:18:02 +0530
Message-ID: <CAO2JNKUus7h7=Q4rdzYenuFgBqi6Y_SM2=XBLo86yoFKBt1qrA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Documentation: kunit: Warn that exit functions run
 even if init fails
To:     David Gow <davidgow@google.com>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 9:32=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's exit functions will run even if the corresponding init function
> fails. It's easy, when writing an exit function, to assume the init
> function succeeded, and (for example) access uninitialised memory or
> dereference NULL pointers.
>
> Note that this case exists and should be handled in the documentation.
>
> Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
> Link: https://lore.kernel.org/linux-kselftest/a39af0400abedb2e9b31d84c375=
51cecc3eed0e1.camel@sipsolutions.net/
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Thank you, David. Except for a spelling error, this looks fine to me.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Regards,
Sadiya
>
> No changes since v2:
> https://lore.kernel.org/linux-kselftest/20230419085426.1671703-3-davidgow=
@google.com/
>
> This patch was introduced in v2.
>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 12 ++++++++++--
>  include/kunit/test.h                    |  3 +++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 9f720f1317d3..f6d6c9a9ff54 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -166,7 +166,12 @@ many similar tests. In order to reduce duplication i=
n these closely related
>  tests, most unit testing frameworks (including KUnit) provide the concep=
t of a
>  *test suite*. A test suite is a collection of test cases for a unit of c=
ode
>  with optional setup and teardown functions that run before/after the who=
le
> -suite and/or every test case. For example:
> +suite and/or every test case.
> +
> +.. note::
> +   A test case will only run if it is associated with a test suite.
> +
> +For example:
>
>  .. code-block:: c
>
> @@ -196,7 +201,10 @@ after everything else. ``kunit_test_suite(example_te=
st_suite)`` registers the
>  test suite with the KUnit test framework.
>
>  .. note::
> -   A test case will only run if it is associated with a test suite.
> +   The ``exit`` and ``suite_exit`` functions will run even if ``init`` o=
r
> +   ``suite_init`` fail. Make sure that they can handle any inconsistent
> +   state which may result from ``init`` or ``suite_init`` encoutering er=
rors

Nit: Spelling of "encountering"

> +   or exiting early.
>
>  ``kunit_test_suite(...)`` is a macro which tells the linker to put the
>  specified test suite in a special linker section so that it can be run b=
y KUnit
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 57b309c6ca27..3028a1a3fcad 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -168,6 +168,9 @@ static inline char *kunit_status_to_ok_not_ok(enum ku=
nit_status status)
>   * test case, similar to the notion of a *test fixture* or a *test class=
*
>   * in other unit testing frameworks like JUnit or Googletest.
>   *
> + * Note that @exit and @suite_exit will run even if @init or @suite_init
> + * fail: make sure they can handle any inconsistent state which may resu=
lt.
> + *
>   * Every &struct kunit_case must be associated with a kunit_suite for KU=
nit
>   * to run it.
>   */
> --
> 2.40.0.634.g4ca3ef3211-goog
>
