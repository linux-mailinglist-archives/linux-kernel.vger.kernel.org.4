Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49D63E0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiK3ToX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiK3Tn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:43:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF497036;
        Wed, 30 Nov 2022 11:43:46 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl24so231308plb.8;
        Wed, 30 Nov 2022 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l2DcvUQCzeMiHwNRaOIRYz18pb8Nk29Wkn+R8wEW5k=;
        b=i/i/jt8iAGXMRriP8xCj6maFrHzwSpMBsKZVf6rgU3SYA00gIaZX/ele+xaG/FZuIl
         gIxD3fI1T68WBPelwtCcgIgZ4Kf+c+6iyAYUxiDi2+M9D1p59C/ywPsLIpuWJU7eMQxf
         4kWn0pWGD+gKCHHCXCqA79dMiPaftl20sgR1hJoCjZ8QZx/Pk8dpcnwgfgBOvv0OktBb
         i7u4ZBFEfhk7YxRk+KIAFO/2QiclwERjFQbLq2QzZ/b20Bqwv1M352GuCodE5U9QvToW
         okrhRWttNEHN6FM95IKfSt8lh9WFVKKeCJ3ZGA/CRUnMNG+PqihEvSS2gV9obmbHZlcC
         PE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4l2DcvUQCzeMiHwNRaOIRYz18pb8Nk29Wkn+R8wEW5k=;
        b=ik/NEhV2ha4OPFOr9TI2Y+bPuJgbUQFYtuQK8NlPH5JENanbY5DF9nPpgwunwQN5iV
         B+R/AgOE0Tv/QNBevY5ldOXk4Vb6V/nfdM0grewTlNVSH4FB7815SORI199iPT+gCWak
         HWW30D+ZoZFUxmdGuaXEfqIH0D3vm4HtITTpQoCr6r94QhuMKkAzFWVpy1GIfd9dcQfB
         Qa4vV9wJETJtiv+a2+Lf5RjZpwSfbKhOvfmag1JXM7qlH+65GIEsm9EnU4cbEiIztODt
         +8JyBXSEKSzdEMcZbs9vu9QrygCFXRauXhXrG77vN6+nz1A5Dmqb7lsH/wvT2BsSZiRN
         ykrw==
X-Gm-Message-State: ANoB5pnGrHaEF3clWKStt45pI2KT3aREgS0vna1ZdLZ10pk0xbaGyehU
        eVuVn2GutkzTWkkvKsE1hak=
X-Google-Smtp-Source: AA0mqf7EmnKIHMkE2Ak7r9WcCipVMPY60uFMXYLh/Imw2ExO2xUH6i6GYyyvHEKFisYKhpXnDOq2EA==
X-Received: by 2002:a17:90a:1d5:b0:219:55d5:f30e with SMTP id 21-20020a17090a01d500b0021955d5f30emr8474826pjd.107.1669837426215;
        Wed, 30 Nov 2022 11:43:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001869ba04c83sm1862427plk.245.2022.11.30.11.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:43:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 09:43:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [PATCH rcu 12/16] percpu-refcount: Use call_rcu_hurry() for
 atomic switch
Message-ID: <Y4eycHpdYz7aoq10@slm.duckdns.org>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-12-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130181325.1012760-12-paulmck@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:13:21AM -0800, Paul E. McKenney wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Earlier commits in this series allow battery-powered systems to build
> their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> This Kconfig option causes call_rcu() to delay its callbacks in order to
> batch callbacks.  This means that a given RCU grace period covers more
> callbacks, thus reducing the number of grace periods, in turn reducing
> the amount of energy consumed, which increases battery lifetime which
> can be a very good thing.  This is not a subtle effect: In some important
> use cases, the battery lifetime is increased by more than 10%.
> 
> This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
> callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
> parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.
> 
> Delaying callbacks is normally not a problem because most callbacks do
> nothing but free memory.  If the system is short on memory, a shrinker
> will kick all currently queued lazy callbacks out of their laziness,
> thus freeing their memory in short order.  Similarly, the rcu_barrier()
> function, which blocks until all currently queued callbacks are invoked,
> will also kick lazy callbacks, thus enabling rcu_barrier() to complete
> in a timely manner.
> 
> However, there are some cases where laziness is not a good option.
> For example, synchronize_rcu() invokes call_rcu(), and blocks until
> the newly queued callback is invoked.  It would not be a good for
> synchronize_rcu() to block for ten seconds, even on an idle system.
> Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
> call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
> given CPU kicks any lazy callbacks that might be already queued on that
> CPU.  After all, if there is going to be a grace period, all callbacks
> might as well get full benefit from it.
> 
> Yes, this could be done the other way around by creating a
> call_rcu_lazy(), but earlier experience with this approach and
> feedback at the 2022 Linux Plumbers Conference shifted the approach
> to call_rcu() being lazy with call_rcu_hurry() for the few places
> where laziness is inappropriate.
> 
> And another call_rcu() instance that cannot be lazy is the one on the
> percpu refcounter's "per-CPU to atomic switch" code path, which
> uses RCU when switching to atomic mode.  The enqueued callback
> wakes up waiters waiting in the percpu_ref_switch_waitq.  Allowing
> this callback to be lazy would result in unacceptable slowdowns for
> users of per-CPU refcounts, such as blk_pre_runtime_suspend().
> 
> Therefore, make __percpu_ref_switch_to_atomic() use call_rcu_hurry()
> in order to revert to the old behavior.
> 
> [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: <linux-mm@kvack.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
