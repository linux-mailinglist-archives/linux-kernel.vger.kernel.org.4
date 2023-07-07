Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFED74B04E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjGGLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGGLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4F1FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688730756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XJ4FXUgFkUhRIC9jXsJYhzmFiMyY6T5YwAK6lqpz2o=;
        b=PXlUg3ikuby/5e4wM77newpFEhXi+wKcVj0gUNpDSyhCGVFh9SOSVYZXmoBdVPACjT1s1Z
        Rlivjy8lxBMd18K2LsNlxGe9sbgA0e3b8j+9aM2cWDIjbVeStCgbunsh/iLFdWQjdoj2iP
        WlzMBt/WEhb4KsMU8qgllomqnsoPB/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-rRHUW52ROM6qrFqWHo2-ww-1; Fri, 07 Jul 2023 07:52:35 -0400
X-MC-Unique: rRHUW52ROM6qrFqWHo2-ww-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe4cecd66so9929465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688730754; x=1691322754;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XJ4FXUgFkUhRIC9jXsJYhzmFiMyY6T5YwAK6lqpz2o=;
        b=POUvYYD1FZ1icT955gyFb8iYsKeGJurimLmKKh1MA/9jrSIlhaWv96l0MY251HQFfU
         pibqy3FvR/bKrksMdBGRx96zRpGkOYwA3nCaC78S8Ij9bGCk8jXWycrbi3ge5ybwsw7f
         IHJFPgEc7qZfX13ELyHnnYc5ZZeeJU0rmi/og77TC3P5eV7MQkl58xXUKfbBHW2oMbAB
         Y2Q/OD82cx1oRvrtcg8c59N6RqYbxu6BFimDfhbwGXCRnFh4dO3lxX8kcRoAIXB1B2rJ
         WcHMbXadfmp3HwRdLQeq/UfTvOX3jPrwoztSVp8eZfRWMEtQ4UcSmi/SEw0xfwGDMw4T
         EcSg==
X-Gm-Message-State: ABy/qLYBk3/BO3AzPuSdJW+chx3HIqP7aNMnBNPOFqaeNomfrZYXEj1w
        PUNG4qEWhsIN+1pN067LtkGdbC61ob2xEKkWs4azMMB0pqd4hDjxmjjplLWJI+FcOTLwuEOvaOQ
        6VHL9/cTk8hJwV9bf+mcXquTw
X-Received: by 2002:a7b:c44c:0:b0:3fc:4:a5b5 with SMTP id l12-20020a7bc44c000000b003fc0004a5b5mr1144915wmi.29.1688730754145;
        Fri, 07 Jul 2023 04:52:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxvuezs98ptqWaXtveLHym86k+FjKP4gOwuZFxoAKspzxWyVgDzNTtI55hUm9XRK9UFuavNQ==
X-Received: by 2002:a7b:c44c:0:b0:3fc:4:a5b5 with SMTP id l12-20020a7bc44c000000b003fc0004a5b5mr1144893wmi.29.1688730753785;
        Fri, 07 Jul 2023 04:52:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d5710000000b00314329f7d8asm4289542wrv.29.2023.07.07.04.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 04:52:33 -0700 (PDT)
Message-ID: <df011987-289e-7923-3df6-d69c0fb06d61@redhat.com>
Date:   Fri, 7 Jul 2023 13:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] mm: compaction: use the correct type of list for free
 pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 10:51, Baolin Wang wrote:
> Use the page->buddy_list instead of page->lru to clarify the correct type
> of list for free pages.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index dbc9f86b1934..43358efdbdc2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1500,7 +1500,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>   
>   		spin_lock_irqsave(&cc->zone->lock, flags);
>   		freelist = &area->free_list[MIGRATE_MOVABLE];
> -		list_for_each_entry_reverse(freepage, freelist, lru) {
> +		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
>   			unsigned long pfn;
>   
>   			order_scanned++;
> @@ -1883,7 +1883,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
>   
>   		spin_lock_irqsave(&cc->zone->lock, flags);
>   		freelist = &area->free_list[MIGRATE_MOVABLE];
> -		list_for_each_entry(freepage, freelist, lru) {
> +		list_for_each_entry(freepage, freelist, buddy_list) {
>   			unsigned long free_pfn;
>   
>   			if (nr_scanned++ >= limit) {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

