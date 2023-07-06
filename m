Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55A74A18F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjGFPwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjGFPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:52:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904C26A3;
        Thu,  6 Jul 2023 08:51:37 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so1012419276.3;
        Thu, 06 Jul 2023 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688658692; x=1691250692;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XS3AYn/Urh4POCl4JCkwBluH3GYvtH7tWih91PK10Vc=;
        b=Bhn8+khTIUcJ10Lj6P7mYeup7qsLYwY790fj3y8Bn0/NRq0LVyGl2YcbKac7iyuIvI
         ro+Xvl9IHdFiw5jKWuPyPvfWryrAOrKJ7UWhp4AOFoWgSDLqcst7yiekXg25USlzOrxI
         uTjGhWccGCPLkG03ZBExObekqy63JRDQVmqUi2qBhuxnMzpKXaM88lZZE3G2/ogEtfUS
         P2mBG12tX2iOuCgIA0TnbrLBRyN9J3uueVjoEMXS8ySGTcjJLVABJ/cgJ6iogQB4kOqE
         Ao8zlnexRuW7B+8bYDcNhFCRtytKOYDWrLRxv/Vlb9s+/ctr9fQAF/Pyimmd7UChNQcu
         s8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658692; x=1691250692;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XS3AYn/Urh4POCl4JCkwBluH3GYvtH7tWih91PK10Vc=;
        b=TA4ou8WYmqg/ZUSSj9rXIhOmnBaR/gmJqAz9PLCE1l2jM+hmq1LTtvJaxNlHb/otkI
         UVtZl5AdJYN3xdQHgXp+kagsaxaL/tKvlzuLr7tpPkWfgaljwpoDw3eFCL5UK+1aD5RI
         3JfCUBjkUp5e56Tc44UGDLcrkK/uf+CLY6l754GEQbTP3ypQ9VV6nbJwBoMWlsTGgEJz
         KgFqIpjN2OBy3J4dXWLsogxHaidaIT4rNnW47i5Clz6vG4mKHxl6k6RM4QzLCFC8KipX
         Tqvd1YiSjYKSb+fKnYH2kuPtkMZwpRyWuOepSqF5Ty0xv5K67jMb5vdIj6yiWAyTrqPX
         nshg==
X-Gm-Message-State: ABy/qLaxmT4/VnqL1FbhBOS5KbWlaQi0RdGBGsmVVlCAMmNpCA3HLfQj
        W99aPdqKxnhAnjsIQtOfxKk=
X-Google-Smtp-Source: APBJJlGkpNwcsEPFjW+tlyQ/s1JCWOrcg+BxFztodPlhrXZZw8TTeUVVIUf5iMijwgIEIMYWHThsnw==
X-Received: by 2002:a25:a106:0:b0:c4d:6a23:37a with SMTP id z6-20020a25a106000000b00c4d6a23037amr3379337ybh.32.1688658692430;
        Thu, 06 Jul 2023 08:51:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 205-20020a2506d6000000b00c5cac376dffsm400441ybg.22.2023.07.06.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:51:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7b7c8cfe-2bcf-8980-fe66-fe3efae03845@roeck-us.net>
Date:   Thu, 6 Jul 2023 08:51:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <544f02b696a0a1554efe63f799754f3e5fbfecdc.camel@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
In-Reply-To: <544f02b696a0a1554efe63f799754f3e5fbfecdc.camel@physik.fu-berlin.de>
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

On 7/6/23 07:01, John Paul Adrian Glaubitz wrote:
> Hi Guenter!
> 
> On Thu, 2023-07-06 at 06:57 -0700, Guenter Roeck wrote:
>> On Thu, Jun 01, 2023 at 11:22:17PM +0300, Sergey Shtylyov wrote:
>>> IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
>>> return -EINVAL instead.  However, the kernel code supporting SH3/4-based
>>> SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
>>> IRQ #s from 16 instead.
>>>
>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>>> indeed are using IRQ0 for the SMSC911x compatible Ethernet chip.
>>>
>>
>> Unfortunately it also affects all sh4 emulations in qemu, and results in
>> boot stalls with those. There isn't a relevant log to attach because there
>> is no error message - booting just stalls until the emulation is aborted.
>>
>> Reverting this patch fixes the problem.
>>
>> Bisect log is attached for reference. Note that bisect requires applying
>> commit 7497840d462c ("sh: Provide unxlate_dev_mem_ptr() in asm/io.h"),
>> which is also the reason why the problem was not observed earlier since
>> it was hiding behind a build failure.
> 
> Interesting. My naive understanding was that IRQ0 is no longer usable in the
> kernel as Sergey claimed. Was that not correct?
> 

I have no idea. All I know is that all my sh4 qemu emulations hang during boot
after this patch is applied. I don't have CONFIG_SMSC911X enabled in my builds.
I also don't see any error messages from failed IRQ requests after reverting
this patch.

Guenter

