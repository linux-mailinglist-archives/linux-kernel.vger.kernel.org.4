Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4161733F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKCAK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiKCAKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:10:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7609B6456
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 17:10:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so392914lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTt5Hwf9q7zQLFGFeLEaHnYrxcK7Q/WIxewploP8MbA=;
        b=nj+eHqLt86/rg8+wPud1VSUPQomasZbDiEDENgYSjE3jOLq6+RqNjwsxXvThLmgoyy
         nkAQ5odp1K3VvYwPsBt7LEUnUms4vgshfEUFxPlmw19LF8jKYGOPoi07qx7bk0CAsy4n
         e9XSgFbo7BIUE2nGi1a6m873itYr672G/cfzxw+Ob0/hCUaUgOjuX9ZZI7BgY7o58dKH
         90OlRABBMcSzCYoPz02TH3ZukzAzohGqn9iQo+Zl1UGmPT8cGCmz8BWigYZG93ot9EMi
         ZlBeoZ9rlPShxL6mI9Vjq+8IfhdWeD74G8MwAMuLN2BkjfbxuBWPXD6MUcmgVSbPA704
         0luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTt5Hwf9q7zQLFGFeLEaHnYrxcK7Q/WIxewploP8MbA=;
        b=C+mon4PHq3901m47/PDhU1Y6B7Wb8gXdwtu7UzM9u4dtEqb2VnrbxFDTrWc149T7zT
         YYF2geAE9cbJZXmEYK8YGJJ2T8ayRj+9YnyqD94/i2vxh1AciqqttsLQBipdv+QKgAiw
         HFzpzeAt9NszXRxniGXG+M1Js3yyvxjaT0OgHmsPQLCp/0JdQDKITrDRnDaqQMjCFHTd
         N8ed+lyPcwjZyzyHbMv9yroF1GTOQqpUrpcvwFq3TOrplCrga9odL2dJT/4slcPd74p4
         DxyLXYz2rirfkRdCq15BfInFd/+ebnPy02eNoFy5XhBQT4122pZJeflc6SxdqAvz2pId
         uogw==
X-Gm-Message-State: ACrzQf1z0eYJNgfexuz6DT9hlhg++1Bs+ji+Pvnl4e16gH22FibD+1TE
        mjIqHYgnPGLtQwLOq3EAlt9X/RDxhanLr/6n1xouJA==
X-Google-Smtp-Source: AMsMyM5pY6axmK0wlFDEWkxrgyE5qqm4t6fdLQ3NVfHCGneDlHam8PX8iolC0Q/RczBx2T48mAzcVKgVJvoiE3wILdg=
X-Received: by 2002:a05:6512:3a89:b0:4a2:fbe:5573 with SMTP id
 q9-20020a0565123a8900b004a20fbe5573mr10128646lfu.546.1667434220601; Wed, 02
 Nov 2022 17:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <20221102165922.GA31833@blackbody.suse.cz>
In-Reply-To: <20221102165922.GA31833@blackbody.suse.cz>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 2 Nov 2022 17:10:08 -0700
Message-ID: <CABk29Nsjbex9VYw01HQN4Bgvrf66w2YDfpRLuns2nDt5UxCjUg@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,

Thanks for taking a look.

On Wed, Nov 2, 2022 at 9:59 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don <joshdon@google.com> w=
rote:
> > To fix this, we can instead unthrottle cfs_rq's asynchronously via a
> > CSD. Each cpu is responsible for unthrottling itself, thus sharding the
> > total work more fairly across the system, and avoiding hard lockups.
>
> FIFO behavior of the cfs_b->throttled_cfs_rq is quite important to
> ensure fairness of throttling (historically when it FIFO wasn't honored,
> it caused some cfs_rq starving issues).
>
> Despite its name, distribute_cfs_runtime() doesn't distribute the
> runtime, the time is pulled inside assign_cfs_rq_runtime() (but that's
> already on target cpu).
> Currently, it's all synchronized under cfs_b->lock but with your change,
> throttled cfs_rq would be dissolved among cpus that'd run concurrently
> (assign_cfs_rq_runtime() still takes cfs_b->lock but it won't be
> necessarily in the unthrottling order).

I don't think my patch meaningfully regresses this; the prior state
was also very potentially unfair in a similar way.

Without my patch, distribute_cfs_runtime() will unthrottle the
cfs_rq's, and as you point out, it doesn't actually give them any real
quota, it lets assign_cfs_rq_runtime() take care of that. But this
happens asynchronously on those cpus. If they are idle, they wait for
an IPI from the resched_curr() in unthrottled_cfs_rq(), otherwise they
simply wait until potentially the next rescheduling point. So we are
currently far from ever being guaranteed that the order the cpus pull
actual quota via assign_cfs_rq_runtime() matches the order they were
unthrottled from the list.

> > +static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
> > [...]
> > +     if (rq =3D=3D this_rq()) {
> > +             unthrottle_cfs_rq(cfs_rq);
> > +             return;
> > +     }
>
> It was pointed out to me that generic_exec_single() does something
> similar.
> Wouldn't the flow bandwidth control code be simpler relying on that?

We already hold rq lock so we couldn't rely on the
generic_exec_single() special case since that would double lock.

> Also, can a particular cfs_rq be on both cfs_b->throttled_csd_list and
> cfs_b->throttled_cfs_rq lists at any moment?
> I wonder if having a single list_head node in cfs_rq would be feasible
> (and hence enforcing this constraint in data).

That's an interesting idea, this could be rewritten so that
distribute() pulls the entity off this list and moves it to the
throttled_csd_list; we never have an actual need to have entities on
both lists at the same time.

I'll wait to see if Peter has any comments, but that could be made in
a v3 for this patch.

Best,
Josh
