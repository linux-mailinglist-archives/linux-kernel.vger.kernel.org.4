Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF086A47AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjB0RPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjB0RP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:15:28 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1681620D22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:15:27 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id bd34so3990781pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WtDYUcEtrkrxOUpSmav/ZoelpyxeItymkIhkfXewTIA=;
        b=fxvd/sGZ4cd3hMipU96tDjuqrFuauWmjHu+IQCFmZqHd2pG8y8qhSL7qhvFEJ64B9D
         WogoIX9xMe1ApQYE7cxfo09uGX/cuRY9xLUtwEgSZ7K/9dKHQPLzMbMwJvZcJ9Xxmtxc
         P8HwSDLfBMaReuJtEEAdk4TX6E4McHoKG/07eAr6JJuT/uKNrOXBErjRwF47cj+Hf+ve
         FVjTFV8fds59jf8H7cX7f1qOoC23NQ91vhUQ+Ny2UVpYFp5+yXFEoEEgdDAa7tXi8lSu
         AMIrX9m6t5/I7UFhwkNxKdh7nEktuGCUth8vkVAaWwkg643VImE5s9PNlSo/rIyRYnK6
         MNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtDYUcEtrkrxOUpSmav/ZoelpyxeItymkIhkfXewTIA=;
        b=Dab9gdT+w5cAw51qWIc4HQ+1yhNdWh+4GsdyvPspuuVkO2IC1vQ/RdlRCgjb8nAkID
         BVcv7cxHMJBO8neSqB8Y/culuHZoyj6jCJLAxgJeFIBkRqwhYzAM+B5JnbxyPcmD8sog
         0heVRu2IaS5gLoaruOfnW5OlutE870d7u3tF3tMTjpB8zUgsB+7+IugjGzH3cCMx+vKJ
         LUPQ6i/elhwZFZco//ESS7nTLPdPixq1sAC6MkGAuADinfg6IGQ6MencxYUAWJcmyKf9
         GedVuQeJ3kEV9gGw3Svk1NzD/3QZTNj5FvLz8yY8MwPQV2K++yLsRkiHOQVE2hm5fXLR
         weLg==
X-Gm-Message-State: AO0yUKXcStQwygVj5BvPxIOlw1YbgBVfzEgKoZBU94zf3ZeTydmR3If7
        vZqiImSKIPSlKlse2VmUmFptbHlmW/Jn0ufQgqAyrg==
X-Google-Smtp-Source: AK7set8eUYxZlt2BI+9YM9QKjlPowIIOFy2WqJercvpRiTSmulKspm5DeUz96qmkTktZUPS19u6hNFCfbtNJHAVSE60=
X-Received: by 2002:a05:6a02:302:b0:4fc:27e6:56fc with SMTP id
 bn2-20020a056a02030200b004fc27e656fcmr3204856pgb.3.1677518126492; Mon, 27 Feb
 2023 09:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com> <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com> <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
 <ccd80042-39ef-f9ea-c2cd-eac5bd0e8095@arm.com>
In-Reply-To: <ccd80042-39ef-f9ea-c2cd-eac5bd0e8095@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Feb 2023 18:15:15 +0100
Message-ID: <CAKfTPtCvy0qbEYJ3A935Cf0t_NPg=0B8-HagTwxmE+0hA1gfSw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 18:00, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 27/02/2023 15:37, Vincent Guittot wrote:
> > On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
> >>
> >> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> >>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
> >>>> What scares me, though, is that I've got a message from the test robot
> >>>> that this commit drammatically affected hackbench results, see the quote
> >>>> below.  I expected the commit not to affect any benchmarks.
> >>>>
> >>>> Any idea what could have caused this change?
> >>>
> >>> Hmm, It's most probably because se->exec_start is reset after a
> >>> migration and the condition becomes true for newly migrated task
> >>> whereas its vruntime should be after min_vruntime.
> >>>
> >>> We have missed this condition
> >>
> >> Makes sense to me.
> >>
> >> But what would then be the reliable way to detect a sched_entity which
> >> has slept for long and risks overflowing in .vruntime comparison?
> >
> > For now I don't have a better idea than adding the same check in
> > migrate_task_rq_fair()
>
> Don't we have the issue that we could have a non-up-to-date rq clock in
> migrate? No rq lock held in `!task_on_rq_migrating(p)`.

yes the rq clock may be not up to date but that would also mean that
the cfs was idle and as a result its min_vruntime has not moved
forward and we don't have a problem of possible overflow

>
> Also deferring `se->exec_start = 0` from `migrate` into `enqueue ->
> place entity` doesn't seem to work since the rq clocks of different CPUs
> are not in sync.

yes

>
