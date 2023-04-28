Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF76F1DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjD1R6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjD1R57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB71FDB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E575638AC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A993C433EF;
        Fri, 28 Apr 2023 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682704677;
        bh=vUy6/4Ph9HknFEtxqJzNk7RhxwSAEm4obtBT4GtISWo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f9aX+70wjGG2AZ8BLb0sezqpB05hL+ZC2Oq5XZm9/GZTFvUK3Kg2rrYZ6maEjahWK
         TQy3sD3CSLAU080GrMrHLQZ3PH6k3z1tVg5GXo940bKJNrxZIfMKWoXzMh0eRw1grQ
         HY48Xh5BV63MFagZ195P+9WWS/yQ2bJ0bqQHBsHk2RWVQkuWenrFepGafjvzQ8mhmU
         M5YHst14ZcE6HTcf0UrqR5kIzQoVHESJKkjRwSOSDXVsXE7MLnVUrxxtoJ5rloiQWD
         3KBpopDFXdNtap0EFAxtb5Op4YHww3m++epK4z2rQqMneyB5MOdxNspSLZ2AzAjbiH
         uba4L/M9EMb4g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EBF8315404E8; Fri, 28 Apr 2023 10:57:56 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:57:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] smp: Reduce logging due to dump_stack of CSD
 waiters.
Message-ID: <088edfa0-c1b7-407f-8b20-caf0fecfbb79@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230428170006.1241472-1-imran.f.khan@oracle.com>
 <20230428170006.1241472-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428170006.1241472-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 03:00:05AM +1000, Imran Khan wrote:
> If a waiter is waiting for CSD lock, its call stack will not change
> between first and subsequent hang detection for the same CSD lock.
> So dump_stack for the waiter only for first time detection.
> 
> This avoids excessive logging on large scale systems(with hundreds
> of CPUs) where repetitive dump_stack from hundreds of CPUs can flood
> the console.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index ab3e5dad6cfe9..b7ccba677a0a0 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -248,7 +248,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  			arch_send_call_function_single_ipi(cpu);
>  		}
>  	}
> -	dump_stack();
> +	if (firsttime)
> +		dump_stack();
>  	*ts1 = ts2;
>  
>  	return false;
> -- 
> 2.34.1
> 
