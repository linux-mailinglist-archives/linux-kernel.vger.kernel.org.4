Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE95BC059
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIRWR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIRWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:17:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F817AB2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 15:17:24 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id v15so20683126qvi.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=COUBS8Lrq/6s4OMF0vyhqM9K1ay0PGRLj6YjKDWMuz8=;
        b=sJGpVsSp8CVYVUTysZ5Dk8xKpexCVaWHglXuw3u9h7QWjExiwspIb/uvE25CeM/5s+
         81jiTtQ1MHFuRsqG1jdLKE1kvqw01+//fG4D1LCFYnsgY72GhKAn6DFNOqL50Y8Hec5w
         nPhjQJwVoIgygPPqlXUDJ5NXOVPtrJLak+NbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=COUBS8Lrq/6s4OMF0vyhqM9K1ay0PGRLj6YjKDWMuz8=;
        b=CeZFNB1EoAywrbLiirv1b1T1P4RSxm1esRYfm5dB1ESInqUuc0ncJFNAKhf6F+5bkw
         ON087B1AhQnV6L1mARRlGEUS5/11T7o0ws5VpMWXjrGedpeX0nzojPuoWYkhclwnD5zD
         BlyZjZDd57TBXsu+t6IYf1l43oqXgVrNAHP0h9Xd+O1nGq15NRZ9OJc+ylX6oDEADLZV
         L4lWfVm/1qMg38GSTE9PdQOkZlaamZHEXE5I6Oa195EWEyuNOp6aeBJu7aBVjPUt/pbS
         MchVdCWKx4VHyDNehgA5fHu9FNupzfKmvqCzN3mlFUmRhh67SWLSUF9TNXmgYY/ly/1Q
         yFRg==
X-Gm-Message-State: ACrzQf0MNiB0NiHw5qfrzoHKqirVo9h8sBTAfUEk1H3pc/XdpeC6fGI0
        49TVRHimmyMfr+MGKl1BMF3o/g==
X-Google-Smtp-Source: AMsMyM5uvOM+G4Sqi/2Jepd/gqyOg1z9T1h4PK+xrm3buvX2t6zUSYQgCgIj+1p1C8elok6gl2VeUA==
X-Received: by 2002:a05:6214:4106:b0:4ac:9160:747b with SMTP id kc6-20020a056214410600b004ac9160747bmr12462773qvb.28.1663539443703;
        Sun, 18 Sep 2022 15:17:23 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id c18-20020a379a12000000b006b8d1914504sm11183358qke.22.2022.09.18.15.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 15:17:23 -0700 (PDT)
Message-ID: <2aa3311d-936c-8f6d-7f2a-6d67776fda00@joelfernandes.org>
Date:   Sun, 18 Sep 2022 18:17:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC] rcu/nocb: Fix possible bugs in rcu_barrier()
Content-Language: en-US
To:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org
References: <20220918221231.79143-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220918221231.79143-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2022 6:12 PM, Joel Fernandes (Google) wrote:
> When going through the lazy-rcu work, I noticed that
> rcu_barrier_entrain() does not really wake up the rcuog GP thread in any
> path after entraining. This means it is possible the GP thread is not
> awakened soon (say there were no CBs in the cblist after entraining
> time).
> 
> Further, nothing appears to be calling the rcu_barrier callback
> directly in the case the ->cblist was empty which means if the IPI gets
> delayed enough to make the ->cblist empty and it turns out to be the last
> CPU holding, then nothing calls completes rcu_state.barrier_completion.
> 
> Fix both these issues.
> 
> A note on the wakeup, there are 3 cases AFAICS after the call to
> rcu_nocb_flush_bypass():
> 
> 1. The rdp->cblist has pending CBs.
> 
> 2. The rdp->cblist has all done CBs.
> 
> 3. The rdp->cblist has no CBs at all (say the IPI took a long time to
> arrive and some other path dequeued them in the meanwhile).
> 
> For #3, entraining a CB is not needed and we should bail.  For #1 and
> needed. But for #2 it is needed.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> I only build tested this and wanted to post it in advance for discussions. I
> will test it more soon. Thanks.
> 
>  kernel/rcu/tree.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 18f07e167d5e..65d439286757 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3904,10 +3904,11 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
>  /*
>   * If needed, entrain an rcu_barrier() callback on rdp->cblist.
>   */
> -static void rcu_barrier_entrain(struct rcu_data *rdp)
> +static void rcu_barrier_entrain(struct rcu_data *rdp, unsigned long flags)
>  {
>  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +	bool was_alldone;
>  
>  	lockdep_assert_held(&rcu_state.barrier_lock);
>  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3916,14 +3917,20 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> +	was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> +
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
> +		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */

I noticed that __call_rcu_nocb_wake() does a restore of the flags, which may not
work for all callers of rcu_nocb_entrain(). Sigh. The patch needs to be fixed
for that, but at least it highlights the potential issues.

