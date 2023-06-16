Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B077333D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbjFPOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:41:28 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B4294C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:41:27 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1b3f66dda65so6493165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926487; x=1689518487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhDvGLDecFh2hF/zpCcDPD4K9B9uog+prVasKVM7Xmo=;
        b=MDTQ7ANRWIiXzg5h8fCohIWoAoixXYml+pO2exDoIuhM4wBKSS7EO2wxKgY98H0RWE
         QAgkEidW1tTuEBs8BY36uq5SzTfD16Trp87mlhLWJ5Wu/KmWJJjVGdX2ie+jLGlelyJ0
         W0R6JGW9MabgxB/AfERYkFFG2ZkF+r6fUBQYxzOtA3K7hd8LUX2iqjBRU6dHVWjFoU2O
         ob+XgJfUDgxmKY4KG/5BZf3om0LCSIL3fOh58wJSbhGElYM6Q6Mm+bW2knd1viR2D8+U
         EGon4s0u8C7dSCyOFxFzvzN5ITuE9XJSpfN7NpqOTp6uFMaa7/KPpPnfLSWVmxpSHU7n
         BBIA==
X-Gm-Message-State: AC+VfDyEbRfmDUT41pnTvJtwbgsNCtpBWGvu7aZ4XKtz1tD86L/EF7vC
        GUJU+mNGC+h+OOnp+klow20=
X-Google-Smtp-Source: ACHHUZ58lCyOp+aPzRk52Fu4JqV51QalmeDbHIy4DrAKBWlgE514D4Rh88sJcxwAQvvdXuZJzIc6RQ==
X-Received: by 2002:a17:902:d482:b0:1b2:1942:9117 with SMTP id c2-20020a170902d48200b001b219429117mr2186093plg.45.1686926486544;
        Fri, 16 Jun 2023 07:41:26 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902968900b001b3c7e5ed8csm5373707plp.74.2023.06.16.07.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 07:41:25 -0700 (PDT)
Message-ID: <829a3198-1b18-c566-20ee-3e4f23ddbffe@acm.org>
Date:   Fri, 16 Jun 2023 07:41:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sched/cputime: Make IRQ time accounting configurable at
 boot time
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230615203745.1259-1-bvanassche@acm.org>
 <20230616074518.GW4253@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230616074518.GW4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/16/23 00:45, Peter Zijlstra wrote:
> On Thu, Jun 15, 2023 at 01:37:26PM -0700, Bart Van Assche wrote:
>> Some producers of Android devices want IRQ time accounting enabled while
>> others want IRQ time accounting disabled. Hence, make IRQ time accounting
>> configurable at boot time.
> 
> Why would they want this disabled? IRQ time accounting avoids a number
> of issues under high irq/softirq pressure.
> 
> Disabling this makes no sense.

This is why disabling IRQ time accounting makes a ton of sense to me:
* If disabling IRQ time accounting would not be useful, there wouldn't
   be a kernel configuration option that controls whether it is enabled
   or disabled - it would be enabled all the time.
* If enabling IRQ time accounting would be essential, all Linux
   distributors would enable it. In the x86 kernels I checked, IRQ time
   accounting is disabled (Debian and openSUSE).
* For x86 there is already a kernel parameter for disabling IRQ time
   accounting (tsc=noirqtime).
* Modern hardware, e.g. UFSHCI 4.0 controllers, supports sending the
   completion interrupt to the CPU core that submitted the I/O. With such
   hardware IRQ overload (100% spent in IRQ handlers and 0% outside IRQ
   handlers) is impossible because the submitter is slowed down by the
   completion interrupts.
* The performance overhead of CONFIG_IRQ_TIME_ACCOUNTING is
   unacceptable. A quick test in an x86 VM shows that enabling
   CONFIG_IRQ_TIME_ACCOUNTING reduces IOPS by 10% (220K -> 200K). On an
   Android setup I measured an IOPS reduction of 40% (100K -> 60K) due
   to CONFIG_IRQ_TIME_ACCOUNTING. This is not acceptable.

Thanks,

Bart.
