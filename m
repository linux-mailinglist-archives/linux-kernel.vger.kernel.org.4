Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87EF6ADB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCGKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCGKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:05:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A23CE37
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678183481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zadC5YEQxS3jLhvS31mnw2aDuHtd3wOc5As59iWb8VQ=;
        b=NVOyzcOqcTqeZH527dT2LWCZ9KKQ2Jwm6P6YRX60KWDgl3nNtNwi+/0Gm2HD/TUuL8kVOP
        0W1TDXm72Zy5I0fF5Ts+so5nZ50CX0pIZlYvO41DwwmtjMNaX7v1b1eo/U/ttwUu4RD/M4
        +E5spCxpVVT5D4ZYfta2MNmyCN0jeVs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-7iGNvO4_NuCWS4PM-QbV2Q-1; Tue, 07 Mar 2023 05:04:40 -0500
X-MC-Unique: 7iGNvO4_NuCWS4PM-QbV2Q-1
Received: by mail-wm1-f71.google.com with SMTP id m31-20020a05600c3b1f00b003e9de8c95easo4614992wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183479;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zadC5YEQxS3jLhvS31mnw2aDuHtd3wOc5As59iWb8VQ=;
        b=48aG3A4dbgQTKnKEj1xlgC6MNXlxsnpmjbdVgbSqOsqZAInGVwHC215d4PirpnxjNG
         lsREhwEnYlm51jkrK69Ebzv4NtNIrF84LkQ8VYTDW+5OKrGjnQNsVsEIpADo+mubzLQY
         snnQ5Vm4zZqqn4uuXucg2ohzf0TRmhAx8l93Ry1TBeKzoyU4Jkp8VPgPq+wKIepwDv3X
         gaVPATf3zGI79RNTolEPvXxQZt2M57cdLyjPpXkU85jFGsutFJ+wxBhYh1PsDZF6F1Mk
         1ehOu0Z6s3sbmxg/Qx0l1llPRFNF291sf0WRLfLy/LF019KDnkG8c0ZiQDXA0VXC3W0s
         4zKQ==
X-Gm-Message-State: AO0yUKURYJaxNYN2Hamo8XaWs2bSHrnNix2iJ15306i0mAhq6n8Rd76R
        dHgTql2nszBoBALL7M+MMS64HGonZcMN1woslYU4e2OWnzsWMe2C6DbCmZjkvf3ApCUQtcRX99i
        N5xxWm1KS19MkZLmc/2ZudOu2jnfI0PD5
X-Received: by 2002:adf:ecc1:0:b0:2c7:df22:117d with SMTP id s1-20020adfecc1000000b002c7df22117dmr8565952wro.31.1678183479372;
        Tue, 07 Mar 2023 02:04:39 -0800 (PST)
X-Google-Smtp-Source: AK7set9Jm3b2K174FUeCQCXv+ffg3MWCpkiqQjFM6XjLHKoG6rGgvc4bPFpjha+S58Y3sn5TwdiW8g==
X-Received: by 2002:adf:ecc1:0:b0:2c7:df22:117d with SMTP id s1-20020adfecc1000000b002c7df22117dmr8565939wro.31.1678183479008;
        Tue, 07 Mar 2023 02:04:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe352000000b002c567881dbcsm12116359wrj.48.2023.03.07.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:04:38 -0800 (PST)
Message-ID: <4c223e9c-2d43-fb8f-7ac9-ad2121914170@redhat.com>
Date:   Tue, 7 Mar 2023 11:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: fix potential invalid pointer dereference in
 kmemdup()
Content-Language: en-US
To:     Xujun Leng <lengxujun2007@126.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307090358.21346-1-lengxujun2007@126.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230307090358.21346-1-lengxujun2007@126.com>
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

On 07.03.23 10:03, Xujun Leng wrote:
> If kmemdup() was called with src == NULL, then memcpy() source address
> is fatal, and if kmemdup() was called with len == 0, kmalloc_track_caller()
> will return ZERO_SIZE_PTR to variable p, then memcpy() destination address
> is fatal. Both 2 cases will cause an invalid pointer dereference.
> 

"fix" in subject implies that there is actually a case broken. Is there, 
or is this rather a "sanitize" ?

> Signed-off-by: Xujun Leng <lengxujun2007@126.com>
> ---
>   mm/util.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4..d1a3b3d2988e 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -128,6 +128,9 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
>   {
>   	void *p;
>   
> +	if (!src || len == 0)
> +		return NULL;
> +
>   	p = kmalloc_track_caller(len, gfp);
>   	if (p)
>   		memcpy(p, src, len);

Why should we take care of kmemdup(), but not memdup_user() ? Shouldn't 
it suffer from similar problems?

-- 
Thanks,

David / dhildenb

