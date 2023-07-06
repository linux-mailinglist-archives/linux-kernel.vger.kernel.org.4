Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEF74929E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGFAao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjGFAam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:30:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA119A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:30:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so83151276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688603441; x=1691195441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDNtb8VGNsWJMd94B1yvjb9baMo04ogysNrDvAUSWkk=;
        b=iPWV8L1jyHGFjgPG1e5DkKfQtY3x/CGt89+fMJ/bu3j/1cV87OyziFgyMwLBr32FHf
         eJAll/hxbFiau5yzj/0Xxv1XL4TrpqOek4oJPr+TWFqHfOyLAo4Ezfs6GXxb8GDL3nTT
         rraj5yM6rOwTWTUhoQ6EFOEPYXTzSqqYg6EqUuuh3uhasSCtxx6M7pB8nzeUxR9IEkai
         es1f/vIFQs89by4IxE+GjuqppQ5L53M6CJWf/ZaQdW0DW3FBm7fBzko1gzm6lkd3KqcN
         n0EHMop9F4f72B6zSYgFWgSG/QvKNC3uvRcsaZXjFndUnGrWi8n8AVKq5CKgDTEQR4px
         wpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603441; x=1691195441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDNtb8VGNsWJMd94B1yvjb9baMo04ogysNrDvAUSWkk=;
        b=N7p372AHFFneIlE5S17QUDtziEMFT51beQ56U5qNqBpy94yARfJBkqPv/J7px9EhGB
         5qR3/96eZqne6DFYICINSYECGxkV/nJ00xU6d6C2zRoAx2P2ZSD1pRz/4MPGOaHIX196
         RuBcVOzsd1iM9x+D594UiEVxgnEEd2EM5Syt7Rn5oKwc7cnry3F4bZC83e1+6dev7QsK
         Scr0L77nJMoSYl3gGfvrGK11kpt4dJoyImvZDnFJTE3P4zpNvMVCh7znG1/e4cDJOq76
         UkUpqQoHUuP+qrK/2VYZSSNBe3bY5G5OuGer9V2NCwmTf/3A2c/G297KPzuFs3aEvvrs
         RIRg==
X-Gm-Message-State: ABy/qLb6oDKgBcqVSunxWGqH3YWRRONmKw3A5RjJ3u4ZlDjPI6vroKb9
        JcmKeU++5kIiNeyjJW7z++AI4qjRMp4I9i7Kt/nchA==
X-Google-Smtp-Source: APBJJlGTkJWTILVgZXDRlL1p0hLqObb6Qq5zIIPhh84UNi8OaQy1jTvMQiQf1KyO7Y1YLXWRj8pKQK81+RRrsDVVNdk=
X-Received: by 2002:a25:98c6:0:b0:c0b:7483:5cdb with SMTP id
 m6-20020a2598c6000000b00c0b74835cdbmr342231ybo.35.1688603440921; Wed, 05 Jul
 2023 17:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
 <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
In-Reply-To: <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:30:29 -0700
Message-ID: <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 5:24=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > I was hoping we could re-enable VMA locks in 6.4 once we get more
> > confirmations that the problem is gone. Is that not possible once the
> > BROKEN dependency is merged?
>
> I think "no".  By doing this we're effectively backporting a minor
> performance optimization, which isn't a thing we'd normally do.

In that case, maybe for 6.4 we send the fix and only disable it by
default without marking BROKEN? That way we still have a way to enable
it if desired?

>
