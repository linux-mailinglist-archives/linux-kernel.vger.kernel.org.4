Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF6725D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbjFGLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbjFGLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB019BF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686137938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xl5lF3cd+Vrp8y6V9jsp3fA29TQ9zzWfur5sh5x50ew=;
        b=dJzz83yieToRaLhR6cNfuV8Ij4QgyzLFEU2efBfmqDwd/DB2kcPYXq7fjUNmm9+GQfQ/y4
        0x6OAW1nWLEoHNgVCmNTltJ2hNo/JrVbErWyn7ERgm2Ka/a3zEQhSRJZ+P/YmUikeQCX97
        h3+/TyqGVu6Mvw3G7Ggcm+rMuLQNqJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-b7gf7H7jN6uS8iR7rs1LpQ-1; Wed, 07 Jun 2023 07:38:57 -0400
X-MC-Unique: b7gf7H7jN6uS8iR7rs1LpQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7eb414fcbso7619645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137936; x=1688729936;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl5lF3cd+Vrp8y6V9jsp3fA29TQ9zzWfur5sh5x50ew=;
        b=XsI7NEc7IfJzKtY0dkBkBCYsnmxuleEo4F9B8vbKU/eiALLRet7Wsz+HwOhT9vpzFP
         ScyQhCoRICHNdKplZfrvfDoNh4jZNB88SbPlu2ziExkIKksLGBrxSMZMcr8H113zU7rl
         wMWamHjHBjBJBniT/IZYgr4huaRSAYvFMMGu/bgg66H0d53y5+/pgokpsgP8X21JGYC0
         OU4RX55iIZhParesy4+r4eMAzmdzUZYeLNxS4RIRWjyD0qvS7kT7i4FejUXSQqurFoGl
         dTx/8agMYoEvK7QjVW/sL2MrXcgTWjHc4laZQ0bPVLZRujn+d4d0IQcvI7lyKA/WnbRG
         re2Q==
X-Gm-Message-State: AC+VfDwsIdDeRbyWUexD6huuPnDopbWUkVP4IihcriH2xOzKgQin89Ra
        fXTrXVco6FN2yFtmQWd6gRq4i8edDXbW2RQV5KVQMicU7/MJaazfqecbBh34cRVSOFY5lBrywLk
        fccjfHy5iXQYCYT2cO5TA267a
X-Received: by 2002:a7b:c3d7:0:b0:3f7:34dc:ed0d with SMTP id t23-20020a7bc3d7000000b003f734dced0dmr4483082wmj.25.1686137936131;
        Wed, 07 Jun 2023 04:38:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5heuZue0wi0O7bnqMLQBR9c8uR94JGVv45Gz/7/fo4uIweaEn2r+seNTp712SXWXulwH/kcg==
X-Received: by 2002:a7b:c3d7:0:b0:3f7:34dc:ed0d with SMTP id t23-20020a7bc3d7000000b003f734dced0dmr4483071wmj.25.1686137935825;
        Wed, 07 Jun 2023 04:38:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9c00:8d26:3031:d131:455c? (p200300cbc70e9c008d263031d131455c.dip0.t-ipconnect.de. [2003:cb:c70e:9c00:8d26:3031:d131:455c])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f1978bbcd6sm7140839wmo.3.2023.06.07.04.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:38:55 -0700 (PDT)
Message-ID: <02418a3d-ce8f-0f00-ba93-06ceb3531490@redhat.com>
Date:   Wed, 7 Jun 2023 13:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] mm/mm_init.c: remove reset_node_present_pages()
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     rppt@kernel.org, osalvador@suse.de, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <d92273f6-28be-dc37-3ca5-a9579a75f8c4@redhat.com>
 <20230607025056.1348-1-haifeng.xu@shopee.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230607025056.1348-1-haifeng.xu@shopee.com>
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

On 07.06.23 04:50, Haifeng Xu wrote:
> reset_node_present_pages() only get called in hotadd_init_pgdat(), move
> the action that clear present pages to free_area_init_core_hotplug(), so
> the helper can be removed.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
> v2:
> - declare 'struct zone' within the for loop
> - fix comment layout
> ---
>   mm/memory_hotplug.c | 18 ------------------
>   mm/mm_init.c        | 15 +++++++++++++--
>   2 files changed, 13 insertions(+), 20 deletions(-)

As Michal said, we could be clearer that this simplifies the code (and 
removes a TODO).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

