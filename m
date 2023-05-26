Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F513712BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbjEZR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEZR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:26:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7418AFB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:26:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso10151cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685121971; x=1687713971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71Kxf0k6A8M4TUhFFp1r7IpZ1IkXMD6IyhPra1EhXqk=;
        b=6JFoJvMoUmS488Gtv5rl7bYHx5RMyM4Q08SLX7BHAkIhGlTVYeCKY0OSn4E2eCugXu
         zmcrRvPdhswhmrwoyPrWt/85tQkdfzXl+guWml4trv26xbngKx5ndaDqFjPruY1c/4HC
         xMDd8SUGj6dkvJvHQ4fSlyqWqxMa92Lo64ZJIiiTo4E+Q+2UDX/lTnuARHB+hiXDOvfH
         sMECPMUfU1H1XsD9r0q+067weg2m4FE4Fog1AXYEQR0HfjT3usMO+Qn1AP1n9gk+kWJq
         3VCtjAkl4jE38cyeT/X1Tky/qBuNrFQ3WZ1ALZpljVkB+B5cJWW7Wsh3cBFqKqUyBlAl
         JsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121971; x=1687713971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71Kxf0k6A8M4TUhFFp1r7IpZ1IkXMD6IyhPra1EhXqk=;
        b=Ak8Iu494krfbryftYloj9iEgIyLbp0Jr1orXo8jN1+/LLq4kCq47FouqN13AyK4lQa
         GBpUDp6+wZ7BKpWxNBwBrM4uQqZiVNMBLHIMZnoBmJ47uW68O/i79ImNPoi7bPcMwGFI
         y0KW8hK4f809AvYUedJIEmVORNu7gs5NeNpuwmxiOsD8mOhML9pgVoBQfNaDkIapX5UN
         CqYiLIx6eYu/O9rAGZlCwV3KRzreClQNxA3XdsUPBdKUwB1bMy0uD5qwxDmigVgWK+Vq
         pp2v0eWvYG35I4WgfSW82prL6cAHYXhPJm+A5YVc//gOAt+j66CeVhu338AgfS3EyWP7
         ws2Q==
X-Gm-Message-State: AC+VfDx6OZazFA5Huw7jVlaLpb4ZRe7y/dr8huOFTRTPv7QQMBEQgDN4
        pmm+JS0BcB6eGyDc8gx6pB9vehjuccIOGv+JUzMdIA==
X-Google-Smtp-Source: ACHHUZ6OCA1JGkLdbuikHU8V1AixK0LKLrs9AT8xGtOvZ6eNwRyFt1Scz9BlSLQpwFsl4F5nru3SB5f1MSvM66Ydhqo=
X-Received: by 2002:a05:622a:1a15:b0:3f6:97b4:1a4b with SMTP id
 f21-20020a05622a1a1500b003f697b41a4bmr132708qtb.21.1685121971305; Fri, 26 May
 2023 10:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230526075355.586335-1-davidgow@google.com>
In-Reply-To: <20230526075355.586335-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 26 May 2023 10:26:00 -0700
Message-ID: <CAGS_qxp3vNeUdFEpTZdD_kazhc+YJ_EumyPTFEwxgkOP4RPn9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
To:     David Gow <davidgow@google.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, May 26, 2023 at 12:54=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit aborts the current thread when an assertion fails. Currently, this
> is done conditionally as part of the kunit_do_failed_assertion()
> function, but this hides the kunit_abort() call from the compiler
> (particularly if it's in another module). This, in turn, can lead to
> both suboptimal code generation (the compiler can't know if
> kunit_do_failed_assertion() will return), and to static analysis tools
> like smatch giving false positives.
>
> Moving the kunit_abort() call into the macro should give the compiler
> and tools a better chance at understanding what's going on. Doing so
> requires exporting kunit_abort(), though it's recommended to continue to
> use assertions in lieu of aborting directly.

Should we rename it to __kunit_abort() to discourage that?
That would match what we do with __kunit_test_suites_init().

Daniel
