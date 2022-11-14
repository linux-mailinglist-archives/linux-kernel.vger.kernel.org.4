Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9A6284F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiKNQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbiKNQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:20:32 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB16B21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:31 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id cl5so19194207wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA9Cqqpconpun6OrI6kW9ZiN+AtmOmJQh1MCCxtYmaI=;
        b=JFNx/oetTYrZ7cNS1te5ZvNBEzgnwgEjVIN/a6zwG7W5gy4gMWNJ/YvutIP161s3pc
         tHGTM6FHpOTm2ood+WNZeTlCfiqWHUCk7I/MBgj8HytZZmXQpK4R70thoKU9aV7RGPPR
         nxjUg9IfjwjYKHQv3N0i7eZsuuhO9UqEs8Tjg92mhfpTsk2COTyyZjZ3CSgdD4Pc0niV
         RRLvwfyUZry6+G071ELS30GZLEep/90npCjk140dgVGAT9NIYqTwUd0W6m5+HNCgQp7k
         vQ5G4lmd3Es5NpV9K248sqdlDBjg3RDSCq4/tjM6EbC0C1TdzddYN9KV54aZRuUOSJBB
         Izyw==
X-Gm-Message-State: ANoB5plKkZmGyG95MaIppSzs35LUeFOX0pAcE3LLj4EW0vYzh72TznlW
        r6QIdsbGv5B3yl/5MFCf9X8=
X-Google-Smtp-Source: AA0mqf7+TN54xSe9LmWylYugTOIKnX+CszNB8roApTrxToIqrSBS0p87x1YVGP/xlWtkGNqsuUX+gA==
X-Received: by 2002:adf:a1cf:0:b0:235:83aa:a6f0 with SMTP id v15-20020adfa1cf000000b0023583aaa6f0mr7815751wrv.623.1668442828846;
        Mon, 14 Nov 2022 08:20:28 -0800 (PST)
Received: from google.com ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003cfd42821dasm9968080wme.3.2022.11.14.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:20:28 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:20:26 +0100
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
Subject: Re: [PATCH v8 5/9] sched/fair: Take into account latency priority at
 wakeup
Message-ID: <Y3JqygejPxrtTFgP@google.com>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110175009.18458-6-vincent.guittot@linaro.org>
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

> diff --git a/init/init_task.c b/init/init_task.c
> index 7dd71dd2d261..b8ddf403bc62 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -78,7 +78,7 @@ struct task_struct init_task
>  	.prio		= MAX_PRIO - 20,
>  	.static_prio	= MAX_PRIO - 20,
>  	.normal_prio	= MAX_PRIO - 20,
> -	.latency_nice	= DEFAULT_LATENCY_NICE,
> +	.latency_prio	= NICE_WIDTH - 20,
                    ^^^^^^^^^^

For robustness/consistency, shoudln't this be LATENCY_NICE_WIDTH?

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b2accc9da4fe..caf54e54a74f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1284,6 +1284,16 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  	}
>  }
>  
> +static void set_latency_offset(struct task_struct *p)
> +{
> +	long weight = sched_latency_to_weight[p->latency_prio];
> +	s64 offset;
> +
> +	offset = weight * get_sched_latency(false);
                      ^^^^^^^^^^^^^^^^^^^^^^^^
As per my comment in patch 1, we almost always (but one time) call this with
"false" and that's not returning the sysctl_sched_latency but a possibly
discounted value in case of feat(GENTLE_FAIR_SLEEPERS).

Just to avoid confusion (this could be not the sched_latency) and to better
document the code, what about using a accessor define something like e.g.

   #define max_wakeup_latency get_wakeup_latency(false)

?

[...]

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
