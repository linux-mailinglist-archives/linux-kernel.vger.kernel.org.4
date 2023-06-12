Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE44772BC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjFLJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjFLJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729893C30
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QC41YKgN0xmHQdNzH6M+Uu76fu7QNsVnoqhBeA2o4jU=;
        b=GTyu1UAs22wCIHwGRR8L+fPSrxLgJPNtsjcgwaK2i3+D1HpFvP8ohE3fnIF14RtM5jLDU3
        TbRXb+LJf8FKW5Qy7o7JT1v69Mx1cX8WCCnF+ydLoVYoPmBx8Och2CYenvjh7bP9PXlRzy
        FvSCkHN4MerGtZrSnJ/fA5xgXEOhMVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-uLC_9u1ZMOi1KHaKyTPH4w-1; Mon, 12 Jun 2023 05:21:27 -0400
X-MC-Unique: uLC_9u1ZMOi1KHaKyTPH4w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so18245195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561686; x=1689153686;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QC41YKgN0xmHQdNzH6M+Uu76fu7QNsVnoqhBeA2o4jU=;
        b=bx28aIvkPmxfQoF+UlvEbcIDsYsjTdINGDjjGEAOu1z56L8o9/OsZtwWKK8yRzJV86
         YrPaLy5BoqK+LlJCDRYXG/2W74yHDe/ak8DIiUSQA6b8tZlxBAXBtQl79/nn0vRATDlc
         BRaMjH1OiG9SBhZlCDqiFxQNcf/Q+awPCPw7ji895A48w+sXNGH/a+Jj9j+lpCM986l5
         aiCtA62wy1gvtgju2MMlpiTy/IwI+/vCTxxDmYvhgrMnqWdfITOjfAemsYpk/oPxO7+P
         zmomWrkU06/XegtIE0ASq1M9JIZGCFeFWspC3vxwO2/AN1u109BhJ+NZ5PjrECtKE4VY
         jIcQ==
X-Gm-Message-State: AC+VfDzGdb251ILWV+PxuH5mAklCZ0dztEH3G8m3luK9b6Jc7MrX6Oi1
        NwpCqMV+SZZlMoQxX6OVdpX7bO9uR3hGPdFuHpPECy4y3OD7AMOo/dIJUsrdKuGUcUta69F+cJN
        Ajwu4WoGf1mahIspSNDso+TO2
X-Received: by 2002:a05:600c:8511:b0:3f6:eae:7417 with SMTP id gw17-20020a05600c851100b003f60eae7417mr9032763wmb.1.1686561686734;
        Mon, 12 Jun 2023 02:21:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tNzUBg1N5t6u4vERZ+uMtFUndF8uxZRRZzGVgwn8EMiCAC08MhC70Lom5Av6mmtdGA3wQCQ==
X-Received: by 2002:a05:600c:8511:b0:3f6:eae:7417 with SMTP id gw17-20020a05600c851100b003f60eae7417mr9032748wmb.1.1686561686424;
        Mon, 12 Jun 2023 02:21:26 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003f709a7e46bsm10692178wme.46.2023.06.12.02.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:21:26 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Li zeming <zeming@nfschina.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] sched: rt: Remove unnecessary =?utf-8?B?4oCYTlVMTA==?=
 =?utf-8?B?4oCZ?= values from push_task
In-Reply-To: <20230510235417.3061-1-zeming@nfschina.com>
References: <20230510235417.3061-1-zeming@nfschina.com>
Date:   Mon, 12 Jun 2023 10:21:24 +0100
Message-ID: <xhsmhttvdxch7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/23 07:54, Li zeming wrote:
> push_task is assigned first, so it does not need to initialize the
> assignment.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>

Subject would be clearer as "Remove unnecessary initialization", but
regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 662c565745fd..55e480d5174a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2073,7 +2073,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>       }
>
>       if (is_migration_disabled(next_task)) {
> -		struct task_struct *push_task = NULL;
> +		struct task_struct *push_task;
>               int cpu;
>
>               if (!pull || rq->push_busy)
> --
> 2.18.2

