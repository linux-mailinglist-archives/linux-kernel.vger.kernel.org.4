Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7FC5B3D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiIIQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIIQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678FEDEC8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662742349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PajPt/TC46nKfhgfrV2SJTEfYUdbGNiCND1AO7d5Qf8=;
        b=Dswb32OIjxwhoF7nP6a9grFJMfKCicISr0Z8Fg8N+cgFSY4zhGDkINipFc8G+2GTKNb/ud
        QI599wCI/4HKFGvGaLv61sZMVsAa4Q5cqGO4hUzNsXfxSIl0pKSq3apP5HcD4ZoDx5bTwz
        /vF8ZMw0mQGzzUVcB34e7fsCObd8hZo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-3HujZFEFOX2-OCqHYWrzRA-1; Fri, 09 Sep 2022 12:52:28 -0400
X-MC-Unique: 3HujZFEFOX2-OCqHYWrzRA-1
Received: by mail-wr1-f69.google.com with SMTP id s26-20020adfa29a000000b00228b0cdb116so494614wra.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=PajPt/TC46nKfhgfrV2SJTEfYUdbGNiCND1AO7d5Qf8=;
        b=vREFDnTfj6gNdWVK2xxRCAJa1l0lr+6LKr/7P3WMK0PZC2giN4yACvFbx73ErFYout
         rdGD4Z+YU6SfTA9rZd9a1jP3TmEuQuEtKI9PqFQXA42ySp13snOMh7gm4uqrWKfYtGI5
         wHldwOlBaecLS50U5u06AIwbcsjb9hmxeXJ7jgdsPQ3wcpqtWINj2Mlrc/zXQZiYgDPu
         fUZsF4wazCSUsdx2ZUDY1sRYRFWIiWf/wcDEeN+t6NzA5I1EJUi6cxxSJVVYbebxLam9
         VIUEQyyBLMgpFP2RHAAROPpaythMcODZ0c+aFJgxJ4IPg2upHUfbiGzRQIQuh8/+kbJg
         ktbA==
X-Gm-Message-State: ACgBeo0ACWp1pf2bnyb19LVflJKQdV0qNvOSYGSPcvcucEVBcl7Fv/Hv
        n9LxbnqH5/9cUQi+2rfPFQQJReyatdt/QO/7HbY6p3m9hNWF3NXZRG5JRn1mCWu1iV8gGaue/rA
        Fd5Xl+G3ypeJUFWTaMig5qI3k
X-Received: by 2002:a5d:5887:0:b0:220:81ca:ec4f with SMTP id n7-20020a5d5887000000b0022081caec4fmr8300758wrf.263.1662742347119;
        Fri, 09 Sep 2022 09:52:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5RknKv2bcRzLPW8dqcU1t28MvBwm6FSTgg11b29hhDYbaxlAWZcpOhlZvbEhttkqn0VW4Kmg==
X-Received: by 2002:a5d:5887:0:b0:220:81ca:ec4f with SMTP id n7-20020a5d5887000000b0022081caec4fmr8300750wrf.263.1662742346887;
        Fri, 09 Sep 2022 09:52:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a846a014c1sm1200646wmr.23.2022.09.09.09.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:52:26 -0700 (PDT)
Message-ID: <712acfd4-f7f4-457e-f1a2-ca0f076c6d24@redhat.com>
Date:   Fri, 9 Sep 2022 18:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm/shuffle: convert module_param_call to module_param_cb
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220909083947.3595610-1-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909083947.3595610-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 10:39, Liu Shixin wrote:
> module_param_call is now completely consistent with module_param_cb, so
> there is no need to keep two macros. Convert module_param_call to
> module_param_cb since former is obsolete and latter is more kernel-ish.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   mm/shuffle.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index c13c33b247e8..fb1393b8b3a9 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -12,23 +12,22 @@
>   DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
>   
>   static bool shuffle_param;
> -static int shuffle_show(char *buffer, const struct kernel_param *kp)
> -{
> -	return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
> -}
>   
> -static __meminit int shuffle_store(const char *val,
> +static __meminit int shuffle_param_set(const char *val,
>   		const struct kernel_param *kp)
>   {
> -	int rc = param_set_bool(val, kp);
> -
> -	if (rc < 0)
> -		return rc;
> -	if (shuffle_param)
> +	if (param_set_bool(val, kp))
> +		return -EINVAL;
> +	if (*(bool *)kp->arg)
>   		static_branch_enable(&page_alloc_shuffle_key);
>   	return 0;
>   }
> -module_param_call(shuffle, shuffle_store, shuffle_show, &shuffle_param, 0400);
> +
> +static const struct kernel_param_ops shuffle_param_ops = {
> +	.set = shuffle_param_set,
> +	.get = param_get_bool,
> +};
> +module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
>   
>   /*
>    * For two pages to be swapped in the shuffle, they must be free (on a


LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

