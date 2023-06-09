Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92DF72A65E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFIWt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjFIWtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:49:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9EB1BD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 15:49:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bacf685150cso2092266276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686350993; x=1688942993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7LcE7DmhrKMXXWImGgQOysWtlJyoq2oM0rOKEdtOQ4=;
        b=xQzU3QbeUFY9kXkPMqupSx1mbwmp8HY7Gjsko+d4ljRkOYSFYYoBCKiqBD+K0e64x7
         OQKiO89c4ipJHDAp6BE5z5tRd0+y1i6PoWloWqG5zLtk156WXfNOmAeGSS16gnVeaXZi
         HCUJc1bb7RwdbySv7XPzUiRwmBl0GNX4R25V/qa+CwwsZDp8JYozPrPjRgs090O+QfgS
         3LiL3RU5gg97idhpJl7UGwKAl5oyho2VWzaM+Vi5v69BH8bMNabbhTlVxvQzI00rtFZ0
         WWzkcOrOZlDH3SqDLxNRZWOGAMdxjG4yJv4eG0r9HwINBwc+4KFunp/Q9sH5ufhdsY2y
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686350993; x=1688942993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7LcE7DmhrKMXXWImGgQOysWtlJyoq2oM0rOKEdtOQ4=;
        b=X+BSXHJOllZONbiu6lPOBPvv22ia0V6B6uQSa8Gj+dnz/HCTnoe+ZcFFa+MSTUQfea
         lv8B7WyS3r8hxrQ/Cz7y6slEpywAsQGeYAxfziTfkkYqRPXBQ61ANYkTy/bDy7j3fgdG
         sZmyvizKZKon5TDaLxMiQuv9RCzaMhpCJ1/9odkhT69WA33ytFoamMvLlxZ4vXe0rgJa
         ChocS0UX72Xlg/y1LEpAtvms6RC6l2YqJ9C/vqKYxnKDb9qa4lOMbP3wkum+c/CW160D
         SgyQ1rRwLJDnaPp5LW9L4pRWoH0E0ffvPggHVdj8/mTjQdvIOFY+LXCMAuly41iH0LQY
         xa+A==
X-Gm-Message-State: AC+VfDwUpGrtwdZUtHWBRJ2JesHXniivqaMy24TUYQfRlaH9iYlfoL6m
        C5U95noex84Qp51p/h+g1GG2y23NUg+kK5YZ73xh2Q==
X-Google-Smtp-Source: ACHHUZ6mmiRZ0jv2+d2Uu570QrMziKru6AqEYGX+uEv01g69PSZikjPuqX5se+lF0xNb+xWQlic2XbN4m8dMSmAaOaQ=
X-Received: by 2002:a25:df10:0:b0:bac:b478:d215 with SMTP id
 w16-20020a25df10000000b00bacb478d215mr2433487ybg.9.1686350993473; Fri, 09 Jun
 2023 15:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-6-surenb@google.com>
 <ZIM/O54Q0waFq/tx@casper.infradead.org> <CAJuCfpE4VYz-Z4_aS3d9-8FGtQ-F4f7adYcJqRk3P3Ks7WPgQA@mail.gmail.com>
 <CAJuCfpG9JeHBKF0fzqR7xpDufpm7HVwgfbQVDeKYW24TWkpckw@mail.gmail.com> <ZIN/VSepGu9HAi42@casper.infradead.org>
In-Reply-To: <ZIN/VSepGu9HAi42@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 15:49:42 -0700
Message-ID: <CAJuCfpGMhN6+D1vCZ1vcr0PE1FJvNFcWZwuTp504njCm1XU2ug@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jun 09, 2023 at 11:55:29AM -0700, Suren Baghdasaryan wrote:
> > Oh, after rereading I think you are suggesting to replace
> > folio_lock_or_retry()/__folio_lock_or_retry() with
> > folio_lock_fault()/__folio_lock_fault(), not to add them. Is that
> > right?
>
> Right.  It only has two callers.  And I'd do that before adding the
> FAULT_VMA_LOCK handling to it.

Got it. Will make the changes.

Thanks folks for the review!
