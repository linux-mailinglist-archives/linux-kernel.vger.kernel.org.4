Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D05EF463
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiI2Lej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiI2Leg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A138248
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664451271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xlKGV7zI8yovT8Qjaw1ezWS3Z9lVHmoWfs71GWUdoy4=;
        b=XPuGtjI+uWbWYDDeNtt21VO/oybFUOHidW5all2oCrbj/Nd1Nsq2CV1TYyuKFGsIXFCYKG
        GuvKq/KD4fiR8T0zeRQ3sjXxyJoEbh2b7e5pAMQdipmSjBK9eOcMSPgpFpM+N8SS0v5lXg
        WPyIKOeDnee+207fYEWEFGJCZH+huFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-pQaDUFMyPUelI1FKIZiPIw-1; Thu, 29 Sep 2022 07:34:28 -0400
X-MC-Unique: pQaDUFMyPUelI1FKIZiPIw-1
Received: by mail-wm1-f71.google.com with SMTP id 14-20020a05600c228e00b003b4d065282dso344130wmf.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xlKGV7zI8yovT8Qjaw1ezWS3Z9lVHmoWfs71GWUdoy4=;
        b=J5IYdwT5lClW4f2Yr3QuN+30hiIZayNeboRE+Yu3n9GqR7dGDRwtSEZZp1iU+jxgEh
         Gk/XwYmOIKs/O4in7l+TxkSB0j5qCGfAh1O+Ke3qr8OWMg9Aqq0IBQMTzEvDgp61J82Y
         1GbS7KU1aEdxWnVfpK6tugnYbdU/eDGZvLxI8SYU11K2i3I9tjArS7M0ENraTH7s6fVl
         MG3WmT9poWQU6UDsvQ0gaV0MeL6lgP8cgpMKEiKXUn5EjgurgrlpCMDmgBXS47bLyXrO
         eFuERT19/MBAq0VWK5L2f4iaQsNP/ISxMJewbpaXMOIOo7f0y/VEjWv7AGeMq7Evwp3o
         2lpw==
X-Gm-Message-State: ACrzQf0sjYGV1JUobJqByu5XiyeaDLeuL0Y78VEXRJHrBecdQakvElFD
        idZz593ggZq0cK1SbpByDd/mUv5YsOd6Ak9oghB85hgFSKR+R07mRSoEPO8hP8dXqFXC0hmZ14s
        BFqEcOsSN+1g8o+MfeFPl4oFz
X-Received: by 2002:a05:6000:86:b0:228:db07:24bc with SMTP id m6-20020a056000008600b00228db0724bcmr1903601wrx.204.1664451266818;
        Thu, 29 Sep 2022 04:34:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4AKzy0m1AK1alKmeZNml2sx8JdsLKH3XBovmokuz24KFW2iqhUvLM4hqCNLY8UmOfW6StkFw==
X-Received: by 2002:a05:6000:86:b0:228:db07:24bc with SMTP id m6-20020a056000008600b00228db0724bcmr1903572wrx.204.1664451266401;
        Thu, 29 Sep 2022 04:34:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ce00:b5d:2b28:1eb5:9245? (p200300cbc705ce000b5d2b281eb59245.dip0.t-ipconnect.de. [2003:cb:c705:ce00:b5d:2b28:1eb5:9245])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b002253fd19a6asm8219675wro.18.2022.09.29.04.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:34:25 -0700 (PDT)
Message-ID: <889909f6-f2db-f34a-0305-eb8500dd5453@redhat.com>
Date:   Thu, 29 Sep 2022 13:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, xu.xin.sc@gmail.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
 <20220929124242.60ef57ee@p-imbrenda>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220929124242.60ef57ee@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 12:42, Claudio Imbrenda wrote:
> On Thu, 29 Sep 2022 02:52:06 +0000
> xu.xin.sc@gmail.com wrote:
> 
>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
>> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
>> after enabling use_zero_pages, all empty pages that are merged with
>> kernel zero page are not counted in pages_sharing or pages_shared.
> 
> that's because those pages are not shared between different processes.

They are probably the most shared pages between processes in the kernel. 
They are simply not KSM pages, that's what makes accounting tricky here.

> 
>> That is because the rmap_items of these ksm zero pages are not
>> appended to The Stable Tree of KSM.
>>
>> We need to add the count of empty pages to let users know how many empty
>> pages are merged with kernel zero page(s).
> 
> why?
> 
> do you need to know how many untouched zero pages a process has?
> 
> does it make a difference if the zero page is really untouched or if it
> was touched in the past but it is now zero?

I'd also like to understand the rationale. Is it about estimating memory 
demands when each and every shared page could get unshared?

-- 
Thanks,

David / dhildenb

