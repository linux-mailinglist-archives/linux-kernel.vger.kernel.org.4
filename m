Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365E67107C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARCBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjARCBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:01:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D0521DE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:01:13 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4b718cab0e4so449251607b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4E07Mrlokbjok8NyF8LoBrAZNQWCs1UWN04ZvvsKt1E=;
        b=k9nZqbAy6zimnKuDQP5Wi59ksf9yl4aqdPitA84ns9UlmkktReAp9H08OJzyEbCc9J
         jlDJGMFtUt+DQUFCjpFjACsoOm7c2T8Ko3BIWmNfotQIa4DTLkedyccK3mJJ5Ty52tU7
         Pjqt7Q630XACChklgKzdcQGHFItj196tBjXccVmZpdBJCyn6CNLYisPTgri5QyuUVR+7
         dmUvvZbw8Qidf7u0joBcNRjhlVUuqFpoLv2ThdeXP2UpNCfOLsBXBlqXHkBQXH0g/JiS
         Ag8FlCGONB7nFbeNMrZ59yFKtUHJpRow7tNRX5eRbp7wzA9oeEkB6FFhJC81J/OTedMt
         9Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4E07Mrlokbjok8NyF8LoBrAZNQWCs1UWN04ZvvsKt1E=;
        b=NqkOzkf30clDOc3duIngOoW9kFccEmWfAXYgZV/9Lq+lhrCrGT7JC6JCqaOyrlg+EC
         XsbmKhWhw+kHyFi1jBFeQG6cfkQP63tO9wiY1wVtxwwY1CTvFDIv6+/uCzk4PIP2JoLX
         WAEz6fooDAwKg7K9UTzmA0rw2J5mR6+cLTrBgFqAb0WKck8iC5eZgAtUSI1S6bi5n9hk
         LRINe69pTNyLnaeTERS+Bov7hTVlDxwjX6q1cYY1di7iiqqaGn9Y2wbaeyNtHfYf0MIn
         J5+FmJM2rB0D1XZ331LJNSJi4tnSTJP37VYnZ1ntjvzWwUQVPR/YPO2+lZQLAdhu2Z+a
         YK+g==
X-Gm-Message-State: AFqh2kqwiYCC2G9ZZnFHCNnCSs7tX8dM/NMpS68CxgCepA6V6R0FaF+J
        nYHcmUCsK8+R1zHIuU33B4JnEkDofwaaWceC16jqqw==
X-Google-Smtp-Source: AMrXdXsZWeD7TD1LZKXqm18TxRLwIraaKkRGisl2ohrjniYmFM7Qtmaw6wJy/oQcDtGLbtaO2lGyLeazDPZnc+XZmGs=
X-Received: by 2002:a81:1d2:0:b0:433:f1c0:3f1c with SMTP id
 201-20020a8101d2000000b00433f1c03f1cmr704506ywb.438.1674007272153; Tue, 17
 Jan 2023 18:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz>
In-Reply-To: <Y8a734ufLZjPHgtT@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 18:01:01 -0800
Message-ID: <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 7:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:12, Suren Baghdasaryan wrote:
> > Move VMA flag modification (which now implies VMA locking) before
> > anon_vma_lock_write to match the locking order of page fault handler.
>
> Does this changelog assumes per vma locking in the #PF?

Hmm, you are right. Page fault handlers do not use per-vma locks yet
but the changelog already talks about that. Maybe I should change it
to simply:
```
Move VMA flag modification (which now implies VMA locking) before
vma_adjust_trans_huge() to ensure the modifications are done after VMA
has been locked.
```
Is that better?

>
> --
> Michal Hocko
> SUSE Labs
