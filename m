Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AC9643786
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiLEV4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLEV4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:56:16 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29551218F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:56:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id h6so2756853iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cC7ZM3itu4XmclOIPc55YEuaARhUE6mDokgemZhoJX0=;
        b=lWURtoNPamkBoYDP9BONRNGIovt6ceE8B2EGn0FtEdxaUCMnG7dKEAW1xkk0xUqc23
         H+yhnD6JpqpkOcI/JoPyCjHDb9dBnWorQH/ftN/ORMIQ6KAD0UgOBV27pC+JyAGrcfTt
         ctAvCCzw57ioKz6+p/XGoPhYMFzKOIaHjDIrJYdCdUWMKe0U8rtDNFJyawq8v4SF0ol5
         LnBYmPJdaieEkGewpJHXJqR7rQOK/9M2w/uvtlL6tpPM1cW2dW9yPqBplhygPvmiGfj0
         FM27OkM+pneyo0bc9AwFZnxFuPDe5PaJwoj47I5jr6NdXjpl5bLthKlIjaIDrkUrwBtk
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC7ZM3itu4XmclOIPc55YEuaARhUE6mDokgemZhoJX0=;
        b=yHpP8wxZl5g4rXhLP35ofSsYSnWEBDDxdQOglrqFJwB0LmI8ALHDMCbzcDiK6w38vq
         r1rKFlFthHUjNSDmlJr4wh6nJH51Tw3HZv1ltII8xAJ2qf4BBq1mTz73i3/9HRAtkFDB
         1ixvD01gwiDU/o7V/hO8wuS0TwdNVEXbMyk45uD0i4dcqMeHjYW6cx84mVWJvJ6S4kaJ
         b/zU3omOLnoGhJ/AJWj8FuDH2bD9Ned8DTpp6zoAdGxw39AVHMJHm0oT7TU8T9n8flsq
         4Ljn2jpGyjwLniqsmfkJ6uXVrAdSORPRPwOZd0+EZYClChHt0zvyCC5I4JQfPPk9dl1u
         opzg==
X-Gm-Message-State: ANoB5pmT6Ry6akFdisWcAQuY0Ak8Fdm2C2waXONR3GLwdJQg/eXGCADR
        yntCUo3zaUMpvbgiyJtCWjqWhaHrrrJlkgDIXaGXbg==
X-Google-Smtp-Source: AA0mqf6QWBW0dWqGvEHQmRY/u07Th9LetpMw6dWiAp3T2hSExNJk781bENNoZfLQuAjT4FuEXDfGvnOVp2rWQLPIy0I=
X-Received: by 2002:a5d:8f84:0:b0:6d9:56fc:ef25 with SMTP id
 l4-20020a5d8f84000000b006d956fcef25mr29317501iol.56.1670277364483; Mon, 05
 Dec 2022 13:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20221205192304.1957418-1-Liam.Howlett@oracle.com> <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
In-Reply-To: <20221205123250.3fc552d96fcca5dc58be8443@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Dec 2022 22:55:28 +0100
Message-ID: <CAG48ez26s0R6DsPKJ1dUomwSwCfhWcpQD6Zb0GU0rbYcFD1hww@mail.gmail.com>
Subject: Re: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously incorrect VMAs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
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

On Mon, Dec 5, 2022 at 9:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 5 Dec 2022 19:23:17 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > Add more sanity checks to the VMA that do_brk_flags() will expand.
> > Ensure the VMA matches basic merge requirements within the function
> > before calling can_vma_merge_after().
>
> I't unclear what's actually being fixed here.
>
> Why do you feel we need the above changes?
>
> > Drop the duplicate checks from vm_brk_flags() since they will be
> > enforced later.
> >
> > Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
>
> Fixes in what way?  Removing the duplicate checks?

The old code would expand file VMAs on brk(), which is functionally
wrong and also dangerous in terms of locking because the brk() path
isn't designed for file VMAs and therefore doesn't lock the file
mapping. Checking can_vma_merge_after() ensures that new anonymous
VMAs can't be merged into file VMAs.

See https://lore.kernel.org/linux-mm/CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com/
.
