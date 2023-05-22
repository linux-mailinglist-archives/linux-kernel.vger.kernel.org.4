Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9EB70C50E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEVSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:20:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D338AF;
        Mon, 22 May 2023 11:20:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so1244819b3a.1;
        Mon, 22 May 2023 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684779640; x=1687371640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnNGFZ0Re+VRM8UtKCafqqilhh7RIrL5HAPnivOKzbI=;
        b=NzXyvxl+eSVn+61YhwsdEeeNs478YJ8xN7PSMdxpV/6VzBVVkU5kVSD7zG8Fx3GUnk
         Z/S4gARmV2kF5gle3UQBkay0WkXphb/SEIJLZGfdhADHFZrv0H9PKv7g3ANWTgJMV2fC
         AoYExvL/IbYRXK9A57srnMouw5q+tRoI8Wy8kQXbwQvXbNyaZ6w6FSaguMNkNR5KYKSn
         lOY6/pTuZI8CepbFHsrDCCCM/+agpMkLpPx/3V410dUCYzaXywb7lJf0VtbyKS3aiv1f
         TtezOHLHlOM/l8thVbZ+r6frmx49L4kplWhlcqckI9Zv3+WkpB1z9eXaJFgF3qKVXbQq
         GZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779640; x=1687371640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnNGFZ0Re+VRM8UtKCafqqilhh7RIrL5HAPnivOKzbI=;
        b=fIivPwJP4PwT2F5RqhA5zknsv/qH0QtDeYuju3ep5nMrolBnzPdz1t60dF8dX1kCIh
         2rt8qztb3KiGX5sbUQ8FLj8s2OaiRXsNL0OXvasRNS9fvu9SMBYOhEI6ewUu+Nj3dFM1
         QX5KcKsyVxmKUBvB7/H2BWrZGCSVrNqSCnEHlbvMgIj78Oe3BhBbmZVlHKC0h6HMV3nh
         Si8s3zLRWDnMLX+CfQSFKjirmX1koc+vMfhNs9KstvMvBUsP4qQvt7y6SEb6HfGXp6ff
         FjFJ3LboElqNvOn03jf3MP+IUevRDG3bbrIzDWv29jRm7nV8MWrAkujXA7xOnlfvVq1I
         HfnA==
X-Gm-Message-State: AC+VfDyOOC5RegLCTXr4Dg39sSuQLoZWphHgdhi7fA3xonj4pfC19tGb
        f6L7yAQ2SCzzwWZlpCcP56c=
X-Google-Smtp-Source: ACHHUZ5nvxuqc3Qq3LnGN+5GzCCr7OSBADk3L3tCN0e3vaf0VPR0/EU0cWZoEqwUS/0dHhFUDYP3mQ==
X-Received: by 2002:a05:6a00:140b:b0:63d:3339:e967 with SMTP id l11-20020a056a00140b00b0063d3339e967mr14978767pfu.19.1684779640307;
        Mon, 22 May 2023 11:20:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id 10-20020a63060a000000b00502fd70b0bdsm4721026pgg.52.2023.05.22.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:20:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 08:20:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:1999
 worker_enter_idle+0xb2/0xc0
Message-ID: <ZGuydp0KToLf55vY@slm.duckdns.org>
References: <CA+G9fYud2YH1c9Hxekd-pi8VsD4HmA4v9g-mr-vRPqaRQd2F5w@mail.gmail.com>
 <CALm+0cXew-QX9gkHkL7majJuENP1C_WLVG=pQ_6RGZ1UgQ79Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXew-QX9gkHkL7majJuENP1C_WLVG=pQ_6RGZ1UgQ79Eg@mail.gmail.com>
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

Hello,

On Mon, May 22, 2023 at 09:24:09PM +0800, Z qiang wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9c5c1cfa478f..f8d739fef311 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1060,10 +1060,9 @@ void wq_worker_running(struct task_struct *task)
>          * and leave with an unexpected pool->nr_running == 1 on the newly
> unbound
>          * pool. Protect against such race.
>          */
> -       preempt_disable();
> +       local_irq_disable();
>         if (!(worker->flags & WORKER_NOT_RUNNING))
>                 worker->pool->nr_running++;
> -       preempt_enable();
> 
>         /*
>          * CPU intensive auto-detection cares about how long a work item
> hogged
> @@ -1072,6 +1071,7 @@ void wq_worker_running(struct task_struct *task)
>         worker->current_at = worker->task->se.sum_exec_runtime;
> 
>         worker->sleeping = 0;
> +       local_irq_enable();
>  }

Ah, yeah, this is correct. Now we're modifying nr_running from timer tick
too, so if don't block irq, the timer tick can ruin the not-irq-protected
read-write-modify nr_running update from wq_worker_running(). Naresh, can
you please confirm the fix?

Thanks.

-- 
tejun
