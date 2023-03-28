Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E56CC52A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjC1PMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjC1PMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:12:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDF1024F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:12:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i7so15514603ybt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+YmdZ2KifzhfvJEdg7p7f3TJNPgCoNZqPs2Cx2ndxo=;
        b=QxwODGEreqDxcIBzupdiBDMaDhVMLLzdv5CfZ77spG0lhFRud2y5nLrWzzAe/C6t7j
         ZOeI1MwZhgbHKufRmNFroSj3WemqRteMnB4I3zgWlrAqlMt2LkDL2uFa+Q4rzDU1486c
         dNNfXBmijmlYD705lBNf01BTyrCyDOrSF9RzPetnYAB3AYPpNLJYWV3MaUX8PnUEt/zX
         ZWmL0MYGGLpvauhUzo75H6kPcjwi3fp70mN3e4rJpmVhTv/25ZngEpNST6bZiJzZmjXl
         eT2y5J/uzC+53+JC7JZ5kq/eruzL0a+NXlhHEm6lqmXJr8zdho9ORG1Eq0Et9AmoG2T8
         Vnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+YmdZ2KifzhfvJEdg7p7f3TJNPgCoNZqPs2Cx2ndxo=;
        b=xPQa75QfQ6UKTl4migLZKWGnSInzDmMEFt/B++fErY+0DE9NXv2VoPRlALE2SMTVTB
         fqD/z//wIW0TvLqeLcq6syjI9EvYKuyYgYit8p97j8B38oYXG9F8slQ3iPHMZrc7ykJa
         HjP70gYtgDiXGw/0S3Ad0oO+PCI0Iw1Xv373IdPbXbZ3mN/zghYW/+Q6rMSqfbwxW4HB
         TXV77Jk7vmBT9vl7T9CLr19Ih2SHYll3cQZzPIRC0ESHsGFAlJaadUXRG+3S2QGw2j9R
         bYUL14h17cWqlysMxTAaArHQGXAEcQrq0VnApJw4hGLugK1OzuuNNkhVYOLPaPKb/Btd
         U4Fg==
X-Gm-Message-State: AAQBX9euYVW/ywgrerfJD4byaFUX1L1eykiHx8BhCKwa3ym/9g8mYdGC
        7+aE2d0ae8mNQlI1gCBXuwa+WnuPu1vYO2mAyyryjw==
X-Google-Smtp-Source: AKy350Zye7Uz+A9wXvm0bc/VbyhY+/GQhhowJbGOvGnmquTK5nbpQG/LFKJZLvFUfYERcKgtllJiz9XGHkAhkgNpcPs=
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr10160590ybn.12.1680016193782; Tue, 28
 Mar 2023 08:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-7-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-7-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:09:43 -0700
Message-ID: <CALvZod7ekQD-ygrv2M-QZzDFVTj7O-v7iCYOHKp3iqG6c-Rt1g@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe contexts
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
>
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
>
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> this function is changed to call the atomic version of
> mem_cgroup_flush_stats(). Reclaim and refault code paths are modified
> to do non-atomic flushing in separate later patches -- so
> mem_cgroup_flush_stats_ratelimited() will eventually become non-atomic.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
