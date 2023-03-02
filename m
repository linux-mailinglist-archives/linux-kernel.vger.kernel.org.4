Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93F6A83E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C4E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677765437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gccvmUWslfjTlAzcdDHC7/3ANajeBrFuvt3rIaFYx8Y=;
        b=bMOVttF7ni/XtkPEh1qixRR8/VTPRJFv2foQRwBR7NWs7NPKlR/iig39m6wIeqG1rppwYu
        MCeYS8e2Jde2pRa1j4l7u/3A059F0RtNJhgrgR0bsjAu7h8+ywexQoKUrbvm2E5D5z0b2N
        DqT4ntICympQe3snn+NOqkEwt3hJ9P4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-EsgGfzxKOpGRYeY8EMBhZw-1; Thu, 02 Mar 2023 08:57:16 -0500
X-MC-Unique: EsgGfzxKOpGRYeY8EMBhZw-1
Received: by mail-qv1-f72.google.com with SMTP id ef20-20020a0562140a7400b004c72d0e92bcso8782461qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677765435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gccvmUWslfjTlAzcdDHC7/3ANajeBrFuvt3rIaFYx8Y=;
        b=W239mK6yihV2jF1TbFcSzbgwILL0hZrReIKRBIQxfkJ0VJGceW9i8mmZw2wuL6952X
         gAZM8XS+VqZpjM6fwlPvrvFRRBWZixMtezskAZklCV36Pxry2SknMKSOYzuFai1oA9mc
         JTqEXoMSfjsv3rF3SDSTfHJCGxhu34Bbz4+GOgwthFcCFegkHwDfn9nlL4ZqHQQu6LwO
         E0d7pwxvmEfXD9wBWYStwo9TNICMQaNMDMqqbfzQ6BuLjO1ofU03AmEW4EBFYKZ40e5o
         zD2UHiLKAmIoPm5KmVIt0vgVJWUaCDRSl7NAxsByLpgVdgFg8SEoZvitmqN9VVfzBvtl
         qugg==
X-Gm-Message-State: AO0yUKUCSPLVHEIie8J7YHAvuwuG7+AYRB+oi2pIAsZ9OMsSM5ez1Vfq
        oZtujP/S7qAGvshOr01p4x0ZiH8YhcBVysWCuRWbZcrz0D6I0OCvkouZVRUvyMMFacohV7f2cP5
        Ox3rxufyjDWfSUfFDZ4qm82lPFRA75A==
X-Received: by 2002:ac8:7f0a:0:b0:3b8:695b:aad1 with SMTP id f10-20020ac87f0a000000b003b8695baad1mr20143122qtk.1.1677765435575;
        Thu, 02 Mar 2023 05:57:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8H4gfBuJJp5phRpbP5qGIlqmNyZirFO7rBLz5iR3KfJfdBtCXIKEdIK9pXyEDSVuBmAby7dQ==
X-Received: by 2002:ac8:7f0a:0:b0:3b8:695b:aad1 with SMTP id f10-20020ac87f0a000000b003b8695baad1mr20143082qtk.1.1677765435194;
        Thu, 02 Mar 2023 05:57:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d71-20020ae9ef4a000000b0073ba3fd4e4asm10972473qkg.16.2023.03.02.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 05:57:14 -0800 (PST)
Date:   Thu, 2 Mar 2023 08:57:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZACrOWKWdVYO/EAI@x1n>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
 <e1e0ed70-76df-647f-30ac-0bb6ae8dc05c@collabora.com>
 <Y/4kjnom6MQqh9iA@x1n>
 <fb7ec372-2b16-14e1-a8cd-a90f4449661f@collabora.com>
 <640319be-ddb6-d74f-b731-eee5ceab3d01@collabora.com>
 <Y/9tA2EVglOJ0Ap1@x1n>
 <fc95fd2c-d661-926c-3bdb-8709cb49de3b@collabora.com>
 <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8783f47e-76ea-cd24-e373-f2156884cd05@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:37:44AM +0100, David Hildenbrand wrote:
> Especially for such large sparse VMAs, the current way of allocating
> pagetables to place markers/zeropages is far from optimal.

IMHO that's not a generic workload.  As mentioned in the reply there, I
would suggest we go with simple then we have space to optimize it in the
future if necessary, because the API will be the same.

If I want to monitor a super sparse VMA on dirty, one thing I can already
try is register with MISSING + WP (!WP_UNPOPULATED).  It may be a good
intermediate solution to avoid any marker ovearheads.

-- 
Peter Xu

