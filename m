Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC1694BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBMPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBMPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABC1A49A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DRobMP9lFTyOx+d42PXwNgf2chEzLFnyo1NLv/1B+k=;
        b=c8vhOcR6mP2HD/bqJLZlP76fzyVeSmmPS0EsNWYPAU2hR4iAkYhBdqQdgbjONS+G6A6dHA
        1vxQyXF6oJYCBE93Qze3AoLWUa1B/5YR+ZVvC4KD8SVqAaswhen5tkKguF/l4dtQGUzuH/
        jg0vIxE88IrQA1m444LrJSAzIRGAX8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-gjx2BGKuP72ZB8sr_ilMkg-1; Mon, 13 Feb 2023 10:50:49 -0500
X-MC-Unique: gjx2BGKuP72ZB8sr_ilMkg-1
Received: by mail-wm1-f69.google.com with SMTP id bg3-20020a05600c3c8300b003e1e7d3cf9fso2886327wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DRobMP9lFTyOx+d42PXwNgf2chEzLFnyo1NLv/1B+k=;
        b=MjDyYHbGgN8zX4wgHBizqGfNJmv3NRapqRe0w2RlqzZgsWGlK0+uGgpF92CLNSiVDF
         Ki4gBjzQ3CTKjiK0JQ3MiWxiPsss1ciotS+MliSDNprgbP5VBQxCLkGH/bgahc0b6njL
         gdGrRuPYCQELP9J4Onz/dvFdBjOKJO/3by8HZiMPyj/YMw1FXp0y7eB4T1C1oxKvnK6z
         lvyNj0kzGPwOus4XaKdS99fInBPvER6mgnceS9zGFXs9pqrWsLeGxObwqUupdwSLTEOE
         gq2BPQGTHUB+hhyTc/s0mCpJ2bNl0Fn4XA6LSLTpVdC8a8f8wmseKyKG98xNMLVM+vht
         50mw==
X-Gm-Message-State: AO0yUKUz3KR+Nj75/NRDV/GePadKC/Fu9F+B+ip4PC7fDcmUI9mXja/Y
        CTo+GcNKQxvGLTJLy1cNJO4SsivLsDQ5fLgfLj+jGHJB9r5fMlCt3kSIARegYyo4k+v5YTPPmd1
        /FtWiKdvuyQi2Vp9DKYzOS5MX
X-Received: by 2002:adf:f20f:0:b0:2c5:4f48:cbb2 with SMTP id p15-20020adff20f000000b002c54f48cbb2mr6716131wro.51.1676303448319;
        Mon, 13 Feb 2023 07:50:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/7z1HvwRarE22I8DRgZXVSpvDKauYENM9qNJSPZT8aqTzhz5RxouJn81sKN7pWwJL2Ogwlmg==
X-Received: by 2002:adf:f20f:0:b0:2c5:4f48:cbb2 with SMTP id p15-20020adff20f000000b002c54f48cbb2mr6716117wro.51.1676303448102;
        Mon, 13 Feb 2023 07:50:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600011c400b002c556f36116sm3691159wrx.66.2023.02.13.07.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:50:47 -0800 (PST)
Message-ID: <3b0e92b5-4b9c-d3aa-8f30-074d538bb82d@redhat.com>
Date:   Mon, 13 Feb 2023 16:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/4] splice: Use init_sync_kiocb() in
 filemap_splice_read()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230213153301.2338806-1-dhowells@redhat.com>
 <20230213153301.2338806-4-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-4-dhowells@redhat.com>
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

On 13.02.23 16:33, David Howells wrote:
> Use init_sync_kiocb() in filemap_splice_read() rather than open coding it.
> 
> Requested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

