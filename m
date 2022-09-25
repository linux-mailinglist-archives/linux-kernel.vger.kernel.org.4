Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD85E9497
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiIYRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiIYRDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FA2D1D7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68A7EB81261
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F534C433D6;
        Sun, 25 Sep 2022 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664125395;
        bh=wt+mZDy4YvA8gmtHTDKqy0I4i4iX1GwGHxWqk6D/Uak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hbIdH3Y6FUgeCxQPNbi72CVz9puHGeo+av3JO16m3Ce+0rhIjrV8W4FKB2VFqIcrj
         /gz0gAnJeKOqtbDyFfnKG7x/Pg8jVw8tDkHAeOiqKW2wKehK8qXlSfBrpIf4rr4wJu
         lG62pIRFUowy8mSLre9DwM+PENnHf3wRazvhUF00=
Date:   Sun, 25 Sep 2022 10:03:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mm v2] kasan: fix array-bounds warnings in tests
Message-Id: <20220925100312.6bfecb122b314862ad7b2dd4@linux-foundation.org>
In-Reply-To: <9c0210393a8da6fb6887a111a986eb50dfc1b895.1664050880.git.andreyknvl@google.com>
References: <9c0210393a8da6fb6887a111a986eb50dfc1b895.1664050880.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 22:23:21 +0200 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> GCC's -Warray-bounds option detects out-of-bounds accesses to
> statically-sized allocations in krealloc out-of-bounds tests.
> 
> Use OPTIMIZER_HIDE_VAR to suppress the warning.
> 
> Also change kmalloc_memmove_invalid_size to use OPTIMIZER_HIDE_VAR
> instead of a volatile variable.
> 
> ...
>
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -333,6 +333,8 @@ static void krealloc_more_oob_helper(struct kunit *test,
>  	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>  
> +	OPTIMIZER_HIDE_VAR(ptr2);
> +
>  	/* All offsets up to size2 must be accessible. */
>  	ptr2[size1 - 1] = 'x';
>  	ptr2[size1] = 'x';
> @@ -365,6 +367,8 @@ static void krealloc_less_oob_helper(struct kunit *test,
>  	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>  
> +	OPTIMIZER_HIDE_VAR(ptr2);

What chance does a reader have of working out why this is here?  If
"little" then a code comment would be a nice way of saving that poor
person for having to dive into the git history.


>  	/* Must be accessible for all modes. */
>  	ptr2[size2 - 1] = 'x';
>  
> @@ -578,13 +582,14 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
>  {
>  	char *ptr;
>  	size_t size = 64;
> -	volatile size_t invalid_size = size;
> +	size_t invalid_size = size;
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	memset((char *)ptr, 0, 64);
>  	OPTIMIZER_HIDE_VAR(ptr);
> +	OPTIMIZER_HIDE_VAR(invalid_size);
>  	KUNIT_EXPECT_KASAN_FAIL(test,
>  		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
>  	kfree(ptr);
> -- 
> 2.25.1
