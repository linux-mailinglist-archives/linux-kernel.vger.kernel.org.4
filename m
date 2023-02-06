Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8648D68B487
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBFDkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:40:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A11421A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:40:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so9979723pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 19:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAM2at24OOBvXTpjluUl1hBo8u80GKWlyMQ4P55j2QQ=;
        b=aY2poNpFxIkZtr81A02OHx3U2uiwUWOnrvdTtaGLzQNvqmZEAjbiAN6cEL0i8tPB5m
         ij4IflD78ws/b/mEdIorFvIu7XyMQSkefRWxwMGDE7dudhGiG1kSAiyo01jnXCgmllhO
         wjHv9qCZm9cVIAOe0nMuaMwaUAoAMkbIis19EPkNh8sW1MqYth5O9hpDXi0uMNrl3eQJ
         ntxybALFJ+ZtNCPex19nqeKKlMgENJntF4fURagJxxYcDnJKYDmGjrqHdLQcV/lke17c
         8PITQY3gCb/zzKUTbFn7znrHPc6y//wIxY/pT0QkpzyIZPzTzohbWmdzw7BPbhGUur59
         UwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAM2at24OOBvXTpjluUl1hBo8u80GKWlyMQ4P55j2QQ=;
        b=rSin8ab3z9TbIRxFBuNUmlot268vNxnxAowC07fAzL2S/LqrE9RRsqxOFCM7wolllw
         QDzALoNEiGEOpF/DLyc0praME7/Tzih40eYrKcW0KfatmdbWW9vWkfrx7P69uVpou9w8
         xaMpYGRCAEvrrO3cXzQb+nG79RKuH8GiJekTWCJKL5PiyR4zPlP2tQzKLfBn+EgQQMNe
         ITiHpsWQlCMDGkEBJAUirUT9e7nxU5GG/HgHDoOVjZN6CfT5mW1nHmig+D7uI1lFNZty
         Afk5zBC/lifMyUoktCObJ/NaBmau5jSDP304V7Io4dsfaV8vJWjKFZvjHLDryA8tsQPe
         B7YA==
X-Gm-Message-State: AO0yUKXnTBoAQgaDykm28xZrNz1emOeki9iM7zEtkgv0qiYreD4hXTvP
        dEaSsgFew3IhK/VsxhB8zecTAAvG7e4WeUFC
X-Google-Smtp-Source: AK7set9cxTDhBIK24Q/ce19/XVSdmDYqIZ6PgsBsbhbxej22cUtpZWIApNOIeUqHhyDkr+bPlY+GpQ==
X-Received: by 2002:a17:90b:3e85:b0:230:3432:31fa with SMTP id rj5-20020a17090b3e8500b00230343231famr19745732pjb.28.1675654818622;
        Sun, 05 Feb 2023 19:40:18 -0800 (PST)
Received: from [10.87.52.26] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a690100b00230a50e6eadsm1702653pjj.24.2023.02.05.19.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 19:40:18 -0800 (PST)
Message-ID: <df83098d-1568-109c-a4ac-176fc786d544@bytedance.com>
Date:   Mon, 6 Feb 2023 11:40:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
References: <20221218050310.1338630-1-wuqiang.matt@bytedance.com>
 <20221229235220.4044edccae7c9d39798af8e9@kernel.org>
 <20230205052240.4581ef09@rorschach.local.home>
Content-Language: en-US
From:   wuqiang <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v8 0/5] lib,kprobes: kretprobe scalability improvement
In-Reply-To: <20230205052240.4581ef09@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I'm still working on the v9, but these days I'm a bit tied up with projects
at work. Hopefully I can figure it out this month.

Thanks,
Matt

On 2023/2/5 18:22, Steven Rostedt wrote:
> On Thu, 29 Dec 2022 23:52:20 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> Hi Matt,
>>
>> Sorry, I missed to commented v7 patch. Anyway, please read
>> my comments on previous version.
>>
>> On Sun, 18 Dec 2022 13:03:05 +0800
>> wuqiang <wuqiang.matt@bytedance.com> wrote:
>>
>>> This patch series introduces a scalable and lockless ring-array based
>>> object pool and replaces the original freelist (a LIFO queue based on
>>> singly linked list) to improve scalability of kretprobed routines.
>>>
>>> v8:
>>>    1) objpool: refcount added for objpool lifecycle management
>>
>> At least this update part looks good to me.
>> (But I think this may be useful only for kretprobe/rethook
>> use cases...)
>>
> 
> Masami,
> 
> Were there other updates you expected from this series?
> 
> -- Steve

