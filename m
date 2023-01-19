Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC467414E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjASSyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjASSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:54:02 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821E30E97
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:54:00 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c131bede4bso40692927b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hbmn5N3c+7Gw/65T8JMoIPDAauVRxveWrxDyVKiAmA=;
        b=S6oQkRuWnpsm0oT4EY6oDOfbr3SfXlxJH7te7SWEg4g+g+QkCCIHJyVvM61rjUg1bK
         HkfEMCh9wK5lUJodmfbK7ainv+lY3roQVUMfL/HPP08y9A44w50DedT2R8+d8v6OsM78
         F1TH/xLu7+OsivESTUy5pd8reCLyw5qIvwYjlAer3MZE9HacN6KiXvaYX56dy/vQTL6m
         sMkWfVw4nCd+YFJpTFuBVoDSt0VVx0yiFR6Ta24SRikrOGCNJ6oWFq04ugwVJaexrHis
         KMRX04ZxKbH2WCPyNDn4xag8MnSxGtMyIm49/3pOUlsPxEuRxCjxT98j/0u+1IwkNR3v
         eyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Hbmn5N3c+7Gw/65T8JMoIPDAauVRxveWrxDyVKiAmA=;
        b=RJxkkSG4qQAcL7op6dC2Xx7tyadI66jts5VXke/gzRFZwM3+Ibs6LKxkzFZLxSmUNC
         w9KxBv+84pIzXYy0G8eo8TAShd0dwOfNRadeEJGc/lU3NrnzPvpONIX9JqWfJzwfA+ja
         vqLd+bnCi9JOISE8l2Kapbn88CMrRitR6l3ot9aheDIRWwK57ca7zegeNFVOTKkFpJQi
         HyxjmlcpgQ7DTnj1hUFkfVYvhG5Ln9JeuJWvlFkcHsJAv5SNiMrsxO/eQcgaNZ+6kL9N
         PNmYpQMXTyfl6cwR/7ewOFymjTlZ5zFpxBYiAWV9UiQxN6RuKXDT9zOUUEGFkzJZtI8E
         hrxQ==
X-Gm-Message-State: AFqh2kooGyNBcRfIotz7rfRO6FCh26zLM9nZOqNTYW+QdUxQICtb1Byx
        lfGbjacTBAeExGV4E4kN7upz5NYvs/iJDRGYndLXWA==
X-Google-Smtp-Source: AMrXdXvv2B+4vOLYHk76C7CB+4Wx7e94nPDtbp7xYrGWt3A23raxsvG0sNfvN79p2SmRHXJoa8xn07dPoTTQDNsV7Bk=
X-Received: by 2002:a81:1d2:0:b0:433:f1c0:3f1c with SMTP id
 201-20020a8101d2000000b00433f1c03f1cmr1593029ywb.438.1674154439858; Thu, 19
 Jan 2023 10:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz> <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
 <Y8e6lm76fIoT0603@dhcp22.suse.cz> <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
 <Y8hls4MH353ZnlQu@dhcp22.suse.cz> <CAJuCfpF3j5Sx+D5p5QPCHP4jcWZUiYm=FfUNYhc6QyHZQvDgpw@mail.gmail.com>
 <Y8kN3stHeEyAoB+D@dhcp22.suse.cz>
In-Reply-To: <Y8kN3stHeEyAoB+D@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jan 2023 10:53:48 -0800
Message-ID: <CAJuCfpHXvm7XxivP-E1tm5M=E9y9F1W=avDAiDBSTLBNmTcn4A@mail.gmail.com>
Subject: Re: [PATCH 17/41] mm/mmap: move VMA locking before
 anon_vma_lock_write call
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Thu, Jan 19, 2023 at 1:31 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-01-23 13:48:13, Suren Baghdasaryan wrote:
> > On Wed, Jan 18, 2023 at 1:33 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > So it will become:
> > > Move VMA flag modification (which now implies VMA locking) before
> > > vma_adjust_trans_huge() to ensure the modifications are done after VMA
> > > has been locked. Because vma_adjust_trans_huge() modifies the VMA and such
> > > modifications should be done under VMA write-lock protection.
> > >
> > > which is effectivelly saying
> > > vma_adjust_trans_huge() modifies the VMA and such modifications should
> > > be done under VMA write-lock protection so move VMA flag modifications
> > > before so all of them are covered by the same write protection.
> > >
> > > right?
> >
> > Yes, and the wording in the latter version is simpler to understand
> > IMO, so I would like to adopt it. Do you agree?
>
> of course.

Will update in the next respin. Thanks!

> --
> Michal Hocko
> SUSE Labs
