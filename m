Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3E694B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBMPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBMPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:49:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57371A665
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sUpm4OM8C3gUXzYRuakEx3dra1Fn9qudKJHgMzZ+HE=;
        b=J5k5SDMHiVC13fLqJi66zV7mF0OsNP1qxx1/QWrsjBIuEFf7GMnYTmtcw6SWcl3kU0v1jq
        ViAbberKHtTZdfYrrtqbhAeucSvtZFoTf1suH8LZjAtm1rk4hV6oUeA+i+/7ow09kfDaU+
        ukYMgwLZrgVaiQuDBpflrtx6BJJ8oaE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-4F9QiT36NJ2BWQ8nRIUGQA-1; Mon, 13 Feb 2023 10:48:46 -0500
X-MC-Unique: 4F9QiT36NJ2BWQ8nRIUGQA-1
Received: by mail-wm1-f69.google.com with SMTP id a20-20020a05600c349400b003dfecb98d38so9363419wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sUpm4OM8C3gUXzYRuakEx3dra1Fn9qudKJHgMzZ+HE=;
        b=CQGWv+kOno+eusDaXP3j3iRuOBKx1JvEjR2Qfr/1M/XBerqJ93psUlav355sKFigyj
         XW3D1tj3VgXerTOOIGce73OFPCG+TBqbfqlN/Mk4RtbCi3g5YxxM1hiTegMGHRcHkEdb
         Ewtoam33qmxj9OteC0WtgndUXwoXYPnUZohV5V26E1/AroquU9VXNiQvfNTQ8aIkQqce
         UgCxFVCcaXo/kiQ2DguHqZS719u9PzC1szxG8ZAzdPtTQF8WrFWXG+xas5dcFb8Fqr1I
         lc7qcO9+XefxJw9EEnRsrqo6jIwQoVCNZ+pIFRyqmpGLNnKxfTbKu8V5g8O5Ed+6YfS1
         IbhA==
X-Gm-Message-State: AO0yUKWUv4skNFvgLaD+9INY62GajFSwW8QhtDLdJaL+dgB63QSnIDIC
        ySOQZO4RYQy7uZPKpvk3HGr77m1QioDIdZsBmAJaFhvSXqthlEYZOpNkbDLnMPl7WrWL/pR/NzB
        Rq5thjYJI0+mvMdoqW2VyJWM+
X-Received: by 2002:a5d:6e06:0:b0:2c3:e4eb:3c12 with SMTP id h6-20020a5d6e06000000b002c3e4eb3c12mr19179596wrz.64.1676303325548;
        Mon, 13 Feb 2023 07:48:45 -0800 (PST)
X-Google-Smtp-Source: AK7set8PhYzgJ6stajpIQWACA5seKzBS2Et14vSbRKWgVli14Fv6m1xvKOhu8wS5pXGt1KWXHAEmJA==
X-Received: by 2002:a5d:6e06:0:b0:2c3:e4eb:3c12 with SMTP id h6-20020a5d6e06000000b002c3e4eb3c12mr19179579wrz.64.1676303325265;
        Mon, 13 Feb 2023 07:48:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002c55efa9cbesm1321826wrr.39.2023.02.13.07.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:48:44 -0800 (PST)
Message-ID: <463118d9-8db2-7d21-ead5-cb35c10cf3e2@redhat.com>
Date:   Mon, 13 Feb 2023 16:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] splice: Provide pipe_head_buf() helper
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
 <20230213153301.2338806-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 16:32, David Howells wrote:
> Provide a helper, pipe_head_buf(), to get the current head buffer from a
> pipe.  Implement this as a wrapper around a more general function,
> pipe_buf(), that gets a specified buffer.
> 
> Requested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
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

