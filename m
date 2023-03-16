Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC26BCF13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCPMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCPMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A3CA1D7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678968754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3ePG2Jrp890ig/knJcRR9G7Nf8O/pD+ILggETyijLE=;
        b=Q1UoIn+CXJUtQEbxd5+6XYOBZOj9hVtgsafrqR3SnmFR1O8f5xOFPhQS7Dq0odbcBx9YlR
        Qa9Rtro7UQwNDsbiHoycXisTj3UErLVdNu1NESCnmGmTA1IhqnDIS9XpauxHh736GK9atC
        7VBTdD818RZJPYO7z96A6EhMXp8nDkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-1pUCTdxxO1m-R1y0yHD9Kg-1; Thu, 16 Mar 2023 08:12:33 -0400
X-MC-Unique: 1pUCTdxxO1m-R1y0yHD9Kg-1
Received: by mail-wr1-f69.google.com with SMTP id i11-20020a5d522b000000b002ceac3d4413so235852wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968752;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ePG2Jrp890ig/knJcRR9G7Nf8O/pD+ILggETyijLE=;
        b=poVBWnpGx8oJcnqzf8M9ApZSU2Y3/o0dS08KVMvjCyY/KMVfDBZJSiYepAAoJC6DWa
         cexu3xubIKwS8pPvOXlyXGXrgYLwybMzECg9jCgq8w7s3ZL9lFLoGrVPssSru0l6IoAT
         8dR7gIq5npKvLhsolcvztLRuygGf+aSESZT4JbT/qGbJUGkKxfViHMrvbV03h2Jf9HRs
         hUoxUCl+oEg4vPDaLNBMCHD6pWyOoNOhMR0vu31KydwVk5TZjDSrigOhjy4vjfhSe+xS
         vM3/H0HrtTenB7wmuVw9O9Ary3G+JC6GU3Cmb1UDsGB+kKJONEyKFNyFL51OhdWXwYdC
         P62Q==
X-Gm-Message-State: AO0yUKWX8wBsFkITXrQ1e95NsiNyOgW4A/4FuxbZfp4fOkTmCgMzhY63
        ZwWxf7JHJHNjr9p7XtE3vP0X+mMz+8seuRQwXj4GTXsw7s8ZYp8qa9tZhwK85ei0y8Gq7h1WEBR
        9gqiPkn0nmuLDPEA0qbC/iKsQ
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr2870285wrt.31.1678968752088;
        Thu, 16 Mar 2023 05:12:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set9hnQElOyOXPASGPy67qgi72TVHh3me4TqgjjfTT8ZUaHm1fD1K1dsqjqZFiZPLA4Z0ykCC7g==
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr2870267wrt.31.1678968751830;
        Thu, 16 Mar 2023 05:12:31 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b002c5a790e959sm7146090wrv.19.2023.03.16.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:12:31 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yicong Yang <yangyicong@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     yangyicong@hisilicon.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linuxarm@huawei.com, prime.zeng@huawei.com,
        wangjie125@huawei.com
Subject: Re: [PATCH] sched/fair: Don't balance migration disabled tasks
In-Reply-To: <4968738b-940a-1207-0cea-3aea52c6e33e@huawei.com>
References: <20230313065759.39698-1-yangyicong@huawei.com>
 <xhsmhilf2m3k4.mognet@vschneid.remote.csb>
 <4968738b-940a-1207-0cea-3aea52c6e33e@huawei.com>
Date:   Thu, 16 Mar 2023 12:12:28 +0000
Message-ID: <xhsmh7cvgnbdf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/23 17:13, Yicong Yang wrote:
> Hi Valentin,
>
> On 2023/3/15 23:34, Valentin Schneider wrote:
>> That cpumask check should cover migration_disabled tasks, unless they
>> haven't gone through migrate_disable_switch() yet
>> (p->migration_disabled == 1, but the cpus_ptr hasn't been touched yet).
>>
>> Now, if that's the case, the task has to be src_rq's current (since it
>> hasn't switched out), which means can_migrate_task() should exit via:
>>
>>         if (task_on_cpu(env->src_rq, p)) {
>>                 schedstat_inc(p->stats.nr_failed_migrations_running);
>>                 return 0;
>>         }
>>
>> and thus not try to detach_task(). With that in mind, I don't get how your
>> splat can happen, nor how the change change can help (a remote task p could
>> execute migrate_disable() concurrently with can_migrate_task(p)).
>>
>
> I see, for migrate disabled tasks, if !p->on_cpu the migration can be avoid by
> the cpus_ptr check and if p->on_cpu migration can be avoid by the task_on_cpu()
> check. So this patch won't help.
>

Right.

>> I'm a bit confused here, detach_tasks() happens entirely with src_rq
>> rq_lock held, so there shouldn't be any surprises.
>>
>
> Since it's a arm64 machine, could the WARN_ON_ONCE() test be false positive?
> I mean the update of p->migration_disabled is not observed by the balance
> CPU and trigger this warning incorrectly.
>

Since the balance CPU holds the src_rq's rq_lock for the entire duration of
detach_tasks(), the actual value of p->migration_disabled shouldn't matter.

Either p has been scheduled out while being migration_disabled, in which
case its ->cpus_ptr has been updated, or p is still running, in which case
can_migrate_task() should return false (p->on_cpu). But from your report,
we're somehow not seeing one of these.

>> Can you share any extra context? E.g. exact HEAD of your tree, maybe the
>> migrate_disable task in question if you have that info.
>>
>
> We met this on our internal version based on 6.1-rc4, the scheduler is not
> patched. We also saw this in previous version like 6.0. This patch is applied
> since 6.2 so we haven't seen this recently, but as you point out this patch doesn't
> solve the problem.

Could you try to reproduce this on an unpatched upstream kernel?

