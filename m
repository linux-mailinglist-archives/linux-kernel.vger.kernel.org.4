Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F196E8302
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDSVHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDSVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:07:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DA2107
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:07:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b621b1dabso100960b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681938451; x=1684530451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oyt6QNUaCcDWPUrakvaGCK9nOfHiZ8gYVdDjTcz/fto=;
        b=kgFc0QGurAiZIIzkZxeIPwiSnlVM/lKit3blxQeVCUj0g1kp7WaiULBOAoFYqkaGp1
         qfWjlcusHgSgI0QpB2/gOdRFuqnxeBz4ErAh+jQwxF5AzlzmMHZfhehAuCQ3Q76NRhaL
         eyVR9R7xEK7BmCr6/TmLWlXv+TMlYD225cfuEWXZoE3z/b9aU4uB88kPFDn77VOm3Jpq
         0MKZuhVLrXFUKZzyrJVS2Xdz4oBTXpFs0pen7H+CcII6huU07U0ZDNvS93xAXQJ7iG6I
         zfQcu9UK8+DT3zosYj8lHyf+r/jRK/+ygigA0Mb+uyvWH+DXt5+2E+4UJ1tcVTS4dQ0s
         58iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938451; x=1684530451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyt6QNUaCcDWPUrakvaGCK9nOfHiZ8gYVdDjTcz/fto=;
        b=jXm7BO3jyBPgZhxtYZ+jHWeWMdhlrjDR//bShYhUIVZ9iBMVqVpOUniSCLx318jEc1
         PryworZKYh7uMVq8jMAhA/kSFgd0vBUvpx2ubwQ+9s5dYDaTvRn9SmzVVzHQGgCC4j4j
         a0yDiXRkTMZiUtLoefNEIxBPHJ14JmxNIK/0JlgctUh8OeBNz6/wvUT5fABcQikG1JE0
         3Y9V5OeAuaig0EqAb7klMRy2TZiPaRrxQ/LJgO87ulbDNXaaU8QFbAIKjQ344gLOoFEE
         FpY7837yW6YbMCZoEpwUnZ3jOvpc7DkWLJ8FkNJBFi95PHFqDmX9A64mJCYRiFsuq7i6
         tHOQ==
X-Gm-Message-State: AAQBX9c7aWWgBccFM2/cT9crxu2RyYDCjeGYYNCMeMujx28IMAxr8fDX
        8OORzxx3HhwDqv89Ll4YpmhcDA==
X-Google-Smtp-Source: AKy350bj6vmJiYsmaMMiYU0mLociOdx6IlXpNpkUji6dJ5AqERgEKGL0RT5pBwfV4Ctxtuq679ez+w==
X-Received: by 2002:a05:6a00:4aca:b0:63d:3a18:49fd with SMTP id ds10-20020a056a004aca00b0063d3a1849fdmr6503623pfb.2.1681938450719;
        Wed, 19 Apr 2023 14:07:30 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a62ae0f000000b0063b8d21be5asm6393691pff.147.2023.04.19.14.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 14:07:30 -0700 (PDT)
Message-ID: <20391481-88bf-2ef4-cac5-7bd2d33c18d6@kernel.dk>
Date:   Wed, 19 Apr 2023 15:07:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] relayfs: fix out-of-bounds access in relay_file_read
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        zhangzhengming <zhang.zhengming@h3c.com>
Cc:     surenb@google.com, wuchi.zero@gmail.com, Ilia.Gavrilov@infotecs.ru,
        xu.panda@zte.com.cn, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org, zhou.kete@h3c.com,
        Pengcheng Yang <yangpc@wangsu.com>
References: <20230419040203.37676-1-zhang.zhengming@h3c.com>
 <20230419140325.b85d54794baaa828a19c138f@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230419140325.b85d54794baaa828a19c138f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 3:03?PM, Andrew Morton wrote:
> On Wed, 19 Apr 2023 12:02:03 +0800 zhangzhengming <zhang.zhengming@h3c.com> wrote:
> 
>> From: Zhang Zhengming <zhang.zhengming@h3c.com>
>>
>> There is a crash in relay_file_read, as the var from 
>> point to the end of last subbuf.
>> The oops looks something like:
>> pc : __arch_copy_to_user+0x180/0x310
>> lr : relay_file_read+0x20c/0x2c8
>> Call trace:
>>  __arch_copy_to_user+0x180/0x310
>>  full_proxy_read+0x68/0x98
>>  vfs_read+0xb0/0x1d0
>>  ksys_read+0x6c/0xf0
>>  __arm64_sys_read+0x20/0x28
>>  el0_svc_common.constprop.3+0x84/0x108
>>  do_el0_svc+0x74/0x90
>>  el0_svc+0x1c/0x28
>>  el0_sync_handler+0x88/0xb0
>>  el0_sync+0x148/0x180
>>
>> We get the condition by analyzing the vmcore:
>> 1). The last produced byte and last consumed byte
>>     both at the end of the last subbuf
>> 2). A softirq who will call function(e.g __blk_add_trace)
>>     to write relay buffer occurs when an program calling
>>     function relay_file_read_avail.
>>         relay_file_read
>>                 relay_file_read_avail
>>                         relay_file_read_consume(buf, 0, 0);
>>                         //interrupted by softirq who will write subbuf
>>                         ....
>>                         return 1;
>>                 //read_start point to the end of the last subbuf
>>                 read_start = relay_file_read_start_pos
>>                 //avail is equal to subsize
>>                 avail = relay_file_read_subbuf_avail
>>                 //from  points to an invalid memory address             
>>                 from = buf->start + read_start
>>                 //system is crashed
>>                 copy_to_user(buffer, from, avail)
> 
> Thanks.  Hopefully Pengcheng Yang and Jens Axboe can comment.

Patch looks good to me, but that doesn't necessarily say much. I never
did much relayfs hacking, and the bits I did was probably almost 20
years ago at this point when I wrote blktrace...

-- 
Jens Axboe

