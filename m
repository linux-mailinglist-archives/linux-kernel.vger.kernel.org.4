Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA1679956
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjAXNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjAXNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE157EFD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674567315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+49GU/bWvRMCUzhe+Y9CTW+q6X2/aURqYv1fh7nN+o=;
        b=M1G8qdTQR2PdVG3Y81PB5xaHJY6y+6Vo0R+8yrxTFZt/rnmpG84kHFq97tt3EVeDBe4z84
        swTxnwYIHPkelpqPeT8YK0GPq6qDKQr7YHBNSt3mIeI8l+ZcXvooPWYeYIieF8T5uumWs/
        xd50JVL34W0pU9ZxpBUVKehC+vXgaXE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-8TsDhN3oMhi2apjCWjymFw-1; Tue, 24 Jan 2023 08:35:14 -0500
X-MC-Unique: 8TsDhN3oMhi2apjCWjymFw-1
Received: by mail-wr1-f70.google.com with SMTP id e37-20020a5d5965000000b002bfb4cab735so90158wri.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+49GU/bWvRMCUzhe+Y9CTW+q6X2/aURqYv1fh7nN+o=;
        b=DDX8kitErnszsNYsX/XKQptK+HZG9DD8eY8DDmUMETemna5iRFu8Iw/FV3UVCCn871
         xiQsRwsIy9ZI9D0abzVJ+mXSnEKA0cgo3vdliP1lah/KTWDUMp5Iqp9zpltUv99fizrS
         +Ty8ZCw0MoeZlNJ2X9ibH7spEfXA82PXIq3VqOOlSgyx3ZArJh6lr9yggbQHiWg3Dq+S
         k4p1ZFuJot/F8nfIFe0w+KagoLT80ewjBmsp68upescbxZQgrMOhMbJY2DhV7yks7nEc
         q4pfdq046Qrqmb4WmYuAoJsytl3gK6X92kzvL7BvhSFktPyRz3Y8Z3TRDbZpSQXIqO/B
         XTaQ==
X-Gm-Message-State: AO0yUKWT4WkFCU86Y4DfXQzM+sXQPWueUzjYPvzwAAv3SfJRwjEqmaCN
        eLOLz08EMXGW9sVkek6jq6IqahDHghOTPFnMnmG6ohO+FkZjEz7pkfQnpIRzeu8kCXp0tB91TN0
        joaJpBfHEsfqvVVd7zbK9Qgcx
X-Received: by 2002:adf:cd81:0:b0:2bf:b1a1:efd1 with SMTP id q1-20020adfcd81000000b002bfb1a1efd1mr1835782wrj.1.1674567313538;
        Tue, 24 Jan 2023 05:35:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/1xONmKmEswh8jWkK0YJc1PVGI0yGZMBR0M8Flc4oZo8a+s4iuTABU8VTpp7zxi7od0H5P3g==
X-Received: by 2002:adf:cd81:0:b0:2bf:b1a1:efd1 with SMTP id q1-20020adfcd81000000b002bfb1a1efd1mr1835768wrj.1.1674567313259;
        Tue, 24 Jan 2023 05:35:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d690e000000b002bdd96d88b4sm1861572wru.75.2023.01.24.05.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:35:12 -0800 (PST)
Message-ID: <c253e119-d5d9-df22-e885-60b153ae5bf7@redhat.com>
Date:   Tue, 24 Jan 2023 14:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123173007.325544-1-dhowells@redhat.com>
 <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
 <Y8/aSZBVVF7NpDQ0@infradead.org>
 <0c043cfb-2cdb-8363-2423-d1510006fc06@redhat.com>
 <Y8/eAEfzOICZ+PSo@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8/eAEfzOICZ+PSo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.23 14:32, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 02:22:36PM +0100, David Hildenbrand wrote:
>>> Note that while these series coverts the two most commonly used
>>> O_DIRECT implementations, there are various others ones that do not
>>> pin the pages yet.
>>
>> Thanks for the info ... I assume these are then for other filesystems,
>> right? (such that we could adjust the tests to exercise these as well)
> 
> Yes.  There's the fs/direct-io.c code still used by a few block based
> file systems, and then all the not block based file systems as well
> (e.g. NFS, cifs).
> 
>> ... do we have a list (or is it easy to make one)? :)
> 
> fs/direct-io.c is easy, just grep for blockdev_direct_IO.
> 
> The others are more complicated to find, but a grep for
> iov_iter_get_pages2 and iov_iter_get_pages_alloc2 in fs/ should be a
> good approximation.

Right, iov_iter_get_pages2() includes vmsplice() that still needs love. 
Thanks!

-- 
Thanks,

David / dhildenb

