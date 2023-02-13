Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EC694B99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBMPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBMPs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671931E9F9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676303252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=Fq8PFZYSCFcnuT7S5D0Ldv/QazvSRLpu74DdT66rRaV6CzpBpT92m0hsdCTsYrXSn5xxMB
        cKGRXNJ3okNOTj4H6bhgphe67pcKHE5IZCMI8JJK/rDVxYoRt7+V6OjpVuvjPLm1pILk3r
        yGWhRQUcPpqgCP9Iszb4/b4pXL88AOE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-yHMgJUXVNvSfJoi1m7UncA-1; Mon, 13 Feb 2023 10:47:31 -0500
X-MC-Unique: yHMgJUXVNvSfJoi1m7UncA-1
Received: by mail-wm1-f72.google.com with SMTP id bg3-20020a05600c3c8300b003e1e7d3cf9fso2881643wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk9ZB85N8qJ1vK9VuqUk4MadsaC7d3r9I0xTkyZcACk=;
        b=srNGYr68tfGXald5CdlSAmLGlwrP3remWwpr3edGqXlIgIA+7cXhKxY5f9NEBjtldO
         zMtZXBcrZMCrar1qyEYOeiNBP5onZqAxqS6NRa6j+Z++aZjHf9X6iFFFevj/bKSv0+K4
         6tbYRoRbJvhuaz2fUhvlPkZU74b0ixHpS5vhsDQYpPxAfcvE4rLIKl8gUR65BW2IXaws
         34qYavaXmkSAG+3Qv2bliiPr/nZjPKv8mFX6+Dcjg96S+Gdi6zjAPLFgjw9h70wdEPkk
         VlbiE2NeP35dqbrK06dchDF+IPjBZIBaxPjitIo20JgjcK6EtrUyh4WJ1p7B93OVJtlx
         IuVw==
X-Gm-Message-State: AO0yUKXC2PuJRgKZcaqNW9fztzHM+Bjf0sqjfYhbApwtlQtAHL/1UGKS
        YTrFbwlq3EsBscD2QNbyakQDYQ0dyPN/52YgVNjHqHht3hTHbLF6hTet3bFZyXFERgTS+SkQ6Rt
        jFrNIvxvpDdp3pjV+2eiA21bA
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794829wrs.39.1676303249979;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9kzLbhn6FVuDM3325N5rlxLs5gU4rYjW2jekddTSwamP6u7flJXRTM1zAOMwya96tpyHAZIg==
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18794818wrs.39.1676303249742;
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b002bff574a250sm10959411wrp.2.2023.02.13.07.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:47:29 -0800 (PST)
Message-ID: <5f3d8009-7579-32e9-ab24-347f71fa5ce6@redhat.com>
Date:   Mon, 13 Feb 2023 16:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] splice: Rename new splice functions
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
 <20230213153301.2338806-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213153301.2338806-2-dhowells@redhat.com>
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

On 13.02.23 16:32, David Howells wrote:
> Rename generic_file_buffered_splice_read() to filemap_splice_read().
> 
> Rename generic_file_direct_splice_read() to direct_splice_read().
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

