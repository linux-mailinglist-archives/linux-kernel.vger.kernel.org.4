Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8D6982F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBOSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjBOSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC721041B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676484661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A3P3Cmxv9JHLPTEUyERBuqKT77mZDmw7OnPrdA3R9so=;
        b=Ci6X/l66AjOX1sjSdtfExp4PlcQsRQy/Xa1gwwbuc5RjaTQetDY+vkFb4hYQR9XSzgwSR7
        zll4R2AY5Zebx3Haxl092qdFmSM28txVgP3NvMj3RAhMmJ25KZxwOaS1YuX+38exkaovhW
        luaZPtydZkQRFY+LkE5VuyITKe/48jU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-2BhvW5sPOdGatngLiBY6UA-1; Wed, 15 Feb 2023 13:11:00 -0500
X-MC-Unique: 2BhvW5sPOdGatngLiBY6UA-1
Received: by mail-qk1-f198.google.com with SMTP id x12-20020a05620a258c00b007051ae500a2so11859436qko.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3P3Cmxv9JHLPTEUyERBuqKT77mZDmw7OnPrdA3R9so=;
        b=PR8axjjtOaTFurveqXZH0vvluD9aza27QakJQOA27I8g3Jy/eQZJCNJ1/nbYFapkk1
         Yc9nHLKe//fjEN4hjVgUuVraYo266kO1i8KCqpQnkO/wvOSyh4EZ9QKeG/pcISeuYJT7
         ol116ofYHtXDAzrDYHUzm2c4yuX7rFlY0iMx+7pTn9a02svjYrfNb+pGczUz6wM00rgo
         dl5AlPUnU69LOZELQ3oKI2MRTnXA9MK8RYaFnSkHOx8ngrd6X9Aes4Di3YRSag0VGXhw
         j4V7LjcfojIn27+ERfDs60Ksz7VFn87c+7C8RglVcaiPJWGF9HEqB15un9quXfLC5ydR
         lh6g==
X-Gm-Message-State: AO0yUKVfgQgxEiy2+zCsxfAL6H7UqUZsFSfvg4GViPAWkFBWFFcheRB7
        8lC8bksQFALtZjid6hmJ/QMh89Ol+53eOEuTKlLKhuA6iNm32DUSHIAs3xZqNiPWIruSIGilryq
        SuWXYkm2h0GYJ72fnSfwNXGq3
X-Received: by 2002:ac8:5acc:0:b0:3b8:41d2:1b43 with SMTP id d12-20020ac85acc000000b003b841d21b43mr4301613qtd.61.1676484658107;
        Wed, 15 Feb 2023 10:10:58 -0800 (PST)
X-Google-Smtp-Source: AK7set/Knwl1qajB1k/lzTVi8qVvL010OUpwc6D/A0nOcmAaWVhuQVm32M1ktLdwsE6oWAsSh0HE6A==
X-Received: by 2002:ac8:5acc:0:b0:3b8:41d2:1b43 with SMTP id d12-20020ac85acc000000b003b841d21b43mr4301585qtd.61.1676484657828;
        Wed, 15 Feb 2023 10:10:57 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c193-20020ae9edca000000b007389403f7e6sm14632229qkg.9.2023.02.15.10.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 10:10:57 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn,
        sunshouxin@chinatelecom.cn
Subject: Re: [RESEND PATCH] sched: sd_llc_id initialized
In-Reply-To: <20230215015435.100559-1-sunshouxin@chinatelecom.cn>
References: <20230215015435.100559-1-sunshouxin@chinatelecom.cn>
Date:   Wed, 15 Feb 2023 18:10:53 +0000
Message-ID: <xhsmh8rgyre8i.mognet@vschneid.remote.csb>
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

On 14/02/23 17:54, Sun Shouxin wrote:
> In my test,I use isolcpus to isolate cpu for specific,
> and then I noticed different scenario when core binding.
>
> For example, the NUMA topology is as follows,
> NUMA node0 CPU(s):               0-15,32-47
> NUMA node1 CPU(s):               16-31,48-63
>
> and the 'isolcpus' is as follows,
> isolcpus=14,15,30,31,46,47,62,63
>
> One task initially running on the non-isolated core belong to NUMA0
> was bind to one isolated core on NUMA1, and then change its cpu affinity
> to all cores, I notice the task can be scheduled back to the
> non-isolated core on NUMA0.
>
> 1.taskset -pc 0-13 3512  (task running on core 1)
> 2.taskset -pc 63 3512    (task running on isolated core 63)
> 3.taskset -pc 0-63 3512  (task running on core 1)
>

This is working as intended, no?

> Another case, one task initially running on the non-isolated core
> belong to NUMA1 was bind to one isolated core on NUMA1,
> and then change its cpu affinity to  all cores,
> the task can not be scheduled out and always run on the isolated core.
>
> 1.taskset -pc 16-29 3512 (task running on core 17)
> 2.taskset -pc 63 3512    (task running on isolated core 63)
> 3.taskset -pc 0-63 3512  (task still running on core 63
>                           and not schedule out)
>

And this is also not wrong, since CPU63 is in the task's affinity mask.

That said, I can see that in this case we'd want the task to use other CPUs
if it makes sense wrt load balance.

However, since CPU63 is attached to a NULL sched_domain, AFAIA your
solution is at the mercy of the @prev and @target CPUs passed to
select_idle_sibling(). So this might only work if the waker is on a
non-isolated CPU.

I don't think your patch is wrong, but I don't think it entirely fixes the
issue either. Unfortunately, due to isolated CPUs being attached to NULL
sched_domains, there isn't a magic solution as the majority of scheduler
decisions are based on these.

A safe bet would be to exclude isolated CPUs from the affinity of your
non-critical tasks. Things like TuneD [1] and/or cpusets could help.

[1]: https://github.com/redhat-performance/tuned

