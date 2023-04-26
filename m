Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8266EFD15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbjDZWML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbjDZWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:12:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2AF2715;
        Wed, 26 Apr 2023 15:12:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24736790966so6458042a91.2;
        Wed, 26 Apr 2023 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682547128; x=1685139128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIUbRme5WeXEWyWjYTXHJNNDnTyj3IXPcZSGHGz56i8=;
        b=CLQ+30qUkBPVcFHYRBgpYd2UbY8V0opPaoXSXXx3br1eyHuexHAg5pFU1NxUP0JLOt
         nwlpT2YC/7JRoFm7iC6banfBljSZjLObYFXQyauAhgvlYkbVwi0v+yTQmB3TIlldtrel
         zFEAngACpD6niCi3OcgYI+HcjpBkY5A2NJWnYhd80ie86pdbxcwqEV7iGMAnSBs7yJNa
         0z0QggjDoq6fod9ZKdG2I8CIWQv855ksEJHeXatgwZx9asvUAu2FrgCzC8zneShMJUei
         zVnQO75ntYnRZiRPYScg5Bt2J0P0MZpqmy/O6kL28TFJpaGfZsQyCByMgwvx9CSnRlZx
         1s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682547128; x=1685139128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIUbRme5WeXEWyWjYTXHJNNDnTyj3IXPcZSGHGz56i8=;
        b=I4/bN/8OctTdjAAirjDu1kOsIKIX+4JMPvef94j4jAfTt0vSgQBO8jBsyJJ7I1jcns
         qFh/vMz3YeLX/hRqmzKKUBrZWFfZyj4q6kgtpOJesRWfuyGCJoqoSAGQHWmwhOHROtaD
         aKR2psM3wFVcmUi/8KCjLcqfdcZaVc9at/6rMIGmrRLuO0Jtt1mlln04enDkGqRVDvYh
         QGBSNJv21qxzg8VuZSPPmuFRf05QoI6Xq2k6V2zz3eEgaTeR8Cvmk5PWLUM13BX6RtCa
         OaLYTT+k9q1dDStfrTaRmxARthB4nVuGLAIbGikrk2Y7o0YRR+vIwPVulfK0Tjl8ABut
         aV8g==
X-Gm-Message-State: AAQBX9fiAJVh5W3JxlJwUA21JgqdiJBC23LUvUA6kjqakZuK3n7kb2qa
        7JmzxKffDhGVdcgbdyqooKQ=
X-Google-Smtp-Source: AKy350bmkN14WoVa088epc95MoWzxpiaLXkJXl0vRxKbBZbV7AN7huwcSea/WPiXKrLJixUyJdx/6A==
X-Received: by 2002:a17:90a:a381:b0:247:35f8:81d2 with SMTP id x1-20020a17090aa38100b0024735f881d2mr22758564pjp.29.1682547127529;
        Wed, 26 Apr 2023 15:12:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1976])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ab8300b0019a97a4324dsm10415583plr.5.2023.04.26.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 15:12:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Apr 2023 12:12:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <ZEmhtdxpelt5jxAu@slm.duckdns.org>
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:26:38AM -0700, Paul E. McKenney wrote:
> The rcu_tasks_invoke_cbs() relies on queue_work_on() to silently fall
> back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
> the queue_work_on() function's silent fallback mechanism relies on that
> CPU having been online at some time in the past.  When queue_work_on()
> is passed a CPU that has never been online, workqueue lockups ensue,
> which can be bad for your kernel's general health and well-being.
> 
> This commit therefore checks whether a given CPU is currently online,
> and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
> queue_work_on().  Why not simply omit the queue_work_on() call entirely?
> Because this function is flooding callback-invocation notifications
> to all CPUs, and must deal with possibilities that include a sparse
> cpu_possible_mask.
> 
> Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
...
> +		// If a CPU has never been online, queue_work_on()
> +		// objects to queueing work on that CPU.  Approximate a
> +		// check for this by checking if the CPU is currently online.
> +
> +		cpus_read_lock();
> +		cpuwq1 = cpu_online(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> +		cpuwq2 = cpu_online(cpunext + 1) ? cpunext + 1 : WORK_CPU_UNBOUND;
> +		cpus_read_unlock();
> +
> +		// Yes, either CPU could go offline here.  But that is
> +		// OK because queue_work_on() will (in effect) silently
> +		// fall back to WORK_CPU_UNBOUND for any CPU that has ever
> +		// been online.

Looks like cpus_read_lock() isn't protecting anything really.

> +		queue_work_on(cpuwq1, system_wq, &rtpcp_next->rtp_work);
>  		cpunext++;
>  		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
>  			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
> +			queue_work_on(cpuwq2, system_wq, &rtpcp_next->rtp_work);

As discussed in the thread, I kinda wonder whether just using an unbound
workqueue would be sufficient but as a fix this looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
