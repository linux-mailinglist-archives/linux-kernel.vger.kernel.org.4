Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A13674653
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjASWnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjASWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:42:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023BEB4E19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674166990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxWTZPauMXnpTaH3mq+4KakgefY9/3sGM9X+qHRltHo=;
        b=Mr2BfM4gsKDAocFljRR4R36pPr+LsmPcuwZnQ2EoyR7pAdYaYSiK9w+nDxohrMeuw56RSh
        QnTDS/XtRq5nHoX+blOfCwafBvm+jIEk+YdTUBBS615Xamxkt4epwEqt0z5cJndSRguyy3
        rqR1orfGAFBkyvh2fRAfetYR+BsYP44=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-jYmHHfthN5aq2FcldYAV6g-1; Thu, 19 Jan 2023 17:23:09 -0500
X-MC-Unique: jYmHHfthN5aq2FcldYAV6g-1
Received: by mail-qt1-f200.google.com with SMTP id bs22-20020ac86f16000000b003b686e0ef0bso1598515qtb.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxWTZPauMXnpTaH3mq+4KakgefY9/3sGM9X+qHRltHo=;
        b=ahZTd6XZfFD13/kmZwIwheDEMoNMZi4+TgiSjeVhOU8jjOp10vz87SsQRtcj7462/7
         f4AnvnLnZZK+j0wXuQWwnMCbl1fBlIyWy+PeK6H/TNs6WE7nDAV0RYuC0ZyIw9uIU96V
         azXcgd6RsZj3wCvLjxzgQObEaKv9SWo0LSktqU92Qp/SgyhqPu3ccPcS7xb9WdeXtwlr
         aneksKSrGUi7shRIalU8cbcA7NAg/n6fFpZ+PHyr0wwZryixPnDTrVb0K+lhn2Ioiu8i
         1dR3nOwvf+JJchS+2cFnnyJuEoM9j4UDmt/V+vHWUlQLikX0ONMRl2FSleoJvaVHc2aJ
         0f4A==
X-Gm-Message-State: AFqh2koDZ5ItD7XGQq3h1b9HUE1hHHWaEDFA3AOAFLaBKoGdFDmwNd0E
        BbSLfrKJB+l0d7QIgEOJiwIO6PBeeefwfhLGIREoNlm2BMfmzNE/kCGWRZj1liUmM/Y3+EGyW6j
        B4th5Lzp55/tKCpnqOqD/RWZo
X-Received: by 2002:a05:6214:15d0:b0:519:ff36:a873 with SMTP id p16-20020a05621415d000b00519ff36a873mr19530730qvz.41.1674166988554;
        Thu, 19 Jan 2023 14:23:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs1AilgOcAVjjfASECLApaVO/xdOmtsX1eluQMpvPfGGDkVwpLpBddnCkQ10P5KIXePFNEYTA==
X-Received: by 2002:a05:6214:15d0:b0:519:ff36:a873 with SMTP id p16-20020a05621415d000b00519ff36a873mr19530695qvz.41.1674166988300;
        Thu, 19 Jan 2023 14:23:08 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id dt41-20020a05620a47a900b00705e7daf6f0sm9684773qkb.129.2023.01.19.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:23:07 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:23:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
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
Message-ID: <Y8nCyqLF71g88Idv@x1n>
References: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8m9gJX4PNoIrpjE@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:00:32PM -0800, Mike Kravetz wrote:
> I do not know much about the (primary) live migration use case.  My
> guess is that page table lock contention may be an issue?  In this use
> case, HGM is only enabled for the duration the live migration operation,
> then a MADV_COLLAPSE is performed.  If contention is likely to be an
> issue during this time, then yes we would need to pass around with
> something like hugetlb_pte.

I'm not aware of any such contention issue.  IMHO the migration problem is
majorly about being too slow transferring a page being so large.  Shrinking
the page size should resolve the major problem already here IIUC.

AFAIU 4K-only solution should only reduce any lock contention because locks
will always be pte-level if VM_HUGETLB_HGM set.  When walking and creating
the intermediate pgtable entries we can use atomic ops just like generic
mm, so no lock needed at all.  With uncertainty on the size of mappings,
we'll need to take any of the multiple layers of locks.

[...]

> > None of these complexities are particularly major in my opinion.
> 
> Perhaps not.  I was just thinking about the overall complexity of the
> hugetlb code after HGM.  Currently, it is 'relatively simple' with
> fixed huge page sizes.  IMO, much simpler than THP with two possible
> mapping sizes.  With HGM and intermediate mapping sizes, it seems
> things could get more complicated than THP.  Perhaps it is just me.

Please count me in. :) I'm just still happy to see what it'll look like if
James think having that complexity doesn't greatly affect the whole design.

Thanks,

-- 
Peter Xu

