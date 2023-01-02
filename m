Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699D65B191
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjABL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjABL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E71BE9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672660517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eaac0zUTFuoCsKmnVZyZkkTalHPLFZnYU3aunXSpmFU=;
        b=MqPHmPKK5BZ0e1pZmUXX4bugeSttZh8WYJIjuVVfJf87CG2usETeKp2qedKFZTG2HqEz6L
        4pGDHLt7vFFQ0jUq/gKGb185RQzVbEMVa+GsjFlZKoTh3vpJS1LgVDdMPS7xbp1DJ3JgoX
        xB5kkQjEuhmrRX/+Z7CwRqtTETdO7hI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-IjmIwAkQNgOeX0Dxf5xiYw-1; Mon, 02 Jan 2023 06:55:16 -0500
X-MC-Unique: IjmIwAkQNgOeX0Dxf5xiYw-1
Received: by mail-wm1-f71.google.com with SMTP id n8-20020a05600c294800b003d1cc68889dso6260793wmd.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eaac0zUTFuoCsKmnVZyZkkTalHPLFZnYU3aunXSpmFU=;
        b=HiesMXlbW6bYZEQB97VTYFU428/n9C27xoRyzDbHs4xSmfepMm3YnO3yHC+gzYcTBm
         PmHmiqX7DzE0ohH0bJpCG7UhudJCU0tlaMAsvY72cXlYM3MtPB8AE2Bf5Vdo9xIvMBs1
         O02Bx/c5y3p62rDRof2tINuFQlkUW1bU+Q5Z/woFW+y0ctLyazEzW085tJkZOD+hQzqo
         nVZS/n8HZqeVYgyqOXLMrC2KbZ5QWs39xWVAF4zZAwQu0zf/5XWKlEtQfNPazkyzO2Jo
         nH9KcDEv4dZVvad0VGe8nT8Fym1pUfhYQD1vXGhJYlANENvs7+qJeLKlFfJP747fxBCS
         xNfw==
X-Gm-Message-State: AFqh2kpRiw/ymaOv3gEHMS1xRe4Lfyi6b5OUtZWx0mWKTkKVBtHC8swd
        +fEO45FMMtffSDPwP8zrakDqNG3MtqJcrkGwI2TY2erIv69aDvsi7gyJq82MasgpgR6TqUbcclT
        AsFzRBDPS2YE1b1vsK2+GdA6O
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id x1-20020a05600c21c100b003d345c6b641mr29176979wmj.22.1672660514912;
        Mon, 02 Jan 2023 03:55:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDuiuqHRAe9GS9nG47HPQ0j1PQIPn7y+bhjAPJ5nptWGKJbmyvUyS9SjWvkI8qPZ9ZsVyNeg==
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id x1-20020a05600c21c100b003d345c6b641mr29176970wmj.22.1672660514646;
        Mon, 02 Jan 2023 03:55:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003d96efd09b7sm39870584wmp.19.2023.01.02.03.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:55:14 -0800 (PST)
Message-ID: <874fd614-23da-c9b6-95f5-41b544b8df18@redhat.com>
Date:   Mon, 2 Jan 2023 12:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Soichiro Ueda <the.latticeheart@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, akpm@linux-foundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kalutes@google.com, mhiramat@kernel.org, cwd@google.com
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
 <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
 <444735fd-7076-7bd3-dc5e-7135a7f3a95c@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio_balloon: high order allocation
In-Reply-To: <444735fd-7076-7bd3-dc5e-7135a7f3a95c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.12.22 06:31, Soichiro Ueda wrote:
> Hi David.
> 
>> How does this affect page migration / balloon compaction etc?
> 
> I guess this patch doesn't affect balloon compaction. When allocating
> pages using alloc_pages(), it skips compaction by masking out
> __GFP_RECLAIM if the order is larger than 0.
> 
> As for page migration, in the current implementation it migrate a
> 0-order page to another 0-order page. With this patch, it may migrate a
> high-order page to another same-order page.
> 
> But I noticed that the migrated high-order page is handled as 0-order
> page in virtballoon_migratepage().
> 
>   >     balloon_page_insert(vb_dev_info, newpage);
> 

Yes, I think suspected that it's broken.

We also might want to handle OOM accordingly by splitting the page and 
retrying migration. Almost nothing should stop a balloon page from 
getting migrated.

One thing to try is allocating a higher-order page and immediately 
splitting it into base pages, and enqueuing base pages only. Only 
inflation would be faster, because you could only deflate base pages.

> We should put the newpage into a page list of the corresponding order,
> like this.
> 
>       balloon_page_enqueue(vb_dev_info, newpage, order);
> 
> I'll fix it in the v2 patch.


Note that I have some more concerns:
* We might end up stealing all higher-order pages from the guest instead
   of eating all of the "small" leftover pieces first. This might be
   undesirable. We discussed this in the past in the context of hugepage
   ballooning [not able to locate the abandoned patches quickly].
* PG_offline won't work as expected anymore and result in kdump reading
   inflated memory, which is undesirable. One workaround would be setting
   PG_offline on all base pages, but this needs some more thought.
* How are we handling a scenario where we are requested to deflate e.g.,
   a single 4096 KiB page but we only have higher-order pages allocated?
   I suspect you would over-deflate right now, which is undesirable.

-- 
Thanks,

David / dhildenb

