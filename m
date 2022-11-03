Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C678D618533
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiKCQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKCQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:47:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB3BC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:47:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h193so2139561pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dvQYgoi3y+vvQ50bO5wEY2ziKJgN3uRgIWAUr9E5Jw=;
        b=pYoK2nbwxhobDmPIN99Fe5ZJDC3EaKCAdu2UlQgObVlBQn6yMS1dly6lVwx3aQUj/y
         0El2jm8R/WlhBYegmcL2bmuxV2MxPdEGy2CPOG4KhdBYDeTfIWQFQYIEKYS7M3j1iqlh
         OCJueyc7jxkYESpHlrgmOWEAOMvVlEK5m7hz0DLMuBW9VkAdwkkARVGcIDXjHeUWokxY
         2GsGASLsrjXj6b4VXURqHExwVJbmw0Hbfw5nFIZqdJYOLfvTOIg00N8wpxqxpPHMBFtx
         FKPOxKMti3pQSmF6ptwywkCeTxkGLbKLRgOx5Xhe99MBlhU060/YNhK36uCeHc1V585A
         0pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dvQYgoi3y+vvQ50bO5wEY2ziKJgN3uRgIWAUr9E5Jw=;
        b=vxqR0Tjh08Tsv7CEbmBj4gKlBZWPhh87wpUm+kyxm6wbdc8g2UN8Sj+bJz6gGLEeLW
         nNHH9UGgoYG04RhjnXJCdpcqEvJti5o+2ggMEcIigT8Iu23lIO1i2dgcu2X4IlX08G0w
         VWZfcIba6bRApvuaDW9rlGyB1yJZ61EbOt5OlGqZSuvwD40Fw7LRAokTHbVieV8f9xfx
         kHZmBMxfTd2/9icfgtwUK0meor7zQkqo/Bg7Vdpva+Bhv5RJ0oiga50EgKSovJcn8cG6
         XKOz9hYIViIepuaSoRLdwDTtlU5SmkRNJKSawA3pslGnYvkj4kJL21BmjddIBmYqsotV
         7InQ==
X-Gm-Message-State: ACrzQf0CyR2zoJzk7C08B2x+sIzJEz9ZikSMyoAAtQmIYVIqEj58r0TB
        ywiK/AepzKr28LfOYLNMZl4CUasvfnrf2Q==
X-Google-Smtp-Source: AMsMyM7s4ZxRSAUI/zeKMRD+nuA22BGCHoMCrbWxcBOqaY8cuz48zL58Xjim/szUlBR3raO/YpHERg==
X-Received: by 2002:a65:628f:0:b0:43c:dac:646a with SMTP id f15-20020a65628f000000b0043c0dac646amr12422597pgv.397.1667494024954;
        Thu, 03 Nov 2022 09:47:04 -0700 (PDT)
Received: from [10.87.63.10] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b001837463f654sm848099plg.251.2022.11.03.09.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:47:04 -0700 (PDT)
Message-ID: <3fb41114-4ccf-bfc2-dc02-9379aec0415e@bytedance.com>
Date:   Fri, 4 Nov 2022 00:46:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4] kprobes,lib: kretprobe scalability improvement
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        kernel test robot <lkp@intel.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
 <20221102023012.6362-1-wuqiang.matt@bytedance.com>
 <20221102143312.a1b09fe962e8e1057fd4a872@linux-foundation.org>
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <20221102143312.a1b09fe962e8e1057fd4a872@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/3 05:33, Andrew Morton wrote:
> On Wed,  2 Nov 2022 10:30:12 +0800 wuqiang <wuqiang.matt@bytedance.com> wrote:
> 
>> Tests of
>> kretprobe throughput show the biggest ratio as 333.9x of the original
>> freelist.
> 
> Seriously.
> 
> I'll add this for some runtime testing.

Thanks.

> 
> Are you able to identify other parts of the kernel which could use
> (and benefit from) the new objpool?

The scalability issue is caused by freelist. Currently kretprobe and rethook 
are the only use cases.

I'm working on the evaluation of bpf percpu-freelist, which scales well but 
uses raw_spinlock and needs local irq disabled.
