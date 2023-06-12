Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172072BC03
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjFLJXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjFLJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DA4ED4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czIpL4TLoK5D3eKZvmop6buHX7NGH22btauuZM6tsDY=;
        b=I9euZ0VsYfFrhS3f1H1Ol5udLRkZwfUTohARwFi8+cgfU8/Kj8YDaiY1CBIHWxZksnqRS3
        hnCDnoKxxqSyFhe3Dc5YQ9b46kK1an5G3zvaMX/TgR/9pd1tLMTOgLHZ40HgpM3NGHIAJB
        xrkfqMAwVYXW9mQqqcEpOUpIpJAEgZg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-vBM9q_eHN72s-npoYdpVcA-1; Mon, 12 Jun 2023 05:15:41 -0400
X-MC-Unique: vBM9q_eHN72s-npoYdpVcA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f59c4df0f9so2556026e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561340; x=1689153340;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czIpL4TLoK5D3eKZvmop6buHX7NGH22btauuZM6tsDY=;
        b=ZlanGPAAV5PQ1TwwElL3icvZtqYsfifF1JcIWBq2Uky4qiZSZOyANWRHCUbJwx7vFX
         e37gUgxIYSK1oUtkKDdP2U/Lqo4RsBf4J2W16lWBjVBcGSeJQX+too+tTQNhbKWaJ1ex
         T7qbWGGB0kccrARigN0kFIN43P3XURPnsh3TbrSHAYY6aBv7OpzPJLIbtV1uH3DB0nER
         68K+LYN9jdeMH3IbUwAlcbU+v+qTMcDIHXCE4x1NCIaN0TY3qugtLARoY5B1kdUmPSoI
         jvZSUc/DeQUUAfWrFR4ywPekKSUFKnTsoq7qEqCc/khJflOBezE0f3iPhj8B8oaYs6mm
         AL8Q==
X-Gm-Message-State: AC+VfDzLlaqK1C1Un73vm/QKfpPbIrXOzZZ2nEBke3EgSGH3u3L/q8zD
        rUVNIS2Ec03upRjdT3otX8yHrfRMc2VeNn0WTEBUBKXPA80VS1+BuxnDOTaTYmIvMe+nX3XlWaS
        RGc4Ej+khzFwXpgN8kwkB/viv
X-Received: by 2002:a19:4f18:0:b0:4f3:a87f:a87b with SMTP id d24-20020a194f18000000b004f3a87fa87bmr3504053lfb.39.1686561339851;
        Mon, 12 Jun 2023 02:15:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ692EK075LkrM2aK7Sk6hg48xxbKzREkGNPfKmmEece5RfX1J3soc0tEyP1ciiAPpRBlBrJbQ==
X-Received: by 2002:a19:4f18:0:b0:4f3:a87f:a87b with SMTP id d24-20020a194f18000000b004f3a87fa87bmr3504044lfb.39.1686561339637;
        Mon, 12 Jun 2023 02:15:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b003f42328b5d9sm10745958wmi.39.2023.06.12.02.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:15:39 -0700 (PDT)
Message-ID: <15095aec-4ed3-c16b-55b3-e7122652a897@redhat.com>
Date:   Mon, 12 Jun 2023 11:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] memory tier: remove unneeded
 !IS_ENABLED(CONFIG_MIGRATION) check
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230610034114.981861-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230610034114.981861-1-linmiaohe@huawei.com>
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

On 10.06.23 05:41, Miaohe Lin wrote:
> establish_demotion_targets() is defined while CONFIG_MIGRATION is
> enabled. There's no need to check it again.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/memory-tiers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index dd04f0ce5277..a516e303e304 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -366,7 +366,7 @@ static void establish_demotion_targets(void)
>   
>   	lockdep_assert_held_once(&memory_tier_lock);
>   
> -	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
> +	if (!node_demotion)
>   		return;
>   
>   	disable_all_demotion_targets();

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

