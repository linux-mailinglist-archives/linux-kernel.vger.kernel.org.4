Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0147317CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjFOLqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344684AbjFOLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:45:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962149F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:40:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9745ba45cd1so248708466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1686829232; x=1689421232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHDankix+JLiU2Nr1JYTN9mJNWmPd/bjBdB0sjT8q/s=;
        b=P4/ciUFY+38pISngwny9usr9/6X/fsPKJgI55lG4j8yHc1zyI1feX806s1s61qSlUp
         1ttzIJkm2YeziTP2AsueW3COytk3K/Zv8zYHbTFsEMEI/cGbD9b+VI1RTtBmVJinFZak
         GjLv8AkpSGlCmkKtZYy5YgTBmZN3kySPcnINOIIdQFph2B1XFjXVM2T/v6KPLJ90bdiD
         qy5SKj9EKAs6dIHqXIW4IPKb7kV7nDXzphHMbJjTOdRiWsSWELmkJQvciBOv5NeuVzhM
         FqZ20WSC1FxMkLf2VF0gpsL8SJIpPJRIT8aRr+PtUIj1iVL36bSNxfNsFBTWRJ8s/E4k
         fxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686829232; x=1689421232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHDankix+JLiU2Nr1JYTN9mJNWmPd/bjBdB0sjT8q/s=;
        b=lBPauEq/84qeE5ZhmgpoBphwE6ihu07DXqApWYJ/GXTKI1W2TT+gtvD64rLC1gD8ae
         XDNVO6qFhlHqbG1CEncFUJGns9fGDxhTYf9NhyenSS4+b4C8PkViArEdEfIQCC3E9mqq
         zamYWJZwnj1pcT1UQl8XDoRcsMiFK6MdkI0ezXEyEB0ffBPl6XCqiBUYN/X87yTEDN8C
         WSHJ/3mqlr8C3YkWooUdEJBpk+S/HjA7BPk0OrgPiLxbNJheq9Y3m+tKCXl34aFDj6M/
         wQwfCM6UcjlkxfJC+NFpeg1B6H99Q9bFOeMpK4laBbD8FWdi0z0oYRX4q+cDmzjFWy3x
         QM4Q==
X-Gm-Message-State: AC+VfDzljbf7otp8LC1hEUGD1VTFMxY/u05biAk9PfDUL+Ic/sQVWTPD
        fF7Odsl/juRW+eE8QZpm1jeWsg==
X-Google-Smtp-Source: ACHHUZ52DMP0G3qO6HmYZtGySZejowJqoJB57B/aKKMedHNEDhi07a2R3IIaKQS2qJTdP8d5eS0pjg==
X-Received: by 2002:a17:906:db0a:b0:977:befe:d888 with SMTP id xj10-20020a170906db0a00b00977befed888mr16689883ejb.13.1686829232551;
        Thu, 15 Jun 2023 04:40:32 -0700 (PDT)
Received: from ?IPV6:2003:f6:af1c:2300:fa33:8d65:b4c4:3ebe? (p200300f6af1c2300fa338d65b4c43ebe.dip0.t-ipconnect.de. [2003:f6:af1c:2300:fa33:8d65:b4c4:3ebe])
        by smtp.gmail.com with ESMTPSA id zo18-20020a170906ff5200b0096ae4451c65sm9358824ejb.157.2023.06.15.04.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:40:32 -0700 (PDT)
Message-ID: <1b2ed0be-7eb9-3224-5829-fcbdb00613e8@grsecurity.net>
Date:   Thu, 15 Jun 2023 13:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ tick.
 -- regression report
Content-Language: en-US, de-DE
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Gusenleitner Klaus <gus@keba.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        stable@vger.kernel.org
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx> <20230406150254.ZrawA2Y-@linutronix.de>
 <87jzypq6gq.ffs@tglx> <20230418122639.ikgfvu3f@linutronix.de>
 <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
 <20230615090356.GD10301@redhat.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230615090356.GD10301@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 11:03, Richard W.M. Jones wrote:
> On Wed, Jun 14, 2023 at 12:59:46AM +0200, Mathias Krause wrote:
>> This patch causes VM boot hangs for us. It took a while to identify as 
>> the boot hangs were only ~1 out of 30 but it's clearly it. Reverting 
>> the commit got me 100 boots in a row without any issue.
> 
> FWIW I have quite a nice test program for catching these sorts of boot
> hangs, see attached.  You need to change the VMLINUX define to point
> to your vmlinux or vmlinuz file.

Heh, nice. For this specific case, though, a simple boot loop in a
single VM was sufficient:

  $ kvm -cpu host -smp 8 -m 8G -display none -serial stdio -s \
        -kernel path/to/bzImage -append 'console=ttyS0 panic=1'

This will reboot the VM in an endless loop until it hangs which is
visually noticeable as there's no more output generated to the terminal.
At that time one can attach to it via gdb and investigate further:

  $ gdb -ex 'target remote :1234' path/to/vmlinux

Yet another advantage is that one can filter the output, e.g. via:

  $ kvm ... | grep clock

Thanks,
Mathias

> 
> Rich.
> 
