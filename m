Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233A73E600
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFZRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFZRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:08:28 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24BAA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:08:28 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1816161b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799307; x=1690391307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyrKujkpd66JsU6tbq1RcnbibB92xcMw5ZP7CFWIkzk=;
        b=KSlOR2UVN5zX9lgeRLq4f+75+ONHe+MDeDTT0OIl+sR7Ddx6nTngx8JvRG7j2+0BzL
         kd4UeeFd/FayjrAHXIKkbqFfo9c2JilLfPrvfaGkBFM5yecQQ368cz74JxWoOyS8GzQj
         esJRVXGkZvfCiweBDONEIj0bBG2ePjaVJFRpLEemO6QP6RwLp5eKK5vTmY2qRJ6MmO97
         KcZIn9OJrbM55eOAd0WH/KEEB/SC+2UTvZzy7JUYyvoinCZNBSEHXySxX4/vQ1yYobEG
         jJVHDMMQlr6E+yPC4QLWxnLyquAZdFlJ/zXKmPUX9WTyIfh8zoovzmbIya6Xv044yQXW
         OC/g==
X-Gm-Message-State: AC+VfDybYXnwqY7GIDpxK2o1z2RSP1Ipi6i59q6cONX2vk1amGWHq+x6
        LlmXXrYVLUIC+A7ypvsPmBs=
X-Google-Smtp-Source: ACHHUZ45sSiUXIYmMeEspiQNg82xy/thvLuEgwX2so0bBG7IWsZuE9x3RlbI9LW4767s/Z2HY2a+tg==
X-Received: by 2002:a05:6a20:428b:b0:126:3759:582d with SMTP id o11-20020a056a20428b00b001263759582dmr6049443pzj.15.1687799307302;
        Mon, 26 Jun 2023 10:08:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ed06:6565:a250:4b59? ([2620:15c:211:201:ed06:6565:a250:4b59])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902868400b001b53953f314sm4455816plo.23.2023.06.26.10.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 10:08:26 -0700 (PDT)
Message-ID: <6e5c4d84-2f40-72f3-81de-163194bfa0fd@acm.org>
Date:   Mon, 26 Jun 2023 10:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] sched/cputime: Make IRQ time accounting configurable
 at boot time
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230620141002.23914-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230620141002.23914-1-bvanassche@acm.org>
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

On 6/20/23 07:10, Bart Van Assche wrote:
> IRQ time accounting reduces performance by 40% for some block storage
> workloads on Android. Despite this some producers of Android devices
> want to keep IRQ time accounting enabled.
> 
> Android devices share a single kernel binary across device vendors.
> Make IRQ time accounting configurable at boot time such that Android
> vendors can decide individually whether or not to enable IRQ time
> accounting.

Can anyone please help with reviewing this patch?

Thanks,

Bart.

