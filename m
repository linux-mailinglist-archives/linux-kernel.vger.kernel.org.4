Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697AE73A187
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjFVNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjFVNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:11:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7991BD2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:11:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ff29d0dd1eso31043051cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687439481; x=1690031481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkEBNBPB7p37IMo+amIH4z6XxA/lZNBkaf1MRNBrflY=;
        b=FGTSnQX8TrM5BmL5ib1AYN1S8uKceRwjORo/f+e06anur6h3COHPAJEP64+LsXNIs3
         2ySpgY6v8FlvZvCdOSSiGpKzHO9zWs3GPPJ53ZOBdu7+BxC6bKY6ket/yES/NwfqQqKn
         UFLMOJt3vT4NkEa5BE52SpjIUz5zEF/R3MCXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439481; x=1690031481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkEBNBPB7p37IMo+amIH4z6XxA/lZNBkaf1MRNBrflY=;
        b=Fh7SmAF7bIKZ9/KP0XZSKiW3TSnMB7D1kLajnkLriS0KDQqIQywpd7eVLl9pA4KoLI
         WD/A2A5NV6+xjMB3xTUSmdzCZHo2IuxKXcWWFJLKPtdPzPGaq4mbHX3/sx9IuBj+9mz9
         REf4HBKqUKXDzv3Yt474/5+htOcrPCidrzbei9iy4gFInRDoPFRmw1d+nIFyd8JQ1C6j
         Z6twvTScUitK3o6Ra92TvUndmfWpMfqbyiFu4owhWxHBBRL66HoE3GiN/oC79zjiwrFZ
         FeeZoc70Y2tyDv3qhl9gLhK83U3RwWNjPYQSNcACxIRHhKCgm9YZTkxvagh95B9nFpCl
         KMiw==
X-Gm-Message-State: AC+VfDzUVAMMyOFF4f7spAAfymcAHGtRmhghEKbOvDiF5YpRcbucq/lv
        hLW8704ri8nUyI55goOhcOV23Q==
X-Google-Smtp-Source: ACHHUZ6TsDEYcMcbjqFBh48C06MfmJB8EuY0JmcU+rae0bpga83YM6Fb7g0gMV1/MJtwhajipsYggw==
X-Received: by 2002:ac8:7f50:0:b0:3f4:f38d:a954 with SMTP id g16-20020ac87f50000000b003f4f38da954mr22435157qtk.15.1687439480724;
        Thu, 22 Jun 2023 06:11:20 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v11-20020a05622a130b00b003f3c9754e1dsm3581136qtk.17.2023.06.22.06.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:11:19 -0700 (PDT)
Message-ID: <139acc54-d24c-5437-7a9d-fa2438fffba4@joelfernandes.org>
Date:   Thu, 22 Jun 2023 09:11:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/15] sched: Commit to EEVDF
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de, tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124604.137187212@infradead.org> <20230616212353.GA628850@google.com>
 <ZJQ4A2Jm4VoGMKbl@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZJQ4A2Jm4VoGMKbl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 08:01, Ingo Molnar wrote:
> 
> * Joel Fernandes <joel@joelfernandes.org> wrote:
> 
>> On Wed, May 31, 2023 at 01:58:47PM +0200, Peter Zijlstra wrote:
>>> EEVDF is a better defined scheduling policy, as a result it has less
>>> heuristics/tunables. There is no compelling reason to keep CFS around.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>   kernel/sched/debug.c    |    6
>>>   kernel/sched/fair.c     |  465 +++---------------------------------------------
>>
>> Whether EEVDF helps us improve our CFS latency issues or not, I do like the
>> merits of this diffstat alone and the lesser complexity and getting rid of
>> those horrible knobs is kinda nice.
> 
> To to be fair, the "removal" in this patch is in significant part an
> artifact of the patch series itself, because first EEVDF bits get added by
> three earlier patches, in parallel to CFS:
> 
>   kernel/sched/fair.c     |  137 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   kernel/sched/fair.c     |  162 +++++++++++++++++++++++++++++++++++++-----------
>   kernel/sched/fair.c     |  338 +++++++++++++++++++++++++++++++++++++++++-------
> 
> ... and then we remove the old CFS policy code in this 'commit to EEVDF' patch:
> 
>   kernel/sched/fair.c     |  465 +++---------------------------------------------
> 
> The combined diffstat is close to 50% / 50% balanced:
> 
>   kernel/sched/fair.c              | 1105 ++++++++++++++++++--------------------
> 
> But having said that, I do agree that EEVDF as submitted by Peter is better
> defined, with fewer heuristics, which is an overall win - so no complaints
> from me!

Agreed, thank you for correcting me on the statistics.

  - Joel


