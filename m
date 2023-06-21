Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D711B738A02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjFUPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjFUPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B85173F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687362146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3qZ6ovJeq5tWh1iDUXLwP6mu+mEkpr462zbbeksiXQ=;
        b=RzAiRfuSOxrQmeHhiVj7RlblR+OzEGJT8aNEAdbijlYI1/BQfKtMP11lYLHljXKp7OXSYC
        lQy0XO+yv/K/5NRcFXrJ6BJIMILK9ESiUFoKE6WPWJmtrMZqy1fTNdt0fGthtjH5wJkdHf
        DqHK7MuuNpQCWLIu9HcwBcTj27vgC94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-BlHZtMNEOVibyvZpBmsRGw-1; Wed, 21 Jun 2023 11:42:24 -0400
X-MC-Unique: BlHZtMNEOVibyvZpBmsRGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C99280BC80;
        Wed, 21 Jun 2023 15:42:21 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76EB0492B02;
        Wed, 21 Jun 2023 15:42:20 +0000 (UTC)
Message-ID: <184ee986-340d-95f2-72c7-f63bcb703530@redhat.com>
Date:   Wed, 21 Jun 2023 11:42:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
 <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
 <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
 <20230621144848.GJ2053369@hirez.programming.kicks-ass.net>
 <309d15f5-0dd8-aee8-14a6-621a071bc363@redhat.com>
 <20230621145436.GK2053369@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621145436.GK2053369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 10:54, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:51:33AM -0400, Waiman Long wrote:
>> On 6/21/23 10:48, Peter Zijlstra wrote:
>>> On Wed, Jun 21, 2023 at 10:44:23AM -0400, Waiman Long wrote:
>>>
>>>> Well, hlt_play_dead() is only called if cpuidle_play_dead() returns an error
>>>> which is not the typical case. My testing does confirm that this patch is
>>>> able to keep the IBRS bit off when a CPU is offline via its online sysfs
>>>> file.
>>> The point is; your re-enable IBRS hunk at the end is dead-code. It
>>> should never ever run and having it is confusing.
>> What I meant is that hlt_play_dead() should never be called unless there is
>> some serious problem with the system and native_play_dead() does return in
>> normal usage.
> This is all through arch_cpu_idle_dead() which is __noreturn. And no,
> none of this must ever return.
>
> If you want an offline CPU to come back, you re-init.

Yes, you are right. I thought it will return. I will update the patch 
accordingly.

Thanks,
Longman

