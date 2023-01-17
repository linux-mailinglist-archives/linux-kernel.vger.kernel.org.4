Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9266D890
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjAQItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjAQIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55ED5B91
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673945282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TaBtCGp30bd4qdJlAJHixSF5/cb929y7jNy9iLh1Hbs=;
        b=BWZi0gmaPGdFbNGAuDWcCnqsjDMP1t1qoo90nchSXRyeEw1ixX/NIvjpzo+Fo+wZ/klRDD
        2inI6NQgRa3F2RIss8Y3XuWPR1SmDLsTNHFnXWSCCMC89tjZFJVz2b0cdsssr8M562Yxk4
        YuNE8Jc0m729PTk1GUS6uAZQO5UVuoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-6BR6wusDPuKqWX4PCCNc7w-1; Tue, 17 Jan 2023 03:48:01 -0500
X-MC-Unique: 6BR6wusDPuKqWX4PCCNc7w-1
Received: by mail-wm1-f69.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso19726089wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaBtCGp30bd4qdJlAJHixSF5/cb929y7jNy9iLh1Hbs=;
        b=iDg29hNsRJ8tOJgtiGy4Mqxt6dt88ATMSwPb32kBGV4de1a/kmV2j3+I3RgIAexpbF
         rSXXXoot0z+drDjFztEjNm7RVHUKtAepI+8tibC/fIEN7Y3hO3cEwgSb+OY3VpjWXVl2
         Shfhg+RLcpzGACYMlYimCe6IOmi8n26xTo3tNxG2/p/K6rD743nXF4tH1O7iCJDrkUSb
         GR4EOg8ZBOiFxZR3xvB4LdiOVpROxhpNbCEM4SlfBCkPc0mrPye+/2qhTPUtCRGLem/6
         Gsl1FYbZ8eqHCUzvP4rFiH6vBbMFcrDy+sMouLZSLzmci90qcWHZz7ytTUKPGF8NJ0Ql
         SjDA==
X-Gm-Message-State: AFqh2krKtRqQkqgKO4BWNrN6usmTrjwiXUIrbBpyPSGx0R9+yAeKAvpo
        S/tIf97mKdMIswx0rHYUNo3gAMY8MZCw7FbN2HPyL+MK8aAwqJDgFyOFCLF320Ddw6iwpxsM/8S
        /jnAbg1HDpMab02B9nteR4ade
X-Received: by 2002:a05:600c:1c8e:b0:3d9:e5f9:984c with SMTP id k14-20020a05600c1c8e00b003d9e5f9984cmr2452722wms.2.1673945280411;
        Tue, 17 Jan 2023 00:48:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvDDzpU1v6vQHWYN8fG5rSMIjxKzFqF3b169vbw/ZlEbBRTr3avFpJjRo1SAi5GChrfzi90Aw==
X-Received: by 2002:a05:600c:1c8e:b0:3d9:e5f9:984c with SMTP id k14-20020a05600c1c8e00b003d9e5f9984cmr2452695wms.2.1673945280046;
        Tue, 17 Jan 2023 00:48:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:f00:323e:5956:8da1:9237? (p200300cbc7080f00323e59568da19237.dip0.t-ipconnect.de. [2003:cb:c708:f00:323e:5956:8da1:9237])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003daf6e3bc2fsm9924673wms.1.2023.01.17.00.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:47:59 -0800 (PST)
Message-ID: <137f9567-411e-b411-3945-e553a57f6793@redhat.com>
Date:   Tue, 17 Jan 2023 09:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into
 iov_iter_get_pages*()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <Y8ZU1Jjx5VSetvOn@infradead.org>
 <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
 <2331410.1673945056@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2331410.1673945056@warthog.procyon.org.uk>
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

On 17.01.23 09:44, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Mon, Jan 16, 2023 at 11:08:24PM +0000, David Howells wrote:
>>> Define FOLL_SOURCE_BUF and FOLL_DEST_BUF to indicate to get_user_pages*()
>>> and iov_iter_get_pages*() how the buffer is intended to be used in an I/O
>>> operation.  Don't use READ and WRITE as a read I/O writes to memory and
>>> vice versa - which causes confusion.
>>>
>>> The direction is checked against the iterator's data_source.
>>
>> Why can't we use the existing FOLL_WRITE?
> 
> Because FOLL_WRITE doesn't mean the same as WRITE:
> 
>   (1) It looks like it should really be FOLL_CHECK_PTES_WRITABLE.  It's not
>       defined as being anything to do with the I/O.

Especially combined with FOLL_FORCE, this is not true.

-- 
Thanks,

David / dhildenb

