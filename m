Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793169340D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBKVja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBKVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:39:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3611674
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:39:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so6436930wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xBpfjQs53Z/vP4xVPdxfYKFH+U3LxXkK1o+VPt/Oi8g=;
        b=R7/eaeBH0rSwxf4SKitKDJkaCfR3iVTX5RrUHlBiDcKSvNxGfTwQ4NDa0SHQ0fdw25
         e4aK3jZWEhOLO5VXllmREs5e/c7egvzvskveANqSiMRDpiwuuRV7T25373fo/ckoqxt8
         wjCP+rZcngJDuPFNQB6bM4R+O/EFIZ/rruAfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBpfjQs53Z/vP4xVPdxfYKFH+U3LxXkK1o+VPt/Oi8g=;
        b=d3FO1vPHlWGo8xro3kv3gYKxZce9k4aEyQiIRz9x2Rl3e4QfsdB6Obl3PjK7oLRdpi
         rj3j1BoPNL1x9FzOk9RkMOAbQ2fE7cVoDZ1841sgEY0ba5tH5ee0s2uXKiUS/8vDXZ3X
         DT7DapRPFMJsKA2pt38fr4WN8StpfbWh9D7jvdjBsnPu13bcGezyqoaZ4lV6OMhP+2dK
         kFMeEBLlOok8VaAce/eFhzGh5AAofyGS7HnRgS+8YnEDZ7guKJPgyDDmMKUgZA3kSTAF
         wlEjL7hJpshmPnh3BQBioV3bVC1Xivv3qNhN6CRIj2ws3kBjXDO5Uv0Ux8zIffecLbFC
         KJmw==
X-Gm-Message-State: AO0yUKVG6LzcWy+psPTxa+yXYC+F28n/UqSjKSQDzK2Tkw4zeYFSdn0S
        BnpgHpHAPfYqDt6Pn3rOwsbyQHc0cgUN3Z5wQ1M=
X-Google-Smtp-Source: AK7set+sjF4DtOZTjcZ/a2iIdX5453CiVJnuD/rqpUV/ncDWof1e2376ryEPbbJ/k1EvJVL4wbXsYA==
X-Received: by 2002:a05:600c:4384:b0:3d9:ef72:190d with SMTP id e4-20020a05600c438400b003d9ef72190dmr15718210wmn.19.1676151565911;
        Sat, 11 Feb 2023 13:39:25 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003e11ad0750csm8249400wmo.47.2023.02.11.13.39.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 13:39:25 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id lu11so23678455ejb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:39:25 -0800 (PST)
X-Received: by 2002:a17:906:16c2:b0:8af:4100:28e5 with SMTP id
 t2-20020a17090616c200b008af410028e5mr2421071ejd.0.1676151564825; Sat, 11 Feb
 2023 13:39:24 -0800 (PST)
MIME-Version: 1.0
References: <167613641114.2124708.9785978428796571420@leemhuis.info>
In-Reply-To: <167613641114.2124708.9785978428796571420@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 13:39:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
Message-ID: <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2023-02-11]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Chen <david.chen@nutanix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 9:28 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> * A patch to fix a page corruption caused by racy check in __free_pages
> emerged on Thursday. It's caused by a change merged for 5.10-rc1, but
> Vlastimil nevertheless said "That's nasty enough to go into 6.2, IMHO".
> Willy reviewed it, but Andrew didn't pick it up yet.
> https://lore.kernel.org/lkml/BYAPR02MB448855960A9656EEA81141FC94D99@BYAPR02MB4488.namprd02.prod.outlook.com/

Ugh. That's indeed nasty.

However, I'm now worried that the problem could be worse.

We do folio_ref_try_add_rcu() in the GUP code too (see try_get_folio()
in mm/gup.c).

I *think* that in that case we're good, because in that case the
underlying page is never really free'd (it's there in the page
tables), so all we can race with is the splitting.

We also do folio_try_get()n in mm/vmscan.c (see isolate_lru_folios()).
There we hold the lry lock and find the folio on the lru list, but if
that is all safe then why could the refcount be zero? I guess it's
because the count is decremented before the lru entry is removed..

So *hopefully* the only case where this can happen is the mm/filemap.c
cases, but this all smells to me.

Maybe we should just bite the bullet and say "page cache pages are
rcu-freed after removing them from the mapping", so that we don't need
the whole folio_try_get_rcu() at all.

I think Andrew (and probably other people too) has always worried
about that magical "tryget" thing forever, but I've always claimed it
was clever and safe. This whole thing clearly shows it was neither of
those things.

But yeah, for 6.2, I think that patch by David Chen is likely the safest thing.

Or even just reverting the original commit e320d3012d25
("mm/page_alloc.c: fix freeing non-compound pages") and say that the
(very rare) memory leak is much less dangerous than that hacky fix
(that was buggy).

Because it's a bit dodgy how commit e320d3012d25 ends up hooking into
__free_pages(), even though that's very much not the only thing that
can actually free memory (ie "put_folio()" itself does the same thing,
just for a different class of allocations).

I dunno.

                  Linus
