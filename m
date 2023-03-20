Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB16C21D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTTpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCTTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6778914991
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679341212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JX45utUIC7hI1qYbp3xg6KRxTGUFDZZZdRkQSxIo/4s=;
        b=RUhD632QKUeoosTpwt7uRjCC2rGMXtZgMTY0F5eJWVY8fRSyD1ZbSR3Fhsgc3N5Xc48L/l
        7Jawt2We6K712bArNkFVow+BS1yiUcm67wajW0ohXvI7nT6bgbusWEaj7lphpKDAOY1qdf
        /gob2stY9FY/Vu8BPmDuF+SniXq98O0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-inu2jhVfNNeIPiQuY1_nyg-1; Mon, 20 Mar 2023 15:40:10 -0400
X-MC-Unique: inu2jhVfNNeIPiQuY1_nyg-1
Received: by mail-wm1-f69.google.com with SMTP id o7-20020a05600c4fc700b003edf85f6bb1so1849494wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679341209;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX45utUIC7hI1qYbp3xg6KRxTGUFDZZZdRkQSxIo/4s=;
        b=LVhdZfVukiQsntHYnLdPPZTfyuJQjvJG7yyxYJhsivgD6uq440e87UgoU9i1AU3BiU
         +7Clk93ptN8uKaKfjRePRiRQW9s6Ton7fKFH6n6h7HxKix9ClTwe29htvdZR1i8FrMQa
         uQIItVn/Wyhtcpvoxt+Boinj784VR0jYlFYxShdik0GXEW7WHMQrajE/unjEqeOJO+0v
         /gyy34cMvhENnJ1ajH1NNdf5Rkir2ZZGa3q/U+3K40/SLEyW7XvmlYFrk+HzIhZ0Mzgw
         VhzBazrfCVDB2VjWez/VlnKMEfh8FFenk7r3zawxtIZv5s+o10mnm4kO8xOUfQeyEvmL
         NJKg==
X-Gm-Message-State: AO0yUKVmYQLMoqTeBxGthG4Ql/XMDzZf/RIQrT8QO+dPcT0sx/NFoMyK
        WGmvnv63gCFwIWMj0dhmiRrgM/2BtUKgzpRTm/MV1dfXMg6L54QcZ+bz2j14WM58RoSptT50Xgf
        DMYWrrkn3zAglye/hp8n1rd8H
X-Received: by 2002:a1c:f718:0:b0:3eb:389d:156c with SMTP id v24-20020a1cf718000000b003eb389d156cmr436947wmh.37.1679341209443;
        Mon, 20 Mar 2023 12:40:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set9nsShGK8n5z0GUDsaUOWY/sI3LQt6u5/RPo38YRxXb+8+DHrB0HpAf6jJ5DEhNevfct5XXdg==
X-Received: by 2002:a1c:f718:0:b0:3eb:389d:156c with SMTP id v24-20020a1cf718000000b003eb389d156cmr436937wmh.37.1679341209147;
        Mon, 20 Mar 2023 12:40:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id q2-20020a1ce902000000b003ed1fa34bd3sm11332380wmc.13.2023.03.20.12.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:40:08 -0700 (PDT)
Message-ID: <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
Date:   Mon, 20 Mar 2023 20:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
Organization: Red Hat
In-Reply-To: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
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

On 20.03.23 10:38, David Hildenbrand wrote:
> On 18.03.23 01:11, Luis Chamberlain wrote:
>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>> in a couple of days (1-2), so no need to rush.
>>>>>
>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>> issue easily.
>>>>
>>>> OK give this a spin:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>
>> Today I am up to here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>
>> The last patch really would have no justification yet at all unless it
>> does help your case.
> 
> Still waiting on the system (the replacement system I was able to grab
> broke ...).
> 
> I'll let you know once I succeeded in reproducing + testing your fixes.

Okay, I have a system where I can reproduce.

Should I give

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts

from yesterday a churn?

-- 
Thanks,

David / dhildenb

