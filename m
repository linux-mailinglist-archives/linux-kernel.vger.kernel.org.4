Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6E5E84DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiIWV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiIWV3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:29:50 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A902ED65
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:29:48 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id w39-20020a4a97aa000000b0044dfa1ddc67so244175ooi.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=ZGsHfCz0vcFr7tUGQ1YmYn/WTXvbxQ/j0IzGjWxyxBw=;
        b=I0aBEbvgjLil0ywPPi6Ss08ZtLCUNNMs3cN1rzPH1Z5uZIXD54xYdyBRbtSdAIIQsX
         vaZouOQ9T1QumiTC3NDHrTvWjJMWeEWpH+OnpplHEVevfIWJdQnjFz6l8RrSgKjgA5mb
         l0jTr0Vd1DfuBJzhajfHxNR1bKUs6Lq/hXbPH/tHyr5pZ+XiHJPFmB6BKXmd9uAPkSTt
         VCo/iqiNzCTeNGPd/IQrfCbzegNKym5AqfjjqBUiYKgKnlZ9cgFP2Zn+QP/F7hnQGX1h
         38TRWe0xZvw/58iiGuVR+gNj/Pa4pzua3bT0zChkr7ZtNJHk2zlOQz2lZnDEYUnNh0+Z
         GthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZGsHfCz0vcFr7tUGQ1YmYn/WTXvbxQ/j0IzGjWxyxBw=;
        b=dv463Iv0qIV4diL9ShuT1O9kScTqrSICGA35DVC15WDfbYNLqP2t/Ah59BK68f3678
         qheavEXxWJADNuFtychkJzYVUYwMx6sDle/BnILKXu+tr3aUgjyIqoIkZdJVgEa5ctpg
         XKGoVhKqvShdeYH3F+nnXlEh1ZxtyQ8uHsweI62b15OEeMrpM4sPwiI3lZf9EePAg7vL
         B8Zxuu4EnC6FJingkvuUjZCmnPcsAirqeRioCgk+1iZs0nUbtMjf+rRfiySANxOTXAer
         HABh2Oe/uJseRQ4TY6lUQ1LCQ8w4lhvUi0sLoaXpe9/IqmeGSp93zx23qBIo1XBgrd3H
         7dvg==
X-Gm-Message-State: ACrzQf09h7sXSkEQ63iBraHfg/fiQAiHo//2mW45n17wmkzG3uK26WM4
        MHPxtDzUzu/iDVFbpk1Sez6kdLsL3j7nDA==
X-Google-Smtp-Source: AMsMyM50XCi7LDTMNO4C0MWoUV/IYyF9t3ZMdSltCTg0JhEoxE8L1v+wfcY/UTC7XDhMwKaC5HYxNQ==
X-Received: by 2002:a05:6820:1505:b0:476:994:186e with SMTP id ay5-20020a056820150500b004760994186emr4276566oob.28.1663968587374;
        Fri, 23 Sep 2022 14:29:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t23-20020a056870609700b0012c21a64a76sm5230776oae.24.2022.09.23.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:29:46 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:29:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Keith Busch <kbusch@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Keith Busch wrote:

> Does the following fix the observation? Rational being that there's no reason
> to spin on the current wait state that is already under handling; let
> subsequent clearings proceed to the next inevitable wait state immediately.

It's running fine without lockup so far; but doesn't this change merely
narrow the window?  If this is interrupted in between atomic_try_cmpxchg()
setting wait_cnt to 0 and sbq_index_atomic_inc() advancing wake_index,
don't we run the same risk as before, of sbitmap_queue_wake_up() from
the interrupt handler getting stuck on that wait_cnt 0?

> 
> ---
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 624fa7f118d1..47bf7882210b 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -634,6 +634,13 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  
>  	*nr -= sub;
>  
> +	/*
> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> +	 * invalid wakeup on the old waitqueue.
> +	 */
> +	sbq_index_atomic_inc(&sbq->wake_index);
> +
>  	/*
>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>  	 * responsible to reset wait_cnt regardless whether we've actually
> @@ -660,13 +667,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  	 * of atomic_set().
>  	 */
>  	smp_mb__before_atomic();
> -
> -	/*
> -	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> -	 * callers can see valid wait_cnt in old waitqueue, which can cause
> -	 * invalid wakeup on the old waitqueue.
> -	 */
> -	sbq_index_atomic_inc(&sbq->wake_index);
>  	atomic_set(&ws->wait_cnt, wake_batch);
>  
>  	return ret || *nr;
> --
