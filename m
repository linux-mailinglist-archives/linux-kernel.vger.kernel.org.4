Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA127475A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGDPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGDPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5178B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688485967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3f/KnP/Vpac561DAxEX8ahpmDGVq/HBOY3OPPidhIk=;
        b=GfoJPWRuxv/ZK3mG1n5+2QiEmPLqJYY3FdN9VkNTlmbPO0HKWALMIUq6ypLVyNT99FQDZJ
        SyHnSP+bplBSmg/G1Hi8JPO5KtQsmV3z2sOFTWkTl7EXxeSAOYlzCDnGH4HR+DfABGb9kb
        +EstiFHSHzNj/ZVAgw6NV9TBhFX0lMk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mlqY3WL_ONaVJ6cKV5Jklg-1; Tue, 04 Jul 2023 11:52:46 -0400
X-MC-Unique: mlqY3WL_ONaVJ6cKV5Jklg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb76659d44so5373890e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485964; x=1691077964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3f/KnP/Vpac561DAxEX8ahpmDGVq/HBOY3OPPidhIk=;
        b=e4aldPpZlf3E6txppWpuqKcqNNmAYmjhyozmfouFSSe0xDJ69WNupMcBK3Z7ns+AFY
         M+Cqdp3senB8cxjwfMno46MeqNDZvQbv0vdlGuq/DKLnX529hg19BY/8rxjPbQZ80ieq
         mSKQL2khwEXm7khxLvZzlxHFQZLZBSVkWHWya1HA6jwXTgm1T0n1V0aFErcuCZY+7y0B
         jBU1eE3V4k59E2m4zVvIsVg93Isg8x1PkVlnRWn8U/kyYPtBqJIPItTr3POTLk6s9T6j
         J6V+c2HlcAVo3hfBsUhaKZBzA3R/Gx+d8LD+vvqrGPzHziO/H5wgxlDqAC0Y7KeLaAd5
         MBdA==
X-Gm-Message-State: ABy/qLbw9cumfQTfZSKY5zFes/Jlv8Mm7bLFpFVA4Af5ccRZU7O34224
        sEcAu5061DwIZ1IPc4h0yOaTw8zwybOleObruUaVM/QXH86gB/hNY6EJ2DLh4c+VKoSb3tp66r3
        5L8hr4Liv3aaknJQoUV1M1ziEI/guri7tXg8=
X-Received: by 2002:a05:6512:310a:b0:4fb:9168:1fc7 with SMTP id n10-20020a056512310a00b004fb91681fc7mr8705090lfb.51.1688485964536;
        Tue, 04 Jul 2023 08:52:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsvQcIr4kqtQciTJtUvCifZyNUeAejP0QU1XLeGaBMqSsR9099qH/PefB4Ef62YvoUcym7pw==
X-Received: by 2002:a05:6512:310a:b0:4fb:9168:1fc7 with SMTP id n10-20020a056512310a00b004fb91681fc7mr8705065lfb.51.1688485964147;
        Tue, 04 Jul 2023 08:52:44 -0700 (PDT)
Received: from [192.168.0.224] (host-79-49-207-213.retail.telecomitalia.it. [79.49.207.213])
        by smtp.gmail.com with ESMTPSA id lr3-20020a170906fb8300b00973f1cd586fsm13572166ejb.1.2023.07.04.08.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 08:52:43 -0700 (PDT)
Message-ID: <70837b44-4d21-9d70-d13b-2b6168fd02e3@redhat.com>
Date:   Tue, 4 Jul 2023 17:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH V3 4/6] sched/deadline: Introduce deadline servers
Content-Language: en-US, pt-BR, it-IT
To:     Valentin Schneider <vschneid@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
 <xhsmhpm5mw2gm.mognet@vschneid.remote.csb>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <xhsmhpm5mw2gm.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Back from EOSS...

On 6/23/23 18:47, Valentin Schneider wrote:
> On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
>> @@ -2033,9 +2147,20 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>>  	struct task_struct *p;
>>  
>>  	p = pick_task_dl(rq);
>> -	if (p)
>> +	if (!p)
>> +		return p;
>> +
>> +	/*
>> +	 * XXX: re-check !dl_server, changed from v2 because of
>> +	 * pick_next_task_dl change
>> +	 */
>> +	if (!dl_server(&p->dl))
>>  		set_next_task_dl(rq, p, true);
>>
> 
> Should this be
> 
>        if (!p->server)
> 
> instead? AFAICT dl_server(&p->dl) can never be true since there's no
> pi_se-like link to the server via the dl_se, only via the task_struct, and
> the server pick cannot return the server itself (as it's a pure sched_entity).

makes sense... I will check that in the v4.

> 
>> +	/* XXX not quite right */
>> +	if (hrtick_enabled(rq))
>> +		start_hrtick_dl(rq, &p->dl);
>> +
> 
> IIUC that got hauled out of set_next_task_dl() to cover the case where we
> pick the server (+ the server pick) and want to more thoroughly enforce the
> server's bandwidth. If so, what's the issue with starting the hrtick here?

I think that the commend was added more as a check if it is correct... it seems it is.

Thanks Vale!
-- Daniel

> 
>>  	return p;
>>  }
>>  
> 

