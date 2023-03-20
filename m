Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F76C0D81
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCTJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCTJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159351DBBF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679305062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSehupr3ZQFIxZG5J2UEktXA19d5C1cRws69ufPXWy0=;
        b=Eu6rIWz7r8r5bX/OBbbAWaXq4kUI34FlNCfrdMYb1eJFczcbyvNs6W6i0gQDYnHbIvjTBF
        isJX+O5z1ULpY1YlmRj2JTHXvkLVKstBu3KWr1RaiR0DPxpmB8oEsbMKs6h/vNstqIEHlX
        O8zuYg+ULiSNhptV/hZDPz82pXZucrg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ZubIBaGVOYO7zCGAQXx0kQ-1; Mon, 20 Mar 2023 05:37:41 -0400
X-MC-Unique: ZubIBaGVOYO7zCGAQXx0kQ-1
Received: by mail-wm1-f69.google.com with SMTP id z20-20020a05600c0a1400b003edcff41678so534493wmp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679305060;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSehupr3ZQFIxZG5J2UEktXA19d5C1cRws69ufPXWy0=;
        b=MDgXzT7i6+8RICoIvG6o3cgKt9rXJ/MQPhtxZff5SvLfvW0a8K13t51relSs8XdwSs
         lKRf1FzXSVbVF+xRpiuwm/3j4NV8E06jwwEjaUrZPXxZKoZm6ox8RCxe6YopJs3R/1Yu
         Fqof1g+mxUv4uJod4QfYOdr855uBbSU4V/X1Tk01BmCXvzl0bI3u0LPh0bfE598etMiE
         zTcousUxA4jEfjmW0lqorEE1ngUQ2Yb3jhZ2hhq/RVqr9EklEEs4bB+RaxmpgsWcd0ak
         fmk6/Ik7dr10ZKfQJYB1ymVBMphg4m632ShE80nvUiRpuTo/GYBZoioA+qv86M8wnBNw
         9GYg==
X-Gm-Message-State: AO0yUKVbjuiYqsvyvFvYtekZJ1qcSca0KnG+FQWj7KEKyOGEeBCg7f1r
        xyzn2i11dNEpwt0Bdob5vMW8jP7of6BjtSseDFsWNq2AIBjmHOXeFeMOayz1UnBe7s7qyYnb9eM
        GpOKKl0pc0g2wNmXbWjIMA7pt
X-Received: by 2002:adf:e74b:0:b0:2cf:e3d8:5dff with SMTP id c11-20020adfe74b000000b002cfe3d85dffmr12265919wrn.9.1679305059957;
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set8/r56O578u5RSgT8sy/rU880Ts62o7ET9TXhnWuxBe7vr18+YzsfivcSxLVJ6J57cPrNNMlw==
X-Received: by 2002:adf:e74b:0:b0:2cf:e3d8:5dff with SMTP id c11-20020adfe74b000000b002cfe3d85dffmr12265901wrn.9.1679305059662;
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b002cea8664304sm8371060wrz.91.2023.03.20.02.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:37:39 -0700 (PDT)
Message-ID: <f65a5bca-ad5f-bd8d-e063-382c076924a8@redhat.com>
Date:   Mon, 20 Mar 2023 10:37:38 +0100
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
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
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

On 17.03.23 00:56, Luis Chamberlain wrote:
> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>> in a couple of days (1-2), so no need to rush.
>>>
>>> The original machine I was able to reproduce with is blocked for a little
>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>> issue easily.
>>
>> OK give this a spin:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>
>> I'm seeing about ~86 MiB saving on the upper bound on memory usage
>> while hammering on kmod test 0008, and this is on a small system.
>>
>> Probably won't help *that* much but am curious... if it helps somewhat.
> 
> How much cpu count BTW?

220 physical ones and 440 virtual ones.

-- 
Thanks,

David / dhildenb

