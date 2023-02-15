Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51013698764
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBOVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBOVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:32:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54223659
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:32:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e17so14407plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MR57eWlfIn1DWn6wNrf/ap9PwUGSeldrOE2p4hCtTEo=;
        b=RhrgYu75ZNqbvp/lWXwt2tXhV2w7qDXTHEvARGImZfiH4gPk4F2PM30/J1CSfuQCue
         IDr8z6bJnXqpDcHN8SI9bsgWOD6CjmpzTKT3HxKL9D8vU11yxqZfMsuKVL9H7CNeGJeV
         ax6fBX+3UuhMJEuVdikbhq3D5ti2C1Ppm4oPzpg0Lm/qxWnGdHR7NukZtaqDf8O1Plpv
         QZTnC8sStoenKApRsCkgs3sCpFo/9+o8PqEHTOaxzNl19tBQqOWPInI+ou0lRrhCTpF4
         NDccizFcjLIbhVG1n4GDyyOXkzvRfkTNGSunzOOSXCNHcn7pST7A5LzO+HM6lUN3Drwu
         sSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR57eWlfIn1DWn6wNrf/ap9PwUGSeldrOE2p4hCtTEo=;
        b=X0ZLCifA68LDxZxf0ly1dO2CYNzCqLTKCM99nJkUBtd3wm2dXCMySGf2Jkhxbd9tJk
         1IR6XDPodzo6JUg/r43IjcN8fy8AbsQ3gbqHVnwlTKL2OBaV7NzWCIduunkiBRhj7ean
         aT3aQhUs2vDPDClz77LOyehtDH9OHIE1VffwHHciUsL7cxGuovrJqfkw/GQcv+fpR/f5
         TZl9hNzCibzX7X2YPa3edJz32aazBsfPMfUgwGKfOh1r7v+hn5vkZVHk2H8dxhBJiYL6
         LplnAYo9LyhxrlxxNjMEVlNyaa29zE7kC32+JksxUxEBj3YTygN+mt+oXyDGo6EENpr5
         JJZw==
X-Gm-Message-State: AO0yUKWAkxP/KKOAx6+czE3/6ovTry9llg5P42SiIYXUuKby9DIG2etT
        +5RgWcpQYBP3YvysSjww69EqL89zlf+iuCGsX8A=
X-Google-Smtp-Source: AK7set9aE4FVzzPg3OfkxxY+i2FWQC6OSGOE68jdQ3XKO/+H8X4N+5lBcpNS9QwhG6m+sN6sN4V7ww==
X-Received: by 2002:a17:903:2283:b0:19a:6ec0:50b5 with SMTP id b3-20020a170903228300b0019a6ec050b5mr91288plh.14.1676496736475;
        Wed, 15 Feb 2023 13:32:16 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b0019a7d58e595sm9359140plb.143.2023.02.15.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:32:14 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     shrikanth hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
References: <20230214120502.934324-1-sshegde@linux.vnet.ibm.com>
        <xm268rh06i97.fsf@google.com>
        <cd37483e-bf11-ec74-c240-74935bb44809@linux.vnet.ibm.com>
Date:   Wed, 15 Feb 2023 13:32:12 -0800
In-Reply-To: <cd37483e-bf11-ec74-c240-74935bb44809@linux.vnet.ibm.com>
        (shrikanth hegde's message of "Wed, 15 Feb 2023 16:31:29 +0530")
Message-ID: <xm26bklu4ntv.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

shrikanth hegde <sshegde@linux.vnet.ibm.com> writes:

>>>
>>>              6.2.rc5                           with patch
>>>         1CG    power   2CG    power   | 1CG  power     2CG        power
>>> 1Core   218     44     315      46    | 219    45    277(+12%)    47(-2%)
>>>         219     43     315      45    | 219    44    244(+22%)    48(-6%)
>>> 	                              |
>>> 2Core   108     48     158      52    | 109    50    114(+26%)    59(-13%)
>>>         109     49     157      52    | 109    49    136(+13%)    56(-7%)
>>>                                       |
>>> 4Core    60     59      89      65    |  62    58     72(+19%)    68(-5%)
>>>          61     61      90      65    |  62    60     68(+24%)    73(-12%)
>>>                                       |
>>> 8Core    33     77      48      83    |  33    77     37(+23%)    91(-10%)
>>>          33     77      48      84    |  33    77     38(+21%)    90(-7%)
>>>
>>> There is no benefit at higher utilization of 50% or more. There is no
>>> degradation also.
>>>
>>> This is RFC PATCH V2, where the code has been shifted from hrtimer to
>>> sched. This patch sets an initial value as multiple of period/10.
>>> Here timers can still align if the time started the cgroup is within the
>>> period/10 interval. On a real life workload, time gives sufficient
>>> randomness. There can be a better interleaving by being more
>>> deterministic. For example, when there are 2 cgroups, they should
>>> have initial value of 0/50ms or 10/60ms so on. When there are 3 cgroups,
>>> 0/3/6ms or 1/4/7ms etc. That is more complicated as it has to account
>>> for cgroup addition/deletion and accuracy w.r.t to period/quota.
>>> If that approach is better here, then will come up with that patch.
>> 
>> This does seem vaguely reasonable, though the power argument of
>> consolidating wakeups and such is something that we intentionally do in
>> other situations.
>> 
> Thank you Benjamin for taking a look and spending time in reviewing this.
>> How reasonable do you think it is to just say (and what do the
>> equivalent numbers look like on your particular benchmark) "put some
>> variance on your period config if you want variance"?
>>Run to run variance is expected with this patch as the patch depends
> on time upto last period/10 as the basis for interleaving. 
> What i could infer from this comment about variance. Please correct if not.

My question is what the numbers look like if you instead prepare the
cgroups with periods that are something like 97 ms and 103ms instead of
both 100ms (keeping the quota as the same proportion as the original).
