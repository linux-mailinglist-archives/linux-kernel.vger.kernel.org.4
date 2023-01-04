Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5622365CED4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjADIx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjADIxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:53:21 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E2B9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:53:20 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-476e643d1d5so352327427b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TC8yBB36dJOtwIcLP7PUotL5XoF8yexyBz9lxLUGOuw=;
        b=U71+aMIK1JfGXVeOOUCgzZlgVwce9KVUK8MsvITFQ12CseoqB11UBQ/yD87mnzls7+
         Udg+lkeJlOaYcHv8nF32vYB1YtXRgmZVOXJYwzodJ0SXj43Vo2tmpYx0T97YU3QtQ48N
         VNs5ze1Wk6x/eU5O9/s7yPpzDCju+/+bnQV620xCvg6WpZ+Q1Q+EJPvJ5X1DMbNM9CfV
         AZdqImG24QcmcXa2S0O3poRunUp6MA5aWd0Il5QwlRhWKs7ulUM0F+6ER2NJzI1zXcgk
         fx5NyH9E5JoAAQTbsbp8xm40ydHd88uUJBmsU+Lbjz0/gfUelgSmAYkGLbfDjA55Lxks
         Y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC8yBB36dJOtwIcLP7PUotL5XoF8yexyBz9lxLUGOuw=;
        b=dLFXQ6iTMymUBjqxdBiTIH4pXWr2iva/t7aOloK6WK4R11bjyBez20jZRaIWSA3KqB
         s6JuWPToI2kNIoDT2AQTFKz2UVuUPdYfX/QdlPcQVQzW8txpoqmdEF9zPbmscqKYFW8n
         N85aDh1/A3BZJ9Iv7EkRcI5+H532a2uIJqKo/NyxD62aitzsxL859qbgCCrZVa9h88GE
         8A+7tqcUbd3Kht8z8hMjN+izhtaoy3Lh35mACtxiolzihNL2iU2v6s1HRjdMUPUOUPVk
         /SE6RULniXF7/2oNcdCZJcgCnoa9kRVUsDGiGnFgPrjt7KWxl8Vu74J8VifJVSyn3kRY
         YAgw==
X-Gm-Message-State: AFqh2koS1ugJ2Mo3Mjb96nlva4X77B4mc83Zw5TPwiH380Vs3ZicWk9U
        PIpFBsD4mSeGGxzf4IY8XsNH9DBdmWNrsjWwktm22A==
X-Google-Smtp-Source: AMrXdXt9RzCN1QGkqr19+W9ziQdaJtNGffrhlj50YdgCTywgjwdfZJaTXWkXPcZr71jOqeDgf/vlqXVyUkhwH0eJvRQ=
X-Received: by 2002:a0d:f083:0:b0:3b2:ce3b:eae1 with SMTP id
 z125-20020a0df083000000b003b2ce3beae1mr5973532ywe.4.1672822399245; Wed, 04
 Jan 2023 00:53:19 -0800 (PST)
MIME-Version: 1.0
References: <f64778a4683b16a73bba72576f73bf4a2b45a82f.1672794398.git.andreyknvl@google.com>
In-Reply-To: <f64778a4683b16a73bba72576f73bf4a2b45a82f.1672794398.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 Jan 2023 09:52:42 +0100
Message-ID: <CANpmjNMBHQxYd4R+s3gsyKrp+OpZLiyVCsKK2TBLzMHGv4urBw@mail.gmail.com>
Subject: Re: [PATCH] kasan: mark kasan_kunit_executing as static
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Wed, 4 Jan 2023 at 02:09, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Mark kasan_kunit_executing as static, as it is only used within
> mm/kasan/report.c.
>
> Fixes: c8c7016f50c8 ("kasan: fail non-kasan KUnit tests on KASAN reports")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 1d02757e90a3..22598b20c7b7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -119,7 +119,7 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
>   * Whether the KASAN KUnit test suite is currently being executed.
>   * Updated in kasan_test.c.
>   */
> -bool kasan_kunit_executing;
> +static bool kasan_kunit_executing;
>
>  void kasan_kunit_test_suite_start(void)
>  {
> --
> 2.25.1
>
