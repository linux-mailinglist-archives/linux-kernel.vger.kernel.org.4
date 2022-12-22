Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F348654312
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiLVObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLVObT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF62A247
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671719433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsPZCMVpzYDswKegA5+aIxMzLBPMDR8IghZms8lnOTE=;
        b=CN3F00G33qtE3mAt7M5eR2be016yF5wbameqSoctJV/Tfkk5c07HZldkGZZqPHie44sNBi
        AKKo2P2VBmEimX8AWmfdWjzdPkKfbKovWOWH8VxWjAlC9RCIkQCypO5gXaRwpzrD/FhdKl
        ZGN0M4vtaPsn6qv9shFFXLNYonnX53c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-y4O1joU7OCqSjMcePJFsUw-1; Thu, 22 Dec 2022 09:30:31 -0500
X-MC-Unique: y4O1joU7OCqSjMcePJFsUw-1
Received: by mail-qk1-f197.google.com with SMTP id bm30-20020a05620a199e00b006ff813575b1so1284817qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsPZCMVpzYDswKegA5+aIxMzLBPMDR8IghZms8lnOTE=;
        b=Icg1b/EikwFI+xYbbMvfi3bR52QElfAMM1NYygLt5z0xpM33gueuy4e7agc4h3mGU/
         8HePEhLoemDGU1RJMzzfppGfJE7pH/WTtfM9SQiHKdQ6sIiPFZP9bcPVTLA5EcE4MwNK
         cXdgrAB3953GvoIphSlekx4lcx3G0kGLn1Nhs/iYq6TIuY4RBxsv9cD07a9tmlE/cJry
         5QnHiQQAqbabL9fqBHc36u8eXkBcztmckQoxTRLhsbQpDLH57GcrPSGMhBXA/w5V6t/s
         SKR/dkavtcC/3d1zcUJJuw+LVIcMeIVgpoO8O+cjROqi/reULsBZDqE8KSjqzEdY8VGb
         II+w==
X-Gm-Message-State: AFqh2kr1UY241n2h/edbMQ/jyZB6YXoi7yfo68wlUEsaI4kFj9osCxl2
        Vd17tqsMm8Vv8apNrr9CtINWYHYWdVSDdut8Iq1Z2nnhxUOyi47guzSJ0YNuIR6+Psq+cwmimo2
        ev6rL/cBjy0TQrUYe2WwA39YG
X-Received: by 2002:ac8:6b8b:0:b0:3a7:e91e:60fd with SMTP id z11-20020ac86b8b000000b003a7e91e60fdmr7374537qts.62.1671719430523;
        Thu, 22 Dec 2022 06:30:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvbCcAsvGm14uy9UuuMTmkrf3+uI9gjc/aitp1UpcQqh+3Em0lTthNiCsOtPL2vTCtmVA5cMw==
X-Received: by 2002:ac8:6b8b:0:b0:3a7:e91e:60fd with SMTP id z11-20020ac86b8b000000b003a7e91e60fdmr7374513qts.62.1671719430325;
        Thu, 22 Dec 2022 06:30:30 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id dt17-20020a05620a479100b006fbf88667bcsm369321qkb.77.2022.12.22.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:30:28 -0800 (PST)
Date:   Thu, 22 Dec 2022 09:30:25 -0500
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
Message-ID: <Y6RqAbGOFEKFUeQr@x1n>
References: <Y3VkIdVKRuq+fO0N@x1n>
 <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
 <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey>
 <Y6OEQB3dLSa083F6@x1n>
 <Y6OJUtVkvdptEgW7@monkey>
 <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
 <Y6Om/dvlt1Wl2uZw@monkey>
 <CADrL8HU_4ymb4XMBpujyFECwONKpWP0fgZgy7odb+M23QUx6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HU_4ymb4XMBpujyFECwONKpWP0fgZgy7odb+M23QUx6pQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 08:24:45PM -0500, James Houghton wrote:
> Not sure what the best name for this flag is either. MADV_ENABLE_HGM
> sounds ok. MADV_HUGETLB_HGM or MADV_HUGETLB_SMALL_PAGES could work
> too. No need to figure it out now.

One more option to consider is MADV_SPLIT (hopefully to be more generic).

We already decided to reuse thp MADV_COLLAPSE, we can also introduce
MADV_SPLIT and leave thp for later if it can be anything helpful (I
remember we used to discuss this for thp split).

For hugetlb one SPLIT should enable hgm advise bit on the vma forever.

Thanks,

-- 
Peter Xu

