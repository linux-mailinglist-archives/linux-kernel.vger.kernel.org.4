Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15BB72C657
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjFLNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjFLNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:47:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECEE41
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:47:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so3192581f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686577630; x=1689169630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUC31iFNpFCg4YbrHKzaxDZcZpH8BQAQvEXDz+dpPFc=;
        b=fXyCSrCjU/YXyUXmLujtuG7roXVtJDaqGgLNDI29FDYR3H5HRNnTra4EW4VnoEiWq0
         130eb+NPiP+Lfdj8hNLwWq06Yrtblu5ot1FyeyuA/kKwm3pF8fBStLYl2yNJGOUTYGG+
         KJz3qGVhA5cEd4SB8LWYikj1Nrya+Ip5I7PDxAQPPjArJGO/dWPNvOLSYibdSeoFc/dT
         4w6Dt/FNAQBz6FjiW/RhCFHFkWqgzVByp1BHUsXmayrR7z55PYY2W2X/VXoaya5P8Cbm
         wgz9OV4IsfHhb4fWpUaudePePwpcr84P5TmBkTqPL9lfQZ943QnxyODo9J2Rx3CFiYoQ
         5jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577630; x=1689169630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUC31iFNpFCg4YbrHKzaxDZcZpH8BQAQvEXDz+dpPFc=;
        b=DiyJzWWoPLx91R2gHsqjF0FW9w2bl5A2gTc0C57mIHifebE+opPamVCR4mFY+6vJYG
         FxUoLU6W6wLHmjTxzFPB6vQQyyWMgPUXxe2Xv0nfWsICaVLX9TkAtyOatGQ/6VShg2pI
         MjPI47fjq/cxtnop5swp0aF+6zZGCrVbi0eTrG5PnRNJ75PPQvJ/TlTVR3ycRYbK9fkg
         eSmk1Rem2L/ObZlQkSRVlqn5bx3mJrS5w4OL3WRVals5VNT1o0d7GfsddWIPCkcA22Nu
         cQyKiAhlQK7oZukXxNxbENAwTz/d3gL10SPXue4jsqLpD8TIRUc02pXNrLEAzGYBVHws
         1NGA==
X-Gm-Message-State: AC+VfDyK6s4R22fIg48oHw2aKAMCuGYF+h40TJE1jQM00R36IPwEYO80
        cCLldz6RgaQOOQZPzTBT1mcumA==
X-Google-Smtp-Source: ACHHUZ4upcuNRg4qfn5TecSWeKV7+GmRpLrr06iL4T03hw2qCwA4rIyfkflOvs5kkG/mberRceZ4Zw==
X-Received: by 2002:a5d:42cd:0:b0:30f:bd17:4f07 with SMTP id t13-20020a5d42cd000000b0030fbd174f07mr3766026wrr.13.1686577630006;
        Mon, 12 Jun 2023 06:47:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y14-20020adfdf0e000000b003063772a55bsm12515914wrl.61.2023.06.12.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:47:08 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:47:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 06/57] sched: Simplify sysctl_sched_uclamp_handler()
Message-ID: <c38a4071-d5f9-4afb-8bc0-7944c5261071@kadam.mountain>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.833273038@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093537.833273038@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:07:19AM +0200, Peter Zijlstra wrote:
> @@ -1810,7 +1811,7 @@ static int sysctl_sched_uclamp_handler(s
>  	if (result)
>  		goto undo;
>  	if (!write)
> -		goto done;
> +		return result;

This would be nicer as a "return 0;"

>  
>  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
>  	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
> @@ -1846,16 +1847,12 @@ static int sysctl_sched_uclamp_handler(s
>  	 * Otherwise, keep it simple and do just a lazy update at each next
>  	 * task enqueue time.
>  	 */
> -
> -	goto done;
> +	return result;

This is a return 0 as well.

regards,
dan carpenter

>  
>  undo:
>  	sysctl_sched_uclamp_util_min = old_min;
>  	sysctl_sched_uclamp_util_max = old_max;
>  	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
> -done:
> -	mutex_unlock(&uclamp_mutex);
> -
>  	return result;
>  }
