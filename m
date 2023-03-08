Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0C6B0686
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCHMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjCHL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:59:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4A9BE24
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:59:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so2073655pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678276773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVQjKCHWrN1eYBET3mp20Di+hZdbe0lSR42xPROArtQ=;
        b=EFma8WgumnWMBW5sY+8kyuxHAzk5tNDb3Us6ZXeEaqwsYNheJwUgm86SBytCi8fOCB
         EuFC4LS+zO10RkMWEYMdQH7BqGybOto2clmwFOSkZk5XQpM3YadMZw1PI6DTYbRxT7wh
         VI3Za0HSA3GwO+3Y3Nn65mp2EBuGrBWFSbxR0i9w+VbiLNNqJrhvfvEqfDolMJ7jcFn2
         Bs3S2R8lFyZrT3OaRVOLcORIWC4W4J9NCfUL1izwSxRl4cE1pTC46ZLpSvNb4tmPUIq7
         nMZxLsL+foPBi967TsVrF2kJBnVi8V9RMdM/aLuWwTO69guWPqnEUlc6kGwUZ6sziicL
         CNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVQjKCHWrN1eYBET3mp20Di+hZdbe0lSR42xPROArtQ=;
        b=mj0vR8qJ0cLqwGXV4CzAQOH2XBQNoUDQEH8q5YOjYPjC26ENmjs0CMf5C7eF2h3Ytz
         CwEEB8ETeItKM2wD4iiPvr0JAfMzUll7N/guvGia8/0h/hOHUMTSGLRZYTBWIteLeQkC
         HeEhBN7Wuxf2DdKUMtwj7wcgst5i6lkDEga8upY7c87rAsMTgQlZsPfCg7KDxKOymRn7
         9G5CvUxkbF87786xOd5v7m5Y4kwuKfenMa4n1HvZvSX0um0iZsxiASqcJUG22TQDtByB
         hspPsi4ufTWHbOSdAJphuWBOxx9XLWgSsULIybHoCu0LY4qbUe8m39IeSR8/6L3r2VU/
         M0jA==
X-Gm-Message-State: AO0yUKWOpUxTZP3yPFjOhxT6BShBrAP9Fba2Ejq0loUO3pjB+0sbgxcW
        /oUac5Sh4aDdCaIKEgyv/9EPzg==
X-Google-Smtp-Source: AK7set/B2Iric4xq4dnnxMX1BGr/ZiRInaW9P9lKh/kW7S7m31/ABfaXCj0SKF+7cclRwHMN6tjwbA==
X-Received: by 2002:a05:6a20:3caa:b0:cc:ce6f:849d with SMTP id b42-20020a056a203caa00b000ccce6f849dmr19896528pzj.2.1678276773530;
        Wed, 08 Mar 2023 03:59:33 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 196-20020a6306cd000000b0050336b0b08csm9135022pgg.19.2023.03.08.03.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:59:32 -0800 (PST)
Message-ID: <6e926e0c-e971-7f0c-70f0-e224abb6740e@bytedance.com>
Date:   Wed, 8 Mar 2023 19:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/8] make slab shrink lockless
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307142026.31c964475fd3c9554a4f62cb@linux-foundation.org>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230307142026.31c964475fd3c9554a4f62cb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

On 2023/3/8 06:20, Andrew Morton wrote:
> On Tue,  7 Mar 2023 14:55:57 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Hi all,
>>
>> This patch series aims to make slab shrink lockless.
> 
> The v3 discussion did contain requests for some sort of measurements of
> real-world workloads.  And Kirill did suggest a workload which could be
> used for this measurement.
> 
> It's quite important that we have this info, please.  I mean, speeding
> up real-world workloads is the entire point of the patchset and without
> measurements, we don't know if the patchset achieves its primary
> objective!

I agree with this.

For the down_read_trylock() hotspot problem I encountered, I
posted a reproduction program in the cover letter, and measured the
change of IPC before and after applying the patchset.

For the case mentioned by Kirill, theoretically there is no competition
between slab shrink and register_shrinker() after applying this
patchset. But I haven't found a way to reproduce it yet, I will
continue to try to do it.

> 
> 
>> 3. Reproduction and testing
>> ===========================
>>
>> We can reproduce the down_read_trylock() hotspot through the following script:
>>
>> ```
>> #!/bin/bash
>>
>> DIR="/root/shrinker/memcg/mnt"
>>
>> do_create()
>> {
>>      mkdir -p /sys/fs/cgroup/memory/test
>>      mkdir -p /sys/fs/cgroup/perf_event/test
>>      echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>      for i in `seq 0 $1`;
>>      do
>>          mkdir -p /sys/fs/cgroup/memory/test/$i;
>>          echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>          echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>>          mkdir -p $DIR/$i;
>>      done
>> }
>>
>> do_mount()
>> {
>>      for i in `seq $1 $2`;
>>      do
>>          mount -t tmpfs $i $DIR/$i;
>>      done
>> }
>>
>> do_touch()
>> {
>>      for i in `seq $1 $2`;
>>      do
>>          echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>          echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>>              dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>>      done
>> }
>>
>> case "$1" in
>>    touch)
>>      do_touch $2 $3
>>      ;;
>>    test)
>>        do_create 4000
>>      do_mount 0 4000
>>      do_touch 0 3000
>>      ;;
>>    *)
>>      exit 1
>>      ;;
>> esac
>> ```
>>
>> Save the above script, then run test and touch commands. Then we can use the
>> following perf command to view hotspots:
> 
> Well.  Simply runnimg
> 
> 	time that-script

I tried this, but the script process will be killed because of OOM, so
the measured time is not accurate.

I will continue to try to measure more data besides IPC.

Thanks,
Qi

> 
> before and after and including the info in the changelog would be a start?

