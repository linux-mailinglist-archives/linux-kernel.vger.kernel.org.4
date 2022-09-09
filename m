Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F55B379A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiIIMX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiIIMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F7E7F8A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662726115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpKZaZKB6OuIOUbNK0QXmxRia5uDsfJYJGNMehBpaeQ=;
        b=Gg28gKJ3uKapzabdcjs/ovSkjmzQHcse7/DT6PFfTqWsw+hYpR7ACfBtTyuGGGiV/+5xuy
        N7xGMSXUYiUl8By9l0ewwMVmj8Q+DdQE+Rz0WnpSaZ/PBT87lvB2r1bpSRU/W3tFQGIMx0
        ZohYkQ23f6xUZy3z3J76XaWgPtdxaW8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-Vp8znUtUMXWaDYsT4wpIHw-1; Fri, 09 Sep 2022 08:21:54 -0400
X-MC-Unique: Vp8znUtUMXWaDYsT4wpIHw-1
Received: by mail-wm1-f70.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so2690499wmo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wpKZaZKB6OuIOUbNK0QXmxRia5uDsfJYJGNMehBpaeQ=;
        b=PQZOqBVLNvn0gao8mmtBWCt/SgT4xe97WDB8TtDJTxI/OSk+J0RNNkd5ikhLlO+d1a
         QptqMmXPqTBWC8wZOR9kc5hoeEMx1AFFWx3SMTBtB178Kf8CyenI/bTqWq4otnBrQ7IM
         Domj0o3Fh1l1fqMN2gY9Wa/OkTLQDCLVxzkGKiRZSoL/3DUAOIjGPZJcKdkDCjkaRkST
         K4dpQQIqEvjmXBDY0gYju3vgPFv91hzv7uPTM2cSFz3BAk5UHTtWQm51foSlC/IkHLCR
         j8987ZTSBiJdC+ZLU7nh+IdG71yYeJf8ipaKEy+NUIENC5c/Wvr6q6Fz45od5gG39ZXt
         fAkA==
X-Gm-Message-State: ACgBeo2StaijvQGG/zC2gYG8HMxEVq+OGb5g528v5I0YZPzmMBbDSbJ+
        9zRq6NjnBGXqPgh31vOABPXo9E0I2p4J9S+3h/cxfLl8YxFTVVQ5lEX8uPNx7p97yfBviu/z82I
        +l6LKd1lJ4qSKp4TOzzOmJ24e
X-Received: by 2002:a5d:588a:0:b0:228:462f:a49 with SMTP id n10-20020a5d588a000000b00228462f0a49mr8372608wrf.616.1662726112735;
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zCe6lDbEZptsQT9dTPwb/AYvVBjW5axO/MWFBwE2Vrd8p4VQ+FCvkXzdgnWOwMPwcYhUpUA==
X-Received: by 2002:a5d:588a:0:b0:228:462f:a49 with SMTP id n10-20020a5d588a000000b00228462f0a49mr8372589wrf.616.1662726112488;
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm429713wma.38.2022.09.09.05.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
Message-ID: <c4447a26-8bc7-2250-0a64-1cb3a1b3b5a2@redhat.com>
Date:   Fri, 9 Sep 2022 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 4/5] selftests/memory-hotplug: Restore memory before
 exit
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220909075200.198363-1-zhaogongyi@huawei.com>
 <20220909075200.198363-5-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909075200.198363-5-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 09:51, Zhao Gongyi wrote:
> Some momory will be left in offline state when calling
> offline_memory_expect_fail() failed. Restore it before exit.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../memory-hotplug/mem-on-off-test.sh         | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 3bdf3c4d6d06..259fd8978639 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -134,6 +134,17 @@ offline_memory_expect_fail()
>   	return 0
>   }
> 
> +online_all_hot_pluggable_memory()
> +{
> +
> +	for memory in `hotpluggable_offline_memory`; do
> +		online_memory_expect_success $memory || {
> +			echo "online memory $memory: unexpected fail"
> +			retval=1
> +		}
> +	done
> +}

Maybe call it

"online_all_offline_memory()"

instead?

Note that "removable" as used in hotpluggable_memory() will nowadays 
always return "1" if the kernel supports memory hotunplug, independent 
of the specific memory block.

-- 
Thanks,

David / dhildenb

