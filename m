Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3D740CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjF1J0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235278AbjF1JIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687943278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tmOGLEvDLwTWFfXTCn0Kgw7Ibn3hUfGy18egvu84cw=;
        b=MGzwGI7n94UCJJZlflpAGchhKIapiHV5B2KhuOi9VjAQxmXr5SFAGdpeoyFwX8/AmAQhCw
        v1Vd6CP8SZMUZidsBK5KEsX88OHzjypmnddTvnj5gWzwpWnDMIKTBck4nxLyEyOUvnJf4q
        b0IwdUr6/dK8Z+W8dcuO97olAC5oexA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-SAXHSXkdNPmG9K8pPhZjFQ-1; Wed, 28 Jun 2023 05:07:56 -0400
X-MC-Unique: SAXHSXkdNPmG9K8pPhZjFQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso36220415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687943275; x=1690535275;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tmOGLEvDLwTWFfXTCn0Kgw7Ibn3hUfGy18egvu84cw=;
        b=fLYzIXw2ItRi472pF2xMjyywREQMMCEXjzeaPVHc8wEvel99l3cK5jJi7Cltmzb4rD
         QGqaLfG+Qc6lht0BRG4q5gdmZwd+fJylfziQ+3kNqb/Nc2l2vo8f/WTtqnUMhDg0dIMK
         J6d12f1MZmTMbDvjw9xrZwT1M8fesx5HO51Fpj78ZCoHMrQFp20nnSSf5XQ9otz82i+W
         lhmRxA6CxEy4WSW+3iYcUETOCuXNjcBLZbOSb08bCvJoSn6M2qBi/5dDB9+03Sh7zJ/A
         +r0+fFB7kA5TMfk0UJBJryaEVEYMBJgn3zvlM2ngmKND3E/IoVL15OAfgLK8t+4BaLxG
         MY7w==
X-Gm-Message-State: AC+VfDynq9JkKdqdF1WVOu9Y4jQf0h4f+rOY8b/KM5W305slAiwMlh8j
        pMg2wK5qfwbA788hcZMxKxMXVhLLIBImrp4PGFUyNMjheBMxQKEgsNQ1wf/9mEupaLV8cinpFv/
        2OrJqY5x32Y1V4BoWNfnp4heV
X-Received: by 2002:a1c:770a:0:b0:3f9:c04:e76c with SMTP id t10-20020a1c770a000000b003f90c04e76cmr24266391wmi.28.1687943275608;
        Wed, 28 Jun 2023 02:07:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Zd/AfCE3hYYcH4TTOMIl2Wfafkc2Ctr/hBivapLM6oxQ4tBDZc7EY3Znf0MnPHEb4hq1UJA==
X-Received: by 2002:a1c:770a:0:b0:3f9:c04:e76c with SMTP id t10-20020a1c770a000000b003f90c04e76cmr24266377wmi.28.1687943275188;
        Wed, 28 Jun 2023 02:07:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ef00:fa40:f6df:a68d:a0e4? (p200300cbc715ef00fa40f6dfa68da0e4.dip0.t-ipconnect.de. [2003:cb:c715:ef00:fa40:f6df:a68d:a0e4])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f9b0f640b1sm13134247wmc.22.2023.06.28.02.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 02:07:54 -0700 (PDT)
Message-ID: <c3bd72a0-6c19-b874-9942-2fc1e1f9a20b@redhat.com>
Date:   Wed, 28 Jun 2023 11:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/ksm: delete the redundant ksm_merging_pages interafce
 in proc
Content-Language: en-US
To:     xu xin <xu.xin.sc@gmail.com>, sunnanyong@huawei.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com,
        yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
References: <20230627133542.2446285-1-sunnanyong@huawei.com>
 <20230628031233.9734-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230628031233.9734-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.23 05:12, xu xin wrote:
>> Message-ID: <20230627133542.2446285-1-sunnanyong@huawei.com> (raw)
>>
>> Since the ksm_merging_pages information already included in
>> /proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
>> make the directory more clean, and can save a little bit resources.
> 
> I think it's ok to remove it because this interface was not proposed for a long time.
> I believe its users are not many yet. The earlier we delete it, the better.
> 

Well ... it's been around since v5.19, which was released 1 year ago.

... not sure if the removal is worth the possible user space break.

-- 
Cheers,

David / dhildenb

