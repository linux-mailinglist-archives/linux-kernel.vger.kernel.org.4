Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F83732C66
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbjFPJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343509AbjFPJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A330E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686908570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GafyBkcQzvQIRjmk7wYgo9lMe6LdHodKWm7c/bSeCg=;
        b=SlXmlcTMRxXN2b31oEywhKKNS1K7iOgoHeRCLXFCrSOJeE+m2VZxAalZ5a3nZ2Regp9rzN
        D4fTSBznodcCIgU4kCKHREzHmon0mUfSdMNvUHOYKo2bh+dBen6CstQo96M+sz5Y+A3JJL
        wSuEoMgdJqu8Mjb/EpNSULE/rkhIlM4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-vtQGLJf2PaCvPgt3Ao2mzQ-1; Fri, 16 Jun 2023 05:42:49 -0400
X-MC-Unique: vtQGLJf2PaCvPgt3Ao2mzQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ec817fb123so359944e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686908568; x=1689500568;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GafyBkcQzvQIRjmk7wYgo9lMe6LdHodKWm7c/bSeCg=;
        b=U2up8rszrjMqHBEoOasLpEOlrjhpx2EVWIY1hGZk1pw0xP3kc/5BrLQ5Xu48dYNFvN
         /fhyxMnHlkCfm98kVIaDFOJI85xrSHs/1rHrAyFGZK6zN5Ik+1Ydb1S1d8BASWb24s6Y
         09YFJ6+Dsm1dJOypYWcmxDpTRbSqzUh5+TgkXVNLr+ElTe8cIZvAlKlaY8Lpg3wJV2bw
         Ndm3Dgo2FTugSEeoh+Sq9wIH1wpdNjsWHhJd2Fz+fE7YMuBuKiJKEpB1ghFWVcqqtGny
         fnfJZ8/5vybgi9v9BAcyVCwB0vQYZTwHo9O/aqNkBcD5jDJZb0NXBuizbJZ2KO6EL2Q7
         F7Bg==
X-Gm-Message-State: AC+VfDzr4meiehG70oRfgZUo36a0SIeJnLJIYeAXEEWOIEArajD6mdCC
        mkxGZEgLETtM3TVA/IA+eOB0SEuveGoftzVGpXsJicdhBKIj2Ry6VrLH7GloYwSzhVSgh0KyUZY
        r01yVdLVk4DxMjYwkssJxUmla03QhXaPS
X-Received: by 2002:ac2:5b46:0:b0:4f7:55e4:4665 with SMTP id i6-20020ac25b46000000b004f755e44665mr830447lfp.56.1686908568255;
        Fri, 16 Jun 2023 02:42:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NdyLPmDxaQj9iocCb59FTYF2Jd9Rvljvltgi+G61jCwMtVET3vezM8eR4IooGuIK/sH1kiQ==
X-Received: by 2002:ac2:5b46:0:b0:4f7:55e4:4665 with SMTP id i6-20020ac25b46000000b004f755e44665mr830418lfp.56.1686908567763;
        Fri, 16 Jun 2023 02:42:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b003f8f884ebe5sm881496wmr.2.2023.06.16.02.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 02:42:47 -0700 (PDT)
Message-ID: <33eabee3-f6f4-ee0c-d74b-98815a9567c4@redhat.com>
Date:   Fri, 16 Jun 2023 11:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: vmscan: export func:shrink_slab
Content-Language: en-US
To:     lipeifeng@oppo.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        surenb@google.com, gregkh@google.com
References: <20230616092112.387-1-lipeifeng@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230616092112.387-1-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 11:21, lipeifeng@oppo.com wrote:
> From: lipeifeng <lipeifeng@oppo.com>
> 
> Some of shrinkers during shrink_slab would enter synchronous-wait
> due to lock or other reasons, which would causes kswapd or
> direct_reclaim to be blocked.
> 
> This patch export shrink_slab so that it can be called in drivers
> which can shrink memory independently.
> 
> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> ---
>   mm/vmscan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6d0cd2840cf0..2e54fa52e7ec 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1043,7 +1043,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>    *
>    * Returns the number of reclaimed slab objects.
>    */
> -static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> +unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>   				 struct mem_cgroup *memcg,
>   				 int priority)
>   {
> @@ -1087,6 +1087,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>   	cond_resched();
>   	return freed;
>   }
> +EXPORT_SYMBOL_GPL(shrink_slab);
>   
>   static unsigned long drop_slab_node(int nid)
>   {

It feels like something we don't want arbitrary drivers to call.

Unrelated to that, this better be sent along with actual driver usage.

-- 
Cheers,

David / dhildenb

