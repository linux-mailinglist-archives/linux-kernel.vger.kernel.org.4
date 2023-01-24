Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011C679CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjAXOys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjAXOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67CF4B18E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674572038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1o51OJziP6bU+eCmiPMiOHJQX1d0z5FefyRCAiwMaA=;
        b=M1FxX9kOQWCxHQ55KpJu7YRX5l4VPjQ0tz3E0UoN18gAGqhrGVgzU6uwBcHBwEw3kM3u6r
        zKFQnEQYsfQZCQXuv84g7jnp3gqR//SNnIoUlZbEn2tO7CqmTOkUyuEDZ0+YwKWcrHm8LM
        DBtNJdktlrlnEiZuJ+90rmNKNLb/E2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-Dg2Brn3UNQmiiFsIkp7c5w-1; Tue, 24 Jan 2023 09:53:57 -0500
X-MC-Unique: Dg2Brn3UNQmiiFsIkp7c5w-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so9294091wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1o51OJziP6bU+eCmiPMiOHJQX1d0z5FefyRCAiwMaA=;
        b=diHYS8/VFHn92GJB+IA2HYucw1OycYR4N17QFBeEu9+kkTh/hL/HThnrmrdiw14WJp
         Y2Tu2snc+jBMr3jjmNAENrpYsPl9bnz7md6dJjg1MWCb6G5YHV1vitt349cmABGLruON
         ZNWo/lc+JuxHwRGez5SxxMQ1UMIGsa0tuPURTBnhv3g2+H6273e5geuZB6RD1BD7xPkj
         a50hwaiYSxUh2fvFEiUy54R7eVU3DvKfZOPdQ9irL6l5XYP8ednK2fbrReeqZh+pEX3B
         3eITxoXPGA6HsRrVM/Y84XRGIeGxxYdg3d4a/47+mh1vQw9pdTMvd6z3oXBl48yauX3I
         E5Yw==
X-Gm-Message-State: AFqh2krE3x+JsxsXLC8UCiRghpka4kSP1iNpu/NvUKWMyVFqe3W8bBY7
        oe7FDmpClWwsps7/q/d/85fNjEiXGoUIYhs83ZCUQNr5nVyordRcavDPsBk2BoyoiztwLBkEvuE
        1t5ox8DtC1PF7+SCdGpgl6meB
X-Received: by 2002:a05:600c:4f10:b0:3d3:48f4:7a69 with SMTP id l16-20020a05600c4f1000b003d348f47a69mr29345045wmq.17.1674572036379;
        Tue, 24 Jan 2023 06:53:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsWKnb4h2V9IrDZPNQLJb9xuVNOAv4tgAP04/SXdS4jirwC5GnrgtxAI7Zz/EbUkNYX+dYayA==
X-Received: by 2002:a05:600c:4f10:b0:3d3:48f4:7a69 with SMTP id l16-20020a05600c4f1000b003d348f47a69mr29345019wmq.17.1674572036027;
        Tue, 24 Jan 2023 06:53:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c082500b003daf681d05dsm2160914wmp.26.2023.01.24.06.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:53:55 -0800 (PST)
Message-ID: <4909601d-8b3b-6ec2-b8b5-2764772d6e8d@redhat.com>
Date:   Tue, 24 Jan 2023 15:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
References: <fc18c4c9-09f2-0ca1-8525-5ce671db36c5@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-4-dhowells@redhat.com>
 <874546.1674571293@warthog.procyon.org.uk> <Y8/wwy6OJEqjzRfZ@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y8/wwy6OJEqjzRfZ@infradead.org>
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

On 24.01.23 15:52, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 02:41:33PM +0000, David Howells wrote:
>> Yes.  Christoph insisted that the bio conversion patch be split up.  That
>> means there's an interval where you can get FOLL_GET from that.
> 
> The only place where we have both is in the block layer.  It never gets
> set by bio_set_cleanup_mode.
> 
> Instead we can just keep using put_page dirctly for the BIO_PAGE_REFFED
> case in the callers of bio_release_page and in bio_release_pages itself,
> and then do away with bio_to_gup_flags and bio_release_page entirely.
> 

Thank you, just what I had in mind ...

-- 
Thanks,

David / dhildenb

