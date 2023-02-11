Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E0693430
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBKWcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 17:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBKWcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 17:32:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAE16AC0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:32:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jg8so23837308ejc.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dh9Mfj+GJ1EDtE88jqp5PZHXrchX7Kr3iI5S46RntLo=;
        b=ef3BEBDJzUmhAk4lbobcyVovew4ssFMQo3+OgYMkMwyjLreYQTqxte5LkLxtJPntii
         MDCGE6/rNX52nAy3smz5Ylt3YEECyBL7ovNUVv0eRFQ1dADmJkRTNqx0WlrYU0QOeWuN
         9/rYMJ5nC2TE4ZXIrWKHcpApr7fLFpkCR5OUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh9Mfj+GJ1EDtE88jqp5PZHXrchX7Kr3iI5S46RntLo=;
        b=y0qw6sNZcUVCCs2xV7NjZ7gHUhaMZRpqolES+1QCqS84OvUnjEtgZQkzajnrkWqrMV
         LGC948HbzRcF6N5OlRD16xI8rDv2bXsbWyIKgYNkRYGLb2wrlXU/Zl510u+8g08ty2uZ
         4x+DfNZ/SSVf9qlzr9juS3SUVZGItjPoNZ8vgx/bvjC/Q8Qf+fCC8hEHFpa9bvXKKUPZ
         NRD8IwrDeimvopJNcydiTV51qrgZImZeXFgds2viAU9Uyp5e7HHu/cV9dHUgMgPCMsUZ
         N8roWRU3KvcyJj6Lg3QCCeMiTPVBJAU+LCOwdW/8wWmSKqPKXFmwi5xeWzF7ldmnVbpy
         lVAA==
X-Gm-Message-State: AO0yUKVQSnKv10ymVcb7yYTZjvrVkjbmYFw5c5RlW8AujP4A29JN+yfR
        sp8GDG7exK+ocCvvsGxhkgYybhahMPPJ3C1jDLpJDw==
X-Google-Smtp-Source: AK7set/eFtfIrcqXsDityqoDVsvoBYv82TtTaxzBZ6TW1lfOllvK8ZeUj6Mq69QCk5ecB8JzBO9hEQ==
X-Received: by 2002:a17:907:6d05:b0:880:3129:d84a with SMTP id sa5-20020a1709076d0500b008803129d84amr26883328ejc.60.1676154731824;
        Sat, 11 Feb 2023 14:32:11 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b0087bd4e34eb8sm4385341ejj.203.2023.02.11.14.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 14:32:11 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hx15so23766958ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:32:10 -0800 (PST)
X-Received: by 2002:a17:906:fad2:b0:88d:d304:3424 with SMTP id
 lu18-20020a170906fad200b0088dd3043424mr2691969ejb.0.1676154730590; Sat, 11
 Feb 2023 14:32:10 -0800 (PST)
MIME-Version: 1.0
References: <167613641114.2124708.9785978428796571420@leemhuis.info> <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
In-Reply-To: <CAHk-=wiEJa-R50PTYPyAQDs02OAyK+Oqr67x5nxns=OKXCEf6A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Feb 2023 14:31:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whncfNmZmWe4yh-M=DXYT6L6Eq1r=UYKdt57=4jUmKbTA@mail.gmail.com>
Message-ID: <CAHk-=whncfNmZmWe4yh-M=DXYT6L6Eq1r=UYKdt57=4jUmKbTA@mail.gmail.com>
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

On Sat, Feb 11, 2023 at 1:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or even just reverting the original commit e320d3012d25
> ("mm/page_alloc.c: fix freeing non-compound pages") and say that the
> (very rare) memory leak is much less dangerous than that hacky fix
> (that was buggy).
>
> Because it's a bit dodgy how commit e320d3012d25 ends up hooking into
> __free_pages(),

Actually, that's not the only dodgy thing about it.

It assumes that any multi-order page allocator user doesn't use the
page counts and only ever has a single "alloc" and a "free".

And apparently that assumption is correct, or we'd have seen a lot of problems.

But it *also* assumes that the speculative page alloc/free was for one
single page, and while that used to be true, the whole higher-order
folio code means that it's not necessarily true any more.

Or rather, I guess it *is* true in practice, but if you ever want to
enable 16kB folios on some filesystem, that commit e320d3012d25 is
just plain unfixably buggy.

Are we there yet? Clearly not, considering bugs like this. But it all
does make me go "Hmm, maybe we'd be better off with the outright
revert and accept the unlikely memory leak for now".

Willy?

               Linus
