Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441D71915C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFADcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFADch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:32:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386BE124
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:32:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f6a6e9d90dso123231cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685590355; x=1688182355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6175I9U/z2jyxRP5N7Vtw8M+q5AaoRaoSYJrLNH/s4o=;
        b=5v6ZpiB5hBHGtpLmWsr/G5Bm5asWzbwElN6SVqvBw/6/h3hztBwvE0zC/99KCQdEMs
         usB4S0l6T0zL6TeBMPMZBZ/1/GUX1vWZw/OpAeYI4i/rGa3f3ULfAvr5A79BvCDa5oJ9
         m0SvFY9s+7a8uEUu+sCH/yoWpxRTinMCICL2LhOPpGaZygfNaNdkQZeypV70XX5BLIla
         X8SvF3MfvSxLW+XOgKOE0NOi5en9ESXSwde9Yag4GP0Eyee/BxeX5UKKkDorkP4Ih9Pq
         S6wvfstmgp2w52JJEyBHVLFpVl//B+fklw+d86nkDFnSbQVrkJs+Ti2xO6u4Wzx5rK75
         p1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685590355; x=1688182355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6175I9U/z2jyxRP5N7Vtw8M+q5AaoRaoSYJrLNH/s4o=;
        b=WYsviws72tSRgAC++QG8w6/LWl5Nr+VK74YWRFA5OnDRWjBGskkI4GQdlkEhRjm+A5
         iXCGsilpT01wPdt5KpISxE2ihiWwweU0gpmBa6hH3ostSJiTNS+MF9nPT+VRGz28S/vF
         z2GsOwYsXaKKq68vTpV9YK8uKlGEdZWH5HNL+0dUteteZEpByQaRP/kzvP1Jr/MgqcYu
         c0At9VFgUTL2JKaS08wwjEriJxRvjBBT3pvTp3qpddXWDKmB2LAMTP4B5+MwC6gmgC22
         36bIFLf3Ph2c4TVujMxghLV0+oznh9svbqQyTu2vAIBtrT3OQF58DFcUoSMdH88dGFYA
         jNFg==
X-Gm-Message-State: AC+VfDxk5O00LO8+tJtIewjZhpadlmmTGrx44t7dmCBFOHpq8EyyaIF0
        GsKR+vhwzUUTIDKHi0+Jm0HI1XBNVLR0xP19hjtgOg==
X-Google-Smtp-Source: ACHHUZ6PeP0dJFnpyBW4HYDQxYzM4RhtgpshSEM7pWOeuJTY3YYvhDujeh0DNRolFzarjROHGGYmRGJyVzM2Y6d8rX8=
X-Received: by 2002:ac8:7f82:0:b0:3f6:97b4:1a4f with SMTP id
 z2-20020ac87f82000000b003f697b41a4fmr60870qtj.25.1685590355219; Wed, 31 May
 2023 20:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230531052158.1788232-1-davidgow@google.com>
In-Reply-To: <20230531052158.1788232-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 31 May 2023 20:32:23 -0700
Message-ID: <CAGS_qxp33qfcrW=jcUJipY-oPmJ8Z32_AWTrezAknJE-FLu0_A@mail.gmail.com>
Subject: Re: [PATCH] kunit: Move kunit_abort() call out of kunit_do_failed_assertion()
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
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

On Tue, May 30, 2023 at 10:22=E2=80=AFPM David Gow <davidgow@google.com> wr=
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
>
> In addition, kunit_abort() and kunit_do_failed_assertion() are renamed
> to make it clear they they're intended for internal KUnit use, to:
> __kunit_do_failed_assertion() and __kunit_abort()
>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Minor note, there's a reference to the old `kunit_abort` name still.

Documentation/dev-tools/kunit/architecture.rst
122:              ``void __noreturn kunit_abort(struct kunit *)``.
124:            - ``kunit_abort`` calls the function:

Note that this comes from commit bc145b370c11 ("Documentation: KUnit:
Added KUnit Architecture").
I had forgotten this existed until now.
