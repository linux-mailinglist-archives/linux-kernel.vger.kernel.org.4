Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54A6685AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjALVnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbjALVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDB6A0F1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673559198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mpde03dkx50wpROlAVOA18diOLnrLZI6qBpcOiZEkg=;
        b=A4K7yF223pWcAfNMnP927YmhrNEr5zXiUKNpsWLTPfY1OJozwHZvqzMEqFtpzkr/m4bxpY
        KVWvSYBEWWLi0YLOuCluMaUGssonsUfU188it2SgoZUO1Ca21mC7P22k8q57Jti1OIl4h7
        klMAxRi6jwtGXJ7AtxQrp6stK+hVVoQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-XIST2JUBM-ec2BVUzJsd6Q-1; Thu, 12 Jan 2023 16:33:16 -0500
X-MC-Unique: XIST2JUBM-ec2BVUzJsd6Q-1
Received: by mail-qk1-f199.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so13879606qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mpde03dkx50wpROlAVOA18diOLnrLZI6qBpcOiZEkg=;
        b=YdhrMm4CT52dGXHb1HVRMVn4i72Wf+FieCIFV2d0yC6PpoH18a2tqB+r5NLP4z7gJ1
         6xadRLj4iIjXBEAwMpz4k2AwA4P0ateNFgrwamIauVtJ4GLLUH0CkbloA0YBa+MCP1KC
         RGhhhO492K93ysPxGWGrHEOD+rTSsWeuW9BveR6Pyr9NnpzNh4jJXFbq1g9RojvEGuOV
         Qv2wjcyC082DVRY95p/HGxQ3GPiYdS5FWKRB9aF6ktINfASYFQqNVav2JBIE0cX4Jfo+
         JdYJ9bs2CBTBgi/gQaaSWDDOalGJRO3QhkfWsorFBWPNqmtjosJX88FuyeCGPAOIi8Lv
         +rYQ==
X-Gm-Message-State: AFqh2kqGkyahTQrMD49G+YGfRG7UY/dtNP/Kygmx/q/QrkQnbZC/xVgi
        EHGDirWulSV6gSMTyK7pW7yDaP8ozxs1p5z0sk8hp+crtKMOsFpdDCjqebgQV6T9dsTDMCTqRKk
        rHBsrlipU0IEkcBF3Sb8R1ScX
X-Received: by 2002:ad4:58b1:0:b0:532:31c1:6655 with SMTP id ea17-20020ad458b1000000b0053231c16655mr17581795qvb.20.1673559195925;
        Thu, 12 Jan 2023 13:33:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtn75kY8BF4XUgj5z9crzUBOhe/9ZUw043kNKLsQS6/1q4BoU2J0u6zOb+y5rFEOwXPZx7JEg==
X-Received: by 2002:ad4:58b1:0:b0:532:31c1:6655 with SMTP id ea17-20020ad458b1000000b0053231c16655mr17581768qvb.20.1673559195724;
        Thu, 12 Jan 2023 13:33:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm11574195qkb.116.2023.01.12.13.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:33:14 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:33:13 -0500
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8B8mW2zSWDDwp7G@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com>
 <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:17:52PM -0500, James Houghton wrote:
> I'll look into it, but doing it this way will use _mapcount, so we
> won't be able to use the vmemmap optimization. I think even if we do
> use Hugh's approach, refcount is still being kept on the head page, so
> there's still an overflow risk there (but maybe I am
> misunderstanding).

Could you remind me what's the issue if using refcount on the small pages
rather than the head (assuming vmemmap still can be disabled)?

Thanks,

-- 
Peter Xu

