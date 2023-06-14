Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1877301FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbjFNOaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjFNOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:30:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28E1BEC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:30:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9745baf7c13so107576366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1686753002; x=1689345002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AI1+jVJ0qXK3qPPDoJix7ay6mh70gtlE+w7dZ3QHNDk=;
        b=GZxE8k16++dEa0JLXG3cnjHWLkpI3nGIjGDIc35FLi/itAHoqjCfhLz21hrEhPWPgF
         bv4U9EIL1fWj+Z0fpE0oP57Q4zpA18WLPGEPDx0Pw+WWvHwFJjhJyamQMIoLuvf/9E47
         kY7/ZEudp0dFc7tj23UG5jBFQM/69J1xEyeu8YNUo6cgMLegBSgcZsOPYbBFMTzk5vqt
         +Oy5ioI/aX8hzJdEUveykZKPFgoo3dNFSlgb28LooN4whVFAcppY+9eiJD+0gPkFrOot
         +ckw+RcFj9vLxkp+DZmG9xTdxSFP1Y7+dReEyaS0QECu050l2nbLfPoNM7Y79WumhUpK
         l69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753002; x=1689345002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AI1+jVJ0qXK3qPPDoJix7ay6mh70gtlE+w7dZ3QHNDk=;
        b=AczfBNpHA5KaDjIPpvGGpma+9gBZofd8MDofdHMvzgNt5Z5/hhV+ds6/DJCFD4Qop1
         amdOzsai4c8595EbD2MY7GWjLNeXflI/DK5yl61XQsKI8O2FW+pe+4xO3UrDkGzQrBnr
         VfebeL9IFPT5oIy336BHN9nx9Dr7UY83mC/oIf/RSHcptckubi1nXYT9suYWdU0ShPzc
         9ouPfh8TUWm+tCZca2UVkcNr7bSefQNIs3NiFXpMZBK2+OPK/rhDFe0nFXbiG+EcMtdA
         LrKxix0i6LIz/N4MawB/1ExQqzh4RtJs5tP4xJscpA412Cyo2l1fd8wI3LxZKLWxzUsp
         Kk3g==
X-Gm-Message-State: AC+VfDyzIqv+bPlvlCZiXAcs1Q41QnoPqLCuYnBMzPRDj3nMJSeOPDf5
        2nQYeS0HtQXeqR+k9MHA+3hjXQ==
X-Google-Smtp-Source: ACHHUZ75xlC7Vpgii9DpgRUZVIqEXIJJ0Hxz5LwgCNtkcxVjqgou9reJjGp2qb2i8c7N6lTeq+8nMw==
X-Received: by 2002:a17:907:6d85:b0:97c:64bd:50a5 with SMTP id sb5-20020a1709076d8500b0097c64bd50a5mr13773624ejc.53.1686753002331;
        Wed, 14 Jun 2023 07:30:02 -0700 (PDT)
Received: from ?IPV6:2003:f6:af14:3c00:9650:2efe:173b:4a64? (p200300f6af143c0096502efe173b4a64.dip0.t-ipconnect.de. [2003:f6:af14:3c00:9650:2efe:173b:4a64])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906115900b00982855d27c3sm417967eja.173.2023.06.14.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 07:30:01 -0700 (PDT)
Message-ID: <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
Date:   Wed, 14 Jun 2023 16:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Content-Language: en-US, de-DE
To:     Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 15:57, Luiz Capitulino wrote:
> On 2023-06-14 09:45, Sven-Haegar Koch wrote:
>> May be this, talking about the same commit as cause as this thread:
>>
>> Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ
>> tick. -- regression report
>> https://lore.kernel.org/lkml/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net/
> 
> Thank you, Sven.
> 
> Sebastian, except for the detailed analysis which we haven't done yet, the
> issue described by Mathias matches 100% what we're observing. Also, we do
> observe this on bare-metal instances which could mean that the initial
> reports are against VMs because those are rebooted more often (our quick
> reproducer boots hundreds of instances in AWS and only 1 or 2 reproduces
> this).

Yeah, we're doing VM based testing more often than bare metal -- less so
on a AWS scale. That's why we observed it first in VMs. But that wasn't
meant to exclude bare metal, not at all. It's just, that we haven't
tried hard enough yet and testing VMs is so much more pleasant when it
comes to debugging boot issues ;)

Thanks,
Mathias

> IMHO, I'd suggest we revert this for now from Linus tree and stable trees.
> We can help testing for the fix maybe for the next merge window.
> 
> - Luiz
> 
