Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4BC63C85C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiK2T1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiK2T02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:26:28 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6596D94F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:23:50 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fz10so9673090qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n82HVyeen1bMmFClFboMPGWDCdQZFtBvU3cG7O5fWI8=;
        b=MRtFC7hP8CY2xCqHP7rCYvfijtDEx8rfOpofNAGAenjjigPd8l2z/ynJKCzqdXRCs8
         8HqKcLlgR/Mh3Tm8fr5tI6H4dPIaUzK6LWHUAO8HRk8hG7k2Hl4tln+GqsEjL9CQGtlL
         znctiN96cf02+vcvkm8/vyh2JwKTdgt8JgeZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n82HVyeen1bMmFClFboMPGWDCdQZFtBvU3cG7O5fWI8=;
        b=zIvlQiskYb5GVmDI5a/c8CJzAhrQsHgHekDT4N9EEpJ63pSZGOTpRrhWLurh9K9wtu
         86iK7r5KckfbEQDaNX5F6BooyCT6bzjo0fuGRBWUloLeXsaksI46XFKv6rn8loF5Po3c
         1ry2f2q5dGOBTvyqYnlV5bxwRyrWiVxqp9452df4xTMcsizmYwi+W/3e8aUfywfVavYL
         Gy8KD4p1sUFPsdmHuVJ5HRN/ucrutRMOm28wrH6azJs7+EiuRh7aCWvTO/5eht2OoPvV
         zSrc+kjWwT8NaNq/9Wtz5gdtvrGvM8OZlONHeqNh9JgiIT2p2PAtsBVS46+mqudrlJmc
         cu5w==
X-Gm-Message-State: ANoB5pl+/zuzLY5qMBO8evZk5PYuxEIkAbrsHDZ7NTBi/nZudBznxom7
        EXc8moVSs3F6HVv70zK7PnTuIv6JNilq5w==
X-Google-Smtp-Source: AA0mqf5N0EsCUXwqskV1mG1MboJ2hgWU0noeW26uCy2zSEGo6IiSj/uq/IRMtfFKoMBjjil5ppQkmA==
X-Received: by 2002:ac8:7447:0:b0:3a5:75dc:ed0a with SMTP id h7-20020ac87447000000b003a575dced0amr34995898qtr.329.1669749829054;
        Tue, 29 Nov 2022 11:23:49 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a084c00b006ee949b8051sm10718161qku.51.2022.11.29.11.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:23:48 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id a17so8705848qvt.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:23:47 -0800 (PST)
X-Received: by 2002:a0c:80e6:0:b0:4c7:1ae2:2787 with SMTP id
 93-20020a0c80e6000000b004c71ae22787mr1804495qvb.89.1669749826624; Tue, 29 Nov
 2022 11:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
 <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
In-Reply-To: <Y4ZYsrXLBFDIxuoO@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Nov 2022 11:23:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMrsHq2ku9LeO23DnzGMZfQpZVSBFd86rZLLo3Q+H0VQ@mail.gmail.com>
Message-ID: <CAHk-=wjMrsHq2ku9LeO23DnzGMZfQpZVSBFd86rZLLo3Q+H0VQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 11:08 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> We can try limiting move candidates to present ptes. But maybe it's
> indeed time to deprecate the legacy charge moving altogether, and get
> rid of the entire complication.

Please. If that's what it takes..

           Linus
