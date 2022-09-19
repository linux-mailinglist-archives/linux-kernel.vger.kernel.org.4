Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA65BCB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiISLzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiISLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9202DA88
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663588448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxH7XjLCdlYQTKyCIzL976yQ4mhPMOVNZUR3p/LmDx8=;
        b=HIfpBzIpTmDdJ8fR5z32qQJCqZA/u+k3Td+Z6jt2BEHvnRngcOHqNZvcP6jJ/CVbM3+saA
        aoCKqrE25iZQ81hAyVSh3r48RAdmo3c8cA+T/CwpHGEoeaFUvnTqSF4nAyqPzqxEXNYwm1
        n8pnMACJnQ6jSIyHIjLSq/uyFds4f/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-O-rwSVsEPtyHydH7L4CSAA-1; Mon, 19 Sep 2022 07:54:07 -0400
X-MC-Unique: O-rwSVsEPtyHydH7L4CSAA-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso4556551wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hxH7XjLCdlYQTKyCIzL976yQ4mhPMOVNZUR3p/LmDx8=;
        b=RU7XL1UUZXoAkllWFy9zhBlPvruEQs/hlKXMZ0uNxeb0iN1Iu6BhP3hwXASs3Zpp9l
         RI3bxFGIMC7ebiBQ0SidPFNra/dkukxjF7MPFF1loeXcI5brSy05brpP/vX2RmEbd2uy
         9mb9tRpGOJn8FAbg4L98MFqD22tZdMxKOIyhqxRz4E/0U9bK7rk6nUSygmsz9Yb5HQfn
         8O2Z22Riqr/Bkksi2CRhQJ4rUlCi/m7baMJXZxc6dMMcRemEQe84dPoQWmhmcTP744G6
         ZsLYEynG+JF+yJhSN44gvJRj8nJHDv7nkhrT5lPPUd3MTGD6dzrqR5YyE3k2q44xY2A+
         RD7w==
X-Gm-Message-State: ACrzQf1X32mZNgq8fKgSjPXk1ToTrUvH3fud3zgqPyQuwP6gixO6P1f5
        lXPYmyMUsrMku/O5xp3WxjJFR9b8Ng14ZFch+OD3YAbLPoRbQuByzcK2Xlqjgh0zp12x2UbftNm
        fhz+em9Ot0948e71elOruh1m1
X-Received: by 2002:a05:6000:10ca:b0:22a:3318:861f with SMTP id b10-20020a05600010ca00b0022a3318861fmr9934757wrx.284.1663588446326;
        Mon, 19 Sep 2022 04:54:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6HbiOSrTrk9TAE5NnDOP0QYF+RHfacKHcGcpTYDBiBVoe5noLLX571BUd1lbeary1JNbNsLg==
X-Received: by 2002:a05:6000:10ca:b0:22a:3318:861f with SMTP id b10-20020a05600010ca00b0022a3318861fmr9934743wrx.284.1663588446069;
        Mon, 19 Sep 2022 04:54:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b003b4727d199asm13853417wmp.15.2022.09.19.04.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:54:05 -0700 (PDT)
Message-ID: <9b0cd14c-2a7d-b3f6-7588-90bc5859d102@redhat.com>
Date:   Mon, 19 Sep 2022 13:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, osalvador@suse.de,
        shuah@kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220917071427.28499-1-akinobu.mita@gmail.com>
 <93c044ca-7d2f-e23f-8eb4-72c133737a15@redhat.com>
 <CAC5umyhhnoJvoGT5NQX8VNn4QT_3qA1nY5tnZre59pL7vbMpzg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH -v2] lib/notifier-error-inject: fix error when writing
 errno to debugfs file
In-Reply-To: <CAC5umyhhnoJvoGT5NQX8VNn4QT_3qA1nY5tnZre59pL7vbMpzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.22 13:40, Akinobu Mita wrote:
> 2022年9月19日(月) 18:20 David Hildenbrand <david@redhat.com>:
>>
>> On 17.09.22 09:14, Akinobu Mita wrote:
>>> The simple attribute files do not accept a negative value since the
>>> commit 488dac0c9237 ("libfs: fix error cast of negative value in
>>> simple_attr_write()"), so we can no longer use DEFINE_SIMPLE_ATTRIBUTE() to
>>> define a file operations for errno value.
>>>
>>> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
>>> Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
>>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>>
>> But shouldn't we fix simple_attr_write() instead?
>>
>> I mean, simple_attr_read() might use attr->fmt to print a signed value,
>> but simple_attr_write() fails on signed values now?
>>
>> I might be wrong, but there is a disconnect. I feel like
>> simple_attr_write() should similarly make decisions based on attr->fmt.
> 
> I agree there is a disconnect, but I have no idea how to fix
> simple_attr_write().
> (strcmp(attr->fmt, "%%lld\n") is ugly)
> If no one seems to come up with a good idea, I'll fix the similar problems
> in fault-injection the same way I did here.
> 

Maybe we simply want another interface for the handful of %lld users. Or 
another way to allow DEFINE_SIMPLE_ATTRIBUTE users to specify it.

Might be good enough to specify instead of/in addition to "%llu" an enum 
that expresses what we want.

$ git grep -C2 DEFINE_SIMPLE  | grep "\%"

tells me that we have

a) %llu
b) %llx
c) %lld
d) 0x%llx
e) 0x%08llx

Maybe we can adjust the debugfs cases to be more similar, to eventually 
get only a, b and c.

-- 
Thanks,

David / dhildenb

