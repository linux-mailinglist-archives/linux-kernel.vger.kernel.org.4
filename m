Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1E727751
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjFHGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHGgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:36:24 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53552113
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:36:23 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so393171a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 23:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206182; x=1688798182;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WbslFANnmX2X7GcQx6MMGxO+lQs8WTrs7UKG6GJbTI=;
        b=NA/JruQT1ZObO5+KqwITOth7gRBJTLz4CvSZYEpDjTOko+Y1DO/MZl/KeQBhg5I9KY
         xn9eUStZFj4MBr5gzuGayHYeqcrrwbHKH+ibQhTf+EUfq9ImxrZM1cnzbFLTuySq1uS6
         nXfRftn8kdc0S27YT7+GbZZ99Z0VfCvRDiz0A5s69QFGk/yc8BJPa1OqBb2E/dqEVVhe
         Yd3Z2HM4tiF9+B09GpzgRlg//iDaEDMqG/1tFrWI+xWWFnoP0u13XHhukMK79Fomfteg
         iddF/TPx/deGBUjfTjmMI+u8VX99e6P2fkwJf+ka/Eqi9uEDxBzi+PoeDCHhwpj89OJ+
         L1CQ==
X-Gm-Message-State: AC+VfDxQMaOXkW2gOSCJZbfePeZcmK72VyDoipZMPX3bA7SPvHS1XLd6
        s8fjmPjuqc8+u0gzt+wDzBw=
X-Google-Smtp-Source: ACHHUZ68ETqR4T7prVx7m7+jmSwcX9yKUQXmjC2V8i9yPOkTw8y9tW5XLPUGyOQ/wIOVDXimQIx/YA==
X-Received: by 2002:a17:907:3d9f:b0:94e:8559:b5c5 with SMTP id he31-20020a1709073d9f00b0094e8559b5c5mr8819858ejc.64.1686206181971;
        Wed, 07 Jun 2023 23:36:21 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00977d14d89fesm272586ejb.34.2023.06.07.23.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:36:21 -0700 (PDT)
Message-ID: <98e85cf9-22db-9b1f-f486-fd5d57e58c4e@kernel.org>
Date:   Thu, 8 Jun 2023 08:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
 <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
In-Reply-To: <4217f682-f0e3-28de-1fb9-634c5df3581a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 06. 23, 8:16, Jiri Slaby wrote:
> On 08. 06. 23, 2:25, Thomas Gleixner wrote:
>> I really wish that we could disable syscall32 reliably on AMD and make
>> it raise #UD as it does on Intal.
> 
> Sorry, I am likely missing something, but why is not #GP enough when we 
> set CSTAR = 0?

Or rather to some hole (to avoid mappings when mmap_min_addr=0) or to 
something like entry_SYSCALL32_kill which you suggested elsewhere.

But that is maybe what you consider not being "reliable".

>  It's of course not as good as Intel's *defined* #UD, but 
> why is not the above sufficient/reliable?
> 
> thanks,

-- 
js
suse labs

