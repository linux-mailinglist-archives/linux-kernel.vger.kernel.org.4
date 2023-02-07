Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DA68E33C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBGWET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBGWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:04:17 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A02C665
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:04:13 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r28so13921907oiw.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=18jRupMh16+/uXzavR13DGUSqgv0Qy3QJjjKfXMMewg=;
        b=LYo/mAKBuROPxd9MzX0DM9RM7tvN7Ac3HLu7QqWSivvZSW0dQrVnw81esfrnPdM1IF
         Baf9wAawX9uLiGquIocxaJTcuHP2fy29DrpbacRK2HeXuPdr8FiKKj8f7FAQrWkhNIKw
         tTvNhGoQt8XjYWlKMF1AlcpXyRd9e7m6Uc1V+EHY3ZV+npY3426IoR+g3qlMdtmWEHCf
         I9R+uUUL72SgOu2edFEXRY59cXCOQ+ySY+Kw9e7ixkYx5zd41smEzJDGUDFLk8HVXvCO
         b55JnSbTsLv++LGWlTPrxVkt5xcOdoWAtbvI+UZEwoxjfWNhg0AEcUNWlE+J03qBwAzO
         Bsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18jRupMh16+/uXzavR13DGUSqgv0Qy3QJjjKfXMMewg=;
        b=h1kkUE5vPgtRv6J8FZ+9qjDJ0m/7Lzse6DWXxokh/5wPfE67Wfsuy24VuAbCm9TV8J
         YckdjKgX1WVzwUfLbbhduTNNqbMGoH8hSDWNaRU8NL8QGQzEIj/eBoGb6YgtIkbMmj2n
         uoWiBMiUu2X51j7wKZ5f4gSz6uZjaGxNRfSBPe1tMBPoB3jCQtzHgYfAl5btcYRx+3vl
         h6hZOQXpfzfqlrFgP3IQ8VBrS1XtHdGVP6mwKx+98mkhNa/ZmakDhnfFklKWlO9Fko53
         uvjf+zEk38rSbbhTpHSbMBbPvyD8DY50UX3xEWXM5FyFARxGhzPwperHOf2Ww4Lu7iBn
         79ng==
X-Gm-Message-State: AO0yUKXs0NvzXSyWNufvzTgFshNo+UXCuspQhuGQ/rjpaKD0irfXzISs
        bvEJrwb7WqwUc6oTgqXHHgu+ciNxvf9oPQ98qwIIHA==
X-Google-Smtp-Source: AK7set+BetbNycdErPWad6WA0SzBBdjoa67KDl1WBR7VlRJfzkifphWG/++ZPLv2lbbhLocxRhcGA14MNdAVsdaZq6Y=
X-Received: by 2002:aca:e187:0:b0:378:2684:14a9 with SMTP id
 y129-20020acae187000000b00378268414a9mr29659oig.273.1675807453023; Tue, 07
 Feb 2023 14:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20230204040452.3699111-1-davidgow@google.com>
In-Reply-To: <20230204040452.3699111-1-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 7 Feb 2023 17:03:59 -0500
Message-ID: <CA+GJov4EV--7zdORh2wy2eN+YY3Wc8RJR0Y05gsu-rHqp3s5oA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add printf attribute to fail_current_test_impl
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
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

On Fri, Feb 3, 2023 at 11:05 PM David Gow <davidgow@google.com> wrote:
>
> Add the gnu_printf (__printf()) attribute to the
> kunit_fail_current_test() implementation in
> __kunit_fail_current_test_impl(). While it's not actually useful here,
> as this function is never called directly, it nevertheless was
> triggering -Wsuggest-attribute=format warnings, so we should add it to
> reduce the noise.
>
> Fixes: cc3ed2fe5c93 ("kunit: Add "hooks" to call into KUnit when it's built as a module")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

Hi David,

I have tested and reviewed this and it looks good to me.

Thanks for fixing this!

Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>  lib/kunit/hooks-impl.h | 4 +++-
>  lib/kunit/test.c       | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
> index ec745a39832c..4e71b2d0143b 100644
> --- a/lib/kunit/hooks-impl.h
> +++ b/lib/kunit/hooks-impl.h
> @@ -15,7 +15,9 @@
>  #include <kunit/test-bug.h>
>
>  /* List of declarations. */
> -void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...);
> +void __printf(3, 4) __kunit_fail_current_test_impl(const char *file,
> +                                                  int line,
> +                                                  const char *fmt, ...);
>  void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr);
>
>  /* Code to set all of the function pointers. */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 51cae59d8aae..c9e15bb60058 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -24,7 +24,7 @@
>  /*
>   * Hook to fail the current test and print an error message to the log.
>   */
> -void __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
> +void __printf(3, 4) __kunit_fail_current_test_impl(const char *file, int line, const char *fmt, ...)
>  {
>         va_list args;
>         int len;
> --
> 2.39.1.519.gcb327c4b5f-goog
>
