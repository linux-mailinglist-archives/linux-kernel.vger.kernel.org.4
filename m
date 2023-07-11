Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748274F405
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjGKPr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGKPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:47:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146CF0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:47:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so60400745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689090441; x=1691682441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4EaPljyU0HSPbHu61XlLmSr07kl10hJYMoKYo6/bmM=;
        b=XWRsF2YVPc1QlYZwZyN3y7o1RaQWpfyxNK8iPw2+XAvkWY7Z/nW2VdqZTHvubNBPNT
         KQR/nYxq8lzt8WrBIJhEy+rcLo8oEI6R5dCKNSljsu1GnTUkmO53brVKvo5fNoTpiZ8j
         i0UjO1rGlyHLfNPDtmnLP/uRSKOvsIGLo1XdoyHZHRt5GzetvZ8j+3evP5BAN9YkceCn
         cwo9EmG45mDFWD+mjFO1YOgRFuu57MFGjct0xaMSIJlVfmMirlF6N1b4N3TyCJeME9cF
         TlwvWRPRO+dftUUORHs9pZP0lih3oEGFXfD5S/PlQXXXN73SOElLeoH247PnQCQjKGTv
         frzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090441; x=1691682441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4EaPljyU0HSPbHu61XlLmSr07kl10hJYMoKYo6/bmM=;
        b=HwJja/jySeoCJKMktAWmn9UNH+kefgzjlV6tfsva3OGKnjQKdsHvvcmSB0MvxpFDl0
         b9JLJkzQlpKFwGgD5qijqvcmC4/eYeMjJ45QM07KI7MwVDpWIfrIHV69Oa/I/YUe+AiY
         IqLr5CQkVQqkFKd5jdCiDKFhSRxVaSJ1lf+M6EAPHcXuHyFNbLobfY2mYnBwsVEMkY/C
         1hmPlpq8iWu3jD3w67kda/mx8fKX2Y4Mw7pOH5AIVM2+SUdhhfsqGbNOF+4Ptw+C8oxF
         LIgsEKPyNoXr7w8eP+SnEe2xPPtJ66UpEzH1UTwal6fFSlJe2IDZKtHJ9aSjj0w8sfWn
         LXTQ==
X-Gm-Message-State: ABy/qLYikuXztwxdadLMi8B7quCewNE8Kqa13GQ5v4RU0f349xcwxqUX
        DLYG8+lra2yXes+AorCG+HDJvQ==
X-Google-Smtp-Source: APBJJlF9uq2sMMAnt7oJuhvGOiwBfgQ0ZGxq/t3cqkwUsht0sMUdFcJ25CdjcEjQEfncTKdT500SrQ==
X-Received: by 2002:a7b:c5d0:0:b0:3fb:b008:1ff6 with SMTP id n16-20020a7bc5d0000000b003fbb0081ff6mr13614981wmk.0.1689090441001;
        Tue, 11 Jul 2023 08:47:21 -0700 (PDT)
Received: from airbuntu ([104.132.45.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003fc02218d6csm11108557wmj.25.2023.07.11.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:47:20 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:47:18 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove util_est boosting
Message-ID: <20230711154718.gudn32sru5opwvlw@airbuntu>
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706135144.324311-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/23 15:51, Vincent Guittot wrote:
> There is no need to use runnable_avg when estimating util_est and that
> even generates wrong behavior because one includes blocked tasks whereas
> the other one doesn't. This can lead to accounting twice the waking task p,
> once with the blocked runnable_avg and another one when adding its
> util_est.
> 
> cpu's runnable_avg is already used when computing util_avg which is then
> compared with util_est.
> 
> In some situation, feec will not select prev_cpu but another one on the
> same performance domain because of higher max_util
> 
> Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Can we verify the numbers that introduced this magic boost are still valid
please?

Otherwise LGTM.


Thanks!

--

Qais Yousef

>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..77c9f5816c31 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7289,9 +7289,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  
>  		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>  
> -		if (boost)
> -			util_est = max(util_est, runnable);
> -
>  		/*
>  		 * During wake-up @p isn't enqueued yet and doesn't contribute
>  		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> -- 
> 2.34.1
> 
