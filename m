Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202C6BB16D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjCOM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjCOM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA89AFCC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678883085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO3xvWEOxLtGfBjQzTV1j3rg9kZXhnrlyWqpPgmzUR0=;
        b=F6CfKZAB2VxCEr+peRwc19VJXlVOMwusSSZkSXW9IeOj9hOmsKvY9smQQiRSgf/3/HRGR7
        ANwHKaxVQPfd1Yq8SWQ0ObMCffQ5Z7nSOVirsk7/DquWbjdcl/7kLSFtHTLmydVXI5J8Ez
        ZlFqul/dZEiWvaN26S8MbdA436lCqR8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-j3b1mhfCOaabCKUhapBmsA-1; Wed, 15 Mar 2023 08:24:44 -0400
X-MC-Unique: j3b1mhfCOaabCKUhapBmsA-1
Received: by mail-wr1-f72.google.com with SMTP id b14-20020a05600003ce00b002cfefd8e637so624923wrg.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883083;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO3xvWEOxLtGfBjQzTV1j3rg9kZXhnrlyWqpPgmzUR0=;
        b=PJ1yVFfQfYSwnkKKgDAQBsIYN7s9qkemuoVlZJmPDHTaQmyckirVOSe7y5yfZk9f7Q
         HL7ElqUmitSfjkqdswQOHlELAm0vzbU7iTppuhgnZSh88b6VjOhucwEBch+o6Rl2Wm+u
         FAIHoUYpv9NeQRgkeX3JuDFAaPrdqOPbZrYwflmZ1FV0buiXiJPxfh40+QaCOHjK5Lh5
         t3preX2BPEt5qrlH4VYVVABOrnfei277Qe/YSNYKqxQgTLfP4kjT9KmCxb5JXQFBbMvQ
         0EIx9iqh9IAPluPVpm6GW0FRdoOJrdLwBP/QJ8gAzGiPfP+Mojot8TOJhF6kjPMA79mc
         HNjg==
X-Gm-Message-State: AO0yUKUmw6awEgWWPf1nr8qOwmUI8MKj+y4Y6vt+GYCOUMkDHJHQuesh
        44OrIQGV9kI7mKp2zMHOnIr67p8SJ3J1nzRhg3BCnOXVgnq+w/7owEuyc2aH/MX2Bn5jS7VvQAh
        YRTmHnizPtcscYa1pHzI9rsPc
X-Received: by 2002:a05:600c:458f:b0:3eb:4162:7344 with SMTP id r15-20020a05600c458f00b003eb41627344mr18437506wmo.22.1678883083148;
        Wed, 15 Mar 2023 05:24:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8fqujSiAvEVS1OAzs9541Izlj/1kOWdRv6q66LMMnewVwESOzM8VL2rQfJ44GE6WjeMsCyzA==
X-Received: by 2002:a05:600c:458f:b0:3eb:4162:7344 with SMTP id r15-20020a05600c458f00b003eb41627344mr18437482wmo.22.1678883082847;
        Wed, 15 Mar 2023 05:24:42 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6936.dip0.t-ipconnect.de. [91.12.105.54])
        by smtp.gmail.com with ESMTPSA id iz11-20020a05600c554b00b003ed201ddef2sm1796689wmb.2.2023.03.15.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 05:24:42 -0700 (PDT)
Message-ID: <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
Date:   Wed, 15 Mar 2023 13:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230311051712.4095040-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11.03.23 06:17, Luis Chamberlain wrote:
> A long time ago we had some issues with userspace doing stupid stuff.
> Well, it turns out even the kernel and do stupid stuff too, as we're
> learning with the ACPI modules aliaes and that hammering tons of loads.
> 
> So add a bit of code which gets us a bit more in the defensive about
> these situations.
> 
> To experiment, this also adds in-kernel alias support to see if this helps
> with some larger systems.
> 
> This is all based on some old code which tried to add defensive
> mechanisms the last of which was here and I had dropped the ball:
> 
> https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
> 
> I've only compile tested this for now. Will need to stress to test
> with kmod tests 0008 and 0009 to see if there's any differences.
> I'll have to re-test and re-gnuplot stuff there. But early feedback
> is appreciated, hence the RFC.
> 
> David Hildenbrand had reported a while ago issues with userspace
> doing insane things with allocations bringing a system down to
> its knees. This is part of the motivation for this series.


I'll try to grab a system where I can reproduce the issue and give your 
patches a churn.

Thanks!

-- 
Thanks,

David / dhildenb

