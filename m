Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9967C7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjAZJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAZJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE35D90C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674726744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=AtBDEYboMRa0IlO4EH28yBvnQGsUIUTQoTs2hN/Uy0d9iJ7Pt3HggE1zisyha075+2Sc0O
        P8Ou6lr6apXxOSmVCk8bAevxMSL7ynwO5sEVG5BGz8mEESpAy43SB6r4XqBbW1BY21xev2
        0LuEBwWUW8WpiLrB1e7UiYizMb+x90I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-eLXSJVgcO5iCFJpx6JR9RA-1; Thu, 26 Jan 2023 04:52:23 -0500
X-MC-Unique: eLXSJVgcO5iCFJpx6JR9RA-1
Received: by mail-wr1-f71.google.com with SMTP id q18-20020adff512000000b002bfc49c299dso175022wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWZYDHaST13TpclKR0o87AcgsReRxfEYg2kbamKtxjw=;
        b=s5nCUlxmwOpdflJ+RbST8JBrz6nCO6FXaTPHWnXKFrMF28bV/oYfyEv05z9q6ODlwx
         wAv1Oo6kruUKstmPXouP7AKaWLtAEV+t/4fSHoZGrsdCghR3Jyh0Czjrj/KCVw/7GfCK
         4iWRi8tFsb2Pa3PMVzYRAJPS0uQBrhJNppmQ7DIfYbzJco4wHvN3HVY3m8V+LmSJJcwu
         1oytrlvaja6YTn/ogMZdbGwWZ15hJH5dFDU/o72M0pPcmKLs3RYtE/Q7wN9O2FN5r1K8
         A9w19wxN9zsDcG218YcP5j9+qXgU+QgRNivc11A392662JI4AHcx3HO6r3Etsgp4+ZNK
         p5vA==
X-Gm-Message-State: AFqh2kriEibDTKYg5tFNWPOZd6G8ScfnbsxhwelHB4HDkuaZUBSOoKwi
        G4VayzPFxbjip5SD9TpbodTRluD+uoiPcydU+Y/1ZiIQfYHlnakzeSiTc4pORO8qkpXXA4bzlxA
        +rDXANelzNXcGqkzUcW/AAggn
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558735wrz.29.1674726742084;
        Thu, 26 Jan 2023 01:52:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt6POr1Th+z4xBilbq6MD55kPKMFdkWNrVBw8NH64BJ/rotUwhIVj/VoLFHThktbZr6ujT1Dg==
X-Received: by 2002:a5d:6e42:0:b0:2bd:fcd3:44c7 with SMTP id j2-20020a5d6e42000000b002bdfcd344c7mr29558712wrz.29.1674726741832;
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f12-20020adfdb4c000000b002bfb1de74absm839299wrj.114.2023.01.26.01.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:52:21 -0800 (PST)
Message-ID: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
Date:   Thu, 26 Jan 2023 10:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 1/8] iov_iter: Define flags to qualify page
 extraction.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2613249.1674726566@warthog.procyon.org.uk>
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

On 26.01.23 10:49, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Just a note that the usage of new __bitwise types instead of "unsigned" is
>> encouraged for flags.
>>
>> See rmap_t in include/linux/rmap.h as an example.
> 
> Hmmm...  rmap_t really ought to be unsigned int.

Not sure if that particularly matters here in practice, ... anyhow

$ git grep "typedef int" | grep __bitwise | wc -l
27
$ git grep "typedef unsigned" | grep __bitwise | wc -l
23

So chose what you prefer ;)


-- 
Thanks,

David / dhildenb

