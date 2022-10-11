Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2E5FAD8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJKHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJKHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CAB89AF3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665473481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeVSXveS/kNQgmI8JGnjgb3M3A0IXYnCuYJT2dIjatI=;
        b=AlLwmS3Lw24pUqz9KKPGef1MXSUFQJ7B241p7nRfS9kVA4jGRrElxLTD6mG1YNIoyf6d9P
        zeoDfJkQiUvm/zrXdoFpyJ2Jhp8J6HJ3JPNmBGyzD6qBDepXMUYeY6OxIXVPOERyrz+4cu
        /SlCBTFMSbWOtQxcxLU4PKJ20WM9wAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-EH0f9JvQOVGUsVGVlkvv8w-1; Tue, 11 Oct 2022 03:31:20 -0400
X-MC-Unique: EH0f9JvQOVGUsVGVlkvv8w-1
Received: by mail-wm1-f69.google.com with SMTP id k2-20020a05600c1c8200b003c3dd3aa638so5571482wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeVSXveS/kNQgmI8JGnjgb3M3A0IXYnCuYJT2dIjatI=;
        b=XpHbTYGxnflxvYPd/FQCodlCfJikR94PcYODwbhlsS7rUyoyrwFkRxfbG85TBbDqqT
         FA8I3gFhfLNaGRqSqPCvHfbR/RXbf9YaWIwg7lCXKF6C+/sv/kM5yaq22x81ojPp7EMu
         M0WtLgGSoY9wkyd8+5L9+eLX15/RDm1YlIF/2D9iSQwstjkCY3tV1+9N2rVUzfB1T2Nf
         9s2c/kZ5eHvilt4MQ0EFgqTjjBefQ2LFDlGIVgzxhjvnVv7/WSNajPSfz6wOos6JlOiR
         VWuKNgBSTBMpSlp+Z8wdQxH95hZEl2hfjqB/hrINcR+ayXABmgPXcppq1XPhzGSNNq4i
         e9Ig==
X-Gm-Message-State: ACrzQf31JgBI9fy3AeIFVzs3RG7NRjDZtxVp4kG0vzF7+/3NkBfxxrFj
        2tfQ8jefORPqL1BdcCYClncAWlq4i6jkUHHgoTI6VvlKxaxOjI73VWTjX8MfeiCbykrzk2J0Wjc
        hrt9Zk9RRmHdH8S/7rkN5WJ8H
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr12167342wrf.141.1665473478947;
        Tue, 11 Oct 2022 00:31:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7r1GZcgsBLBlZVyDoGI+egr1BEdqjAarH2S2H6VNTDFxZziRZGyyHKBXhDDtBjK2BCNIbzsA==
X-Received: by 2002:a05:6000:16c3:b0:22e:c6fd:2676 with SMTP id h3-20020a05600016c300b0022ec6fd2676mr12167315wrf.141.1665473478539;
        Tue, 11 Oct 2022 00:31:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6900:f110:6527:aa46:a922? (p200300cbc7096900f1106527aa46a922.dip0.t-ipconnect.de. [2003:cb:c709:6900:f110:6527:aa46:a922])
        by smtp.gmail.com with ESMTPSA id t128-20020a1c4686000000b003b4a699ce8esm9802959wma.6.2022.10.11.00.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:31:17 -0700 (PDT)
Message-ID: <eb839bff-90ff-adfe-c463-a20fdfa86b0e@redhat.com>
Date:   Tue, 11 Oct 2022 09:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next] selftests/memory-hotplug: Remove the redundant
 warning information
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     osalvador@suse.de, shuah@kernel.org
References: <20221011013926.200774-1-zhaogongyi@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221011013926.200774-1-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.22 03:39, Zhao Gongyi wrote:
> Remove the redundant warning information of online_all_offline_memory()
> since there is a warning in online_memory_expect_success().
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 74ee5067a8ce..611be86eaf3d 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -138,7 +138,6 @@ online_all_offline_memory()
>   {
>   	for memory in `hotpluggable_offline_memory`; do
>   		if ! online_memory_expect_success $memory; then
> -			echo "$FUNCNAME $memory: unexpected fail" >&2
>   			retval=1
>   		fi
>   	done
> --
> 2.17.1
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

