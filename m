Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132F7199E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjFAKfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjFAKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E3C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685615691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbwVxe6+xmwUKvGIJv5WqDZHuN38pvVs22yL4zWwfDk=;
        b=WeeuLdzhWqTDAUwqo0SMrkbMcO2CVkgCg695fHClROR5+Z/nPsGRhC5VKRTm65etMB0//y
        HTvEb8vYBE1CTnbxjLXGi5kNPMoMrTO9QDX5vhQ/04ykDOUlqaUYVxI+bFZUawNCaLlOSw
        kkzIJ1cVBnBWNizP0hGPC/J4Bfle0wQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-83e87OTmNdCQnfHRpcX-yg-1; Thu, 01 Jun 2023 06:34:50 -0400
X-MC-Unique: 83e87OTmNdCQnfHRpcX-yg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96fa4c724fdso244015866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685615689; x=1688207689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbwVxe6+xmwUKvGIJv5WqDZHuN38pvVs22yL4zWwfDk=;
        b=NpaxyqLumu8x7hstCxyQ29ZaM8fpg2D5jkHhkoCxeGtlxVKmOU5iyzBnUEhbdnCMBc
         a/5CP4S6SA2oU/TpbSQlttZcOEC4U8F0HkUWmUyhY33BuQTZ3DxmigBGxf04PAgZUhF0
         EZlwWNmMnrj2oElx6EA57muHWCBrNaRk0bWgmMSF/70I9pHrspjJg+0f64B6f7T5NbAs
         WygC2z8Y1hnugE/qjHRzX6enV39S3UfT3W/o/6+Rrgv7M41EIw2pBX48tzZ6sWvI7sQk
         vXOUZWm5Cc8UOrqzCM1tqr3qrvsbw5rx5wgeimh3dJYuugQAV5oYRSrKwWhCIbyiU2xj
         WCdQ==
X-Gm-Message-State: AC+VfDyv+7nhMvmeJ5aM3eUvkkTNz39uoau8nxPRlBRwLdnWyCBOiDDe
        f3UP1uRBTPWI9soY20JEgMaS4AwlMgA7hzsoAZDCroiKllkz/Zy5CsmD/7E2zL7ph9i6QjeZXhO
        SFDeF2Q9/FPLkdkuRTitrYTKx
X-Received: by 2002:a17:907:96a6:b0:973:7096:60c2 with SMTP id hd38-20020a17090796a600b00973709660c2mr1384110ejc.20.1685615689653;
        Thu, 01 Jun 2023 03:34:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iRZhaMUInghZ0iVaiwaetNtipwYRss7o+cKaQOXKsyUmAG2w/BEDo9bC199Nw3fCDGqCP0Q==
X-Received: by 2002:a17:907:96a6:b0:973:7096:60c2 with SMTP id hd38-20020a17090796a600b00973709660c2mr1384093ejc.20.1685615689344;
        Thu, 01 Jun 2023 03:34:49 -0700 (PDT)
Received: from [192.168.0.224] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090627c300b0096a1ba4e0d1sm10330726ejc.32.2023.06.01.03.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:34:48 -0700 (PDT)
Message-ID: <605cbf2c-e41e-a3fe-61ee-0703f7a762da@redhat.com>
Date:   Thu, 1 Jun 2023 12:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 1/2] sched/deadline: Fix bandwidth reclaim equation in
 GRUB
To:     Vineeth Pillai <vineeth@bitbyteword.org>,
        luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230530135526.2385378-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 15:55, Vineeth Pillai wrote:
> According to the GRUB[1] rule, the runtime is depreciated as:
>   "dq = -max{u, (1 - Uinact - Uextra)} dt" (1)
> 
> To guarantee that deadline tasks doesn't starve lower class tasks,
> we do not allocate the full bandwidth of the cpu to deadline tasks.
> Maximum bandwidth usable by deadline tasks is denoted by "Umax".
> Considering Umax, equation (1) becomes:
>   "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)
> 
> Current implementation has a minor bug in equation (2), which this
> patch fixes.
> 
> The reclamation logic is verified by a sample program which creates
> multiple deadline threads and observing their utilization. The tests
> were run on an isolated cpu(isolcpus=3) on a 4 cpu system.
> 
> Tests on 6.3.0
> ==============
> 
> RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
> TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.33
> TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
> 
> RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
> TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
> TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
> 
> RUN 3: 2 tasks
>   Task 1: runtime=1ms, deadline=period=10ms
>   Task 2: runtime=1ms, deadline=period=100ms
> TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.67
> TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.37
> TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.38
> TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.23
> 
> As seen above, the reclamation doesn't reclaim the maximum allowed
> bandwidth and as the bandwidth of tasks gets smaller, the reclaimed
> bandwidth also comes down.
> 
> Tests with this patch applied
> =============================
> 
> RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
> TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.19
> TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.16
> 
> RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
> TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.27
> TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.21
> 
> RUN 3: 2 tasks
>   Task 1: runtime=1ms, deadline=period=10ms
>   Task 2: runtime=1ms, deadline=period=100ms
> TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.64
> TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.66
> TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.45
> TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.73
> 
> Running tasks on all cpus allowing for migration also showed that
> the utilization is reclaimed to the maximum. Running 10 tasks on
> 3 cpus SCHED_FLAG_RECLAIM - top shows:
> %Cpu0  : 94.6 us,  0.0 sy,  0.0 ni,  5.4 id,  0.0 wa
> %Cpu1  : 95.2 us,  0.0 sy,  0.0 ni,  4.8 id,  0.0 wa
> %Cpu2  : 95.8 us,  0.0 sy,  0.0 ni,  4.2 id,  0.0 wa
> 
> [1]: Abeni, Luca & Lipari, Giuseppe & Parri, Andrea & Sun, Youcheng.
>      (2015). Parallel and sequential reclaiming in multicore
>      real-time global scheduling.

So, I did some testing, mainly to validate the "one task cannot run on
two CPUs,"  that is, a case in which a higher utilization task would
always have its % of CPU available, even in the presence of low utilization
trying to reclaim all the CPU time. E.g.,

	Task 1: runtime=1ms, deadline=period=10ms with reclaim
	Task 2: runtime=1ms, deadline=period=10ms with reclaim
	Task 3: runtime 8ms, deadline=period=10ms without reclaim

On two CPUs task 3 always have 80% available... the other tasks
do not get 95% because of migrations.

With 3+ cpus, the tasks can run up to 95% because there are CPUs to
everyone.

I played with migrate disable to force timelines... and yet, I failed
to break things so... we are good :-).

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

