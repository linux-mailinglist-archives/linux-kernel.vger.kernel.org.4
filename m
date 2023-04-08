Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984CD6DB90F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDHF1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:26:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC994C31
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:26:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a4f8e5d190so1905445ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 22:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680931593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9Ug1/tPy8825Ij6g3Q1xr/XLB0Q00SXY0Q+3fkJ87I=;
        b=Yb3hSRf2FsUFXMLYYdY9LMwFMyWb8qrW/uxnioGRwu+ZnGIYTc8KU1p8nH4W5OTqbM
         BOJf2IueXnELAbFsVGUxTJ2nvJLbionN6t0/S6kDlLw1tsaAcpSY4nTeHwXcYwF2Xqa4
         A4oeAHjLyOD5q7faetdPAjnXuqoiriwCFIDv0skoViXZCv4coseA4zh4D4yN8+EEMBrq
         CNJMgm4SPaKqQT1eY18lt8w8Y15kjsW88cClXT23pEgzGgJlcFecZ2JT4tizdxTAArpl
         mCHHViiS3ujfnW19hJ5p1wlTtNHRjEaNmXjJPulxvPHjTnKc2ZpvjABhG/nsST6E7/R/
         3Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680931593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Ug1/tPy8825Ij6g3Q1xr/XLB0Q00SXY0Q+3fkJ87I=;
        b=XvesW8pSKeO2okyn8w8mu3IF+9S2Nu/j+JPyAV1BwVv/iDY6wDuTixDsTaIjIHVc1c
         bXrKbnxXLIHiU+9jN8sPxUxb1QrozdC5TngoB2EI7jotlHEYwlAR2kPNcw1WnYMlP8XF
         F7j23h8FeVFezhcwGifY41Stc92QzIULXneNbNlPdv1Oe2SfMbmQBSMkmjorzneWOUdA
         qp+F96LbVcCZMz1OpELbESSQYqSd/R6roGeB0tio8xOUgZgIgQh9TYlAulHS3O0nWQwh
         MCAJPLno0tdhVtiueCUylQrSIRHnivJ2YM+ATWcb3oOht/0hO95WKpLkp/a6dQsHwM9t
         GG8A==
X-Gm-Message-State: AAQBX9fUyUWGrQ6JaUyfaGDFu+CNFIg37iQ0ROiPk6ybAHf8+N8kLjUE
        hcJnSMIy/0c5D2Xo2YTupuFp+A==
X-Google-Smtp-Source: AKy350b6rxsMthHttFIFvHXUtFDFD45Cs8NNVldbiRe3+CV6zEPtKKyeg6QyZduXHD/Sk8B/19VOZQ==
X-Received: by 2002:a17:90a:2c0c:b0:244:a41a:f658 with SMTP id m12-20020a17090a2c0c00b00244a41af658mr1430858pjd.4.1680931592790;
        Fri, 07 Apr 2023 22:26:32 -0700 (PDT)
Received: from [10.200.9.10] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id cm24-20020a17090afa1800b0023af4eb597csm5459137pjb.52.2023.04.07.22.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 22:26:32 -0700 (PDT)
Message-ID: <9bd50ce2-0ac8-a5dc-a584-0610891c7805@bytedance.com>
Date:   Sat, 8 Apr 2023 13:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] x86: make profile_pc() use arch_stack_walk()
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-2-zhengqi.arch@bytedance.com>
 <20230408045619.m5zfbispodf4zjvz@treble>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230408045619.m5zfbispodf4zjvz@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/8 12:56, Josh Poimboeuf wrote:
> On Thu, Mar 30, 2023 at 04:15:51PM +0800, Qi Zheng wrote:
>> The profile_pc() try to get pc by doing a trick to read
>> the contents of the stack. This may cause false positives
>> for KASAN, like the following:
>>
>>   BUG: KASAN: stack-out-of-bounds in profile_pc+0x5b/0x90
>>   Read of size 8 at addr ffff8881062a7a00 by task id/130040
> 
> I don't think this was actually a false positive.  The !FRAME_POINTER
> code in profile_pc() has been badly broken for many years.
> 
> BTW, there was a similar patch here:
> 
>    https://lore.kernel.org/lkml/20230224021858.120078-1-chenzhongjin@huawei.com/

Ah.

> 
> I thought CONFIG_PROFILING was obsolete but Andi said previously he
> wants to keep it for at least boot-time profiling.
> 
> Andi did suggest removing the lock profiling hacks, which means all the
> profile_pc() implementations can just be removed in favor of the generic
> instruction_pointer().

That's great, and I see Chen Zhongjin will send a new patch for this,
let him continue this work. :)

> 

-- 
Thanks,
Qi
