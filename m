Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D3770FFED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjEXVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEXVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:23:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A6D12E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:23:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-4d9b2045e1cso1002a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684963382; x=1687555382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8Qg2K654YRlKmz23V8WpWN+Y6cHXvK/b2p7jnK6OQs=;
        b=t5sPqCEeZFf9HQQ4ntEgMZTuOcPaVIMzfbEpscsappcH0P0d2ASkDmPicxu7wnamVk
         fP7ckKxxzZ8Oa9e8Y9KxlAfJjjPM4n8ovg48npe8rUJGnj7kJB9mv+7kiXrASjqNkq5S
         HPROKIUIYb5aqkZrRAAnNwuIAEmtdGTHM/cDqQd8FPOPOnje75XJUaV+Q09uhuVLt1T9
         PD5ShFEzQOAIiyfSv9ZpYIXNf+CmJFUy+EMFb0xxxyEyumo7jL/Awq1K/4H3SO2dKs3p
         1dM9K37a6Go1bNHi7BE+tQSRYg8qJUjyB/Lpfxuo3TZAxAHFUUP0hfPsR+l7dFF/rLuc
         CWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684963382; x=1687555382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8Qg2K654YRlKmz23V8WpWN+Y6cHXvK/b2p7jnK6OQs=;
        b=MPAH5tfkb9qd5q87RXlQPLMhP+8cxccOFf56oMM4PMbEjx00aAyieFPjW9SRIRtOVI
         Hs3a5QoQRFzY85B/kHD1Lyafh+2ZSRwzMmQ3deqZiW9c2/NveoGkfuo255Y68SUVr2H4
         7NTgYcKGrT0nKC24AbDnDSn5BAMayxTdav6I2lm5tYsB/1BwE3yjeuqTYknmhD7sTagi
         xA3TPOxc3ozL/RGJHHdlGYq4XvIbwo1+jjDjX56+MQe75AtpV4l/6OB06TqNSjT55gqe
         tgGYOWos3zK+qgKRJihwCPmU44C5a+qRBAyG7O8P26O+8loKRWbUfl8esVYBB6ExFmbA
         h5QA==
X-Gm-Message-State: AC+VfDzQNreV+2L+3YSfZ2272Q1ugTdAk3hFmqdTEat8Oi7C+oWyVzr0
        S8nCS+3K0ViyvawaUMdx3uVKEnn1cTJI1urHkSfPFg==
X-Google-Smtp-Source: ACHHUZ5yTS6/RmEjOM02kGVgahV7AKQIXPIdgnvD5TrNps0XUfGtHGCFrSRoBOWokdISojFDAn2sBb1/6+NP+V2CyXM=
X-Received: by 2002:a50:9317:0:b0:506:b280:4993 with SMTP id
 m23-20020a509317000000b00506b2804993mr48726eda.2.1684963381628; Wed, 24 May
 2023 14:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230518083849.2631178-1-davidgow@google.com> <20230518083849.2631178-4-davidgow@google.com>
In-Reply-To: <20230518083849.2631178-4-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 24 May 2023 17:22:49 -0400
Message-ID: <CA+GJov6nq+RHsc5wU_WJw8nfMO=YEW=f2OsHM+_=hZP7xf92wQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation: kunit: Add usage notes for kunit_add_action()
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, May 18, 2023 at 4:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Add some basic documentation for kunit_add_action() and related
> deferred action functions.

Hi David!

This looks good to me. Just two typos below. Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This patch is new in v2.
>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 51 +++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 46957d1cbcbb..c2f0ed648385 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -615,6 +615,57 @@ For example:
>                 KUNIT_ASSERT_STREQ(test, buffer, "");
>         }
>
> +Registering Cleanup Actions
> +---------------------------
> +
> +If you need to perform some cleanup beyond simple use of ``kunit_kzalloc=
``,
> +you can register a cusom "deferred action", which is a cleanup function

Looks like a typo here: "custom"

> +run when the test exits (whether cleanly, or via a failed assertion).
> +
> +Actions are simple functions with no return value, and a single ``void*`=
`
> +context argument, and forfil the same role as "cleanup" functions in Pyt=
hon

Another small typo here as Bagas noted.

> +and Go tests, "defer" statements in languages which support them, and
> +(in some cases) destructors in RAII languages.
> +
> +These are very useful for unregistering things from global lists, closin=
g
> +files or other resources, or freeing resources.
> +
> +For example:
> +
> +.. code-block:: C
> +
> +       static void cleanup_device(void *ctx)
> +       {
> +               struct device *dev =3D (struct device *)ctx;
> +
> +               device_unregister(dev);
> +       }
> +
> +       void example_device_test(struct kunit *test)
> +       {
> +               struct my_device dev;
> +
> +               device_register(&dev);
> +
> +               kunit_add_action(test, &cleanup_device, &dev);
> +       }
> +
> +Note that, for functions like device_unregister which only accept a sing=
le
> +pointer-sized argument, it's possible to directly cast that function to
> +a ``kunit_action_t`` rather than writing a wrapper function, for example=
:
> +
> +.. code-block:: C
> +
> +       kunit_add_action(test, (kunit_action_t *)&device_unregister, &dev=
);
> +
> +``kunit_add_action`` can fail if, for example, the system is out of memo=
ry.
> +You can use ``kunit_add_action_or_reset`` instead which runs the action
> +immediately if it cannot be deferred.
> +
> +If you need more control over when the cleanup function is called, you
> +can trigger it early using ``kunit_release_action``, or cancel it entire=
ly
> +with ``kunit_remove_action``.
> +
>
>  Testing Static Functions
>  ------------------------
> --
> 2.40.1.698.g37aff9b760-goog
>
