Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE56F8E22
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjEFCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFCvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:51:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E94219
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:51:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaff9c93a5so16834075ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683341489; x=1685933489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSiTgvOcxTmKoy818zPNUfk1L4fGACVXftmQRMManmM=;
        b=X+xHAEtBymWl+SnZsyqGPogSfd+y5EKxfQ+p0leYWJjUOLxYlcEWWGMM7Jey8FIbsy
         KiYfqiaPsnFZQPLj/DgSUEPbsy1NI+bgYiQRSVROrjvHk9zqX05uohJvgR1Zgakg6Dz6
         MwUEQ5Jd3yJAndO7Ah3qwfNJ0Yu6AvqiPX7OkhjGQXBaHqNSORIjCxN6AOuFASUrv+Ot
         appY+Ie0J2ebc2a7gd14DSnKMbQoDcRhOy4vlLPLileZrdSj5Y+yiVtI5FEBOe9yutGN
         joSvr3MyP9VnxKrqdNuwHGcbqN6RriuvE/N5BdQSpPCziBaIpXPs6R/VZIsT6edqIjGm
         ihjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683341489; x=1685933489;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSiTgvOcxTmKoy818zPNUfk1L4fGACVXftmQRMManmM=;
        b=UG4mY/9qWZ41XebR1hxtIYozT7UdcGhWMqgfYXdJrzmJ0m8pWyIQhvB7z/pJC0dJK1
         LenUH1ZNxivIypdJd0i6nNnvIcnbkRxJksNPgEfVYCom3AxsL2g48OneRvHC4LXKK1ei
         W3PhCNgcc1F/RrHp53KXBEhdhF+G/OjNt10M4n38D5aYOyZkcDba+14CVd+3GLzJatsK
         NZepbYp+QOB4BPYfV1GrdaOlPo334COd/R0FCpn8tZO1rHoyuWptbF+/y9uEBvz26oGl
         yz5gtJLFU7FwFrL4hlRX6QRL8fcw7/eao+evW1cuN+1B+F0xGtpsEtGmMLJMsK2nmq99
         NrEA==
X-Gm-Message-State: AC+VfDy/sPR7ZCQvVkHbV1QrA66YTLr6DTBcCo+cRqvK3PfCRP9Oa1ql
        rLRqQ3xuoWb7d66dwvRcG8HcuQ==
X-Google-Smtp-Source: ACHHUZ5Q17wyZ31rm3kEj4m0RXsWSOSFRCbWA9hVRVySyH8NwCCmTUvYBMU+b6mXNqFNakajTVdl8g==
X-Received: by 2002:a17:902:e74c:b0:1aa:cddd:57f2 with SMTP id p12-20020a170902e74c00b001aacddd57f2mr4286079plf.25.1683341489418;
        Fri, 05 May 2023 19:51:29 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.8])
        by smtp.gmail.com with ESMTPSA id t23-20020a170902b21700b001aaefa0f82csm2442930plr.31.2023.05.05.19.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 19:51:28 -0700 (PDT)
Message-ID: <9d976db8-b800-ad84-9c67-0afb942934d9@bytedance.com>
Date:   Sat, 6 May 2023 10:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Content-Language: en-US
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
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <369d1be2-d418-1bfb-bfc2-b25e4e542d76@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/28 17:27, Mark Rutland wrote:> The architecture allows a CPU 
to allocate TLB entries at any time for any
> reason, for any valid translation table entries reachable from the 
> root in
> TTBR{0,1}_ELx. That can be due to speculation, prefetching, and/or other
> reasons.
>

TLB will be allocated due to prefetching or branch prediction. Will it
be invalidated when the prediction fails?

> Due to that, it doesn't matter whether or not a CPU explicitly accesses a
> memory location -- TLB entries can be allocated regardless. 
> Consequently, the
> spinlock doesn't make any difference.
>

And is there any kind of ARM manual or guide that
explains these details to help us programming better?

Thanks a lot for your help.
Gang Li
