Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24AD694BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBMPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBMPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3251F497
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqQFqbt2uDKkNjjudGw6jBGBdW/uqCcypE/3jIGrizI=;
        b=LjsiVkvGHAuRMCzYH6KCjlH6F3zd1KX4Hf1Ms6A3y1yFTJhsJXtoJFKGPqRK0RUXVz0Efc
        w0rht2sgxHkklBZq3Y8xlXz8AfjRHS5rn6ZA085tUeEkal5gsPHIFUT7espoT1wxc7GC5B
        VGE/X9ZHK9pqexBjEf6fWA4kbGuIU0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-N9JEEpSXOPCzqAZ2fCZqWA-1; Mon, 13 Feb 2023 10:52:59 -0500
X-MC-Unique: N9JEEpSXOPCzqAZ2fCZqWA-1
Received: by mail-wm1-f70.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so9348457wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqQFqbt2uDKkNjjudGw6jBGBdW/uqCcypE/3jIGrizI=;
        b=Ladg9sYyMUESp54Er98pRhtbRfdNafUx3ovZBlrdiw8xqqAUozHIs7fonjCLQ89gZq
         5hHwtUZwOvM2tYd/BECbhmimNxtR4e7SH5SXyCWggu8QEVQJ+FuYpyQHalZvW6f8cQg4
         vfGc02QPnSnvKp7geShRPm9aGpyL3lVp0DZqDS6FQDuETMo4tPPq+AcTNjuuuGIB9+kf
         0uQlchgFMRNYIOz5oRjuKX0WvTyA5VnZzihNG5PEN+hrLrZAhBvbaxy2mpcXJ87P59mJ
         X69ZyWGEkDPiSSEPHJmvLbifPBGdFXrGRAoQxkuI9ea9eZJdk3p93w8aPk58JA0GzAoQ
         +Rww==
X-Gm-Message-State: AO0yUKWWx3J9Ik2au44jvC9sVi4hQWKwdbspX/kM7kU0NjxxPedlTqoD
        RdeCvecOgIdYMExdnJjQ4uAzVR1rfTIiiVTZdwsLVmb5yrJKtsUK7lRN98iiztpq47IiR9TFxsc
        gWBv7aK3CykmdieffbAl8aRnj
X-Received: by 2002:a05:600c:1895:b0:3dc:4aa6:a8a9 with SMTP id x21-20020a05600c189500b003dc4aa6a8a9mr18805238wmp.7.1676303577994;
        Mon, 13 Feb 2023 07:52:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8Q0mH/knNLxtPiAFxRQ/iZossuaA9mVcof/DvPYMRKAMR7Igz1EFOCAYiZjx9gsdCA5TQFvQ==
X-Received: by 2002:a05:600c:1895:b0:3dc:4aa6:a8a9 with SMTP id x21-20020a05600c189500b003dc4aa6a8a9mr18805230wmp.7.1676303577736;
        Mon, 13 Feb 2023 07:52:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b002c3d29d83d2sm10913857wri.63.2023.02.13.07.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:52:57 -0800 (PST)
Message-ID: <3818e166-b4f5-6f41-8788-79be941dbf62@redhat.com>
Date:   Mon, 13 Feb 2023 16:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] docs/mm: Physical Memory: add example of interleaving
 nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230213154447.1631847-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213154447.1631847-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 16:44, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Add an example of memory layout with interleaving nodes where even memory
> banks belong to node 0 and odd memory banks belong to node 1
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

