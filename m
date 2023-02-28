Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC06A5660
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjB1KLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1KLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:11:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC3279BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:11:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p6so8999822plf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wD/SGxYAJGfv6P7lzgEe2qnIweNRY2a8ZhgJw0kNFSQ=;
        b=Qpa7Z37ILyNstbZDM5+E6l3Osh8PM0l1LPn768bFkmh1ohK/pX/5bbTkJLc7VJv9w4
         k9o0PJYYOa7W94Ca8nAHOyI5LwySqwqXcRZOrh1zis35NDAMnUhWd9870V2K8YbtyZy8
         MXY+pNJWAUcS1QZX/bnOKIfD2Y45ARlq/7yTBPmN/DCelbG7JAznkEoAh3L9Ru2vIrde
         cbUQSsaGOMqQ2g9mCsY82bMfgdWMLDmyXlvD1ZGMhOy+KZg+ttVEHbfXoUdEQYRyP+iW
         8Mq6EmlrZznU94Eg8oklkZRV7w8XlbRK5vFXQgV0AjqoJ8mqbtjPWvClawjhdhXz+XhL
         kqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wD/SGxYAJGfv6P7lzgEe2qnIweNRY2a8ZhgJw0kNFSQ=;
        b=G7z7hbavZMu1/ra+7Hvk0GukZk0tz5z/PdqrDTNU31QYlGunTTXDsMJHhJLo8Rajwh
         P3oSnmCAXwR0otZND/Vw/ZyTsUxYKlGiyhsg7Q/rbl1Bt5yfnTguQ10FGi/8tWZj06nZ
         Jh/LYtjuuiDSh+teNHNCFBxMew/3yF8dlXaKSYBGUwBg3QMWSZHWTu4dnzGw0baBV9f6
         7wjUqMdxkH3sy57kl/sLD1rSKCvs2xmwUOetRofZYVCeMALGCP+25kuIHuyoood0lCyX
         WUKfDohBmt31YpH4DXyYjwFdu7c3V7l04VLA+ocQZT0/18XSC4zwoIC2Hlpi/T1I3nlx
         pDEw==
X-Gm-Message-State: AO0yUKUSVkzdYFHhkF2PuSb0Yvcvudtc6dhQd+kdIp47fKCub1yVMzYW
        Uj/Im60DLHGR2Hp6Sjis64BxjrGKEWjuKFoC
X-Google-Smtp-Source: AK7set/NqFYLT+08TLimNOADHeZ7U7fMUGrCa49QHr97+9Sj8HhckgDQjybug9FgeK2Ze8dsPdh7Tg==
X-Received: by 2002:a05:6a20:8e02:b0:c0:2875:9e8c with SMTP id y2-20020a056a208e0200b000c028759e8cmr3420724pzj.1.1677579102830;
        Tue, 28 Feb 2023 02:11:42 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b005a8ce67874asm5694754pfo.86.2023.02.28.02.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:11:42 -0800 (PST)
Message-ID: <c949c89a-0b0d-723f-4c60-f6374b1993f3@bytedance.com>
Date:   Tue, 28 Feb 2023 18:11:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tkhai@ya.ru,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/z+P5cgeunD6u21@P9FQF9L96D>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y/z+P5cgeunD6u21@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 03:02, Roman Gushchin wrote:
> On Mon, Feb 27, 2023 at 09:31:51PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/2/27 03:51, Andrew Morton wrote:
>>> On Sun, 26 Feb 2023 22:46:47 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>> Save the above script, then run test and touch commands.
>>
>> Then we can use the following perf command to view hotspots:
>>
>> perf top -U -F 999
>>
>> 1) Before applying this patchset:
>>
>>    32.31%  [kernel]           [k] down_read_trylock
>>    19.40%  [kernel]           [k] pv_native_safe_halt
>>    16.24%  [kernel]           [k] up_read
>>    15.70%  [kernel]           [k] shrink_slab
>>     4.69%  [kernel]           [k] _find_next_bit
>>     2.62%  [kernel]           [k] shrink_node
>>     1.78%  [kernel]           [k] shrink_lruvec
>>     0.76%  [kernel]           [k] do_shrink_slab
>>
>> 2) After applying this patchset:
>>
>>    27.83%  [kernel]           [k] _find_next_bit
>>    16.97%  [kernel]           [k] shrink_slab
>>    15.82%  [kernel]           [k] pv_native_safe_halt
>>     9.58%  [kernel]           [k] shrink_node
>>     8.31%  [kernel]           [k] shrink_lruvec
>>     5.64%  [kernel]           [k] do_shrink_slab
>>     3.88%  [kernel]           [k] mem_cgroup_iter
> 
> Not opposing the intention of the patchset in any way (I actually think
> it's a good idea to make the shrinkers list lockless), but looking at
> both outputs above I think that the main problem is not the contention on
> the semaphore, but the reason of this contention.

Yes, in the above scenario, there is indeed no lock contention problem.

> 
> It seems like often there is a long list of shrinkers which barely
> can reclaim any memory, but we're calling them again and again.
> In order to achieve real wins with real-life workloads, I guess
> it's what we should optimize.
> 
> Thanks!

-- 
Thanks,
Qi
