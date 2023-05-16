Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32D17046D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjEPHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjEPHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:47:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8930F8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:47:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64388cf3263so9784159b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684223242; x=1686815242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zbdg58IBW7s4N+TghS0ZUxIL6roid6tTvsWGzD5zozY=;
        b=MpcBhR0RWvYDa3Mid6OCuEv+4qN5aJSGfXNpa9S5guSHbCWy8fjrc858mX3EDrGWgt
         1S74f4DXgDuP/GOlyO6WhrJx+3X+yNRU8VQwd+79uyhJPD3xTYT/356HAGspsNbQh792
         jas/mUtj1PZ8BjaKuyk+1V8MM3X8mjyyN1ujcD4cl10W3pBu27/nZjE0mygr6w7hrDd0
         Yx0jQicbl0Wn4DXgIouzWiKKSA5GWwhvhHYuWJnZjOp5fAedTOadouAvEXb9ixsT7zxb
         KgEqSCEVlboZrIIx5W53q7SMaVf5OKIvKbC0MdrsbsBsg9NqxhKnGIm4AJmxJznpAEIn
         On2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223242; x=1686815242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbdg58IBW7s4N+TghS0ZUxIL6roid6tTvsWGzD5zozY=;
        b=QRfLkvMJZ1HrJCc7fH9fAYvMx/f9/u9QNsDu9JgrY3/3qbDuX5HcWlQhajP8mHq03H
         zzEB8EohuRyOXQgzdVxV9ADf2rTnFzHSGqZuY/VuyWr+vAm0rKeeg18wJAjbPZXYVcBL
         uysLBfxV9LSEZs+CxRJciI+eCvJE3zKvUj8NojWBZ6WuCFvzpd649MKro5srVhPdizov
         88Am2x6cNmn8WL0NQ37vUAIqQP2e8igE+QHqZ9PnoTLtToG3Clu5BevSHsdLHe9DjncR
         3wRrWjQtWztxXS1httP6fvHneucJyf04ypv4Epwo3qd6Kj7XXRigvQQucuVld2GQtT9L
         9IfA==
X-Gm-Message-State: AC+VfDzGQzGn8QgxZQFGkA7+wbr2871T+HKuKlQ3pMsUcEiOVG4+/OSf
        Pu1Um2gb1W0aoz7AZEPhl56wNg==
X-Google-Smtp-Source: ACHHUZ5kOHm53/fpKiobhMW6lfXHCo/g+Q1KeaY9D5cUsEabofat9LGZHyAVjmgRZKyA3rZmxwS5qg==
X-Received: by 2002:a05:6a20:7354:b0:101:1d1d:43a4 with SMTP id v20-20020a056a20735400b001011d1d43a4mr31893987pzc.15.1684223242172;
        Tue, 16 May 2023 00:47:22 -0700 (PDT)
Received: from [10.70.247.178] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id p19-20020a63f453000000b005287b22ea8esm12991287pgk.88.2023.05.16.00.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:47:21 -0700 (PDT)
Message-ID: <fd8bda4b-32ee-d06d-af77-12e30e70c0bf@bytedance.com>
Date:   Tue, 16 May 2023 15:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
From:   Gang Li <ligang.bdlg@bytedance.com>
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
 <ZEokfJSM9a4ZZvQv@FVFF77S0Q05N>
 <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
 <9d976db8-b800-ad84-9c67-0afb942934d9@bytedance.com>
 <ZFpZAGeEXomG/eKS@FVFF77S0Q05N.cambridge.arm.com>
Content-Language: en-US
In-Reply-To: <ZFpZAGeEXomG/eKS@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/9 22:30, Mark Rutland wrote:
> For example, early in D8.13 we have the rule:
> 
> | R_SQBCS
> |
> |   When address translation is enabled, a translation table entry for an
> |   in-context translation regime that does not cause a Translation fault, an
> |   Address size fault, or an Access flag fault is permitted to be cached in a
> |   TLB or intermediate TLB caching structure as the result of an explicit or
> |   speculative access.
> 

Thanks a lot!

I looked up the x86 manual and found that the x86 TLB cache mechanism is
similar to arm64 (but the x86 guys haven't reply me yet):

Intel® 64 and IA-32 Architectures Software Developer Manuals:
> 4.10.2.3 Details of TLB Use
> Subject to the limitations given in the previous paragraph, the
> processor may cache a translation for any linear address, even if that
> address is not used to access memory. For example, the processor may
> cache translations required for prefetches and for accesses that result
> from speculative execution that would never actually occur in the
> executed code path.

Both architectures have similar TLB cache policies, why arm64 flush all
and x86 flush local in ghes_map and ghes_unmap?

I think flush all may be unnecessary.

1. Before accessing ghes data. Each CPU needs to call ghes_map, which
will create the mapping and flush their own TLb to make sure the current
CPU is using the latest mapping.

2. And there is no need to flush all in ghes_unmap, because the ghes_map
of other CPUs will flush their own TLBs before accessing the memory.

What do you think?

Thanks,
Gang Li.
