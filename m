Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557F85BC470
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiISIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiISIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48115A0A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663576731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/1dK0PxjoGznFpiAoqtIHG4VWSzhz2ih+XQXjO5ifg=;
        b=JtKYF1N9hVJ/qaUW9Fsr4ELAWFxHo4HVcd93Wkn/C62UEKhaA0Mhtq2/GtQ3MTFCEMD+eH
        G5od157Kf3fOwoWoiv/WzWh159KecF/7hlNVKCdyjhPKMWZrTQauAfJSC8jwTMs3Le4lZj
        A0ulKHO4az1CDqcs6JEDBjvmRGNrg2w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-7al0CRBcN4CKGc-fKMR1lQ-1; Mon, 19 Sep 2022 04:38:49 -0400
X-MC-Unique: 7al0CRBcN4CKGc-fKMR1lQ-1
Received: by mail-wr1-f70.google.com with SMTP id d9-20020adfa349000000b0022ad6fb2845so1298403wrb.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=h/1dK0PxjoGznFpiAoqtIHG4VWSzhz2ih+XQXjO5ifg=;
        b=EQWibJxIkoyq5Fkrl7+4uYg5YBFKsGSDno/yTGlbUDod8cbOWqEcssHkHimDWmJ899
         Gjnqpf4RqS1uNiauyXX91uN0NuA4YN4rVZ9Geqb6wW/sOb6tL9HLQqkSq4JwR3rxh85Q
         kCz07hA/JikQK5SJfrXETWXCot01p9Ubpjx64ZqRdDPPsRNsRUMpU0oZ5MQYbzVGlnvD
         6gewpzjVjGICyWPSFtf6yIxKQjC8XRHNq9tKV566M/Ek1rAi+fUjwEm85DScShpz+5qL
         n8BzN4H+fd1NzoPHgrdJfiHUVlXpimrvhcK4gdXNjAaPwcaXotWSs+rcbDH+u1897kIt
         EXdA==
X-Gm-Message-State: ACrzQf3V2gtP18+7aHkql7/saeszALXLY93jLOibkVvcmYdbavy35wkf
        3vHnWQZEW8MxKRANyRTWwqefHeQkB0HGVoqV8nKkxDnGY5SpQYLHiiDNOxSik7zWhEaVMiyRlRt
        I5/nUsG1rtj2OXjh6sik3Qg8k
X-Received: by 2002:a05:600c:4841:b0:3b4:76f0:99f with SMTP id j1-20020a05600c484100b003b476f0099fmr12138978wmo.85.1663576728601;
        Mon, 19 Sep 2022 01:38:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68ak8tki3cJednv9FaWTNBlfIi+u7t4wN8VfYwATW5egZksWN115favkIGDmHtsK0hme9WQA==
X-Received: by 2002:a05:600c:4841:b0:3b4:76f0:99f with SMTP id j1-20020a05600c484100b003b476f0099fmr12138972wmo.85.1663576728388;
        Mon, 19 Sep 2022 01:38:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm14764593wmq.23.2022.09.19.01.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 01:38:47 -0700 (PDT)
Message-ID: <826cd775-14d2-12ae-2e96-cf0766aa1502@redhat.com>
Date:   Mon, 19 Sep 2022 10:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Correlation CMA size and FORCE_MAX_ZONEORDER
In-Reply-To: <CAOf5uwk=Tx+W-JuJBXUYjt2BLmSvr9Q153D1RTyJG_cmeO4AUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.22 23:36, Michael Nazzareno Trimarchi wrote:
> Hi all

Hi,

> 
> Working on a small device with 128MB of memory and using imx_v6_v7
> defconfig I found that CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE
> are not respected. The calculation done does not allow the requested
> size. I think that this should be somehow documented and described but
> I did not
> find the documentation. Does it work this way?
> 
> With CMA_SIZE of 8MB I need to have FORCE_MAX_ZONEORDER=12 if I have
> the default FORCE_MAX_ZONEORDER=14 the min size is 32Mb

The underlying constraint is that CMA regions require a certain minimum 
alignment+size. They cannot be arbitrarily in size.

CMA_MIN_ALIGNMENT_BYTES expresses that, and corresponds in upstream 
kernels to the size of a single pageblock.

In previous kernels, it used to be the size of the largest buddy 
allocation granularity (derived from MAX_ORDER, derived from 
FORCE_MAX_ZONEORDER).

On upstream kernels, the FORCE_MAX_ZONEORDER constraint should no longer 
apply. On most archs, the minimum alignment+size should be 2 MiB 
(x86-64, aarch64 with 4k base pages) -- the size of a single pageblock.

So far the theory. Are you still running into this limitation on 
upstream kernels?

-- 
Thanks,

David / dhildenb

