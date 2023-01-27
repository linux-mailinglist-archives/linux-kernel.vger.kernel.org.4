Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9167DA43
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjA0ALf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0ALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3D4B763
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674778244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFCRwwoODaZccr7NcmMarl4NMoXDR8hwKLWDxPSkIE0=;
        b=g4s2Twg2cS/3+1qLGvUaFdAgyQYy0k1/KRayEHRBkR6Wm+9o2xJgHnGQ9JtsL+5+kjMRH7
        yLnONPBvGF9CxWXZcLP3L0kzOPF6fUBNulBm6C4n0xYyfh9VlK2mQpTvo2OtgC6G0di8t1
        lTxCmtieVGB6zthZ38vKnZVp2y7vX3Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-yaCndK1QMmmLahYjteiqQA-1; Thu, 26 Jan 2023 19:10:42 -0500
X-MC-Unique: yaCndK1QMmmLahYjteiqQA-1
Received: by mail-wm1-f70.google.com with SMTP id j8-20020a05600c190800b003db2dc83dafso1861599wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFCRwwoODaZccr7NcmMarl4NMoXDR8hwKLWDxPSkIE0=;
        b=3oU+TqaF3gdLZw2qJ1689c8+62HCE/4CHmp1XdiCPgtncci21EkbH0YCcw9+R63uPT
         sjzS63Mn/1q6CG7KCiABNWpvdGIjb1ZycB48f8+gqmA8YvwDXIBSPOZxgHYaIfWHYmke
         DIBW8wohzIYITC+8NbVOjFcUI6rfOpi3WZfIarW+Bzu5rPsC+RhwPXbfZmKuscgJWanf
         VMLrfPwMjdofeL9Uu/ILutXPZR4toyrCGyIgTWXoURimbXM0V3V5CyJf1kJ6ZFR0dFjb
         vr+Uq/vXkSPrRNa35oQnX5VVwDbzVj9Ea3GTRVZv4+D2ypuvotxUerOnz6oHQYoNs+EA
         d05w==
X-Gm-Message-State: AFqh2kqz2Wr7181NB07dU7qk6t+Z4bGhY77/67L684+TM2Z+gSs3wkXt
        I9W7olfIVZfkOelGZtErPVTbtvfbze8Xg8UsZ9Yr7sYI52/AW2jYFcu6TWZNHlrMk2pfNBpZ5yF
        RYwEPVpcHNy76PsKfSQGln8Nw
X-Received: by 2002:a1c:4c04:0:b0:3d9:f0d8:708c with SMTP id z4-20020a1c4c04000000b003d9f0d8708cmr45243536wmf.26.1674778241431;
        Thu, 26 Jan 2023 16:10:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuIVvTV3+Y5mMoncMUvJp0bRzJpK5PiB4pT8WE56lw5xCntGDrrPKnbs5J1gjhF3vHcyTl7Ow==
X-Received: by 2002:a1c:4c04:0:b0:3d9:f0d8:708c with SMTP id z4-20020a1c4c04000000b003d9f0d8708cmr45243516wmf.26.1674778241115;
        Thu, 26 Jan 2023 16:10:41 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6387.dip0.t-ipconnect.de. [91.12.99.135])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003db305bece4sm2638720wmn.45.2023.01.26.16.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 16:10:40 -0800 (PST)
Message-ID: <3e5df0cf-d2bd-7795-617d-06a3a32fc18b@redhat.com>
Date:   Fri, 27 Jan 2023 01:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
References: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV> <2907150.1674777410@warthog.procyon.org.uk>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
In-Reply-To: <2907150.1674777410@warthog.procyon.org.uk>
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

On 27.01.23 00:56, David Howells wrote:
> Al says that pinning a page (ie. FOLL_PIN) could cause a deadlock if a page is
> vmspliced into a pipe with the pipe holding a pin on it because pinned pages
> are removed from all page tables.  Is this actually the case?  I can't see
> offhand where in mm/gup.c it does this.

Pinning a page is mostly taking a "special" reference on the page, 
indicating to the system that the page maybe pinned. For an ordinary 
order-0 page, this is increasing the refcount by 1024 instead of 1.

In addition, we'll do some COW-unsharing magic depending on the page 
type (e.g., anon vs. fike-backed), and FOLL_LONGTERM. So if the page is 
mapped R/O only and we want to pin it R/O (!FOLL_WRITE), we might 
replace it in the page table by a different page via a fault 
(FAULT_FLAG_UNSHARE).

Last but not least, with FOLL_LONGTERM we will make sure to migrate the 
target page off of MIGRATE_MOVABLE/CMA memory where the unmovable page 
(while pinned) could otherwise cause trouble (e.g., blocking memory 
hotunplug). So again, we'd replace it in the page tale by a different 
page via a fault.

In all cases, the page won't be unmapped from the page table.

-- 
Thanks,

David / dhildenb

