Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456667C8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjAZKmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAZKmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3286367D3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674729706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=B0EFAhwNbslbtxP7GyCLaYg1bTbvfQOvQ66MIxaMljxr/5BJXsz4GziPVGMHBPl8fqx3jX
        auhhnUFnwm30TCU58XoM1Y5hFRYY8QUMgb84RZc3jAZnEXOLiMhCFhhRG294m296uxjy73
        xMdmc/FF28DJ7f/ERFY2WUuxPx2+bhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-tLObk3vXM7uga8b56aLINA-1; Thu, 26 Jan 2023 05:41:43 -0500
X-MC-Unique: tLObk3vXM7uga8b56aLINA-1
Received: by mail-wm1-f72.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso334667wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSKGSRAw4zApLqZOZxojx5gSJ8OH2ShG8cSG815Lldg=;
        b=S6hBhtkaqwu1kQSytZp2DkOaDSo2YOYa7l1Ok0hdkvVO+/kmS13oKfEFDfm7vhL4ZT
         K4kTQy4BHmYPYU+l/FPMiBxaxZS91ElZkJ6t42C3qsh7tZwSbQfkmigBZ5wr7zwNDc8p
         Bg/E+YFimUtZxdIgSU/KHE84fCm+z/onSme2nU/WDx6C9ZGfffvAyrl7lZJrcZVK4FXE
         Lm1S5sG8BoWpy1vQmxhRQUaL9xLB71OKRmE8iwHycmexBZQnYpfTUPXj86O+6b4JO60W
         +Ero3PQs5DNgUBB57/1THT3ePdu81uMTFV307R6uiqM/LbJ2CsHlXQB71ZJcAfS+xUAD
         Dihg==
X-Gm-Message-State: AFqh2kpQ9Xh9okNGxAXIejNcKtfK/t3T3n4LjkTtfHBVV0VmZW73Tmox
        ke3/wwFJe4ZXKVaBXbCll6NLh9NqS111seKYmQMtrtE7OZY1qAsp/DB8PhYNcBUVtY/xtQ2ZK5S
        IplDgSpmzECOLQJwRE3o1iyv/
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303918wmn.2.1674729702027;
        Thu, 26 Jan 2023 02:41:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWhy4TGOvCPFAbQoLxK9D8awwiSNTdJq0Nz5MUw3B7wix4cF4N7mvyXVyul/6m5yzASpKTpA==
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr33303893wmn.2.1674729701735;
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003d9fb04f658sm4683254wmq.4.2023.01.26.02.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:41:41 -0800 (PST)
Message-ID: <b8082dcd-632b-bf75-061c-143cca6fa70d@redhat.com>
Date:   Thu, 26 Jan 2023 11:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
References: <e7d476d7-e201-86a3-9683-c2a559fc2f5b@redhat.com>
 <af0e448a-9559-32c0-cc59-10b159459495@redhat.com>
 <20230125210657.2335748-1-dhowells@redhat.com>
 <20230125210657.2335748-2-dhowells@redhat.com>
 <2613249.1674726566@warthog.procyon.org.uk>
 <2638928.1674729230@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] iov_iter: Use __bitwise with the extraction_flags
In-Reply-To: <2638928.1674729230@warthog.procyon.org.uk>
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

On 26.01.23 11:33, David Howells wrote:

> Interestingly, things like __be32 are __bitwise.  I wonder if that actually
> makes sense or if it was just convenient so stop people doing arithmetic on
> them.  I guess doing AND/OR/XOR on them isn't a problem provided both
> arguments are appropriately byte-swapped.

I recall that __be32 and friends were one of the early users of 
__bitwise in the kernel. And the reason IIRC was exactly that: detect 
when no proper conversion was performed using static code analysis 
(Sparse). While some operations might make sense, the abuse is much more 
likely.


LGTM, thanks!

-- 
Thanks,

David / dhildenb

