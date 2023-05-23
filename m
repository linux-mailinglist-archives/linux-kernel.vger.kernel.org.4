Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4270E5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbjEWTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbjEWTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:40:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA62E73
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:40:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d577071a6so204079b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684870818; x=1687462818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5+vEum+icvRoOsA8RbdszrE+oDIqpAAJx5BE5S3Yrk=;
        b=b8mDkUonfyAkUSWIM3sTxP1tatTZXVjyQBfJuxQt0M4ezKPu+WCadC1slZTi4BUIW5
         cXQWuVUkdGHl1SgaZsma1+s+pgwj39A92qswoVpQ/ftNkUW96wEjXWwyQOTB218irSTV
         MaSRqLki3VnPrJr3ag+X/UkeMIxzvTSuojK8IKPLITAOiXSWalm8+Eb3cCJVHv1Wo8E/
         tOyjrlgcT8CX+l4jL2twlyHGQyQYlvJ1u1evh+yT+CvDnMHYgCANReAFwMq2Gpktp7I2
         FIripO9orrDM4zr4dgBhMWwduQZU743lkgF0ahy9D7H9vEjHc78gJ61YcHZKJ7bDwIaU
         98VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870818; x=1687462818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+vEum+icvRoOsA8RbdszrE+oDIqpAAJx5BE5S3Yrk=;
        b=QcEmodV13ZdMl6em9e6YgRN9sOMx+Hfza9ccrO1UxlDXJemngNlLJXtkB218DY8Rpf
         0df9dHSVaoE8JgRFv7smZrE08Cxs9cBVPc8mKApn7tGA33c/pY1hNwWF6zV696WKmlWE
         yQVaGMHyPJG9gFlkUocmACCiBzyPMxOakNicT2rYF42QekQVLRPb2ygpgA+bhS3xfT/+
         4YeGuFCskUjhjHCTAHOJKkm9IDmMMyfxzmJ1VGlAaYC7CaivnnXdrTy2WDXqZbN+o+qf
         h6VflqQ7nj9IRCCyIzDia43VishOP242Zi+J18GbNHtGBfZ0qM3tpQZNdWOzkV8RWHQk
         wy5A==
X-Gm-Message-State: AC+VfDxOD+kbQ/hOFgYzsQxAdTSx51jDwtf549e1w9Euji5OrzztgTh4
        3NesmozG3OLCJNASmkIl5A8=
X-Google-Smtp-Source: ACHHUZ6fmN/stE+tIK3VU9YuB7QOmO9Mm6I8b/dV9nu4GkQDSlQ9ZxiTrRFxSh2skG7CI3od0tJP4A==
X-Received: by 2002:a05:6a00:14d0:b0:639:a518:3842 with SMTP id w16-20020a056a0014d000b00639a5183842mr230904pfu.7.1684870818001;
        Tue, 23 May 2023 12:40:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a14-20020a62e20e000000b00643889e30c2sm3942573pfi.180.2023.05.23.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:40:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 09:40:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix warning triggered when nr_running is
 checked in worker_enter_idle()
Message-ID: <ZG0WoOqfr6R5wK1p@slm.duckdns.org>
References: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
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

On Tue, May 23, 2023 at 10:09:41PM +0800, Zqiang wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9c5c1cfa478f..329b84c42062 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1144,13 +1144,12 @@ void wq_worker_tick(struct task_struct *task)
>  	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
>  	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
>  	 */
> -	if ((worker->flags & WORKER_NOT_RUNNING) ||
> +	if ((worker->flags & WORKER_NOT_RUNNING) || worker->sleeping ||
>  	    worker->task->se.sum_exec_runtime - worker->current_at <
>  	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
>  		return;

Ah, right, this isn't just interrupted read-modify-write. It has to consider
sleeping. This is subtle. We'll definitely need more comments. Will think
more about it.

Thanks.

-- 
tejun
