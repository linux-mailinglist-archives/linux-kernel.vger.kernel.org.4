Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0164C22B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiLNCL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiLNCLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:11:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FEB220F2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:11:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so1091784pgh.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 18:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WTwRd3Vfb9mMXt87QjpBobPhpTfI8kJpvB+zz9Ggrdc=;
        b=COu9NWhJ67WsyFRU2hjs5TqHYciSwbilz5g7t1Z+ZLdU2tlsLG8/wjdXSjlL+xh4fL
         TMm52Td++Ur6X1U2aN7usUppUTFmj3gzAQIpRFzSLODmnigY1ZPgzor5QmG5FrWUfI54
         F3DAd5oL4fsfSNODiB25I3LjQg/mw2oEPzUhCAfAozrLNRmQafMQhx385Oay4gv0pf4B
         Gr1g3okj9Y/xtJVmjj8iRQbdOSolvN5H+gTJnSNZdK5+NKV1TEY2WtkmB1rt0dUdiK2b
         4BwHfVRf2ndDKZkJYOuKeh6AcvgF0PRADrcIpTuCbpwSeyYvi8eLB0JcP8Y+ZCG2Vw63
         28Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTwRd3Vfb9mMXt87QjpBobPhpTfI8kJpvB+zz9Ggrdc=;
        b=YJumjl5gHISkeGiSFmiG10vBxtXl1ozzU+CbfmzVTXM4GceCcTAedme7tiGNlJZZrQ
         fImLbvtQPSYF7Ak5A2boTsvwJRG1f1TkvXnNF3qG5ACQPwrZYvB9eC8YXMZ3bVDG7QQM
         uTugP2+oSoTceH2O7Dm/PhdgqHBI9mgc/3dXYfXIcP5YkPw3s4DWkVqLctepSpPbBzF/
         RGY3Ab4d+sxnWFmIT8i+pUOHtHf4U4iZSQkrzOf+OsjEnajq2NiSRN2B/KdM1trV7vhn
         PuBJHQu3UezhEtLznkXhlRSwhqSZY/uts1QDVpqcgYwZRtkbW+LGbhjfl8o3oWux+jVV
         CZWw==
X-Gm-Message-State: ANoB5pmqz1VJ+GrmYOVT3dFNi1hs8OfXnDOYpemDm0V6We6xXYtOxmXN
        otq2RnAUW9yfLc1q3kfu6t/9Gk34yqetuB/MJ7xAIw==
X-Google-Smtp-Source: AA0mqf5/xweGeEjmBl4DOm2Y/blYrG1UU2cHlX0uIDmT/udC/44xAdbkJ28KzqoV1xcoXbVUpAT8ISGiwe7fi55T27g=
X-Received: by 2002:a63:1247:0:b0:476:ed2a:6216 with SMTP id
 7-20020a631247000000b00476ed2a6216mr77729739pgs.556.1670983911856; Tue, 13
 Dec 2022 18:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
In-Reply-To: <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 13 Dec 2022 18:11:38 -0800
Message-ID: <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
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

On Mon, Dec 12, 2022 at 2:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 29, 2022 at 10:22:42PM -1000, Tejun Heo wrote:
>
> > Rolling out kernel upgrades is a slow and iterative process. At a large scale
> > it can take months to roll a new kernel out to a fleet of servers. While this
> > latency is expected and inevitable for normal kernel upgrades, it can become
> > highly problematic when kernel changes are required to fix bugs. Livepatch [9]
> > is available to quickly roll out critical security fixes to large fleets, but
> > the scope of changes that can be applied with livepatching is fairly limited,
> > and would likely not be usable for patching scheduling policies. With
> > sched_ext, new scheduling policies can be rapidly rolled out to production
> > environments.
>
> I don't think we can or should use this argument to push BPF into ever
> more places.

Improving scheduling performance requires rapid iteration to explore
new policies and tune parameters, especially as hardware becomes more
heterogeneous, and applications become more complex. Waiting months
between evaluating scheduler policy changes is simply not scalable,
but this is the reality with large fleets that require time for
testing, qualification, and progressive rollout. The security angle
should be clear from how involved it was to integrate core scheduling,
for example.
