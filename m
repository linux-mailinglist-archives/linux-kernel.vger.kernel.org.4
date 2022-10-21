Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC616074DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJUKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJUKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D525D67E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPkjQ5gJeqFcNbmHMFmugRV0TbKd9OVS/vY9UX71k1w=;
        b=g/DOmHeQzY5ihfeLNk13GqOoqx8nsFHPQMYvLpSxrHqksuMJUFgXRoAguMgu2jtB/a0/aZ
        Yr768ER3F0ziMjMtWjNJwmgX+iNj1zoDtYmqR7yXH6H9O9hUslIYd2MIYKyLwU0KJX2ygX
        55nmWjXfsIqYhub3eOSL56YlHfmXbks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-2_NumOjZMk-aoSzbkbx-sQ-1; Fri, 21 Oct 2022 06:18:13 -0400
X-MC-Unique: 2_NumOjZMk-aoSzbkbx-sQ-1
Received: by mail-wm1-f71.google.com with SMTP id 133-20020a1c028b000000b003c5e6b44ebaso3117085wmc.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPkjQ5gJeqFcNbmHMFmugRV0TbKd9OVS/vY9UX71k1w=;
        b=s6Y67KsiQsiEeDvhLO2apvqkwG2VNH7ztMfQ32d7xlDrWfT5teaFQCBNuAEI3vxVqP
         V20OfPZkiTtekOn7IREuRkpwlFenGEejjMzzaukfIOqUO47bY4BJSQibmyDJ/B8vuA0K
         +SO2mJVzL49SEgrZUtlxmOgwqMHHE+5livLpgeuKw773C2aAY1eS43bXr0PHgG7WSCHm
         Xcy7zIf00eT74vW/BO3c9c4jQVV0VNXHKqUzVMRtv0QwZ08fGcbIOR85a/tcGNsM7k/b
         jDAaO0EC+AJ4ZJp2aKs+rdgWhbjeWfRGlVcthJJojlZwswjzIDYxiL3Gk+UT+wtW0NTb
         6sZQ==
X-Gm-Message-State: ACrzQf0Hmay3q63WwcQbKsgeBqB2HXvZ8Hlr6YpHmOMcUcN+7zlNVtN3
        IcA24ExdftfZpDurGdY5a0f8VBYv7p0tJCF4W7Vdegsu8ZZlovtZI4yn8ewUMHaEVVUkPiMBz8z
        A14bTbBTv/8Wk4yVq2rHC5hp3
X-Received: by 2002:a05:6000:186e:b0:22e:5dd3:e32a with SMTP id d14-20020a056000186e00b0022e5dd3e32amr11636814wri.167.1666347492406;
        Fri, 21 Oct 2022 03:18:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5jnfoq3jKrac0Ke1UOkfG/iNPScqM4JMpvllN5SPCu9U75sfif2BMK1Y/1rhRnJlNd5WNqmg==
X-Received: by 2002:a05:6000:186e:b0:22e:5dd3:e32a with SMTP id d14-20020a056000186e00b0022e5dd3e32amr11636796wri.167.1666347492076;
        Fri, 21 Oct 2022 03:18:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1700:e40d:574c:c991:5f78? (p200300cbc7081700e40d574cc9915f78.dip0.t-ipconnect.de. [2003:cb:c708:1700:e40d:574c:c991:5f78])
        by smtp.gmail.com with ESMTPSA id f7-20020adfc987000000b0022e04bfa661sm18716200wrh.59.2022.10.21.03.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 03:18:11 -0700 (PDT)
Message-ID: <6eea25bf-08a8-641e-2360-68884e194608@redhat.com>
Date:   Fri, 21 Oct 2022 12:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        xu xin <xu.xin.sc@gmail.com>
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
References: <20221017165541.6e2d3cebdc1ba13861ea4b2b@linux-foundation.org>
 <20221018090022.373574-1-xu.xin16@zte.com.cn>
 <20221018155407.41c993924ec09a64ae966d50@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221018155407.41c993924ec09a64ae966d50@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.22 00:54, Andrew Morton wrote:
> On Tue, 18 Oct 2022 09:00:22 +0000 xu xin <xu.xin.sc@gmail.com> wrote:
> 
>>> A full description of the real-world end-user operational benefits of
>>> these changes would help, please.
>>>
>>
>> The core idea of this patch set is to enable users to perceive the number of any
>> pages merged by KSM, regardless of whether use_zero_page switch has been turned
>> on, so that users can know how much free memory increase is really due to their
>> madvise(MERGEABLE) actions.
> 
> OK, thanks.
> 
>> The motivation for me to do this is that when I do
>> an application optimization of KSM on embedded Linux for 5G platform, I find
>> that ksm_merging_pages of some process becomes very small(but used to be large),
>> which led me to think that there was any problem with the application KSM-madvise
>> strategy, but in fact, it was only because use_zero_pages is on.
> 
> Please expand on the above motivation and experience, and include it in
> the [0/n] changelog.  But let's leave it a few days to see if there's
> additional reviewer input.
> 

I just posted a selftest:

https://lore.kernel.org/all/20221021101141.84170-5-david@redhat.com/T/#u

That could (should) be extended to test if unmerging works as expected.


Having that said, I think we really want a second pair of (KSM-expert) 
eyes on these changes before moving forward with them.

-- 
Thanks,

David / dhildenb

