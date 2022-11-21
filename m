Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC4632D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiKUTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKUTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78782D2DDC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669060215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En7S4ToAZ7C1d2RdYAB0+iVFnYG0ZnYEDFN8qv1i8Ng=;
        b=IED0DjByn2vX/ISV6cXTU/ppa1wKlNhgc4NeNl8Z333IFE1cJ8giX2Q1qkrpQO08ckn1ld
        uJtKaNu+LeBbxa3pQSxj4tz9MYMz83PSksHQYqKWd6zLD/lv0x++OkGDo750wXah7iCyq9
        TUkNCiZiQy2spDQiXOcjX75aTWkdhbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-6iLa2Vd3O86EGDmve1L9LA-1; Mon, 21 Nov 2022 14:50:14 -0500
X-MC-Unique: 6iLa2Vd3O86EGDmve1L9LA-1
Received: by mail-wr1-f70.google.com with SMTP id d11-20020adfa40b000000b00241db65ec27so1040254wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En7S4ToAZ7C1d2RdYAB0+iVFnYG0ZnYEDFN8qv1i8Ng=;
        b=Z8BxaUJLWMO/uUzMYk/GTP5Kc8P6X4y/H2bLJk3/h1rp1gqbMf/kyJd/aTGt+XPN2V
         F++MdFchcxrMSRtW+uF74Io+5S9xtNmGZ6I7azZyRLvlPj1GEbhFlWN4cfB7ATvjlJ/P
         Crga+3XPfOmAWSmClmbR+6gy5r96cLKlw+tRJW+rTChFeJVH+8eG9KXGMZNJp7238Dd8
         xePwAbaEBpOqRwucxPbbJxmVMC5SPj0XO0sAV4NxFuH9qQIsEUpU3UkZJbsNQ9dNhMi5
         jmEQ/VF/MPQgw8/NpSA3ZX+w2NCw2KTGHWmxUbPiDVjMtTF6Kx/w+PwGb/kmfnmGf25z
         IkGA==
X-Gm-Message-State: ANoB5pkiHCh6oZrx9bAlpras3pVgQ/1Rt4hkAea+M8i/iujx3hhlwGgq
        ie35lfTDGHI9VioI07U/surml7saabHusxagNEaFPijKCiFxqJ6YVCyxUJlNiXxYOEKxEWV10s3
        KKO++SxsRiuHhqA+NLMPHqevw
X-Received: by 2002:a05:600c:19d1:b0:3cf:4d12:1b4b with SMTP id u17-20020a05600c19d100b003cf4d121b4bmr17146442wmq.23.1669060212898;
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4oAelbVCwjbeETHEH/KsM25flrvhhZ4bAv1IWQpJNBVIgBeB4DaoW2Fmr5Mj4IolOhPCoE+Q==
X-Received: by 2002:a05:600c:19d1:b0:3cf:4d12:1b4b with SMTP id u17-20020a05600c19d100b003cf4d121b4bmr17146428wmq.23.1669060212577;
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
Received: from [192.168.3.108] (p5b0c67dc.dip0.t-ipconnect.de. [91.12.103.220])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003b95ed78275sm15738785wmn.20.2022.11.21.11.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:50:12 -0800 (PST)
Message-ID: <11f65f51-5d77-e1cc-8f8a-779e35dd6af3@redhat.com>
Date:   Mon, 21 Nov 2022 20:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
 <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
 <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3vLbDAeILx7gJPT@bombadil.infradead.org>
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

On 21.11.22 20:03, Luis Chamberlain wrote:
> On Mon, Nov 21, 2022 at 05:00:49PM +0100, Petr Pavlu wrote:
>> On 11/16/22 17:03, Prarit Bhargava wrote:
>>> On 11/15/22 14:29, Luis Chamberlain wrote:
>>>> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>>>>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>>>>> I don't have the machine at hand right now. But, again, I doubt this will
>>>>> fix it.
>>>>
>>>> There are *more* modules processed after that commit. That's all. So
>>>> testing would be appreciated.
>>>>
>>>
>>> Can anyone tell us if
>>>
>>> https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/
>>>
>>> resolves the module loading delay problem?
>>
>> This patch unfortunately makes no difference on my test system. In my case,
>> the kernel has already intel_pstate loaded when udev starts inserting a burst
>> of acpi_cpufreq modules. It then causes the init function acpi_cpufreq_init()
>> to immediately return once the check cpufreq_get_current_driver() fails. The
>> code modified by the patch is not reached at all.
> 
> To be clear I don't care about the patch mentioned in the above URL, I care
> about this:
> 
> https://lkml.kernel.org/r/d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com
> 
> David was this the on you tested too?

Yes, that's the one I tried without luck.

-- 
Thanks,

David / dhildenb

