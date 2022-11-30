Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3693963E0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiK3TnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiK3TnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:43:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE3226132;
        Wed, 30 Nov 2022 11:43:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl24so229863plb.8;
        Wed, 30 Nov 2022 11:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUBcXV7nQy/1r0o6E64fUR2RwhClmxU+dP9giO6hLmY=;
        b=fBZVpztZLS4scqkNd2KK5kBSJaDFwKbZkCD7lBloMLPUm1TxERP3E6+Awn4UyBRiws
         RrFEP2bcgV6oWYpuTKP35X1NhRHLIYuBvf0xnaG3Ta1so5bYMBsei779ZlT8fR38icqX
         FmHpKdrR40GVytaMY/oF09SOnM/LTlZ2UoPLI8AdPREHGPMtmLVvAP2+QXWOx2pmwjrT
         nO+pRilq6WETWtwL3w78XpSiy8noae+/SPNfJiiFpGXlPALaPVuLB9hV4gKs6uv+5uuI
         8UiAqE7kZlf8C1yGFtWc+r4Hox3xWYsLg2j4KLUtiLPDj48BtDEc9mvupGhQAUDLIvFa
         Jf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUBcXV7nQy/1r0o6E64fUR2RwhClmxU+dP9giO6hLmY=;
        b=hLYsEEpxIZ+WutNQ2ZeRQq947vbAWXXwpbUzMknHVTaLr8n5C3b2xHmnn3QGz8ZbYb
         lTvmsPbC7p0KujgfP6HuXmSJhwVm7unpTn4Q0OhRHrYaHM48/b59FmTeE8a54RWV4MM+
         0wwbHadNPBHfo4QoOE3RcDS0xB+ajpgbLzhnvZQtGsvD91xtj+PH6IqCGpM4bTA7+dEG
         umZBYS5mlrH9OR0sGo2trA5TujElvO057vw/7QK3x/BZNwDOmmA14yufD1nA8NH+uMnD
         4k/X99jV76I9PQhzjmJijO80AGOCib+cCWiT9dMI8EzEYAJLOmIRE4Qpk+8hWSiA54Nh
         0nIg==
X-Gm-Message-State: ANoB5pmImhYYqmAKWx9HcarR91NvgDwHqUWwNGFXyFo6tEel5lh0N7xq
        8X95KKRuZKM9pQJmypVpIvM=
X-Google-Smtp-Source: AA0mqf4JI4PebfL031B6uLFeBwXnDd5rO16aayoO4CIzpe3CmYLTGEM3ar1kjES6c5bygXsrxdM2tw==
X-Received: by 2002:a17:902:8548:b0:186:8398:350 with SMTP id d8-20020a170902854800b0018683980350mr43130061plo.6.1669837395109;
        Wed, 30 Nov 2022 11:43:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b00188fc33e96dsm1870452plk.198.2022.11.30.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:43:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 09:43:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_hurry()
Message-ID: <Y4eyUZwY2pY78NR7@slm.duckdns.org>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-13-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130181325.1012760-13-paulmck@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:13:22AM -0800, Paul E. McKenney wrote:
> From: Uladzislau Rezki <urezki@gmail.com>
> 
> Earlier commits in this series allow battery-powered systems to build
> their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> This Kconfig option causes call_rcu() to delay its callbacks in order
> to batch them.  This means that a given RCU grace period covers more
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
> And another call_rcu() instance that cannot be lazy is the one
> in queue_rcu_work(), given that callers to queue_rcu_work() are
> not necessarily OK with long delays.
> 
> Therefore, make queue_rcu_work() use call_rcu_hurry() in order to revert
> to the old behavior.
> 
> [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
> 
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
