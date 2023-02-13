Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5D6953AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBMWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:19:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557661BAFE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:19:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k16so3944414ejv.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DdMCs5H/JbVPnWmVGco7GaqG11iC0AcIT5fsrf+QDfI=;
        b=KFhLIbySr50Oa8sCR5/ttrXS+KaoYFaH6AeqV/8/irVu90nmkKYvpyt1TUBsRKxQc2
         iFw2sIJul+x6NLvT3VEF5EcS7gCvG9AeCpfAtltEgntiSmb4MN++sQrtO7ovQ57xEPoR
         +IZ/HqRpLpbx6wQzywccDeDlwK04i5gUsyZEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdMCs5H/JbVPnWmVGco7GaqG11iC0AcIT5fsrf+QDfI=;
        b=dQ9cv31gNT7xEHkUpGW8EXKbO6no4eeBvofNwNrxal9m3/qv7tYj+4+7IPMy2krWhQ
         McMybyCq0VCJiYn+INHjLjwH9eSnohxZQN8E8D4r1Cyjfl8t6QsykvuyynzuVLClwmap
         HguzNi7QdAm7DgLd8b8Bj6dFppyMhMTBgzzjNBMGughkqb2ZuGThZ1xlKBNgjK8h7EfB
         QadcBhtF0BNSU83tXbfOjsUJ98h+kJwlDTdva72UvXUA4SDlQXygJfPBSw9b+H23+RUJ
         0HhrvQHKBfSbPILegr1+lpuJ5mwKbNhcoyh1FbsxI3JJjF0bPmGhDf6LEjTO9qLEIMkx
         cSBQ==
X-Gm-Message-State: AO0yUKV7C6YK5LzYpE3ja2fAyu93guLrEXKciIrONEXFQAqjToGMQoX0
        tc1x3mgL2RHbjwauCKzvhw9PWKEoOAMEOXpvR4c=
X-Google-Smtp-Source: AK7set9mesTA8ncXZbiDErnz1Lz+hIptJVKOJvOoQb5voi7yvIdQtkYuGFI8sWUBhyDudb4m8CzXiQ==
X-Received: by 2002:a17:906:b807:b0:8af:7efc:84a7 with SMTP id dv7-20020a170906b80700b008af7efc84a7mr472663ejb.43.1676326777684;
        Mon, 13 Feb 2023 14:19:37 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709064e8700b0088ad82a8de4sm7337872eju.34.2023.02.13.14.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 14:19:37 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id qb15so33424859ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:19:36 -0800 (PST)
X-Received: by 2002:a17:907:984a:b0:88f:a9ec:dfd7 with SMTP id
 jj10-20020a170907984a00b0088fa9ecdfd7mr268381ejc.0.1676326776594; Mon, 13 Feb
 2023 14:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
In-Reply-To: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2023 14:19:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com>
Message-ID: <CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.2
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Feb 13, 2023 at 2:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Kuan-Ying Lee (1):
>       mm/gup: add folio to list when folio_isolate_lru() succeed

Ugh. I really hate fixes like this.

The problem came from mis-understanding the return value of
folio_isolate_lru(), and thinking that it was a boolean
success/failure thing.

It wasn't, it was an integer "success/errno" thing, and the sense of
the test was wrong. So the patch is

-       if (!folio_isolate_lru(folio))
+       if (folio_isolate_lru(folio))
                continue;

but at no point was the code *clarified*.

Wouldn't it have been much better to write the new code to be

        if (folio_isolate_lru(folio) < 0)
                continue;

to actually make it clear that this is a "negative error return check".

I've pulled this, but I really think that when somebody notices that
we had a silly bug because of a misunderstanding like this, it's not
just that the bug should be fixed, the code should also be *clarified*
at the same time.

                 Linus
