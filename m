Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA256743CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjASU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjASU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D91BCD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674161590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kjxdWqV/Idea8P7wH81gWdM8bAD9a8dt6ZW4Hjmn574=;
        b=E8ttUGC1c2syka13sSgDPGHqwZKPWLK/BV3ewsvHKfLeLJQ3TzcQvqmuNZD2RpzEtqEXvn
        9TUQDfIXck2Plosu9u5Q9dTTeLhniW191GQhA2sc9oZ1X2/iHxd44A1BJbde2WkDqs5sIc
        BpMEKgFmNJWqJwq/mvx/iaKkk0u/J8k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-YAIKmmiOO4KQg0lJSjgDqQ-1; Thu, 19 Jan 2023 15:53:09 -0500
X-MC-Unique: YAIKmmiOO4KQg0lJSjgDqQ-1
Received: by mail-qt1-f199.google.com with SMTP id u12-20020a05622a198c00b003ad1125712dso1498333qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjxdWqV/Idea8P7wH81gWdM8bAD9a8dt6ZW4Hjmn574=;
        b=sIbQJehZpi4CQo8f9NPtS2g0JqomDwl6197/KjDAticnpNwAqInSk3rNv2/mdKPPIp
         OMCykoeLdcKdR0PI+Av0HDibzMj6kmZIp5gpRnvazt6CCFk7SPvZL/jeb5TIFVmU54gY
         j50KNd0s2txr8cWlTkqaERH77V2DSLOX8grudFGSjJm+z6qlR1QVpi3ycNlbEsUnm+/F
         086MHwcUfZECreV1oIvg7QxZ3rlk1EDx9QRxDJFpqXiggYqGzRMSz9KZcVJOzkV6ffuo
         geg30SjbOz2OddF60WbTQDJwOMN0bU31Cm2eCvtJJ87k158nlW1kPVOhgoq+kLo4A/V+
         YrXw==
X-Gm-Message-State: AFqh2krOT+drksp1UaPaaTMh9yLMaRLDwhUhYOo26gh6Iof5zUqIMOHw
        8z428c/TtxfRfflh+50uftudQqY8Bv0YXd70OPu8FlDlOJrynmlyox73hUYFhbUtx3qyoOhHXkX
        dzcihrS5KRFFmXa6d2ZTMHNkG
X-Received: by 2002:a05:622a:5917:b0:3b6:2c11:ec76 with SMTP id ga23-20020a05622a591700b003b62c11ec76mr18226303qtb.52.1674161588190;
        Thu, 19 Jan 2023 12:53:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhND0Ov4HZvejCKXnwpfvcg2Vk+ZKPZ459Y2BvlHrv5I5mpCgtXHBMZ0hx0of0XCQS91rOzw==
X-Received: by 2002:a05:622a:5917:b0:3b6:2c11:ec76 with SMTP id ga23-20020a05622a591700b003b62c11ec76mr18226280qtb.52.1674161587964;
        Thu, 19 Jan 2023 12:53:07 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006fed58fc1a3sm24886955qkp.119.2023.01.19.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:53:07 -0800 (PST)
Date:   Thu, 19 Jan 2023 15:53:05 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8mtsfYhR9sTw4Kn@x1n>
References: <Y8B8mW2zSWDDwp7G@x1n>
 <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:42:26AM -0800, James Houghton wrote:
> - We avoid problems related to compound PTEs (the problem being: two
> threads racing to populate a contiguous and non-contiguous PTE that
> take up the same space could lead to user-detectable incorrect
> behavior. This isn't hard to fix; it will be when I send the arm64
> patches up.)

Could you elaborate this one a bit more?

> This might seem kind of contrived, but let's say you have a VM with 1T
> of memory, and you find 100 memory errors all in different 1G pages
> over the life of this VM (years, potentially). Having 10% of your
> memory be 4K-mapped is definitely worse than having 10% be 2M-mapped
> (lost performance and increased memory overhead). There might be other
> cases in the future where being able to have intermediate mapping
> sizes could be helpful.

This is not the norm, or is it?  How the possibility of bad pages can
distribute over hosts over years?  This can definitely affect how we should
target the intermediate level mappings.

Thanks,

-- 
Peter Xu

