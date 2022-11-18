Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1262FFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiKRWH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiKRWHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:07:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B23A7C2A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:07:54 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k4so4415884qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pojgnIa3yng2KeOHm7wwCrEJ0fgeI0WPAxB+/uOvwqM=;
        b=BwyNh1+rdJu96LlHA3PC1MOZUU6OGfAEg0/tTi+QC3LJoTPhce1Ta4CvWzjrgf4+Sf
         DTwyzA6fhfEAh6di13kUKXRKwBstF0zE2/NNYalqp+WdAU1IJmbCGLK0ZIGaiaqa2xUm
         civ9S76Llz+rTYBme/YQ+goRH+/X0k8/EanB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pojgnIa3yng2KeOHm7wwCrEJ0fgeI0WPAxB+/uOvwqM=;
        b=CdF90rP+2ODz6cd5esPmAe25kpcrw/coegFL7g++hlhZAahzbjW2dboTYrcEpulJWC
         50slldI+Am0tGNxZoJXKTVQAHV8X7TJoscEBkETKVhgwmLSeLHmer4aoKGQyr90Tx4lY
         1PpamD7uEsSBbbT20G95sc6UlOKpkap4Zyst34Q24guY61UK2jqXW26a00Kw1dPDSY+O
         n792QL4P/4/4iJHYyTyxvLJ73rAYPBX/qHIJ62m7+E2TfEa10QbPSsklzNsTxrkMU7QG
         6ZeOW5IGitDhEa3TP20zcunmgDLNzqWtyIorbuPJyvaH+/52Fx2aXm/OYB63O80L3kzJ
         yexQ==
X-Gm-Message-State: ANoB5pm5NHZcx0+HYjy7ytveIcdU6KWsVf+eLDu1tCnKm97QIf1IIzCK
        RaKHCgPN8QktqAIyIEWLLijD3774rTpMnQ==
X-Google-Smtp-Source: AA0mqf52guTt4eB/tdYLBr3RGAfTa8tsMEcewMcs37lL+6dcrh9rP6XbyjfiEfW3zSlFik9Eam9NXw==
X-Received: by 2002:a05:620a:9c3:b0:6fb:4a84:1c1 with SMTP id y3-20020a05620a09c300b006fb4a8401c1mr7718053qky.387.1668809273007;
        Fri, 18 Nov 2022 14:07:53 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a448100b006cec8001bf4sm3369998qkp.26.2022.11.18.14.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:07:52 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id g10so4420713qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:07:51 -0800 (PST)
X-Received: by 2002:a05:620a:1fa:b0:6ee:24d5:b8fc with SMTP id
 x26-20020a05620a01fa00b006ee24d5b8fcmr7692107qkn.336.1668809271549; Fri, 18
 Nov 2022 14:07:51 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <CAHk-=whmq5gHrKmD3j=7nB=n9OmmLb5j1qmoQPHw1=VSQ-V=hg@mail.gmail.com>
 <93fa81ae-d848-58c2-9f70-27446bf9baa8@google.com> <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
In-Reply-To: <20221118140346.b9026301b4ba03e43e15aeca@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Nov 2022 14:07:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrA5F=cJ4yk6C5uyg2VniwFMHp9U_DLBB-9uZbqdd25w@mail.gmail.com>
Message-ID: <CAHk-=whrA5F=cJ4yk6C5uyg2VniwFMHp9U_DLBB-9uZbqdd25w@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Fri, Nov 18, 2022 at 2:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> I'd prefer that approach.

The "that approach" is a bit ambiguous here, particularly considering
how you quoted things.

But I think from the context you meant "keep them as two separate
series, even if the second undoes part of the first and does it
differently".

And that's fine. Even if it's maybe a bit odd to introduce that
locking that then goes away, I can't argue with "the first series was
already reviewed and has gone through a fair amount of testing".

             Linus
