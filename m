Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE166BB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjAPKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjAPKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF21A949
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673863615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utBEhwz3I4xTt4VIWSQ2Wq24W/wWfrsA+dG2HY8SvPQ=;
        b=EhhufsTqZI2ikEcJXAT7YoA52+wt9DMgfzuZgUCRDEUbnE3NNLpTgMbmNaKPOr/fYvTl9P
        89/yZ6qTcwzim/P3Rrpdjtz5/udLAIjBOHN2eU4Zkjec3Iji4MgIO1kNTlEw41Ku/5S/cX
        mdpVwY+H4iH/r9t1Enac1vE22YjGg9k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-FvWTvvOGNIu9JqzoZDfNdQ-1; Mon, 16 Jan 2023 05:06:53 -0500
X-MC-Unique: FvWTvvOGNIu9JqzoZDfNdQ-1
Received: by mail-ej1-f72.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so2031810ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utBEhwz3I4xTt4VIWSQ2Wq24W/wWfrsA+dG2HY8SvPQ=;
        b=CAgiS7v7xIKm0320mMuoXDfLf9dKLUPSSKNl58p//UemhCjwOdb00FGrstcF1PdFtZ
         ew6ePf8ABVsoJjsSSfGc7XvKYIBEkLf+uBb7cLQpAUz25zqxjVmu75Y8ika7Yml+I9yo
         BVWsjNDqUv2UadPQ9CbyrbiP0Muun0xIE8FQrtes8tbfNZeJlobmyzV5vEAkPGO1TXIO
         mYLMMTOGmM4yYK6zv5pMkx28gPhdmVSA9MjjhdPV+EktQFCVL3polp/rC6Rx3vSiQbbX
         SPnp/r8Rz4SwkiPfiwvY14bIxhcVNs7+eo4MOnY23eZqPUuXFVdGB3iHklKefhZ5+Q5q
         UPLQ==
X-Gm-Message-State: AFqh2koxLS5F1V2iJkHQz795CkW29G0a1e9/0PBFYcX8sFv4vx5HlA/M
        Lss6jtTL2D2yS1GASswbzk7ETiyh+ZJ92iYIyP8HJc9i0XfXL626eGWmKXrWlcKEDdz/tJoM/VF
        KlS1azaPie4bMd+2ktPnB2f41
X-Received: by 2002:a17:906:30d3:b0:7c1:1e5a:ed10 with SMTP id b19-20020a17090630d300b007c11e5aed10mr92086928ejb.8.1673863612297;
        Mon, 16 Jan 2023 02:06:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtza4H9rasmjokup90Tvu2HZKhPVerxRQjKmCHRUPFo+rdfTo4BcJ7GMG+K/amUTwJMHAuIRw==
X-Received: by 2002:a17:906:30d3:b0:7c1:1e5a:ed10 with SMTP id b19-20020a17090630d300b007c11e5aed10mr92086904ejb.8.1673863612011;
        Mon, 16 Jan 2023 02:06:52 -0800 (PST)
Received: from [192.168.0.198] (host-79-52-203-188.retail.telecomitalia.it. [79.52.203.188])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm3363494ejh.205.2023.01.16.02.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:06:51 -0800 (PST)
Message-ID: <3cd68923-660b-42d9-2fce-4cf5f9369d18@redhat.com>
Date:   Mon, 16 Jan 2023 11:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
 <Y8USikoCYTBl7VFr@gmail.com> <Y8UYtEepRT3xC8O/@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <Y8UYtEepRT3xC8O/@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 10:28, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>>> Urgh, can we please make this a cpuidle governor thing or so? So that 
>>> we don't need to invent new interfaces and such.
>>
>> I think the desired property here would be to make this interface on top 
>> of pretty much any governor. Ie. have a governor, but also a way to drop 
>> any CPU into idle-poll, overriding that.
> 
> ... with the goal of having the best governor for power efficiency by 
> default - but also the ability to drop a handful of CPUs into the highest 
> performance / lowest latency idle mode.
> 
> It's a special kind of nested policy, for workload exceptions.

Yep, it is for the (extreme, but existing) case in which the user wants to skip idle driver
machinery (and overheads involved).

People use idle poll on high-frequency trading or to avoid scheduling out a vCPU,
but as the systems are becoming more dynamic (and shared), having this option dynamic
and per-cpu is useful...

-- Daniel
> Thanks,
> 
> 	Ingo
> 

