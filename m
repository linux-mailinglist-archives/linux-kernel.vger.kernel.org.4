Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715061DAA2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKENlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:41:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0E5F5C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:41:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z14so10458341wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEQEeCKAAx7P9RJsBQBEZFuwGhZxQ+qlEBnAty2v/6o=;
        b=FXhh/EaXg8N8cczrsPlZD480pn+K0XCsFaHNnKmjmBFirhUKCyNb2uaXixuFWrR/Je
         SpIoSReIUrmYMi2NiIoTZerZOHqJH8FMa1WR5aWzdR3cqOD+WmREYNK5Fh7DWtmzusbk
         mAW4gXqCxIZ5O3TXExqRH7pH53oBK0khIUBMZlle6ZOeWQFNZbuEfhFMassE7jppbtO8
         Sng6nqhUKE01Knj/7T7YiuH7miHvtGdBxwYuv4gnjpU1cHwQ2BYId/JFIjeRDcm7JLLg
         zDNJVri/NbkUWn5k7a2zVJbwQ2J10L+ljFenrfZKlm4rDvC5ZIIc0tOy0kRS/XMjwN2k
         syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEQEeCKAAx7P9RJsBQBEZFuwGhZxQ+qlEBnAty2v/6o=;
        b=gCle4Y4FeRadYBlByHUO3Tyw9tqe/bYowCHpKZe2u2ImMlogJHQjIOVGFiLU+HybLD
         C/EdYpi+YykJlXE0qI3LUMnTVsa/XcitW+X98SekJiks/KAI9tzytMdzI/gr4HCi0LIW
         cGNAvokyEYQtkUCJbLcJxi6b3TLVREqHxbfEHdoPNuqPJ0JlBJQORaJavceyph4UwH62
         PY1hU7oMgFbPvKxySG1xRg25tZUbWAa9Yv2oJOcdQ0PpAVwhfWeLjugRMtjopnhzpg3X
         NEqXr64fCBxrFw4092iPMuOJP60qi2K2dsaTqO1sApc0BjpMGk3h0HEUXnjvO1NSCqvV
         VrKw==
X-Gm-Message-State: ACrzQf0hMpMC12jBRg8+gYcmBxC7kvuog6WrT1NpGWLs7FoaA5BykqPB
        T1UeraO/prW1v62df3d5GNR/Mg==
X-Google-Smtp-Source: AMsMyM7Me24pzJ8MZeUH4ILUBqQdxtRXVBR7o1wiFDnADxJEjiOHHDU/bj7VR/NYXcuWWGqdkulVHA==
X-Received: by 2002:a5d:6288:0:b0:236:dc84:1f70 with SMTP id k8-20020a5d6288000000b00236dc841f70mr18353362wru.549.1667655698552;
        Sat, 05 Nov 2022 06:41:38 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5946000000b002356c051b9csm2199019wri.66.2022.11.05.06.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 06:41:38 -0700 (PDT)
Date:   Sat, 5 Nov 2022 13:41:36 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221105134136.zmdbjhw5bf7gr7mv@airbuntu>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-7-vincent.guittot@linaro.org>
 <20221101192848.pjns3um7dnrwrk5p@airbuntu>
 <CAKfTPtA=vJQA_=6Un1CqwzMUaOxMeFGTKUZnj8qyqvqmSdYBAg@mail.gmail.com>
 <20221103142732.m5ibwkuymvhcdxkn@airbuntu>
 <CAKfTPtDu=c-psGnHkoWSPRWoh1Z0VBBfsN++g+krv4B1SJmFjg@mail.gmail.com>
 <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
 <CAKfTPtAuJvV117iwnpVpajC6nWPzagtTMk+8NPnGVyukygiFMg@mail.gmail.com>
 <Y2UoR9LqxWInJ90t@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2UoR9LqxWInJ90t@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 14:57, Joel Fernandes wrote:

> > The current use of latency_nice doesn't need to walk the hierarchy
> > because it applies at each scheduling level so the childs
> > automatically follow parents' latency.
> 
> Not really, I don't see how that will work that way in the wake up path. The
> wake up path (EAS in particular) does not walk through CPU controller group
> hierarchy from top level, it only cares about cpuset/affinities and the
> "effective" values of tasks.
> 
> So when you wake up a task, how will you retrieve the attribute for 'prefer
> idle' in the wakeup path using this patchset? The only way is to aggregate
> the CGroup hierarchy information to get a per-task effective value; say using
> a min function.
> 
> If you see uclamp_rq_util_with(), that also is using doing uclamp
> aggregation similarly.
> 
> So I think Qais is asking about the aggregation function in the EAS wakeup
> path.

Yes that's what I was trying to say. Thanks for helping to clarify it!


Thanks

--
Qais Yousef
