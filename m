Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73FA711FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbjEZGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242130AbjEZGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:24:18 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A012E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:24:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96f50e26b8bso59816766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685082255; x=1687674255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuKEnKsCconscSQexlVpJ5RB0QZfLt385jyEr+PosEs=;
        b=BOGDxRjXkrv3ucz4f7EaCIxwSxelGn18fpKkLAPyxjNbEgXvqclYN5AJc5UzgUoJ3l
         OYFgEFZ72/AMmYi3F4AgLF7VbeL28EIad6x9dCbRFrXZrz9bLAEiTZsP6xXh91yZuc7J
         ezX2U/GhvKVxTdDEAH6Wv4BtkUu5+a5SiPyDL9M+4pK+8JaGJzUMeiYnoibGXfTCFsK1
         P1e1kTucInSUQUHDLTu5/88l3u9r3TraPPK3smMCTp3FFmZD01pK1W5J0I3qVKWWlW9H
         T6hbktu2i7VMs/Zyn/bWZUb0fShyHQRpydmaKE1g6v2Gb8Vy7AHarlBuOfRIHtZaB6P7
         voWQ==
X-Gm-Message-State: AC+VfDy5GYeUBwk6ORzCG6LhtXUKsHeMfRUuYrLkG+uNqx73NCNglD8z
        tYU5sFNzl9pafP0p+kR3rAY=
X-Google-Smtp-Source: ACHHUZ6COGaN62izOMUN0KGqZ2KP02OZWuU4WIkuYiZsna+h/dSrLzqAhnqJDRMm3VXC6SqoRXhLaw==
X-Received: by 2002:a17:907:60ca:b0:96a:b12d:2fdf with SMTP id hv10-20020a17090760ca00b0096ab12d2fdfmr1373201ejc.12.1685082254478;
        Thu, 25 May 2023 23:24:14 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id lv17-20020a170906bc9100b0095707b7dd04sm1697999ejb.42.2023.05.25.23.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 23:24:13 -0700 (PDT)
Message-ID: <1a2d7583-ac56-52ea-2ef7-887958966a07@kernel.org>
Date:   Fri, 26 May 2023 08:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
To:     Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 23, 21:39, Nadav Amit wrote:
> 
>> On May 25, 2023, at 12:05 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 5/25/23 11:42, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>>
>>> When SYM_CODE_START_LOCAL() is used, the symbols are local but need to
>>> be preserved in the object. However, using the ".L" label prefix does
>>> not retain the symbol in the object.
>>>
>>> It is beneficial to be able to map instruction pointers back to symbols,
>>> for instance for profiling. Otherwise, there are code addresses that do
>>> not map back to any symbol.  Consequently, the ".L" label prefix should
>>> not be used when SYM_CODE_START_LOCAL() is used.
>>>
>>> Few symbols, such as .Lbad_put_user_clac and currently have both the
>>> SYM_CODE_START_LOCAL() invocation and the ".L" prefix.  This commit
>>> removes the ".L" prefix from these symbols.
>>>
>>> No functional change, other then emitting these symbols into the object,
>>> is intended.
>>
>> Nadav, could you perhaps do a bit of research on how this situation came
>> to be?  Was it an accident or on purpose that these symbols came to be
>> .L?  Then, could you CC the folks who made this change and ask them
>> directly if they intended to induce the effects that you find undesirable?
> 
> Fair enough. I actually thought it is an oversight, but it now seems
> intentional (although I am not sure I understand/agree with the reason).
> 
> So apparently, for one of the symbols from my v1 (which was already
> removed), I see that Borislav Petkov suggested to prepend the “.L” in
> order to for them not to be visible [1].
> 
> The reason that is given for not making the functions visible is that
> these are "functions with very local names”.
> 
> I do not think in this tradeoff not exposing local names worth
> preventing profilers (and their users) from understanding where a
> sample/trace is was taken. If for instance you look at a branch
> trace (e.g., using Intel PT) you want to see the symbol to which a
> branch goes to.
> 
> Borislav, Jiri - do you agree?

Ah, if it makes tools' output harder to follow, I would indeed switch 
back to emitting these symbols, i.e. remove the .L prefix from them.

That said:

Acked-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

