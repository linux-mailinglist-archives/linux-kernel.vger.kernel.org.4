Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5269C5B3664
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIILbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIILbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C411B008
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8mO4V6+jC7+cyazFgx5SIaIZ4GrrkSJvMkGYj1DVsk=;
        b=itlJDE0YnTbeL/xsf4Sb2bipjiOmyAOiwCryH5xPHHNKQurqt0gkvLNa0FepCfvwqzeoVj
        daLsINVYBd2eyqFTcB0c0qX8tPluneZkSBsrcRFiv4++QWHXB9FOxiwUWdQMF9xyCYUzVg
        Mjs1gHmNr5P3QRcMkJISy1lOmco42q0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-3CA2Lg9KOPWrhtezg_bl1w-1; Fri, 09 Sep 2022 07:31:04 -0400
X-MC-Unique: 3CA2Lg9KOPWrhtezg_bl1w-1
Received: by mail-wm1-f70.google.com with SMTP id p3-20020a7bcc83000000b003b2973dab4bso2642679wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=P8mO4V6+jC7+cyazFgx5SIaIZ4GrrkSJvMkGYj1DVsk=;
        b=dkXhxpxx8sd+ANW+hpaZx3Y+5xZWxkGbodea4BFKE/du9NieBggBFjEGgySs37A/QA
         YCPpbmYDkrifXjQIfQJykf5oEjngJ/HMifJcBU9quFpcaPn1pwmWaECnU6Skbt3i+7la
         8oW27wJgzY6t9uMyqDuA2dbBRN9AmIUmuzTb2UQFZRoGLjN7avU9/zu/ogzQ8hNdATet
         SwdwKbH/hwLe6cEYwgK+jitSIvKE21b2R2a8HfU6ijb4WnYno3prZyAGrD4IakxNPwIT
         GH2W/rl1r3Ld3ZuiuoYRz8HHLq73sV2khnwBolR3RcCW8dKN03QTTRjWjf5kPpxkgDTb
         GG6w==
X-Gm-Message-State: ACgBeo0ElPKYeSlQUpWMwr7DjXv8toO1h5X+GW6nJAbXWw2qIvwQSxLO
        MEHeBCjXAy7GVh74sRDU7WTMVYnW8mGp5cZxGXNU8ODcKYJ9dQycliLCVNlUbCjOLLN8kStmWKi
        VFHTZCWsdkgvK1SfxYJwVOBIb
X-Received: by 2002:a05:600c:19d3:b0:3a8:3b06:655a with SMTP id u19-20020a05600c19d300b003a83b06655amr5127033wmq.182.1662723063241;
        Fri, 09 Sep 2022 04:31:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TfAgMHxcpdIObPHE5KB51ObDNCFmGK3bD6l24TQQxpmch5NWDx4j2npqP0ibnJCL/BeklgQ==
X-Received: by 2002:a05:600c:19d3:b0:3a8:3b06:655a with SMTP id u19-20020a05600c19d300b003a83b06655amr5127014wmq.182.1662723062925;
        Fri, 09 Sep 2022 04:31:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm307401wma.38.2022.09.09.04.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:31:02 -0700 (PDT)
Message-ID: <e908087d-bcd8-8c3e-8b64-a01b41b77372@redhat.com>
Date:   Fri, 9 Sep 2022 13:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/16] mm/page_alloc: add missing is_migrate_isolate()
 check in set_page_guard()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-9-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-9-linmiaohe@huawei.com>
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

On 09.09.22 11:24, Miaohe Lin wrote:
> In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
> caller will take care of it. Add missing is_migrate_isolate() here to
> avoid possible unbalanced freepage state.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a35ef385d906..94baf33da865 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -873,7 +873,8 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
>   	INIT_LIST_HEAD(&page->buddy_list);
>   	set_page_private(page, order);
>   	/* Guard pages are not available for any usage */
> -	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
> +	if (!is_migrate_isolate(migratetype))
> +		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
>   
>   	return true;
>   }

Do we have a fixes: tag for this one?

Can it even happen that the pageblock is isolated when we end up in this 
function? IIUC, we'd have an allocation in an isolated pageblock, which 
would be wrong already?

-- 
Thanks,

David / dhildenb

