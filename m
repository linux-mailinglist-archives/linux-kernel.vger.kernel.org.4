Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2D6DA81A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDGDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDGDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:47:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D061E63
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:47:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-244a2cac6b7so140694a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680839250; x=1683431250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77QxDKdE2rjdmn5UavlvJ+dKYEVB2yFZDow3mJT0z7c=;
        b=XfexivY5m3FSANbetslsNJ+QLsk4IrinL45EjlgFtAJmtIvriFj4eVpciikknhMwps
         i6TdeOAZoX2/3eRfKd7zPB2yAF93MaBZgNbYgD8wxw6QhN3a1nRIoBWzpzCxB6ZP/8Ka
         yot4Godu5GPYfZ46OicDi32tswE1GIbefXxeN6orUgUq6EMKXbC2P0O/5jwgzhBiEtfj
         grY3VyLzK7MZb7BIg2BBLefU4BVXolQsDwBvseRI1R61yhQnOF4HIx/o9EYfdQgoruqI
         Cbje8MG37ssUWsp6KuGQ0vKQJh1cMYIsUsZmXiF3kog2Iaiu2ZfkZMgZagqeqoMAsi4y
         +UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680839250; x=1683431250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77QxDKdE2rjdmn5UavlvJ+dKYEVB2yFZDow3mJT0z7c=;
        b=dA//2MzAlpIlOSsGJMULrMYgyafftxtYirpzHqrwSVMkjKJenKTCJNOET7GHPRdr4i
         WpHQeVUztBD/nG+5f+1ymib/WIg3rYxFNnxM9lQ0po7eNbu90FZrWx3GuNRJNMm0jmq3
         Pweh5WYe+wAuXBFCEVkSfM56YF6YaSbs5jHeMUlSsktRVzltaQXVx0ele2iKcNKARogU
         z8OHOfDJ1v3vSvwa2CfJdm1wjsOsmaUJAyYAO08mksG8WcOH/8NX6GyGVUQ0/G+GmgF5
         wrENPQrWobGYWzQ9sDB8C1oK8EtAGxSErUYZFxe0nFFgi3ViP17T3IOIk3WFhxIHsAMU
         8zyQ==
X-Gm-Message-State: AAQBX9edVJqe9oOi1DA+DkgHOFNNBd6Rq7tL5N8xfHHtSGgF+KBV/SMj
        nXbQaXWboRT1+YJdUod6Fa1QFA==
X-Google-Smtp-Source: AKy350aYHI6zM5Gxa268/qZ5FZHaU0AQ+7MHkgj4I8Wwr1Xqz54mRQpeqvaKrIvRzU8No0j7ekRpYw==
X-Received: by 2002:a17:903:2285:b0:19d:2a3:f019 with SMTP id b5-20020a170903228500b0019d02a3f019mr1289012plh.1.1680839250020;
        Thu, 06 Apr 2023 20:47:30 -0700 (PDT)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id jf17-20020a170903269100b001a4edbabad3sm2051740plb.230.2023.04.06.20.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 20:47:29 -0700 (PDT)
Message-ID: <58d0903b-0081-6a0a-e199-b90af19eb6a2@bytedance.com>
Date:   Fri, 7 Apr 2023 11:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] some fixes and cleanups for x86
Content-Language: en-US
To:     peterz@infradead.org, keescook@chromium.org, jpoimboe@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/30 16:15, Qi Zheng wrote:
> Hi all,
> 
> This series uses arch_stack_walk() to fix false positives of KASAN and
> avoid open-coding of unwind logic.

Gentle ping. Any comments or suggestions? :)

> 
> This series is based on next-20230330.
> 
> Comments and suggestions are welcome.
> 
> Thanks,
> Qi
> 
> Qi Zheng (2):
>    x86: make profile_pc() use arch_stack_walk()
>    x86: make __get_wchan() use arch_stack_walk()
> 
>   arch/x86/kernel/process.c | 22 ++++++++++++----------
>   arch/x86/kernel/time.c    | 36 +++++++++++++++++-------------------
>   2 files changed, 29 insertions(+), 29 deletions(-)
> 

-- 
Thanks,
Qi
