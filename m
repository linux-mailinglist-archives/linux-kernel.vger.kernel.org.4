Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D595F068A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiI3IeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3IeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C250E1C6130
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664526841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qO+BdsidXtPxlgGBkdeG85IbyU5cabWapFdrZ2axzLg=;
        b=LvsGB3BWosNMAnQ0TXQP132X4W+mdOPrYuRltGaO/VFUY7sh2RcCYT4JCh/OheHBopigyq
        Go/KVAQIACee8eEu5OKAEhQa043HhDClrWa9/8qWCIcR3An5fFzwi7F7HJC5sc72U3v1Z5
        lEFy+TkfQpuMS8nfX32iHYrQUsRbkrs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-Ou02AQjIN2qZYj9mHYZdrA-1; Fri, 30 Sep 2022 04:34:00 -0400
X-MC-Unique: Ou02AQjIN2qZYj9mHYZdrA-1
Received: by mail-wr1-f69.google.com with SMTP id t1-20020adfba41000000b0022cc6bcd8dbso1299467wrg.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=qO+BdsidXtPxlgGBkdeG85IbyU5cabWapFdrZ2axzLg=;
        b=cyz5YTZOFrjcvpopZqb1e8SWiB1ubX1oqJWmpPfimPOu6YStMnJnay5PHIYJAF/p01
         0PJLMUJMGknZqPSeavGFb7SciujbQnXuIrw+PWbaO+d2I7jXgt7cXWZppF/XE2TSIj8u
         G+57OADoTeqCQY7GBn34DuwEJuLqVqEOqnNJ4RLHK9WheDZ+ExWjPe9REd/iHfXUlDrk
         YvDvcA7+pJYgF2v2t8tZ2rjk/KsVoXBCzG04JFmrEeig5fE6wb4GXr4ay8KuS3R1RP9T
         TbW0wJ6gciSsjjNk8f8rm0gHT8JFJtXkJ2zkOCcFXLWKDRlYqc0WlviQ4eJhKM85RHnU
         sINg==
X-Gm-Message-State: ACrzQf2K0/uVIV6b2Drrni8MBsW346NGGVz15bFnUN6Co9CnCQgDhecS
        1Bel++5yTCoEuuzUg/rw5LNepdkoTfIwYvlkpOtg6IOpEpX4c6ZuF+lE2NQjEoP2ZSP35HuV8Ze
        6nbE13GkxPzz8egzRoF24SofS
X-Received: by 2002:a05:6000:384:b0:22a:5d05:c562 with SMTP id u4-20020a056000038400b0022a5d05c562mr4999334wrf.701.1664526838892;
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6NRmhoyd+3R2o1xuvY/2jTk5yngLV7dYKGrw8U3pNLD5NdDevDCS6YN3KRzA4TJTUkM4dd2g==
X-Received: by 2002:a05:6000:384:b0:22a:5d05:c562 with SMTP id u4-20020a056000038400b0022a5d05c562mr4999314wrf.701.1664526838661;
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm6534230wmh.23.2022.09.30.01.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:33:58 -0700 (PDT)
Message-ID: <b90f1f32-eac5-a1cd-436a-3486b704c9c9@redhat.com>
Date:   Fri, 30 Sep 2022 10:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next v5 2/4] selftests/memory-hotplug: Restore memory
 before exit
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220930063527.108389-1-zhaogongyi@huawei.com>
 <20220930063527.108389-3-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930063527.108389-3-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.22 08:35, Zhao Gongyi wrote:
> Some momory will be left in offline state when calling
> offline_memory_expect_fail() failed. Restore it before exit.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../memory-hotplug/mem-on-off-test.sh         | 21 ++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 1d87611a7d52..91a7457616bb 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -134,6 +134,16 @@ offline_memory_expect_fail()
>   	return 0
>   }
> 
> +online_all_offline_memory()
> +{
> +	for memory in `hotpluggable_offline_memory`; do
> +		if ! online_memory_expect_success $memory; then
> +			echo "$FUNCNAME $memory: unexpected fail" >&2

Do we need that output?


-- 
Thanks,

David / dhildenb

