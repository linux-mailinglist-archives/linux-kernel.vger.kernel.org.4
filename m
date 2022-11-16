Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B162C576
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiKPQxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiKPQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4271403C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668617465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G55FrDAGyGXiishVQf4ECL+0mTuEqsMoVobpqZUA3Kw=;
        b=AKqUX0zS3ap0KjHZqWfA9Mnjw5ynZwjtWlvt/GGKCbhWkSS259iDHt7ixLXL2vQvSIoLRa
        UVxqNHWxgqIPmMxtAywre3EuOd36qL16GRxr2t0pMMGeA9tvDBdrStaSzRZ+Mgznauz/6I
        lBsqRprNPeTeqzXpVOI6X9AL7v7rAGo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-0eandKzLNN2CIqiRLiQJgQ-1; Wed, 16 Nov 2022 11:51:02 -0500
X-MC-Unique: 0eandKzLNN2CIqiRLiQJgQ-1
Received: by mail-qv1-f72.google.com with SMTP id d8-20020a0cfe88000000b004bb65193fdcso13661448qvs.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G55FrDAGyGXiishVQf4ECL+0mTuEqsMoVobpqZUA3Kw=;
        b=54rXfKpAMX4aO7Gg6SJFwKzU4rKb4zv7R5ADxo3PVXkVPJUeCBZEw5BkcP77S0ER7k
         FYIVjxMCAI9myGLSh0LfLKNgmQ2YXPjbtmhYd0Fn7l3f8MzF1hisSdkOpj3bsFz5gJQV
         dJOAAnn6OfqvAE/AOxjgm6vF/ytO4J9wMXLbITCZY/BXfuxHBehgZGdqsBbpEA9T9KjR
         Dpq/6qQn4A51v2DYKHy0xXPZFXPZmeXKgoili/Izxt63XjZW2kzM8PZJ5AmJbp0c03Sl
         VGqJyb3IrLyNeTloj0Fx9Gd55/RC9cwlBRUxtIffppK3fn5vUehf1qs9pl7jgdOFHB4W
         umxA==
X-Gm-Message-State: ANoB5pnsOLUnct9nQGVk3hHvtD5F2kfCGqUgv2eIJzEP1G0vXj+lXMQ/
        Ax4MHpQC84YYvPpuLiHaBMItwHvMVrks4RcA4nffoqNQWwGtb20yBz3BBu+M8oao+ZYueaIvDWl
        HKIJVtRrIzU/CBLCLVzXUJZri
X-Received: by 2002:a05:622a:488a:b0:3a4:f665:7791 with SMTP id fc10-20020a05622a488a00b003a4f6657791mr21964292qtb.380.1668617460490;
        Wed, 16 Nov 2022 08:51:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6VF+Mw1C1c2yDBORYsI9Dm3FfH9tOiFFWRqDix38ykCMkMv0RyJve4sg6IUZLzg6NxpMkLJA==
X-Received: by 2002:a05:622a:488a:b0:3a4:f665:7791 with SMTP id fc10-20020a05622a488a00b003a4f6657791mr21964260qtb.380.1668617460217;
        Wed, 16 Nov 2022 08:51:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006faaf6dc55asm10464328qki.22.2022.11.16.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:50:59 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:50:58 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/47] hugetlb: only adjust address ranges when
 VMAs want PMD sharing
Message-ID: <Y3UU8p5Et9l64bPl@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-5-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-5-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:20PM +0000, James Houghton wrote:
> Currently this check is overly aggressive. For some userfaultfd VMAs,
> VMA sharing is disabled, yet we still widen the address range, which is
> used for flushing TLBs and sending MMU notifiers.
> 
> This is done now, as HGM VMAs also have sharing disabled, yet would
> still have flush ranges adjusted. Overaggressively flushing TLBs and
> triggering MMU notifiers is particularly harmful with lots of
> high-granularity operations.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

