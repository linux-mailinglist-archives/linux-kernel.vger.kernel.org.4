Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734EB5EBB70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiI0H1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0H0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F5580A1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664263612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9ODtW5t5SdFcjBY6SIxecQUGUZ3KwRU79qXAI2vn/s=;
        b=R3Vem+P1LBQoTTjOWbv3+re23VA0+a1NaAr/9NeDBSvB2jueg1dz/yFN+jbSqqsnXPeCET
        qkFcHVDEc8CzbgoE4WcMbODLaMNa5shlolPMk/k0abv9KuL5I5U2kvsxhLLdjJ5/DuCkJg
        Gtm0ZhIufG6p961fbKbn7VpTu8Xg+Fg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-jNxO_Lm5P8W137T6DjgItw-1; Tue, 27 Sep 2022 03:26:44 -0400
X-MC-Unique: jNxO_Lm5P8W137T6DjgItw-1
Received: by mail-wr1-f72.google.com with SMTP id f9-20020adfc989000000b0022b3bbc7a7eso1858336wrh.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W9ODtW5t5SdFcjBY6SIxecQUGUZ3KwRU79qXAI2vn/s=;
        b=odndqNy38T7VobIi6JYcZXE8SmtU5OvsScwGO1obMv2V/PnwnTOWDb2wa0CtYslcA4
         Fi5x6PHaKsVuZV3Rq8cV/ugaWFGmUGsZoycSpG1beXisim6G0uhWajA73xXEpSpgn0CD
         tr+nEVavKDKRvAhduTxeOw762lVsnl1D1flgON/DX45cLaLmq/nhucXrV1EFau7pJctH
         EtJ++iRXX1Xvbp3+N39y/qSyC0ZzRzvvLRDmZbDdTQlbrGRbAZNGyP8DKnCa1q581U/S
         1nVkH37WvIxPLzo/jGkxeD+/vtw69yBOQcdxovYz6ZtpVJFV55ckVYlr9Ihqmyv0UN6M
         afig==
X-Gm-Message-State: ACrzQf3QRlTq8S+8EUAZWIUG5Tb7MUML2ikayo3Cabs3B2GX2Pw+AqV/
        rDzbDtgNr9CbmRNhrS6Z2xslgCoxStiZ0zxGDH+hFeTtt6grL7obCK1rZ0GAQHDXNhImXiJF8L1
        TddRVMkvXp69CyIzXrTM1tJK9
X-Received: by 2002:a05:600c:19cc:b0:3b4:adca:a821 with SMTP id u12-20020a05600c19cc00b003b4adcaa821mr1501643wmq.37.1664263602892;
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/u7dRyYkitd+pZfI4fWVynEDAa14tDXYouDfpjUugWODzpdBq08pRSKrBR8ZnTmXtzQFY8g==
X-Received: by 2002:a05:600c:19cc:b0:3b4:adca:a821 with SMTP id u12-20020a05600c19cc00b003b4adcaa821mr1501630wmq.37.1664263602593;
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80? (p200300cbc705ff009ec26ff611a13e80.dip0.t-ipconnect.de. [2003:cb:c705:ff00:9ec2:6ff6:11a1:3e80])
        by smtp.gmail.com with ESMTPSA id jb6-20020a05600c54e600b003a5537bb2besm885860wmb.25.2022.09.27.00.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 00:26:42 -0700 (PDT)
Message-ID: <5b62011e-e41c-ffb8-68f6-80e55925498c@redhat.com>
Date:   Tue, 27 Sep 2022 09:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220927032851.128174-1-zhaogongyi@huawei.com>
 <20220927032851.128174-2-zhaogongyi@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH -next v4 1/3] selftests/memory-hotplug: Add checking after
 online or offline
In-Reply-To: <20220927032851.128174-2-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.22 05:28, Zhao Gongyi wrote:
> Add checking for online_memory_expect_success()/
> offline_memory_expect_success()/offline_memory_expect_fail(), or
> the test would exit 0 although the functions return 1.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../selftests/memory-hotplug/mem-on-off-test.sh      | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 46a97f318f58..1d87611a7d52 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -266,7 +266,9 @@ done
>   #
>   echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
>   for memory in `hotpluggable_offline_memory`; do
> -	online_memory_expect_fail $memory
> +	if ! online_memory_expect_fail $memory; then
> +		retval=1
> +	fi
>   done
> 
>   #
> @@ -274,7 +276,9 @@ done
>   #
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_ONLINE/error
>   for memory in `hotpluggable_offline_memory`; do
> -	online_memory_expect_success $memory
> +	if ! online_memory_expect_success $memory; then
> +		retval=1
> +	fi
>   done
> 
>   #
> @@ -283,7 +287,9 @@ done
>   echo $error > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
>   for memory in `hotpluggable_online_memory`; do
>   	if [ $((RANDOM % 100)) -lt $ratio ]; then
> -		offline_memory_expect_fail $memory
> +		if ! offline_memory_expect_fail $memory; then
> +			retval=1
> +		fi
>   	fi


LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>


I am questioning the stability of the offlining test, though.
Offlining a random memory block can fail easily, because "->removable" is not
expressive:

# tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
Test scope: 2% hotplug memory
          online all hot-pluggable memory in offline state:
                  SKIPPED - no hot-pluggable memory in offline state
          offline 2% hot-pluggable memory in online state
          trying to offline 2 out of 96 memory block(s):
online->offline memory0
tools/testing/selftests/memory-hotplug/mem-on-off-test.sh: line 78: echo: write error: Invalid argument
offline_memory_expect_success 0: unexpected fail
online->offline memory10
online->offline memory11


I guess this test will almost always fail nowadays.

-- 
Thanks,

David / dhildenb

