Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408F95EAC40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiIZQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiIZQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:15:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441615A31
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:04:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id u28so4264325qku.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/fFjRZ8t/90FQXYub8lwlEmUW4z8FYh2n7IMlmSjywQ=;
        b=hhzyiKN0Ckp2AUbCjVvWDo3TbpeKMuyNCWgBF0EOCu22Dk98mUibh1PI62Xr1hbbd3
         hKMoaNnrjhXNGqTvisj87IXdosQ0MhZcUJ5WEFQQAGiI5FsasjkjH7RibqS1NSp/h30/
         jPX81i6b4g6kRqd1GDZWF/MBmgMk5i/B/Q84Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/fFjRZ8t/90FQXYub8lwlEmUW4z8FYh2n7IMlmSjywQ=;
        b=hUnykG5xflitVYE5FoKGTWhzWebQmSDvmm91kQH0tGnvBd5iFBP/PFbrcM2DKaLR0i
         WnklfdwFBUPOyzruaBA+X7PpUaD9IbPg4MNsIuZqdqSLnsziTa4o6Tm7Ac9VnW3wWmrt
         a5zx+TpY3YYqr8p/YkzKcxETcvXmjtxZHerhc+G0/0R3k73WwYSJWiMM8egRk/r7N0Ep
         K/yGaSn4IT8s4jjB9dLaEVYrBCr1xyd0LmZL7tqRlb/V3KGHxDTU1jbVS6h+MVQ0RZEZ
         4tGjgpR2dQyA1XHeZvS39lugL0KrzkAif/v7QlwHNfOnbMiOXevMJDIP75z0BYf4Hokp
         8Wgg==
X-Gm-Message-State: ACrzQf3u63NXno+r6GOX4LUe3FGte/dz6E05BJEqk3eHMA0xJLNtVCOT
        Ip6BSqIiDSLpGbDHtQCd3v5c4w==
X-Google-Smtp-Source: AMsMyM4PCBslBtIGUG1WjB1OqFU1MCVwAhQy90m/98ozqlcLqwydU5Hr6zWyKGIALJCRHrmcpuQMjw==
X-Received: by 2002:a05:620a:4081:b0:6ce:6253:b90c with SMTP id f1-20020a05620a408100b006ce6253b90cmr14465020qko.172.1664204679595;
        Mon, 26 Sep 2022 08:04:39 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05620a468800b006aedb35d8a1sm11427276qkb.74.2022.09.26.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:04:39 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:04:38 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzG/hoePbBumpaBV@google.com>
References: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
 <22F29015-5962-433D-8815-E4154B4897DD@joelfernandes.org>
 <20220925220045.GA182613@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220925220045.GA182613@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:00:45AM +0200, Frederic Weisbecker wrote:
> On Sat, Sep 24, 2022 at 09:00:39PM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Sep 24, 2022, at 7:28 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > ﻿Hi Frederic, thanks for the response, replies
> > > below courtesy fruit company’s device:
> > > 
> > >>> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > >>> 
> > >>> ﻿On Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Google) wrote:
> > >>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
> > >>>   rdp->barrier_head.func = rcu_barrier_callback;
> > >>>   debug_rcu_head_queue(&rdp->barrier_head);
> > >>>   rcu_nocb_lock(rdp);
> > >>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
> > >>> +    /*
> > >>> +     * Flush the bypass list, but also wake up the GP thread as otherwise
> > >>> +     * bypass/lazy CBs maynot be noticed, and can cause real long delays!
> > >>> +     */
> > >>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAKE));
> > >> 
> > >> This fixes an issue that goes beyond lazy implementation. It should be done
> > >> in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixes: " tag.
> > > 
> > > I wanted to do that, however on discussion with
> > > Paul I thought of making this optimization only for
> > > all lazy bypass CBs. That makes it directly related
> > > this patch since the laziness notion is first
> > > introduced here. On the other hand I could make
> > > this change in a later patch since we are not
> > > super bisectable anyway courtesy of the last
> > > patch (which is not really an issue if the CONFIG
> > > is kept off during someone’s bisection.
> > 
> > Or are we saying it’s worth doing the wake up for rcu barrier even for
> > regular bypass CB? That’d save 2 jiffies on rcu barrier. If we agree it’s
> > needed, then yes splitting the patch makes sense.
> > 
> > Please let me know your opinions, thanks,
> > 
> >  - Joel
> 
> Sure, I mean since we are fixing the buggy rcu_barrier_entrain() anyway, let's
> just fix bypass as well. Such as in the following (untested):

Got it. This sounds good to me, and will simplify the code a bit more for sure.

I guess a question for Paul - are you Ok with rcu_barrier() causing wake ups
if the bypass list has any non-lazy CBs as well? That should be OK, IMO.

> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b39e97175a9e..a0df964abb0e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3834,6 +3834,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  {
>  	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
>  	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
> +	bool wake_nocb = false;
> +	bool was_alldone = false;
>  
>  	lockdep_assert_held(&rcu_state.barrier_lock);
>  	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
> @@ -3842,6 +3844,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	rdp->barrier_head.func = rcu_barrier_callback;
>  	debug_rcu_head_queue(&rdp->barrier_head);
>  	rcu_nocb_lock(rdp);
> +	if (rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist))
> +		was_alldone = true;
>  	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>  	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>  		atomic_inc(&rcu_state.barrier_cpu_count);
> @@ -3849,7 +3853,12 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  		debug_rcu_head_unqueue(&rdp->barrier_head);
>  		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>  	}
> +	if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
> +		wake_nocb = true;
>  	rcu_nocb_unlock(rdp);
> +	if (wake_nocb)
> +		wake_nocb_gp(rdp, false);
> +

Thanks for the code snippet, I like how you are checking if the bypass list
is empty, without actually checking it ;-)

thanks,

 - Joel

