Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDC617B78
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKCLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiKCLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:24:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A2D12615
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:24:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y203so1303582pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb1PCHwGfPo505kh/ELVZrrK/1cmmXPJSCGJGf5/CVM=;
        b=4IcBBu5xgDAajmbgwG8b2dzVfCzhWls5JzKrjlK5+CEYksx7SF8JXS/el9C/Ye4D0W
         Vf1tKOum5TCVJikKpdAxcfX+rTHeRquq2NEcC5LE4D0tINAZlgi9TsomD1L8daYn9Haq
         p6X/KbaWlZGnjiQT9v8Dhs2g9WYsN+kIXcNxXm8namegFXLwaSXe2750GySr/Uaq0qUq
         QIbYCK25AH1BhM8itZ+PUKKWZDKxIfFZ1rdGfDSi8HlVSSXkhEM+/n0iINRaHHE9hlwi
         4VdpSg7k9Zvl/hKROzaXuay2+VJ+zhM3kHDstFYsY2nJYpj1xWKNAQ8mZPifPFMMLRwa
         Jm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cb1PCHwGfPo505kh/ELVZrrK/1cmmXPJSCGJGf5/CVM=;
        b=t1DcyzwyDP3KGaxLvosOxZYsYoTqADpa/aoG5wmp/eD5413W3P7R9UlofbVXqhJ7l+
         Th9CT9sFmIyOjRCsmQJc5279vP6jNnG3CyF0NleZjv0CdwdBE3rnCCOFSfQ+G+IU5Rvm
         fQfSfQ2E9KAALOPNIUOcsjpzX4oYTGEzMwcNcswm4esqrwKYUFm107tSqi9pMWYdSBhI
         //3bM1othV5waAxzjCI9rcFwbLzT1Gvg2VBvKIk4J2BmaQsSq2tpMkVdT4KWFkq8SNgE
         EZowPA/pkcxYUIjUas61AyHbWabD6roYcl+n4agREYFEeSHt73bqX/b72w6vxMhNKIH8
         CVfw==
X-Gm-Message-State: ACrzQf3iUOeSdpHttFkuSgNh20sdWC6dHxtyZOH92oB0OYtZoZgLkH+G
        RlzlLb6seOl8YbL+WiwCr1Ucsg==
X-Google-Smtp-Source: AMsMyM67mb6gwRtoiJsTr1oN2sdml6t3fKnaz6ZwUCzmOMgUnjY8mhTzFy4tWotyvA2C4BSlnToa2A==
X-Received: by 2002:a63:ce43:0:b0:45b:d6ed:6c2 with SMTP id r3-20020a63ce43000000b0045bd6ed06c2mr25767896pgi.406.1667474645549;
        Thu, 03 Nov 2022 04:24:05 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y1-20020a655a01000000b0046497308480sm546779pgs.77.2022.11.03.04.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 04:24:05 -0700 (PDT)
Message-ID: <a7eed150-75aa-6385-06e4-0a8bb02b4460@bytedance.com>
Date:   Thu, 3 Nov 2022 19:24:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
 <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com>
 <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/2 07:39, Josh Don 写道:
>>> Some weirdness about this change though, is that if there is a
>>> non-idle current entity, and the two next entities on the cfs_rq are
>>> idle and non-idle respectively, we'll now take longer to preempt the
>>> on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
>>> 'hidden' by the idle 'first' entity. Wakeup preemption is different
>>> because we're always directly comparing the current entity with the
>>> newly woken entity.
>>>
>> You are right, this can happen with high probability.
>> This patch just compared the curr with the first entity in
>> the tick, and it seems hard to consider all the other entity
>> in cfs_rq.
>>
>> So, what specific negative effects this situation would cause?
>> For example, the "hidden" non-idle entity's latency will be worse
>> than before?
> 
> As Abel points out in his email, it can push out the time it'll take
> to switch to the other non-idle entity. The change might boost some
> benchmarks numbers, but I don't think it is conclusive enough to say
> it is a generically beneficial improvement that should be integrated.
> 
> By the way, I'm curious if you modified any of the sched_idle_cpu()
> and related load balancing around idle entities given that you've made
> it so that idle entities can have arbitrary weight (since, as I
> described in my prior email, this can otherwise cause issues there).
Hi Josh,

Indeed, there are some subtle influences here. For example,
find_idlest_group_cpu() may return i if sched_idle_cpu(i) is true.
In nromal cases, it would work well, however it would be unpredictable
if we change the default minumum weight. I have not found a suitable 
solution yet....

Thanks for your guidance.
