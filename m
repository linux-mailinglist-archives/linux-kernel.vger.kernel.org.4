Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861436F42D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjEBLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEBLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CD5260
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683026866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1xWxQUPrqXW2bGySEuDkOkWRAsXj0s5JI7VBrKLuwQ=;
        b=LMhHuCTOsstP2FnleLhanaZUKWKafnEppeKP8eTD/5+HL1q1LMcBg2QGHf4DBAWoNowUvG
        BzCCr8v/8KBLzuC517loU2eAu1RGJTjfi9WzyczI2QIjlMDfaQfAhRUepS/0fB/+VeoDTe
        kv/0IClE3uRP/fmJ9vXtTJr1C9eSZeg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-R9CBRYLxMdiGOMlp7m9dsw-1; Tue, 02 May 2023 07:27:44 -0400
X-MC-Unique: R9CBRYLxMdiGOMlp7m9dsw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f625d521abso2157974f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026863; x=1685618863;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1xWxQUPrqXW2bGySEuDkOkWRAsXj0s5JI7VBrKLuwQ=;
        b=Jy6wQAHVeDDCsab2/G6dfczZQg69wdkdYtphT2Oia3Fhf3Z07mm4yDnpbFTlEOoako
         QhoBEwG+0fGf5BX+Lrhc2iNpwKAK5FfAl5SHl459DdErBLM2ThRaoDS95sVcpqtYNOON
         ECZVRxF1I+CIU9MoUAwUPaGGvtBtvoECCB+qa7cg/r15YGXeT5x7/rzLfquVZUVjjCHL
         T2cX5uCfspveCsagyOhBW//bz2U2BpD9DpkBKUKkaqicy3h8UyFj61G884WqzpCM146a
         j+GnaB8WV9/iSJ1Cr3Pp0vq1HflTYO6X04BWzc/TIZRfcYpMJO9r7lG0Kco8ssoAt+Oo
         AuIQ==
X-Gm-Message-State: AC+VfDy4U75QVh1euU4jsQWK20x0bDebX3MEKWMlr2yRcLlwq4JDzas/
        MDm+NYxexnEvss7RSlri3LthZXNpPy8lnCmH891RoAnmQxFTPZTDEyhDolyXJ+LVT+ozj1ha2Sq
        p57sTCCFHi9hav7cYtOmPlIju
X-Received: by 2002:adf:fac8:0:b0:306:36ee:3c17 with SMTP id a8-20020adffac8000000b0030636ee3c17mr1491307wrs.71.1683026863591;
        Tue, 02 May 2023 04:27:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BZQJgC+V3WzGUyoEJ6zZCSeZcJ7b9ZWkx8TUXcEPQ1lZk5m3i7yEcnB6gve9DXP+2P5Jswg==
X-Received: by 2002:adf:fac8:0:b0:306:36ee:3c17 with SMTP id a8-20020adffac8000000b0030636ee3c17mr1491293wrs.71.1683026863240;
        Tue, 02 May 2023 04:27:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm30878929wrx.2.2023.05.02.04.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:27:42 -0700 (PDT)
Message-ID: <5574983a-3b32-f519-9012-a66b319fc6a8@redhat.com>
Date:   Tue, 2 May 2023 13:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] mm: change per-VMA lock statistics to be disabled by
 default
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, lstoakes@gmail.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230428173533.18158-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230428173533.18158-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.23 19:35, Suren Baghdasaryan wrote:
> Change CONFIG_PER_VMA_LOCK_STATS to be disabled by default, as most
> users don't need it. Add configuration help to clarify its usage.
> 
> Fixes: 52f238653e45 ("mm: introduce per-VMA lock statistics")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   mm/Kconfig.debug | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 6dae63b46368..a925415b4d10 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -274,6 +274,12 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
>   config PER_VMA_LOCK_STATS
>   	bool "Statistics for per-vma locks"
>   	depends on PER_VMA_LOCK
> -	default y
>   	help
> -	  Statistics for per-vma locks.
> +	  Say Y here to enable success, retry and failure counters of page
> +	  faults handled under protection of per-vma locks. When enabled, the
> +	  counters are exposed in /proc/vmstat. This information is useful for
> +	  kernel developers to evaluate effectiveness of per-vma locks and to
> +	  identify pathological cases. Counting these events introduces a small
> +	  overhead in the page fault path.
> +
> +	  If in doubt, say N.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

