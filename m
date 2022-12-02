Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAA640EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiLBTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiLBTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:43:17 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E42AA8CD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:43:16 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h15so2484017ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=of7uVX1tXYOzviZXLnVMaGfqQG4lADtgdnHuJ5eU4J8=;
        b=Hjyg7ElN0qzCGB7na9HaUNn7ciQAT0b5qOatwgrfMuVI8j/sV5jXT0FFQY/GI1o1qC
         AcczKv1OlDCC2eJzSdLDvg/tSJdISvhiRx2JUnskBQ54VvwOov89yEj+4Pjm4vCMD57Y
         ehzOk8IOa4UMEVIOZeyyYOx766NiGzY+WI0MPE4EZW2+9KmOlRuoWKFhIm/EzklGuJDK
         eVo/w9wt/Axw9kLT1MkqxEFIlc30vO989++RzYyvu4zlErOjlCFeJNGWtm1eJWP/DXQa
         t7yf3zo3aKJx/8lIZk0zMYfs1bpH+FBS4NklapQa6OxLyamj+a8GB9Tuf6quubMFgtbZ
         kHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of7uVX1tXYOzviZXLnVMaGfqQG4lADtgdnHuJ5eU4J8=;
        b=IIh8Nm4EMmc1GJDPbVR36DernBjJHeFwVKDtDFz2+X/TaM7nZ3aHjxn7dDsFUJSiGo
         PK2UbO5cUeEZLR4bBT0DuA+FggRch4+Gk5kl13cnT1jsaQ3M+tTDT9HBCN8jW4h872J5
         kvNNMNsKRjY19au37pbygeFMiu7KNow91Xy5hfeziy2eQqWMb7e6pBEtDAZHFbyebtJq
         rRiiVk2M/OL1ZMWE5+gg9Nj/vx96etXX4EUeEv/yon0IUYqnGGxn4TdDEudtsdhnxjrP
         jPPhzxIU1fEIBfH5RGX+ZWVk/5dHXf4Im4IJf+Wq901EWcK2ewr5eLxDMJhqdqz2uCE4
         QWiQ==
X-Gm-Message-State: ANoB5pkHe6K4hEnBvb4/s+kgsqzNDY7BcpESNC0Jnatga+bhZXXdbpEY
        rEmJc5hfpLlCRMu1QIwAuaOydgHYbDW2y3HlwNqn8VbDHnvoNmBm
X-Google-Smtp-Source: AA0mqf5vOr9B1OU2Kl1NzZ7MyNVHUUPr7ggM2JuciN0rkZ2xGqqig1ovb82pzSOmo204S05lutg74iv4GrrL5Q065ec=
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id
 d9-20020a926809000000b002f94d925b2amr24412987ilc.177.1670010196130; Fri, 02
 Dec 2022 11:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
In-Reply-To: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Dec 2022 20:42:39 +0100
Message-ID: <CAG48ez190wrwM57AiC6dsxtXYu84OcSgJOAc+q8a9H5pntoq7Q@mail.gmail.com>
Subject: Re: brk() in v6.1-rc1 can expand file mappings, seemingly without
 taking file locks
To:     Linux-MM <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jason Donenfeld <Jason@zx2c4.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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

On Fri, Dec 2, 2022 at 7:53 PM Jann Horn <jannh@google.com> wrote:
> As of commit ca57f02295f, brk() can expand ordinary file mappings (but

Sorry, that was worded confusingly - I meant "ca57f02295f is the
commit from Linus' tree on top of which I was testing".

The broken code seems to have been introduced in
commit 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand
existing VMA and add do_brk_munmap()").
