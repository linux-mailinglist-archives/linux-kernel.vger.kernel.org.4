Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA88E6A68F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCAI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCAI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7203800A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677659251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4y49hGQC6F9+PK0Pkd3K9hehgxio6wnKkyFuIEbQX1E=;
        b=edGJeAo9sCoPu5f9Je2tiULN+nd74B4tudHacnUsRlo7kVZu68rUg+Z5+P7osIY1CWO+uB
        Yn1ovQU3Qw00vfsTdCwEqM+r+WE9shW6jaBMdXnFiKCtB9dGBS4TZyiRqB2FVq89sgz1bm
        Myap7hQPUlwQYb7pHylAZWF3KnzPKcw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-A-ZTxZSKOTqkVqWjsN4y3w-1; Wed, 01 Mar 2023 03:27:30 -0500
X-MC-Unique: A-ZTxZSKOTqkVqWjsN4y3w-1
Received: by mail-wr1-f70.google.com with SMTP id k6-20020adfc706000000b002c716981a1fso2323141wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y49hGQC6F9+PK0Pkd3K9hehgxio6wnKkyFuIEbQX1E=;
        b=EzIL+7MtKFll5dMYdBYqKTF+/YvKyzaPEYE60ygaJNgKRzxMvksBztTbEljGJnLYd2
         6OQg0hz7ZDJDi12IAugqI7IKdKcXP0NTmi78+WASCQAC9qb9xPTJlD6OWSDMk2kdND+N
         tEJM8tDJiz/uxRfbbaEJ2nc8PFkL7N/jVzQ0Etl8oTEDAcmxwQIeZuCpqc8U5giW+cSQ
         bDdcrlhnf83AXnzm9tS61uvf9hD8VJLFPinheD9yAIwPJIIyXrgln/MjIOe8///R5xRW
         8X0jukCBX2eVpeuUKBhm8pMBl9ph9R3IjyoXSWZAnFxHltU73kmfTOkaheAvnHITJUQB
         Wbzg==
X-Gm-Message-State: AO0yUKXPJveCTCHVUperVRA3zgjYj1iyXsie0P0fpz2cvNRhkN7r34nZ
        EwnPqF466q9kxhFx4qBichyRzfTkgCCl1Td62nPYtPPAGBKQUbsEhArw1yeSSsetTPEnQVTGR9y
        VyuQi7a1c6WH6lSLQvjShdA8B
X-Received: by 2002:a05:600c:468a:b0:3eb:39e2:9156 with SMTP id p10-20020a05600c468a00b003eb39e29156mr4289316wmo.5.1677659249077;
        Wed, 01 Mar 2023 00:27:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+ZwlNWGD0Ltr1w1w+14UPkJI4sbgpAePvQ00hy0xJHTlxxHNKQRjYXJXNNDiv1jJKgcwTsUw==
X-Received: by 2002:a05:600c:468a:b0:3eb:39e2:9156 with SMTP id p10-20020a05600c468a00b003eb39e29156mr4289305wmo.5.1677659248764;
        Wed, 01 Mar 2023 00:27:28 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003db0ad636d1sm21138374wms.28.2023.03.01.00.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:27:28 -0800 (PST)
Message-ID: <a45e3136-bc88-2de2-4127-62e103656242@redhat.com>
Date:   Wed, 1 Mar 2023 09:27:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] mm: document FAULT_FLAG_VMA_LOCK flag
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, error27@gmail.com, willy@infradead.org,
        Liam.Howlett@oracle.com, jgg@ziepe.ca, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com,
        mathieu.desnoyers@efficios.com, pasha.tatashin@soleen.com,
        laurent.dufour@fr.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230301022720.1380780-1-surenb@google.com>
 <20230301022720.1380780-2-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230301022720.1380780-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.23 03:27, Suren Baghdasaryan wrote:
> FAULT_FLAG_VMA_LOCK flag was introduced without proper description. Fix
> this by documenting it.
> 
> Fixes: 863be34fc093 ("mm: add FAULT_FLAG_VMA_LOCK flag")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/all/20230301113648.7c279865@canb.auug.org.au/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Fix cleanly apply over mm-unstable, SHA in "Fixes" is from that tree.

Okay, that should be squashed then. LGTM.

-- 
Thanks,

David / dhildenb

