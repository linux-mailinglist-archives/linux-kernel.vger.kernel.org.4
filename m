Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA96284F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiKNQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiKNQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:20:55 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A965C6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:54 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso11055756wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aimDqY0RjB+gPNJoEJ+Cxlak9hzcynx+8kIMR7cwNXg=;
        b=Oo1TZik5Yj/kSw42mUBhFqikMRXd0ud4/4zhVo3uhtZ6ssIQqpo6qeQ5iC7lZ3SuLX
         d59ww4b711eFEncJL1DYyULng3v4+utn8uBxJ/4ieZwx2soFY5zUXF3aSNEIL955qlcs
         n/ewbjNWe2LLJXnKzzamwL3K45yMD3JiqZ1kQQ/2yfugS/urM1Cd+vdtHRGUVR6JvwJC
         Tz1GNHWL1YhWt2Q6nxQj1SLT6p2jufyXfGUMOCkYblDf+l25ZFXRSG4lONLO1Z2K7taz
         BPndwrHSsT5hPKQ5d5fWsYL8kP9UIUlVK43tV/QB+SzsDctB4vkynyO1bh2Wb6CHEGCP
         5P0w==
X-Gm-Message-State: ANoB5pmQJK1ZXKs32/P0nvtZx9aD+C2cR1B0dxFAmtuzt7RASqSy2AXt
        5Up2Ktlc0uTTJBWxdxJ3H74=
X-Google-Smtp-Source: AA0mqf4ZHpEl09T5pIhdlQgRtZ6B5N9kvCzDfoD4OqCmANtXgjpE2X3W8cWsDk92VrkNn24KbhGe8Q==
X-Received: by 2002:a05:600c:3516:b0:3cf:8952:300c with SMTP id h22-20020a05600c351600b003cf8952300cmr8666627wmq.51.1668442852457;
        Mon, 14 Nov 2022 08:20:52 -0800 (PST)
Received: from google.com ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00236e9755c02sm10062259wrm.111.2022.11.14.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:20:52 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:20:50 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v8 6/9] sched/fair: Add sched group latency support
Message-ID: <Y3Jq4gBB5+Qg67u7@google.com>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110175009.18458-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 10-Nov 18:50, Vincent Guittot wrote:

[...]

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index be4a77baf784..a4866cd4e58c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1095,6 +1095,16 @@ All time durations are in microseconds.
>          values similar to the sched_setattr(2). This maximum utilization
>          value is used to clamp the task specific maximum utilization clamp.
>  
> +  cpu.latency.nice
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	The nice value is in the range [-20, 19].
> +
> +	This interface file allows reading and setting latency using the
> +	same values used by sched_setattr(2). The latency_nice of a group is
> + used to limit the impact of the latency_nice of a task outside the
> + group.

This control model is not clear to me.

It does not seem matching what we have for uclamp, where the cgroup values are
used to restrict how much a task can ask or give (in terms of latency here).

in the uclamp's requested-vs-effective values model:

A) a task can "request" (or give up) latency as much as it likes

B) the cgroup in which the task is in any moment limits wthe maximum
   latency a task can "request" (or give up)

C) the system wide knob set the "request" limit for the root cgroup an any task
   not in a cgroup.

This model seems to be what we should use here too.

IOW, for each task compute an "effective" latency_nice value which is defined
starting for a task "requested" latency value and by restricting this value
based on the (B) cgroup value and the (C) system wide value.

That's what we do in uclamp_eff_get():
   https://elixir.bootlin.com/linux/v6.0/source/kernel/sched/core.c#L1484

Why such a model cannot be used for latency_nice too?
Am I missing something?


Best,
patrick

-- 
#include <best/regards.h>

Patrick Bellasi
