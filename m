Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3967DD25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjA0Fir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Fim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:38:42 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F6721E4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:38:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so2517605pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXkXWQAWqOhK5zPC17QLJZMm/iek5TrrZTt5bXHKZE=;
        b=hD/fSRxX4tsflwyoHmuD3m8kyxd10JvQ/nQGztp6CPBkoLuWQUV2aohmT+oTUIp2Xr
         8zt52OjV1mgr0JHdk/YbK85SPQcn0VQ4+2/FMCuW8+y4sSGfccivBzzPHxAIqqC7osfM
         32Sw9xwF7If5LRyfSWV2A4y7zTizubIh3U643KFfTNBTKdnJDQZfuxZwhWMvFpI/dS46
         Qu44z39MIuJ99wvDsC5oIAPNEYeIwSTt7xidHEMke5kmhyuAEVZPmsLwbk/zcdPiBvHE
         LImoSAqehO6eduCPB+JAThUBOKaImnKs+c+w8qbAyX6WLT7oOcCq0wLcGj6JqDf1y9Ur
         lQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AXkXWQAWqOhK5zPC17QLJZMm/iek5TrrZTt5bXHKZE=;
        b=vZaHbEfK6XwNskLsj6KGcLTbyZBJp6BD2OHAIPsPNZsqhM1aK3xbDR0MO7v/jloVeW
         oChKrXPSKSIdXim/5+1Gkksk/YhziVa4Pe7xPwLde0rJJYJL9V9ebPKnrpRXTEzo5o1K
         ipwOArusxFgxP74enr7UosXvPvINXBlworE94HKHkd8WaAbrQaLqtggi3mhBOoWeQn7Z
         JD0b35myQ+xidmpsaRmANJpUtCnfPgbpsuhILoLaP/xgvbZoMrn5CizCGS08NZdztnnj
         Hb14EkVSZSVOHWgM5kG3T7SbSTejYZhcd8O8TZd8Cjj7ZonmuQP8idUogBmYou0OkyHd
         7EWg==
X-Gm-Message-State: AO0yUKV8JMhkpbqp2VbFaViHhA5ZFcLJzpORYghFi/XWzwtXzBGP/s+Y
        pYjC5hHobnGlGS3q1zF+boW16uqmERQKdRKAjgBGRRz6csuM3WX+YgZI2Q==
X-Google-Smtp-Source: AK7set9+WPEw09PZ0/16bM6oTLo37eglDexdHgi+WW6q0+Qx2bteLPbTVta2v1sjjOKMDbxqQx1ESiJoXBqfbqVxP/M=
X-Received: by 2002:a17:90a:43c6:b0:22c:4fad:d26b with SMTP id
 r64-20020a17090a43c600b0022c4fadd26bmr70412pjg.162.1674797920949; Thu, 26 Jan
 2023 21:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20230124080350.2275652-1-davidgow@google.com>
In-Reply-To: <20230124080350.2275652-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 26 Jan 2023 21:38:29 -0800
Message-ID: <CAGS_qxq4vWvRJ89477S+rxHYLvnc2xN435GQ4+BvpLgqon8miw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] kunit: Add "hooks" to call into KUnit when it's
 built as a module
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 24, 2023 at 12:04 AM David Gow <davidgow@google.com> wrote:
>
> KUnit has several macros and functions intended for use from non-test
> code. These hooks, currently the kunit_get_current_test() and
> kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
>
> In order to support this case, the required functions and static data
> need to be available unconditionally, even when KUnit itself is not
> built-in. The new 'hooks.c' file is therefore always included, and has
> both the static key required for kunit_get_current_test(), and a
> function pointer to the real implementation of
> __kunit_fail_current_test(), which is populated when the KUnit module is
> loaded.
>
> A new header, kunit/hooks-table.h, contains a table of all hooks, and is
> repeatedly included with different definitions of the KUNIT_HOOK() in
> order to automatically generate the needed function pointer tables. When

Perhaps I'm overlooking something and this is a dumb question.

Is there a reason we can't go with a less-clever approach?
Like have a global struct?
We could memset it to 0 to clear it instead of defining a macro to set
individual variables to NULL?

i.e.

// hooks.h
extern struct kunit_hook_table {
        __printf(3, 4) void (*fail_current_test)(const char*, int,
const char*, ...);
} kunit_hooks;

//hooks.c
struct kunit_hook_table kunit_hooks;

// in test.c
// here all the functions should be in scope for us to use
static void kunit_set_hooks(void)
{
  kunit_hooks.fail_current_test = __kunit_fail_current_test;
  ...
}

 static int __init kunit_init(void)
 {
  ...
  kunit_set_hooks();
  ...
}

static void __exit kunit_exit(void)
{
  ...
  memset(&kunit_hooks, 0, sizeof(kunit_hooks));
}

> KUnit is disabled, or the module is not loaded, these function pointers
> are all NULL. This shouldn't be a problem, as they're all used behind
> wrappers which check kunit_running and/or that the pointer is non-NULL.
>
> This can then be extended for future features which require similar
> "hook" behaviour, such as static stubs:
> https://lore.kernel.org/all/20221208061841.2186447-1-davidgow@google.com/
>
> Signed-off-by: David Gow <davidgow@google.com>
