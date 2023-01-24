Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8719679C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjAXOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjAXOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:38:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066827D6D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2x/J0bGGkJ5eISXSY0hav/Re/JEb7A0J6D4E1fdc+E=;
        b=IAwH7/TfR99q0Xm63K9rHesNxZstOiZpmPllDzHe92+tmPrvOcg5qYMEP2jDdKEaLn+FSP
        FRfsPtVXPkezLDxGGyI+iUaSEL+jgMAsWnuhwgbqG1dxtLwyuw+Dt8j4Q2/QmgsbVsASip
        SPX7UpIykexPAmLGPnlwIqZeecm94XE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-3V64sFZtPpaR-5MCO1f7-g-1; Tue, 24 Jan 2023 09:37:46 -0500
X-MC-Unique: 3V64sFZtPpaR-5MCO1f7-g-1
Received: by mail-wm1-f72.google.com with SMTP id n16-20020a05600c3b9000b003db127e03c5so838656wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2x/J0bGGkJ5eISXSY0hav/Re/JEb7A0J6D4E1fdc+E=;
        b=ReUOtg1JyP6EVHRKS9CcYizUyESs4qhmYRGMt1+zoUD/Nxt98QyMdFrQdCP3OJQ1RB
         gLYECVIUg0sSe//uOx+TpIeVOBy5OYsZhDtW53mk3WtGNZ45yDCfgzsHlM6WnpTP7JG4
         WkTKgtttkYt/FIaI2GiQkS8aUVgFL9hRdxSdhmt1kWsKB6+hcoRo/V8E0RwtKpOFw9jc
         SVbZEl8tBNrKH/bApH9u9MVi37MbgWI4o2wePwgkMWWP76rdK09TNcT1kpjlgXrlY4Zm
         /bHbMtibimB2edakjacFVz2TKfzMaCumtcWjPdG2QMgGORPOzWQnnWaIPuCgBCw1gNGh
         fcfw==
X-Gm-Message-State: AFqh2kr6iEeiRFkeL0FyiekCYq1Mx+/GU4myQPLsLY5ExSA5ldMFwI6E
        z1cma+JjVTuU8PcAXxNoIZszXkKjdo/Y7r01mv4NUyRYy6n7xT8tsM53IkmsSsSiszlk3whz6do
        k0ZnQl9ziKSXAYSOV2kMuuRy4
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr17927350wmo.37.1674571065226;
        Tue, 24 Jan 2023 06:37:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsTPiQ8xro+N8cTZHPqCpvzQVYFmoI1YAEYsyNxhplELggRoT15RtOz9oihNoQhKICc6Aksgg==
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr17927322wmo.37.1674571064886;
        Tue, 24 Jan 2023 06:37:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id t24-20020adfa2d8000000b002bdc129c8f6sm2020545wra.43.2023.01.24.06.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:37:44 -0800 (PST)
Message-ID: <5bc85aff-e21e-ab83-d47a-e7b7c1081ab0@redhat.com>
Date:   Tue, 24 Jan 2023 15:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-3-dhowells@redhat.com>
 <874093.1674570959@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <874093.1674570959@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.23 15:35, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> +#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PIN : 0)
>>> +
>>
>> Does it make sense to move that to the patch where it is needed? (do we need
>> it at all anymore?)
> 
> Yes, we need something.  Granted, there are now only two alternatives, not
> three: either the pages are going to be pinned or they're not going to be
> pinned, but I would rather have a specific function that tells you than just
> use, say, user_backed_iter() to make it easier to adjust it later if we need
> to - and easier to find the places where we need to adjust.
> 
> But if it's preferred we could require people to use user_backed_iter()
> instead.

At least reduces the occurrences of FOLL_PIN :)

-- 
Thanks,

David / dhildenb

