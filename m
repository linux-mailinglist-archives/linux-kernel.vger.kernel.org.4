Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5273E632854
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiKUPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiKUPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD129686B4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669044742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAnNSC79PB+nEOAdqHzoVvnCbPLv+tVDX8zsNeLu1uI=;
        b=XIvcUMoG99nQAfCLv0t233PqIv0gyB1PTINLUjwbUPpumzsxl8neSM9fxX+ayUrpUzSjNz
        zr0dn3i7l0i3UwH9Eyqq1pjXu+rEBmfdPAf+IymryGq4kV0i/HvPwotSS2+YvMQI4QV8oE
        e4za4vMipNTE7+37mAhtdC9SRBbvqzM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-JaooPh-AMHOYhCk8Seq3ZA-1; Mon, 21 Nov 2022 10:32:13 -0500
X-MC-Unique: JaooPh-AMHOYhCk8Seq3ZA-1
Received: by mail-qk1-f197.google.com with SMTP id bm2-20020a05620a198200b006fa6eeee4a9so16048298qkb.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAnNSC79PB+nEOAdqHzoVvnCbPLv+tVDX8zsNeLu1uI=;
        b=sRN0GWnXfZjsTRBgd3ZflAyMvyYwXYfWaBEk3k92gZbRUs67Hm+7uLBDj4I8flAwuw
         EGRSYVmOtXYmSyhYcQTj+YaKebwo9o+Z30iizYeBofx0vkEyWd1cEOOvJVHDIL8t7bAu
         Ty6p1VrQqG66KGghlzM5ADHsDSohXMKmhiWKHDHXplQTAIqAJaexGhADKqgMZQ4fHmKi
         6FHpEc+HAmos7o9EEovTl5F4qC5tbTb5HQRbmFarYIrvKYPKg/Zd+J7iSDD6pWPSYDVn
         nJF0FPvX1iAMnErsQSbCtX+rEK1Rvm3erIybZeBiEGL3J9wgzmuvcNvrRnlipo9I/N8O
         0t7g==
X-Gm-Message-State: ANoB5pkAHJTnV9lXTiOu2L0GiMo21z2mM7s4mmY9wOW4SXRUsT/Ytyfn
        vSXqxZqsZyUBCpMN5EL64vOxFXS1w21/4BDH9VLhm/zcxRIOlyup62eDjapUssRhIF+AzytJjR6
        Y8iLcsHXWpS1osIHwfNvKnDQe
X-Received: by 2002:a05:620a:c02:b0:6ec:54d6:ea87 with SMTP id l2-20020a05620a0c0200b006ec54d6ea87mr16526654qki.245.1669044733169;
        Mon, 21 Nov 2022 07:32:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5QzcKpByoH5IFOBRZhUId/n1mZE/TJWamNTXtflc+eRaSTrKwX2lDdC7dfI+/Rue70ehtUbg==
X-Received: by 2002:a05:620a:c02:b0:6ec:54d6:ea87 with SMTP id l2-20020a05620a0c0200b006ec54d6ea87mr16526622qki.245.1669044732744;
        Mon, 21 Nov 2022 07:32:12 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80747000000b003a4d5fed8c3sm6718285qth.85.2022.11.21.07.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 07:32:11 -0800 (PST)
Subject: Re: [PATCH v6] livepatch: Clear relocation targets on a module
 removal
To:     Song Liu <song@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>
References: <20220901171252.2148348-1-song@kernel.org>
 <Y3expGRt4cPoZgHL@alley>
 <CAPhsuW4MaiJBTNnwVhqkmxPxBn8e1cn9PPGm9PkgF6YaO0AWKQ@mail.gmail.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <09ac46a0-45fe-e280-cabb-682e05c7fddc@redhat.com>
Date:   Mon, 21 Nov 2022 10:32:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4MaiJBTNnwVhqkmxPxBn8e1cn9PPGm9PkgF6YaO0AWKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 12:14 PM, Song Liu wrote:
> Hi Petr,
> 
> On Fri, Nov 18, 2022 at 8:24 AM Petr Mladek <pmladek@suse.com> wrote:
>>
>> On Thu 2022-09-01 10:12:52, Song Liu wrote:
> [...]
>>>
>>>  arch/powerpc/kernel/module_32.c |  10 ++++
>>>  arch/powerpc/kernel/module_64.c |  49 +++++++++++++++
>>>  arch/s390/kernel/module.c       |   8 +++
>>>  arch/x86/kernel/module.c        | 102 +++++++++++++++++++++++---------
>>>  include/linux/moduleloader.h    |   7 +++
>>>  kernel/livepatch/core.c         |  41 ++++++++++++-
>>
>> First, thanks a lot for working on this.
>>
>> I can't check or test the powerpc and s390 code easily.
>>
>> I am going to comment only x86 and generic code. It looks good
>> but it needs some changes to improve maintainability.
> 
> Thanks for these comments and suggestions. I will work on them
> and send v4.
> 

Hi Song,

I'll help with testing the arches (at least ppc64le and s390x, I can
only cross-build ppc32).  I can either pick up the patches from the list
when you post, or if you want to run them through testing first, lmk.

Thanks,

-- 
Joe

