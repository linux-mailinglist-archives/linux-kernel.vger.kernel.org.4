Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78624695E61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjBNJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjBNJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB7EC6C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676365665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXhjJZ2GdnHCbU45RiKd1H4tJiPK57eePtUK3Fm9rk4=;
        b=gygpW1m8ETDkwu0jtPdgUp1geawkq/isu4lEGeoIVpgkBsVYZUHWkOEnMe4fNV4VYPVNJH
        NqQw41h9+jj56aKuWL8GdUE4NCyOjygRRQ9LGm6g7Eg7htVAYWT0HKsm+PbH+OjZCSDILE
        CfdcTmCC7QYEssuJXiBvNTqYMJiZMs0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-1yWmBRUbOHCaxK5BuD3jMQ-1; Tue, 14 Feb 2023 04:07:44 -0500
X-MC-Unique: 1yWmBRUbOHCaxK5BuD3jMQ-1
Received: by mail-wm1-f71.google.com with SMTP id l21-20020a05600c4f1500b003e00be23a70so10639394wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXhjJZ2GdnHCbU45RiKd1H4tJiPK57eePtUK3Fm9rk4=;
        b=Li4x/w06ydTpDAorkSK0slEO/ppbHNNaTbJkK5LzXLWYtg7us26I5RX7FNuFCDGZ/U
         zgTMgcvfXh3iBNKRaLfkHpuwG/c1rhuslRDaosOZgGm2naUFPLasCvCWLcmUFv/3Yz6x
         zciHc3OzV3Eo2kW+EAUr/keHo8JnTahMybbrPHCA4wBT3shQUmTMSsoMM9+9QhdVb6Jz
         jh+DSfdqPyRFmnGM/yYRBkUnLnRnQiI6dcTrIczieSH5gmD9pXwz0/9a//rWgLF4O3pq
         d747ipS8LWF92ELfwzn8uhZKt/mLI7mqjvyjI4+ftLl5CQ65Jl4ioaA+32XDI3IczAVZ
         HpIQ==
X-Gm-Message-State: AO0yUKUvVLjT0bfKWQaC81TPhJJ1EwLHmtEQXH9NHSQ7QFWc+TXGD2H2
        A+3ml5L2v7kUNJQ1Pi5uc9KGqOy4Mwk6SPzJWO1AwC2xmFeVGtccNRZeKdy5E12Oipx11ND/UEu
        h/Kco1y42dAPFWTaOeGmdx0gW
X-Received: by 2002:a5d:46d2:0:b0:2c5:4b93:1f4 with SMTP id g18-20020a5d46d2000000b002c54b9301f4mr1673347wrs.58.1676365663048;
        Tue, 14 Feb 2023 01:07:43 -0800 (PST)
X-Google-Smtp-Source: AK7set9tKSS15UUZyB55NrmYIY9oMjNB9gXG+WnOns1nL3MBlxyjxsKbgGdScR9/PpTqD72Icq0ULQ==
X-Received: by 2002:a5d:46d2:0:b0:2c5:4b93:1f4 with SMTP id g18-20020a5d46d2000000b002c54b9301f4mr1673316wrs.58.1676365662594;
        Tue, 14 Feb 2023 01:07:42 -0800 (PST)
Received: from [192.168.3.108] (p5b0c60e7.dip0.t-ipconnect.de. [91.12.96.231])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b002c569acab1esm265077wro.73.2023.02.14.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:07:42 -0800 (PST)
Message-ID: <75d74adc-7f18-d0df-e092-10bca4f05f2a@redhat.com>
Date:   Tue, 14 Feb 2023 10:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/5] iov_iter: Adjust styling/location of new splice
 functions
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230214083710.2547248-1-dhowells@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214083710.2547248-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 09:37, David Howells wrote:
> Hi Jens, Al, Christoph,
> 
> Here are patches to make some changes that Christoph requested[1] to the
> new generic file splice functions that I implemented[2].  Apart from one
> functional change, they just altering the styling and move one of the
> functions to a different file:
> 
>   (1) Rename the main functions:
> 
> 	generic_file_buffered_splice_read() -> filemap_splice_read()
> 	generic_file_direct_splice_read()   -> direct_splice_read()
> 
>   (2) Abstract out the calculation of the location of the head pipe buffer
>       into a helper function in linux/pipe_fs_i.h.
> 
>   (3) Use init_sync_kiocb() in filemap_splice_read().
> 
>       This is where the functional change is.  Some kiocb fields are then
>       filled in where they were set to 0 before, including setting ki_flags
>       from f_iocb_flags.
> 
>   (4) Move filemap_splice_read() to mm/filemap.c.  filemap_get_pages() can
>       then be made static again.
> 
>   (5) Fix splice-read for a number of filesystems that don't provide a
>       ->read_folio() op and for which filemap_get_pages() cannot be used.
> 
> I've pushed the patches here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract-3
> 
> I've also updated worked the changes into the commits on my iov-extract
> branch if that would be preferable, though that means Jens would need to
> update his for-6.3/iov-extract again.
> 
> David
> 
> Link: https://lore.kernel.org/r/Y+n0n2UE8BQa/OwW@infradead.org/ [1]
> Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.com/ [2]
> 
> Changes
> =======
> ver #3)
>   - Fix filesystems/drivers that don't have ->read_folio().
> 
> ver #2)
>   - Don't attempt to filter IOCB_* flags in filemap_splice_read().
> 
> Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
>

You ignored my RB's :(

.. but unrelated, what's the plan with this now? As Jens mentioned, it 
might be better to wait for 6.4 for the full series, in which case 
folding this series into the other series would be better.

-- 
Thanks,

David / dhildenb

