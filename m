Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E815679BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjAXOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjAXOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DD46D4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674570590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vo8komcAdWdEd2HeYlqbGambAOZnw7KhmFAc4ykFVR4=;
        b=RXb75rPObeJqtns3DpgAig/eMqWpHltYWN1FC1vwtADroJeEOHFaNYtSpOvC0+NU4ngzie
        VB8KMThRWLdve0/PwQ0vTzdHetgg8wKpc0/kgdjBL/3mgEh/Q7AZ8qPx3urt8p5FWoJje4
        GREwZKB4QPzDMzKsDsShDCQGpR5KmgI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-221-XceqzRpLN_mvZa7eJ3vk4Q-1; Tue, 24 Jan 2023 09:29:49 -0500
X-MC-Unique: XceqzRpLN_mvZa7eJ3vk4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 12-20020a05600c228c00b003db09699216so4005959wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo8komcAdWdEd2HeYlqbGambAOZnw7KhmFAc4ykFVR4=;
        b=m+Cx5CgaPjGAPr26CidaOt+34ajvJ3pO4YjU5/EhuViAd5MK+Ib/V44YzKwsJvHW0W
         FV7YccARY1tkK+d4gexhPGRYaJDFrILPKTq646TZ8BJ4aDBa14Bpsefm6QQ20zQjIi9v
         V+XW5YmBU25jZIQ01aSn6iLQ9QAmk2yZR7vrV7WEzoNd2yf3hJmqzA1jmGtSx9FjpwUv
         gczwJmWvkBZhF/QWT6XUl4HB/pmgQqhbDLkhMhAnUjVvvnpyG6mZwUNSE5eUK9Y+7Np+
         deY6XXsEFzfLxow9CGzetNGnyuVxpyVWed4BJrHIt9lZihT7IML/5B8Bf3auYvlDawIZ
         a4iw==
X-Gm-Message-State: AFqh2kr44MiwlZxdl5W2qm54r4yxs/apsCqhjK+wKNuvhv6rqCbeG9Zb
        fSWH7XmdkJ0mc1FaWfoYgw9DQKxfiog7DQCPPlrof9QmeOXgvVUDX8osSSi5oDj71qDeYHtUFIJ
        n0AXja/9rHqdPJrOoox0m3CAY
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr28401075wms.23.1674570588489;
        Tue, 24 Jan 2023 06:29:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsyFqAD6TPt3fgk8iAn3mdUhNKxrUDu7vp8H7TLkDfIF7R+AaPkLbQzT2K7yCwghdLrRYin7w==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr28401055wms.23.1674570588170;
        Tue, 24 Jan 2023 06:29:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm18913172wmg.27.2023.01.24.06.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:29:47 -0800 (PST)
Message-ID: <76a0dc81-7fd6-a923-f22c-22b0be12a709@redhat.com>
Date:   Tue, 24 Jan 2023 15:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 04/10] iomap: don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-5-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123173007.325544-5-dhowells@redhat.com>
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

On 23.01.23 18:30, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9804714b1751..47db4ead1e74 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   	bio->bi_private = dio;
>   	bio->bi_end_io = iomap_dio_bio_end_io;
>   
> -	get_page(page);
> +	bio_set_flag(bio, BIO_NO_PAGE_REF);
>   	__bio_add_page(bio, page, len, 0);
>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

