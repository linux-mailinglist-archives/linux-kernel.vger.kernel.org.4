Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15799614408
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKAFGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKAFGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:06:10 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93513FBB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:06:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id l9so8910583qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTThmV3apwKutx5mPZ6rLFzjTx0EoNpOu6L39fUT9iw=;
        b=jichQ0BIDVucR1JWEy0sMvwEeqTZ44mioH3txbRMI8WZtdk1yf/zYtJLo5WGUygq1D
         qp9dPW3+F3mU5rV+iNPfzCEppOl3qxasop7zzWxpcKRe8QxYU/bLTocT/I22AbBAq7w4
         DkpBR4DvurqRwdfbRezK0+SxKcYgazT8TPaRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTThmV3apwKutx5mPZ6rLFzjTx0EoNpOu6L39fUT9iw=;
        b=aXpGJwF+2jplMelJW5JJWRyYfE7f+dWBhApUHEhIZIFOMYLD66bpH9m4anHROybpwj
         rLVMegAFUwQWHXBALUllXxj9NDvO0I6x7IbjqOlLZbIWYDblWJYZHl0xN2U5aqOeHoCv
         OHBwtgUZ1545gMB0MfjqRBW8EWi0Fruyh5FwRzZUT7Oiaj72sOPRBfogPSYN3Fr1YR+H
         2shYa7a/nQTto+BMXCoryVw1AwlPsXi3RUeDKIJpAYQBfHXFjjhZebRMgnHHeNKGMMpK
         Fh93+gzBB3ucmbSkSTBLGfLXcmdvml8i5dSFZlFj6qT6txiRwzsaIdFnevEV9sg5jpe0
         RGSg==
X-Gm-Message-State: ACrzQf2CCYuUCqFiq1xOgWs05RKgLU4Fbu71oiBLOD1SmKdmVRjtRmgG
        1Q1PrtJatLTTMQePRlV2G4zpDEPTF2PcSA==
X-Google-Smtp-Source: AMsMyM7r9UeiA9kEUf8i42/gqbQ8KJ6sRzKE0F98x97lZc0IZ4PC8ti3ZEDOiDgswEibthHEnMQ1nw==
X-Received: by 2002:a05:620a:2185:b0:6fa:9b5:7bcd with SMTP id g5-20020a05620a218500b006fa09b57bcdmr11413978qka.689.1667279166238;
        Mon, 31 Oct 2022 22:06:06 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm5832617qkd.134.2022.10.31.22.06.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 22:06:05 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id i9so6154058qki.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:06:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:6ee:d68b:5b26 with SMTP id
 v9-20020a05620a440900b006eed68b5b26mr11943094qkp.47.1667279164717; Mon, 31
 Oct 2022 22:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
In-Reply-To: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 31 Oct 2022 22:05:52 -0700
X-Gmail-Original-Message-ID: <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
Message-ID: <CACGdZYLcQeFUdZYkkF1L6XzB=3K-eD37A0znYQbr9U2NbXYeHg@mail.gmail.com>
Subject: Re: Why don't we always grab bfqd->lock for bio_bfqq?
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 9:37 PM Khazhy Kumykov <khazhy@chromium.org> wrote:
>
> I'm investigating a NULL deref crash in bfq_add_bfqq_busy(), wherein
> bfqq->woken_list_node is hashed, but bfqq->waker_bfqq is NULL - which
> seems inconsistent per my reading of the code.
>
> Wherein I see bfq_allow_bio_merge() both accesses and modifies
> accesses bfqd->bio_bfqq without bfqd->lock, which strikes me as odd.
> The call there though to bfq_setup_cooperator and bfq_merge_bfqqs()
> seem wrong to me. In particular, the call to bfq_merge_bfqqs() I am
> suspecting can cause the inconsistency seen above, since it's the only
> place I've found that modifies bfqq->waker_bfqq without bfqd->lock.
>
> But I'm curious in general - what's special about bio_bfqq? Should we
> grab bfqd->lock when touching it? e.g. bfq_request_merge() also
> accesses bio_bfqq without grabbing the lock, where-in we traverse
> bfqq->sort_list - that strikes me as odd as well, but I'm not fully
> familiar with the locking conventions here. But it feels like,
> especially since we can merge bfqqs, so bio_bfqq is shared - this
> lockless access seems wrong.

Something on this front, since it does look like in *some* paths we do
call blk_mq_sched_allow_merge()/bfq_allow_bio_merge() with the lock
held, and some paths we do not - e.g. blk_mq_sched_try_merge gets
called directly by the schedulers (and bfq calls it under the lock).

However, blk_attempt_bio_merge also calls blk_mq_sched_allow_merge(),
and it's called by blk-mq directly on the submission path
(blk_bio_list_merge <- blk_mq_sched_bio_merge <-
blk_mq_attempt_bio_merge <- blk_mq_get_new_requests <-
blk_mq_submit_bio), and so we'll call bfq_allow_bio_merge without
bfqd->lock held in this path only.

I can see also for bfq_request_merge(), it gets called under
bfqd->lock, since the only path to ->request_merge() is through
blk_mq_sched_try_merge() - which is called by the schedulers. If I'm
understanding this correctly, and the functions are intended to be
called under the locks, perhaps it'd be appropriate to add some
lockdep_held annotations?

Khazhy
