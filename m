Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25672636905
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiKWSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiKWSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:34:52 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7ACCFEA2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:34:40 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3abc71aafcaso50036987b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tELD2VQL8vhWDECXZ4KBFxXiAPz5Gyk7j2brYG+e7vo=;
        b=MsY086PNmr0Enodb3X6kbiamRzMWU6bqnw3zAK/YhYEIMOzRtWLfMKo/hKzzyBUapk
         QcM9+DGMXq9/qqpaiec63a+VT4ELUKRbyCZ3+ZFDDW1CnwYEe+kwXwuGSUo01eohnJ5F
         C0P7zjWF88GUfhfkn/pJLlJMCoHR8O3Rb5bZIq80jG9kUd83cEOOhuOwSFI1Iv9KE2Kt
         jpufQUaMk2odO6mtmdK7EhfINsOo6DhuZtdaxlQPKXJFdVpjTqlArOKKI+4rFAIbY6xG
         0IMiw8bfVB7sDBvcxZYEOHndyy4gYsLtQor3yHI2KLjKXYbibhvPhJ9Hp8jsRO/bzHn/
         dEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tELD2VQL8vhWDECXZ4KBFxXiAPz5Gyk7j2brYG+e7vo=;
        b=wuOB/lMPEz18uCIjrvvVIR/96vhAacv7v1z2ECDOyx+6k3XZ92hVnRAOd+jXjAXvWG
         PdqUIeve41SAmcpJRah+9rCmepy94bYCUmvfebEFnukYGGuh4Wch/c0pk2WN0oNmLs+r
         6D44zftxKj4n5xWASAoDqzPKxcpnAfnGa0YJIfG8HDO0RfG7jl0f67gyhvWGzDRiI3kp
         diva1Vow7AAJvV9T8ncXBusVQB+VeMFo7HDWUMldJcrl06R65svgZta/fnxNQBfluEgN
         N75jvjBsT1T3rgnTSHpYp2DvhkXbDhg+h5msuBBBROKdCg1cI9l4BxcaCzJjjAXQ70YR
         +FJg==
X-Gm-Message-State: ANoB5pm+aB0SG9Ak5OnzdCC/+SeCA9Oa3AACXJtQqNWbElRcQuj7SQBV
        kyMfAQW2wPh6GJkXHtd1BVxHLyySGSW2Uva+WG99H07UzRY=
X-Google-Smtp-Source: AA0mqf63BwCDKbT1psyyIgHPu4i+Q9UO32S4KaibspypqvHEqagKzj/uhWOYCo3lqz739vZRqbmiJMWRgQX3hLzftlA=
X-Received: by 2002:a81:5c82:0:b0:392:b19b:47e9 with SMTP id
 q124-20020a815c82000000b00392b19b47e9mr12433845ywb.252.1669228479550; Wed, 23
 Nov 2022 10:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
In-Reply-To: <20221123181838.1373440-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Nov 2022 10:34:27 -0800
Message-ID: <CALvZod488YStQ5tucPgc0b3FSwiqFhVJptPceFvaZjj2Ba24YA@mail.gmail.com>
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> rmap changes (mapping and unmapping) of a page currently take
> lock_page_memcg() to serialize 1) update of the mapcount and the
> cgroup mapped counter with 2) cgroup moving the page and updating the
> old cgroup and the new cgroup counters based on page_mapped().
>
> Before b2052564e66d ("mm: memcontrol: continue cache reclaim from
> offlined groups"), we used to reassign all pages that could be found
> on a cgroup's LRU list on deletion - something that rmap didn't
> naturally serialize against. Since that commit, however, the only
> pages that get moved are those mapped into page tables of a task
> that's being migrated. In that case, the pte lock is always held (and
> we know the page is mapped), which keeps rmap changes at bay already.
>
> The additional lock_page_memcg() by rmap is redundant. Remove it.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
