Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA221642270
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLEFEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEFEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:04:07 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF713D6C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:04:06 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3c090251d59so106747527b3.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 21:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDW880diX7mHRZdhC0FMBpf8ZaAd6FKghQ3113HgW4I=;
        b=HZsN7G7YvTSC26S5K6Yc3T/p6JpRuK7WTPsGnqOVEkU67s3G9u58fjA0Ju52+XQPee
         0wtlIqpD29Jb5oMkjmUw7r4PTbkUHz0zGYsrBrbebm1Hnznf6dpL/Wu2aZoUxTnZfUE5
         YOpz+AK/fiqDRVlAul2Qw4w2J3vh+q7jYnVI7OSGxj2q5cGMAFfrmn5OoaYaqkee77me
         JsLJnN8tX0ZfqKRhGfrd7+3h7IZ/SeUaNkNBsd8iq6UU0LGqo511zTMNjDAq5Fsg+Llq
         ASQxILTct11B2nBufTkQkHPC1tKLpaY1u4/oFFv94244gH2c5babP+gj7eeuna705F5/
         TWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDW880diX7mHRZdhC0FMBpf8ZaAd6FKghQ3113HgW4I=;
        b=S0HUTln1DXN+aZWSdbi77hBOishJBVQR8nk7R8dffTDMsG6T4mKPNfm7SApw4fcYxq
         QR5I6WQ+6R51gfqeyGcEhO3mVoqh+QbuYamhZLYlXy2yjSwxhBIaei+ahXVydHq1BkmO
         I9G4rra9bgkrs/HwRpM4PisfBj8DxJhIop/pjsVS2zpoKasvADwzSViEvGbY9FTPDGaf
         mhAvxTKyKAK1ZvBKmOGLt8h2SXRjzALqHJrYYn2ILYXHIIxmY1pJuXpX4GNCNRL5on4T
         aVozyigQGypEQdzubhaBGtItmB9kNRgb9FLU4ZHOQh1aRfy+YmlbZMAOxWnUOQ1SCv43
         HS+w==
X-Gm-Message-State: ANoB5pmSLjIXgrrTZ6yPTuUDBvlZovONaVx+5fGofvoUjPDhymuSQ2wu
        ynrv8fndnJCay8yXcuRyLMhIt3cvAk4GiUtlK8271A==
X-Google-Smtp-Source: AA0mqf5XyktmFCkM1RUHPDrxXx11hDtfGD9Cpd/rThn1uHWbRRKsqVnJdRq+WlWAOPBHJxXnEHDHzLJxZH9FOxhKRJw=
X-Received: by 2002:a0d:d5ce:0:b0:3ba:29f1:1ddc with SMTP id
 x197-20020a0dd5ce000000b003ba29f11ddcmr42585153ywd.311.1670216645962; Sun, 04
 Dec 2022 21:04:05 -0800 (PST)
MIME-Version: 1.0
References: <b8b96ee0-1e1e-85f8-df97-c82a11d7cd14@google.com>
In-Reply-To: <b8b96ee0-1e1e-85f8-df97-c82a11d7cd14@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 4 Dec 2022 21:03:54 -0800
Message-ID: <CALvZod6Np0uqpSCVL-x=pS7uq6FDVUfBstTZE3fYwK4=WvfdFQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix swapcached stat accounting
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Sun, Dec 4, 2022 at 5:01 PM Hugh Dickins <hughd@google.com> wrote:
>
> I'd been worried by high "swapcached" counts in memcg OOM reports,
> thought we had a problem freeing swapcache, but it was just the
> accounting that was wrong.
>
> Two issues:
>
> 1. When __remove_mapping() removes swapcache, __delete_from_swap_cache()
> relies on memcg_data for the right counts to be updated; but that had
> already been reset by mem_cgroup_swapout().  Swap those calls around -
> mem_cgroup_swapout() does not require the swapcached flag to be set.
>
> 6.1 commit ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> already made a similar swap for workingset_eviction(), but not for this.
>
> 2. memcg's "swapcached" count was added for memcg v2 stats, but displayed
> on OOM even for memcg v1: so mem_cgroup_move_account() ought to move it.
>
> Fixes: b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
