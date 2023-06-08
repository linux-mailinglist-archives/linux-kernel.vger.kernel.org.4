Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4172833E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjFHPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:08:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4872D59;
        Thu,  8 Jun 2023 08:08:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2568caabfbfso421686a91.3;
        Thu, 08 Jun 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686236934; x=1688828934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IEn5e3O37UYFQUronoHDerBOhdacjq599KRhqwKq5KA=;
        b=Lz6uq5mRmJS7cgpQbs0Uohbo4RJFczfdSYfnTgkEmgO6cGhjQ6iQubwHsBpEFoTxse
         IeW9a4vfmoshpcO7p5NVtKJw6qpbZ+a2lh6rEpI6KgO02NBcTTjo3lg9HbKenMfR+c4y
         nB+7NLl4oVrrOC+v2bIrs06CdaA4/6ZwzSaX5nfFtOgp3lRaQWQQg6RHMypY+hZz6bXq
         vCRdm09yKaQ0ny5rMpvIM74o1OPrh2Iqtc8MMBgfZX027VgJcLVN54ta8ePWb6vInPW3
         eZGlsbYTHqDIhwhAwg4jJb3wEexNH5zu1RKOVtVPSvTTnKypWIS3t8krdIrZUFa9SQw/
         XxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686236934; x=1688828934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEn5e3O37UYFQUronoHDerBOhdacjq599KRhqwKq5KA=;
        b=XKBqtdZ/ATFaz3oZ9AToD7N6AHaUv4MqCnEj7HLplJrp8o5VSo5c8K9TSPmnPyBCi5
         8t+K/J34H177fPTHuqIQe8OyzN8wL2fN7TmYn3yEMguLxtA3OYNV5o5+m30N3f0HfQL1
         pvelAKjWdz2K05wAB4A0qEzlrIee8koAv01kAh2WXUsvZKVBLIOAsPsnv1tRvZyfZlUz
         d0tDoWrE21sVQkxBKFXuAdN13HfXEoE6R7dxeYdV+2LBVKfYMxJC5q3ZReej7ealZCp4
         dx/ImhgP8B9Klvn9soi3QbdxWfft5dtAgH+FutvAINlbKAcefd76TYQAB7SNyO/mRF6c
         Wlqg==
X-Gm-Message-State: AC+VfDxLds0yI8X2O1de8rPXNZFuAUR9Sbz4UBcLlgbQ/Vyf+J50m9Jd
        k/PptH7HRFFh6n8aaBME8a8=
X-Google-Smtp-Source: ACHHUZ7Uf5pFMO3YlEHqNSgVn+xEpUoTbXA+3SYvl36Bv0VcxB3XJPQilOfYZZgYbGfCYWrgcpvbbA==
X-Received: by 2002:a17:90b:2347:b0:256:4196:f722 with SMTP id ms7-20020a17090b234700b002564196f722mr4647476pjb.47.1686236933842;
        Thu, 08 Jun 2023 08:08:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij14-20020a17090af80e00b002502161b063sm3190146pjb.54.2023.06.08.08.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 08:08:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cf6f959e-2885-1e7b-826d-61bff351ff14@roeck-us.net>
Date:   Thu, 8 Jun 2023 08:08:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200913.334991024@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 13:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Failed builds:
	loongarch:defconfig
	loongarch:allnoconfig
	loongarch:tinyconfig
	loongarch:allmodconfig

arch/loongarch/kernel/traps.c: In function 'trap_init':
arch/loongarch/kernel/traps.c:815:21: error: 'EXCCODE_BCE' undeclared

EXCCODE_BCE is indeed undeclared in v6.1.y.

Commit 'LoongArch: Relay BCE exceptions to userland as SIGSEGV with si_code=SEGV_BNDERR'
is not marked Fixes: or stable: and should arguably not have been backported.

The same problem affects 6.3.

Guenter

