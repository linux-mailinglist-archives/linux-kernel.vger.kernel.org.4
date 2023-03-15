Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E56BBA22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCOQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCOQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C33A85B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ish4HOwYk+bfvweZUG7R/ggOz5EHjTFqrtCH+lkNtE0=;
        b=Nqep7BdHDPs8tbbVQ1jGDV5+GvC4VaQLvQMfaelQisPlQX0UDocRr8eNRfNb4BOE89PY6f
        nkythqlqTfuWZYUmQbj+rLliAM6E+7Wtap9Wee2ObYn6x7XyIK0y5sssPsoN1MllEnFaap
        BxpR0CI4QY/xmJc0YlhnIAdkqjnv7gE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Ev6QdhKIPhOdYkXAaoNGQg-1; Wed, 15 Mar 2023 12:41:56 -0400
X-MC-Unique: Ev6QdhKIPhOdYkXAaoNGQg-1
Received: by mail-wm1-f69.google.com with SMTP id az12-20020a05600c600c00b003e8910ec2fdso6964989wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898515;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ish4HOwYk+bfvweZUG7R/ggOz5EHjTFqrtCH+lkNtE0=;
        b=tf5r6z3zZVPuG9CcmU8H3BjxSqt2Kd8bY+tWL4V7YV3A0vklPdcCkwhVYSJZWVDmYd
         FVvqfwbe3VwAN1YRJBYO2C4dBC52wDPh9M30dCipMUKF+J5YMH9ZhMOmCOSLUW5lXe00
         wo2C+DHyUmH4TOYLe6y8m7xDEGs8KPLG0s6U5TtJsfgPVfzLAP8ImT09qsN0nI7MJ2oR
         ePt31euJrOhbl6IulBHt0dCj8P1EJofJHsdmARmGIaWG7DHRUmEr9PuAoj++ME8KXbDV
         itLJU+ZpKTKaxJv+xpgJrtk+mqfWsuvK6bsdlvKJNOC1OpzB/oNRIN//ppeEa4G1bS/i
         6y7g==
X-Gm-Message-State: AO0yUKXGMqpwWyIgOtzr38UOJ7lsaz6w8zHx8Lk2NwOrhg+dUo1nhV/i
        mxqBoyjyrFBxk4+DUHZYz/uwMnlH85cjHFT5Ymp1ltP0ZYTXsNhogkPSQ39mSNGk0AbRPHIXwMh
        ZZKt0m1/lrSYcYeqCoazSpyTG
X-Received: by 2002:a05:600c:1d29:b0:3eb:3945:d3f4 with SMTP id l41-20020a05600c1d2900b003eb3945d3f4mr21233144wms.2.1678898514907;
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+MrHac4o2ZwkDMHboYyrIICw8C859iTL0x1tIQW0QrRbGroJmH92hX+qLCk/+Iv4fZd3Aa9w==
X-Received: by 2002:a05:600c:1d29:b0:3eb:3945:d3f4 with SMTP id l41-20020a05600c1d2900b003eb3945d3f4mr21233131wms.2.1678898514603;
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id l4-20020a1c7904000000b003ed1ff06faasm2324765wme.19.2023.03.15.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:41:54 -0700 (PDT)
Message-ID: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
Date:   Wed, 15 Mar 2023 17:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.23 17:10, Luis Chamberlain wrote:
> On Wed, Mar 15, 2023 at 01:24:41PM +0100, David Hildenbrand wrote:
>> On 11.03.23 06:17, Luis Chamberlain wrote:
>>> A long time ago we had some issues with userspace doing stupid stuff.
>>> Well, it turns out even the kernel and do stupid stuff too, as we're
>>> learning with the ACPI modules aliaes and that hammering tons of loads.
>>>
>>> So add a bit of code which gets us a bit more in the defensive about
>>> these situations.
>>>
>>> To experiment, this also adds in-kernel alias support to see if this helps
>>> with some larger systems.
>>>
>>> This is all based on some old code which tried to add defensive
>>> mechanisms the last of which was here and I had dropped the ball:
>>>
>>> https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
>>>
>>> I've only compile tested this for now. Will need to stress to test
>>> with kmod tests 0008 and 0009 to see if there's any differences.
>>> I'll have to re-test and re-gnuplot stuff there. But early feedback
>>> is appreciated, hence the RFC.
>>>
>>> David Hildenbrand had reported a while ago issues with userspace
>>> doing insane things with allocations bringing a system down to
>>> its knees. This is part of the motivation for this series.
>>
>>
>> I'll try to grab a system where I can reproduce the issue and give your
>> patches a churn.
> 
> Great, then please wait for v2 RFC as the first patch was missing an
> obvious mutex grab / release, I already have some memory pressure data
> that shows gains. Hope to post soon.

I expect to have a machine (with a crazy number of CPUs/devices) 
available in a couple of days (1-2), so no need to rush.

The original machine I was able to reproduce with is blocked for a 
little bit longer; so I hope the alternative I looked up will similarly 
trigger the issue easily.

-- 
Thanks,

David / dhildenb

