Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48968741E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjF2DE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF2DEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F942110
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688007847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36xMCYTl0fRQ3bokXhwMdx0i+ytJIVoK5bZ80UNZk2k=;
        b=fdttqglojGyac7xY0ZfLyMeo11qqB6BBJ3LMeRx6G3i445e9xdTnad2+m2ItnIhxn0YO3c
        zyChtZIX5Exc13qKeTE4K1fUuV1yQF1GLhEqzxSSEOMhd8RJkBBMEld2amPMM3KjHOGGhW
        gNy4WHHqkMgyHWAwmfucP8yUknglnCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-xfzANjggN-2sXftPaTIhUg-1; Wed, 28 Jun 2023 23:04:06 -0400
X-MC-Unique: xfzANjggN-2sXftPaTIhUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42F60185A7AF;
        Thu, 29 Jun 2023 03:03:46 +0000 (UTC)
Received: from [10.22.34.177] (unknown [10.22.34.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05A6A200C0F2;
        Thu, 29 Jun 2023 03:03:44 +0000 (UTC)
Message-ID: <9ab9d8ef-36c1-82e9-125f-1f8e6ba5a228@redhat.com>
Date:   Wed, 28 Jun 2023 23:03:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] intel_idle: Add ibrs_off module parameter to force
 disable IBRS
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230628022554.1638318-1-longman@redhat.com>
 <20230628022554.1638318-5-longman@redhat.com>
 <24b34b27-d2eb-e287-ffbb-29ffde66790d@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <24b34b27-d2eb-e287-ffbb-29ffde66790d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On 6/27/23 22:58, Randy Dunlap wrote:
> Hi,
>
> On 6/27/23 19:25, Waiman Long wrote:
>>   Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
>>   drivers/idle/intel_idle.c                   | 14 ++++++++++++--
>>   2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
>> index b799a43da62e..8604e6d1fe2c 100644
>> --- a/Documentation/admin-guide/pm/intel_idle.rst
>> +++ b/Documentation/admin-guide/pm/intel_idle.rst
> You may take or leave these comments as you choose.
>
>> @@ -216,6 +216,21 @@ are ignored).
>>   The idle states disabled this way can be enabled (on a per-CPU basis) from user
>>   space via ``sysfs``.
>>   
>> +The ``ibrs_off`` module parameter is a boolean flag (default to false). It is
>                                                         (default false).
> or
>                                                         (defaults to false).
>
> Then I think it reads better if the next sentence begins with: "If set,"
> instead of having it in the middle of the sentence.
>
>> +used to control if IBRS (Indirect Branch Restricted Speculation) should be
>> +turned off, if set, when the CPU enters an idle state.  This flag will not
>> +affect CPUs that are using Enhanced IBRS which can remain on with little
>> +performance impact.
>> +
>> +For some CPUs, IBRS will be selected as mitigation for Spectre v2 and Retbleed
>> +security vulnerabilities by default.  Leaving the IBRS mode on while idling may
>> +have a performance impact on its sibling CPU.  The IBRS mode will be turned off
>> +by default when the CPU enters into a deep idle state, but not in some
>> +shallower ones.  Setting the ``ibrs_off`` module parameter will force the IBRS
>> +mode to off when the CPU is in any one of the available idle states.  This may
>> +help performance of a sibling CPU at the expense of a slightly higher wakeup
>> +latency for the idle CPU.
> thanks.

Thanks for the suggestion. I will make the change if I have to revise 
the patch again for any reason.

Cheers,
Longman

