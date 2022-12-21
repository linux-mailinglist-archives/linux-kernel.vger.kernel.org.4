Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5766536F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiLUTYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUTY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C539264A0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671650621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEPPIEZvL3irasUeIG2Bu5N+ZbEQsDWkll1bdKF+MRg=;
        b=M8EzmHt9QC3cSGSOGDi+NMY4NgnDhcnAT5cVFIifqskagOP3YZ+ikHwJDKXZOzvFlyzJsB
        pFrHr9artcoDzY9IsUKdCP7s4bLL+Bwl+DSVudNp1+jdhBWYlyfjNOMLTnx/WvsjHrSVNz
        QqOZSq/5GeZX6g/MY2eQMsiMe450drs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-uwQ252WHN8iHxX5GnkdSRg-1; Wed, 21 Dec 2022 14:23:40 -0500
X-MC-Unique: uwQ252WHN8iHxX5GnkdSRg-1
Received: by mail-qv1-f70.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso9071842qvr.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEPPIEZvL3irasUeIG2Bu5N+ZbEQsDWkll1bdKF+MRg=;
        b=Xt1dva51wFSZVdfwcr0R4DkT10mTrLojLV3pcAemNto9LndvdIUkIGXAzvtGe4wDy3
         l0nh18pU/zzKwOMyF+Dq2qgRBc5N4AMbN34pQjzyXgJYBJFXn7K4x+V8hA/NrHyw8WFW
         r40gQ3uqjANDAegdIJqlGlruvDeec+TcrTdyAPIQXzPLJ+KHIKe6UYA09gPHz4isIZkE
         4MMNVwGi2xW6y8erQq4LsjREXintStASWpV2O5pimNo6gjeW5nOpdA8pMKNvXLqVjrZs
         vAp1d4kEy8DGacY9VUXEefWcJY/RvSBU9AoJR2qe1Tc3YhvVJWDvWxDbY4PvkrbfwkEZ
         hsCQ==
X-Gm-Message-State: AFqh2kruYl7G4hiejHCzwYmNshKAtS4Sg11WTW7eyXD7kmM30ytf51jR
        vOHsEOfIG38poswvj5TyCJEp+GoEZowLY+Tjt7uBsTqrPR7c0JxOagQhw0M3DpgXKHwFYNoVv1q
        MR8yUYW2uZs9Bg0zcm4tyji2w
X-Received: by 2002:ac8:4509:0:b0:3a8:162d:e977 with SMTP id q9-20020ac84509000000b003a8162de977mr3362671qtn.58.1671650619542;
        Wed, 21 Dec 2022 11:23:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuUsrKCfqYArmWISQMGkKPYDQG4A1LkKr8+9Z0Acuffwbg4NVSTxG78riWgfvD0o0op5AyN0A==
X-Received: by 2002:ac8:4509:0:b0:3a8:162d:e977 with SMTP id q9-20020ac84509000000b003a8162de977mr3362650qtn.58.1671650619320;
        Wed, 21 Dec 2022 11:23:39 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006faaf6dc55asm11148662qkj.22.2022.12.21.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:23:38 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:23:35 -0500
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
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y6NdN2ADVCcK70ym@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com>
 <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Wed, Nov 16, 2022 at 03:30:00PM -0800, James Houghton wrote:
> On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > > Userspace must provide this new feature when it calls UFFDIO_API to
> > > enable HGM. Userspace can check if the feature exists in
> > > uffdio_api.features, and if it does not exist, the kernel does not
> > > support and therefore did not enable HGM.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > It's still slightly a pity that this can only be enabled by an uffd context
> > plus a minor fault, so generic hugetlb users cannot directly leverage this.
> 
> The idea here is that, for applications that can conceivably benefit
> from HGM, we have a mechanism for enabling it for that application. So
> this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
> prefer this approach over something more general like MADV_ENABLE_HGM
> or something.

Sorry to get back to this very late - I know this has been discussed since
the very early stage of the feature, but is there any reasoning behind?

When I start to think seriously on applying this to process snapshot with
uffd-wp I found that the minor mode trick won't easily play - normally
that's a case where all the pages were there mapped huge, but when the app
wants UFFDIO_WRITEPROTECT it may want to remap the huge pages into smaller
pages, probably some size that the user can specify.  It'll be non-trivial
to enable HGM during that phase using MINOR mode because in that case the
pages are all mapped.

For the long term, I am just still worried the current interface is still
not as flexible.

-- 
Peter Xu

