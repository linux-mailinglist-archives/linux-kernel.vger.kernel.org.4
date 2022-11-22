Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1895633228
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiKVBbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKVBbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:31:16 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56FB70C6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:31:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id b131so15654615yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYRjBqU3ZoHV4i/knmVPjtRYVyj2wBtBdprE9kY1bXY=;
        b=g5eszoEulUfrD1WqxBnLIM3gUgku3IJD6GBT91ItK1iQ3CxkGoNjn4a2GWvTpmdSFi
         lVPxF9/dWFtr1nFuFXhSuZJw4FsGD+qKgco89uA/o5CL0rOWhS6iLjHimnSuvw+Zbr3M
         hd9XngwctwS8u8UKW5cxJm3NuK1i1QaV6Ff5SoqsmPl2knL0bPLiF4P3bruDRLe+ZoBX
         L/9ygwEcgsHydEymZYpk6EmBs2aPgOYUl33sXvPNl77s93ZF6cTkx57vBtmi9Z2wHKdN
         2iT20/pBA0ALqF1gCn54EBl5r80A+JsvDMLC+Y4DhkhDE/AKhjh2aazXYzDejfWdkeCy
         JNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYRjBqU3ZoHV4i/knmVPjtRYVyj2wBtBdprE9kY1bXY=;
        b=HoDzpzLlE2bzrYjEQPcD4oMs3ENpH4yyd5pb+p9y4pvJcmw3wo03/L20u6UJBBZ95I
         cd5ZsIPfH2GunlMv/pysmRLTo0IjUJCX+WR2XRbnoWIfiObCFgal1We/RjWrH/6zQKEM
         wtekat4TEsAUsMB53wiKh4HQ7wx/IAF8+XLBk+Dthl+sWkTosMcn1MRRe+g69EZrZ+EI
         ge6WS7wZ6jcOSeUNr/hnt/aESFXIk5JDJxkAUljOuD1bNwkWWgd9lE85f5EuSawrUyvK
         H4t2aDAxgQrgledyZwnX5pJZkTohETRvJ6rIgbmMI8kkNWdqGrdFdVTjo0CXPEivqgRq
         QsJQ==
X-Gm-Message-State: ANoB5plLxx2EFlrnsba4IGgNvhu46Gkoye2NLrp7aZUOEDvM9sD0Y9kv
        6SD2p7Y7TUSEpQgRT638VoO0PiBO59JJ0r0qWjbbQw==
X-Google-Smtp-Source: AA0mqf4BKdfRzMVGdYVC78GLj287VlFFPylImBY9mMzZlCVRzwhU/woID2KDtu9GDCYShjObFVE7+ndAAu8aVAdZGaQ=
X-Received: by 2002:a25:d2cf:0:b0:6cf:e761:43e1 with SMTP id
 j198-20020a25d2cf000000b006cfe76143e1mr20115372ybg.650.1669080674817; Mon, 21
 Nov 2022 17:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com>
In-Reply-To: <20221119081252.3864249-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Nov 2022 17:31:03 -0800
Message-ID: <CAGS_qxqyyH-v4wMJyD1phPP2YA5_6L98C-t4cJtt_SYsSvR3Ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
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

On Sat, Nov 19, 2022 at 12:13 AM David Gow <davidgow@google.com> wrote:
>
> KUnit does a few expensive things when enabled. This hasn't been a
> problem because KUnit was only enabled on test kernels, but with a few
> people enabling (but not _using_) KUnit on production systems, we need a
> runtime way of handling this.
>
> Provide a 'kunit_running' static key (defaulting to false), which allows
> us to hide any KUnit code behind a static branch. This should reduce the
> performance impact (on other code) of having KUnit enabled to a single
> NOP when no tests are running.
>
> Note that, while it looks unintuitive, tests always run entirely within
> __kunit_test_suites_init(), so it's safe to decrement the static key at
> the end of this function, rather than in __kunit_test_suites_exit(),
> which is only there to clean up results in debugfs.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I didn't know anything about the static key support in the kernel
before this patch.
But from what I read and saw of other uses, this looks good to me.

One small question/nit about how we declare the key below.

<snip>

> +/* Static key: true if any KUnit tests are currently running */
> +extern struct static_key_false kunit_running;

Is there any documented preference between this and
  DECLARE_STATIC_KEY_FALSE(kunit_running);
?

I see 89 instances of this macro and 45 of `extern struct static_key_false`.
So I'd vote for the macro since it seems like the newer approach and
more common.

Daniel
