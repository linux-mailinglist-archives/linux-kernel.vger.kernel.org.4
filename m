Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCD677C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjAWNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjAWNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:25:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1024492
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674480257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=EbxXMhRtRiYzDy2F9fR304N9/g+oOp9PfPHLlQ9jRxzWuF/SbMUbDdFY3iAT5Gen9p/LpN
        kZpG9ti/U+wePKkWACqtbqvFmMxQfrinvB+aphtZT6d6Gbw7ng0SXlzeVIRWKsi1mRx8Zx
        ROqAE1GsUPEiKkGMv6hLOVsu4GRiJyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-YLXZ6A19MRufIO8unUcCsA-1; Mon, 23 Jan 2023 08:24:16 -0500
X-MC-Unique: YLXZ6A19MRufIO8unUcCsA-1
Received: by mail-wm1-f70.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso9419639wmq.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAf3V2MVK33/cJvKp6aHY4bpR+JdJT/jLy/3Pm1O1K0=;
        b=8RMUDvKChsdWSz3HjQxMag0Q5+Z5aG+F8fWYMByfQpO7IIF8Zc4oWT/48ylJvulmBO
         SB1ZKzmHQDFbOOy4bf4NPqlzMcC3FzZF00TwKhl/0gKxQRa6vFhrTYVf2t41C9eXsO0X
         hFFL+7WQbddiOPGylchydeZV6FWRmvV6BBkm5GTwh/mUqIp27A45PkzOqhz66tlhUTMI
         FHNmsM5OOGl617FuyN1u4/fkNz/Rp1lDpoTjiTDsAT/d24JHEHIj7EV60nPlpxhVU9UX
         VWZdc+nugxRB7U65Sff1NFbDb5ztIwYXMX50amlz9U7Lpfd70yqeK8A8R6HoBJKAXXaV
         Vwow==
X-Gm-Message-State: AFqh2kpAB7UPCABFIWiO8p4/qtPtEM/TN7bQ2EJc+oOjghvdemdjSQrx
        7icJuHaxZIjhHNck8hi4cZNZzXCzW2PmGyCcVgL6FUpy0o9TYg08Z3N09BHWuUpccKuVJSLT6wQ
        0z0jGrtUUHC3FNu2iRKxo6Jl9
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258705wru.11.1674480255378;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvSy/zF5gTuo4Pty91+hnKwsIVtv4UfaZ96iv4w0a9eQ3v+gYxG+33cMyS8lFosJqrFvgcRYQ==
X-Received: by 2002:a5d:4dc9:0:b0:2be:21fc:ae3 with SMTP id f9-20020a5d4dc9000000b002be21fc0ae3mr19258685wru.11.1674480255115;
        Mon, 23 Jan 2023 05:24:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002bdcce37d31sm33258092wrw.99.2023.01.23.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:24:14 -0800 (PST)
Message-ID: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
Date:   Mon, 23 Jan 2023 14:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
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
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3903251.1674479992@warthog.procyon.org.uk>
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

On 23.01.23 14:19, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
>> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
>> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
>> unfortunately, no reflect reality yet.
> 
> Yeah - I just came across that.
> 
> Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
> get_user_pages()?  In which case my patches only need keep track of
> pinned/not-pinned and never "got".

That would be the ideal case: whenever intending to access page content, 
use FOLL_PIN instead of FOLL_GET.

The issue that John was trying to sort out was that there are plenty of 
callsites that do a simple put_page() instead of calling 
unpin_user_page(). IIRC, handling that correctly in existing code -- 
what was pinned must be released via unpin_user_page() -- was the 
biggest workitem.

Not sure how that relates to your work here (that's why I was asking): 
if you could avoid FOLL_GET, that would be great :)

-- 
Thanks,

David / dhildenb

