Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A76826A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjAaIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjAaIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:38:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674851B56C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:38:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 36so9513997pgp.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0YOgb1qqY+eYSMvEeNHP+Hqfb8/SIN7dXd5+Q8wSDw=;
        b=ISQTBSXKp5vZheNDNbgJgxc8QhRpCjt4p/8zTq2lmx/K/QORLle9hCl0aRHYNmE7bA
         DAIbYEOe+wqRfihl5meXLKnT2L1jCw/qdo+UDM0JpmbttQdugF6PoRuPWMHTwR0+6iL3
         +4qgQxUfNJnZx9exU/Ov6WHNn3Z24QFcPDGk30U8fvL8+buiDP8YMrw+vfBP4uSvUPjd
         7NZVEJZUr0nc1qsQNpcpw7Q7O49tf1lLq9Sc+uPD2bQmZB1ZzVzAl1mdH7YSCil2WP5u
         +zkoZx0eflRnKw4IuL7RKYSrJ8Hb8G3OykIwmA75G7aBoc4rAMFMw4/gnvDuy5FMZgQV
         jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0YOgb1qqY+eYSMvEeNHP+Hqfb8/SIN7dXd5+Q8wSDw=;
        b=jxnTLfAHhVMTHZIWsW6IPJ5o7qPUYy+gSnBaKGan6ILbgE7fo9zNjfDYyf9hd3R1/+
         75OIwy/RAWlCQTyeZu+l0hC7YhlSWmMY3dK4XsamDMj/T6sSAi89K4mQcV3M27C3f3Uc
         nsgX6mnJljQcT4hXzGQjcgKrZ4T2y6Kz8o18jh5V6mcP0FLO6C6Kcb6yeEEw9Yu9/jaL
         2DqbmTzfkMpVVf4hSsQ6QaRvv91zLxDyygY8aaa/qTrkcb9ad8dj4CClj68J2oDwCxD/
         cjC+K3HscQDgZFizXdrXRImMq5K83ochRYU4yFwZawCotJpkXOSruYX5pwYXcU99vPse
         9Dow==
X-Gm-Message-State: AO0yUKVpzAlRasBu/sIofdE7jQr5uV1VjjNHEBuCNG0ygbA0NDIO5x6T
        mI80TeRpf8gblhMuSi7KSG0=
X-Google-Smtp-Source: AK7set9V4v10dCKnXellHnRjZZLAYKhT7gKtrOZH79TXD4DPm7ZFZxn/mEmSjdBWDr+GYGEfwIHscQ==
X-Received: by 2002:a62:cf43:0:b0:593:a3f1:7c04 with SMTP id b64-20020a62cf43000000b00593a3f17c04mr8372501pfg.8.1675154287816;
        Tue, 31 Jan 2023 00:38:07 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t63-20020a628142000000b00585cb0efebbsm9089629pfd.175.2023.01.31.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:38:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:38:02 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v4 1/3] mmflags.h: use less error prone
 method to define pageflag_names
Message-ID: <Y9jTahuqsqID87aU@hyeyoo>
References: <20230130042514.2418-1-42.hyeyoo@gmail.com>
 <20230130042514.2418-2-42.hyeyoo@gmail.com>
 <Y9e5qD2whT3+xDMD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9e5qD2whT3+xDMD@smile.fi.intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:35:52PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 01:25:12PM +0900, Hyeonggon Yoo wrote:
> > As suggested by Andy Shevchenko, use helper macro to decrease chances
> > of typo when defining pageflag_names.
> 
> Suggested-by: ? :-)

oh, yeah I only wrote in changelog forgot to add the tag.
I think Andrew will kindly add that when picking this series up?

> > Link: https://lore.kernel.org/lkml/Y6AycLbpjVzXM5I9@smile.fi.intel.com
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> LGTM, thank you!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you a lot!

> -- 
> With Best Regards,
> Andy Shevchenko

Best Regards,
Hyeonggon
