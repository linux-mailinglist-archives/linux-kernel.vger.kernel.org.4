Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D117F738656
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjFUOKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjFUOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521EE65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687356524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Q9msWaizyCAHka/QwGxLArVrojwbB6E5UYjjZaMbBE=;
        b=CNXuMRlOKvE8hBIMyD6Dy77CLI+iiQOzv3tzxN/ctKfsbY8TeI2BR2Z8eD0yK/mFdpB4Ae
        kPZoaDuHowveT+cJE9YkSQoTAkMSl1uzM5Urob2F0XSnjEzF0+zkdzUCGsltyIWka51l3d
        IvHlhTTbTjpCYHKHXexg0gEXazDbba0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-aN1_YF8kPm-a8NuBrtKb7g-1; Wed, 21 Jun 2023 10:08:39 -0400
X-MC-Unique: aN1_YF8kPm-a8NuBrtKb7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B64F92835DF2;
        Wed, 21 Jun 2023 14:05:07 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A1340C2063;
        Wed, 21 Jun 2023 14:05:07 +0000 (UTC)
Message-ID: <dcc515cd-d0cf-5a14-8b48-aa94770e50bd@redhat.com>
Date:   Wed, 21 Jun 2023 10:05:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/5] x86/idle: Disable IBRS entering mwait idle and
 enable it on wakeup
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
 <20230620140625.1001886-6-longman@redhat.com>
 <20230621073212.GC2046280@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621073212.GC2046280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 03:32, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 10:06:25AM -0400, Waiman Long wrote:
>> When a user sets "intel_idle.max_cstate=0", it will disable
>> intel_idle and fall back to acpi_idle instead. The acpi_idle code
>> will then call mwait_idle_with_hints() to enter idle state. So when
>> X86_FEATURE_KERNEL_IBRS is enabled, it is necessary to disable IBRS
>> within mwait_idle_with_hints() when IRQ was disabled to avoid performance
>> degradation on silbing thread running user workload.
> Urgh, no, just no. This is nasty.

OK, will take this out in the next version.

Cheers,
Longman

