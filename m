Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE9563B0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiK1SQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiK1SPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:15:38 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662431EDE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:58:35 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id g7so5417758ile.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uD2w3R4o515pC/pkYBEngc4fNNJTLw467snghkylLDg=;
        b=YGcVF035901iCot04PiZsjp+j/CJGXvLVBbsEb6sAA4tFxJZLOY213BfGhXf/9H41Z
         o3uFV4CFicd3Nt9oWN+i84+9mVCl5rS6QZwM526D4cAHrdZprwMZzMdoLXXAhGsV4cQu
         h42Lo793gEjy4GY4NorQrgd1lkj1m4HjuV+rg8pTCd8UkL8tx5YtBoOrikBO+Jegqbks
         xvFyBYrCaq8fvaKKIQXDJ1YbftPKQ0kAvTLRXd5oMKQVAw+okr1PE9TGPvSWL9Z8jUkb
         5HnLpJTirT30+XzdWD4V7F7cPE4yjaJttalyNZFwKRDpbxa8wnxVquRFhpMkmjEnbwq8
         4Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uD2w3R4o515pC/pkYBEngc4fNNJTLw467snghkylLDg=;
        b=y61skM0p7rQif8z8hV5chv59kc1sxc7buBsMNfH4InOJCpRq3a9zV3+99H5cIN6Z/l
         0i0tJIn2OO3W7nwBEIvnjDLXp00tIFgWfMa7QMM3TlABpiPlhbk1CV9Mmf3FfdKWCdnb
         MpD+nFKFpWPwekFE+XaTYpcX7n0V3Eq6RdEyJJPUBJ6qdVZ7afg4c5dQhGqxY1Lt+oha
         jo5GGHbKoYO1I0KpdO4UP4cYBL1wCcwiaZ/YaYgdSL5Ty3Yd2EvBdw2JXMRLP4o7ZNmI
         /4v3TRZM2s1pcVTzExhZQ2P7O7eCeApyd/+h4v9DFVSwbJogddIfndpbWg0lsmj/7xjC
         DbvQ==
X-Gm-Message-State: ANoB5pl0595B3twYZubCsdqNwZfmZLJf9fg1k0Vury9KfDFYGekenA6f
        MseC9+snaJVOJQIlZgn/u4txxpHb9Kh3ZBeH+DGciA==
X-Google-Smtp-Source: AA0mqf6d8H769WKotjlx89RVrJ2Q6gqYe2VptBWTK4C8VyNlzUcQ9pHKin6+3TRkLvvF/pNON5zTilb85bSeFLGl48Y=
X-Received: by 2002:a92:c8cd:0:b0:2ff:b56a:3984 with SMTP id
 c13-20020a92c8cd000000b002ffb56a3984mr17822786ilq.187.1669658315186; Mon, 28
 Nov 2022 09:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20221125213714.4115729-1-jannh@google.com> <20221125213714.4115729-3-jannh@google.com>
 <66cfc9ba-868c-9620-fbfc-38931c76ff50@redhat.com>
In-Reply-To: <66cfc9ba-868c-9620-fbfc-38931c76ff50@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Nov 2022 18:57:58 +0100
Message-ID: <CAG48ez23WvRRX6LKgCe+sJMYWBKVa+U1fg7G1o0nOobHCEQBGg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file
 collapse paths
To:     David Hildenbrand <david@redhat.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Nov 28, 2022 at 6:37 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.11.22 22:37, Jann Horn wrote:
> > Any codepath that zaps page table entries must invoke MMU notifiers to
> > ensure that secondary MMUs (like KVM) don't keep accessing pages which
> > aren't mapped anymore. Secondary MMUs don't hold their own references to
> > pages that are mirrored over, so failing to notify them can lead to page
> > use-after-free.
> >
> > I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
> > ("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
> > the security impact of this only came in commit 27e1f8273113 ("khugepaged:
> > enable collapse pmd for pte-mapped THP"), which actually omitted flushes
> > for the removal of present PTEs, not just for the removal of empty page
> > tables.
> >
> > Cc: stable@kernel.org
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
>
> I'm curious, do you have a working reproducer for this?

You're on the CC list of my bug report to security@kernel.org
with title "khugepaged races with rmap-based zap, races with GUP-fast,
and fails to call MMU notifiers". That has an attached reproducer
thp_ro_no_notify_kvm.c that is able to read PAGE_POISON out of freed
file THP pages through KVM.
