Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84672BF37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjFLKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjFLKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF03A262
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686564935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vn9XmzFCfAP4xk0kJ7qaLU2v0x0cmbrEQEPzoMusjqE=;
        b=LLFRwbzI7jxBGQsGpxC9vFmJ+zHf4Zs18kErS/H+NoDlg2KYdKNcHEvh0ptx4U3P/3/9zl
        wgLJ9KuKi1FxLX5Ko8BVKpwva8iCnOPYuoIUF9iu5/qktHW/3ug9YR6EpaIzKVZ+rGkfpg
        m+sN0z5JQ28lPNEcverJX3PHEKBXb9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-HMtFKm6qNWm2KYly_1mb_A-1; Mon, 12 Jun 2023 06:15:26 -0400
X-MC-Unique: HMtFKm6qNWm2KYly_1mb_A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so80226315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564925; x=1689156925;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vn9XmzFCfAP4xk0kJ7qaLU2v0x0cmbrEQEPzoMusjqE=;
        b=cb0dhrlDq0iVttsfk+XY2sStLoTXmTXoDSXSto/TAJxPJThbUqOqykSlnmiAEUH+Id
         7LomjRCLq+Tb0O/szj68TWutdx6IIP2jl9KKZvpslXZuyIsQtJlLKiofOmr265fSuPsq
         vnOMYYdFI3roN/idSNlwD6h81v9p9iBpbgpm0m7QWZuhOE+HqaWHd+c/X3oJnb1wTtVh
         iJWDOMXlmmY1k2B3BFDwverKNMgeVZirJeFJu86HIISFqFuLzA41+S59wxfLesR16LUO
         HF+qNdz86jNcWipSVIe3chT5NN8tdaiRrXQhfVjzZS076lQFNNjdHK/giE5BpVeFWf0M
         E5ZA==
X-Gm-Message-State: AC+VfDzDrtJzEyz8hybP4+JbOBYzjb9jW4wGCCtO6pnmWwHFp98e4mkZ
        3firpS/ymTtuQDAm+bjOKz6/qGxg9K/hm4CUyqnK6ZEgw7XcrOko9WX7QXxZjiZ+7j1JrP86rye
        cs73ueFN3zt2ofAoAsYbes4VC
X-Received: by 2002:a7b:c40b:0:b0:3f4:447d:f74a with SMTP id k11-20020a7bc40b000000b003f4447df74amr7155824wmi.26.1686564924882;
        Mon, 12 Jun 2023 03:15:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Pf8lfoH+lNDNIWsX2aHUSVyvVZjeUUPuAyebO+YZ94ioVitDMCcKIM/IbQjf2Ui3o0ZV9PA==
X-Received: by 2002:a7b:c40b:0:b0:3f4:447d:f74a with SMTP id k11-20020a7bc40b000000b003f4447df74amr7155808wmi.26.1686564924605;
        Mon, 12 Jun 2023 03:15:24 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003f801c12c58sm10846852wmd.43.2023.06.12.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:15:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Li zeming <zeming@nfschina.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] sched: core: Simplify cpuset_cpumask_can_shrink()
In-Reply-To: <20230518203416.3323-1-zeming@nfschina.com>
References: <20230518203416.3323-1-zeming@nfschina.com>
Date:   Mon, 12 Jun 2023 11:15:23 +0100
Message-ID: <xhsmhr0qhx9z8.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/23 04:34, Li zeming wrote:
> Remove useless intermediate variable "ret" and its initialization.
> Directly return dl_cpuset_cpumask_can_shrink() result.
>

FWIW, this sort of intermediate variable can and will be optimized away by
the compiler. It's pretty obvious to see in the objdump (GCC 13.1):

before/core.o: mainline core.o
after/core.o:  patched core.o

$ gdb -batch -ex 'disassemble cpuset_cpumask_can_shrink' before/core.o
Dump of assembler code for function cpuset_cpumask_can_shrink:
   0x000000000000b260 <+0>:	endbr64
   0x000000000000b264 <+4>:	cmpq   $0x0,(%rdi)
   0x000000000000b268 <+8>:	jne    0xb274 <cpuset_cpumask_can_shrink+20>
   0x000000000000b26a <+10>:	mov    $0x1,%eax
   0x000000000000b26f <+15>:	jmpq   0xb274 <cpuset_cpumask_can_shrink+20>
   0x000000000000b274 <+20>:	jmpq   0xb279


$ diff <(gdb -batch -ex 'disassemble cpuset_cpumask_can_shrink' before/core.o) \
       <(gdb -batch -ex 'disassemble cpuset_cpumask_can_shrink' after/core.o)
<nothing>

Generally I think it's good to not be afraid to use intermediate variables
if they improve readability, even if they have only one use (e.g. as
parameter to a function with many arguments / long expressions used as
parameters).

In this case though, the intermediate variable really doesn't do much for
readability :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/sched/core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a66960da3f5c..f3f2ece26291 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9273,14 +9273,10 @@ void __init init_idle(struct task_struct *idle, int cpu)
>  int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>                             const struct cpumask *trial)
>  {
> -	int ret = 1;
> -
>       if (cpumask_empty(cur))
> -		return ret;
> -
> -	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
> +		return 1;
>
> -	return ret;
> +	return dl_cpuset_cpumask_can_shrink(cur, trial);
>  }
>
>  int task_can_attach(struct task_struct *p,
> --
> 2.18.2

