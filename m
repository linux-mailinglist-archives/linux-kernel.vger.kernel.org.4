Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2E6BBCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCOTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjCOS7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95179763DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678906749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=OkA6u5+WAin8q0Gt3IK3KSVLwSI9TF/+CuGIi507S9m8bg4RtY4T9Oe6fnXtEnmyd8XFOQ
        ds5ym7r0rlIubsGoPnz+Jmfqhg/46k3S08J5a0QTXhV1bMb0t2Dv+bN2+CyOUVlUh7d6Ml
        aCx7MG3nk17jh1S2NyU4Y+b1aL8LpWI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-nW9k4c1dPAG5ZFz-n0Ph8A-1; Wed, 15 Mar 2023 14:59:08 -0400
X-MC-Unique: nW9k4c1dPAG5ZFz-n0Ph8A-1
Received: by mail-wm1-f70.google.com with SMTP id l18-20020a05600c4f1200b003ed35ab903aso980912wmq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906747;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pRuFXv24zO9iZj6MhHQgS7pRqlQAfg3F2hO5yqQOu0=;
        b=RUZE1QFHqxpGQpy9M5j/zDzfLMmkiopbMyzmSKyg6ILRVt6ZoCXyuNYYGl2HG2hSgp
         y8CQGwqM7Xz+PsEaqGuqjmngXA/3H+GmOn5EM/6VuQO3PS9f+Asd9I9YQOcgFiO8um42
         1kYf4Thq79UmsM1G8TR54FH52Wtmg+o7jopR2WhWmpGJbIHz6j8ppJerrOwsRmSvDNNM
         Hc/dAf5t5x1oYmJFa8r2GpXjUlXsDMrgjs0oqJ6h/yavObimjksQT0DmHuNxFGSydAVy
         /PkZlZsEic7JogAbOVkTrEJ2T2qJaI+PyfF4E/SOFveScuT11S1//PIgJQ+pHGv6ER1B
         wYMQ==
X-Gm-Message-State: AO0yUKWc/T5Vn0bndhJDH7d5OKIg0Q8ZexVWgXt/NsHlfWiIcZnUTEqe
        0rYaNajXuDh16K+SYtBydmqdPMuI2fotbaot9ksujnS/pslm8Thd9lubyCktS6gST6oOxSHW0hR
        A29+42X50Gx99mYcRrFMR0jNO
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499462wra.43.1678906746989;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set/id0A51e2uD6Xav4KlpzhQfvsr1WBJ6M12HWKP+dMN7x79MowOlKwVntfM4m25nbOzwjbzYQ==
X-Received: by 2002:a5d:452b:0:b0:2cf:ec84:b63a with SMTP id j11-20020a5d452b000000b002cfec84b63amr2499453wra.43.1678906746804;
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:2f00:2038:213d:e59f:7d44? (p200300cbc7022f002038213de59f7d44.dip0.t-ipconnect.de. [2003:cb:c702:2f00:2038:213d:e59f:7d44])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d45ca000000b002ca864b807csm5451460wrs.0.2023.03.15.11.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 11:59:06 -0700 (PDT)
Message-ID: <0064f021-ac21-8bbc-5156-90328da61b8f@redhat.com>
Date:   Wed, 15 Mar 2023 19:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 02/15] splice: Make do_splice_to() generic and export
 it
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-3-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.23 17:35, David Howells wrote:
> Rename do_splice_to() to vfs_splice_read() and export it so that it can be
> used as a helper when calling down to a lower layer filesystem as it
> performs all the necessary checks[1].
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> Link: https://lore.kernel.org/r/CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com/ [1]
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

