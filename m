Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7767468D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjASW7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjASW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08FA3175
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:45:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t5so3316194wrq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcDtohvp2B7qEghqHFvGOxURNU+p0D+oExVevoB6IBY=;
        b=asVroelQi2KhRLvgv1N4Xv3vnf0/gxTLwJDcrOZbehdN0rSMpxWM5p/sFRpmkgqtzJ
         lBTCz+P1xfFdmbAKMuW/s7azblR9ntIxxZqy9ej1pBz9edazBnibHUnIdj5AJzvxdccb
         8p9aHGG2/hYZTmK7V9iqx1jFWtBV5aet9qqeSgFaLRK5UVjKPjaQ+buGHtBLrf+kcj0S
         IWUZr7gbdDdmpGbgsDYK/s3YaVk3oJrcJNGtvOokmYlOkjbavXV24YEZEyH06ig5LJ7Z
         Lq9sXZAQk+YkgKSiOBi8EUA6tjNVil1X+aoIf1hC+LbKcbvx+nWMO2O391z3vLpCsnCV
         ofkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcDtohvp2B7qEghqHFvGOxURNU+p0D+oExVevoB6IBY=;
        b=pBtf3SYrQZ69X9di4XNiQHTpryJse/ykeOWhx+oKUCPackV45xYZfci0C1ElGk5REC
         100Ma7d+xao40SL4Jspxu+930I3cYwKucDnVzbmrRBfV4iZnryt/BMbwkFR/+VCoOqWz
         3a5/wmmD9JRE9PWiMTVKM08pOIoJpGKNhg7IpRtmkkdU56UWKcChXRgh1dLAeUrOnN1F
         qvpvmHjuJEad9x/i/AMC+YaRfmwbplCW/F6c0ZakYs5I91TKU/3w6f5K4oOhLAnNaVAj
         caKzl/LzSHjTU3BYUcag0hCm20w9MO91bLv2HKFa65u5iMdfyFvai1HNMVOytWrPPHdE
         pYHQ==
X-Gm-Message-State: AFqh2koO/ekcyAJFjJmH5Wkz1CfxMM7i2o++9MW3Fs4FWwO0wka6v8bO
        CrcbrYqg8UZP5CRwSDtey8+vduBolQhTbGKcNHdh2Q==
X-Google-Smtp-Source: AMrXdXviF55YDG4+95WndehLJvnHv2oI5pRxAORlf8g2RpR3UXeO55ug2V9znbohpn9NEMiF8BzUz7nG2ac5Q/oMny4=
X-Received: by 2002:a05:6000:818:b0:2bd:df18:28f9 with SMTP id
 bt24-20020a056000081800b002bddf1828f9mr491219wrb.355.1674168347258; Thu, 19
 Jan 2023 14:45:47 -0800 (PST)
MIME-Version: 1.0
References: <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com> <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8mtsfYhR9sTw4Kn@x1n>
In-Reply-To: <Y8mtsfYhR9sTw4Kn@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 19 Jan 2023 14:45:10 -0800
Message-ID: <CADrL8HUn0jmuDCFnQT--LDMZnHm+75O0FZC0kicdTV9FJctrhA@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:53 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 19, 2023 at 11:42:26AM -0800, James Houghton wrote:
> > - We avoid problems related to compound PTEs (the problem being: two
> > threads racing to populate a contiguous and non-contiguous PTE that
> > take up the same space could lead to user-detectable incorrect
> > behavior. This isn't hard to fix; it will be when I send the arm64
> > patches up.)
>
> Could you elaborate this one a bit more?

In hugetlb_mcopy_atomic_pte(), we check that the PTE we're about to
overwrite is pte_none() before overwriting it. For contiguous PTEs,
this only checks the first PTE in the bunch.

If someone came around and populated one of the PTEs that lied in the
middle of a potentially contiguous group of PTEs, we could end up
overwriting that PTE if we later UFFDIO_CONTINUEd in such a way to
create a contiguous PTE.

We would expect to get EEXIST here, but in this case the operation
would succeed. To fix this, we can just check that ALL the PTEs in the
contiguous bunch have the value that we're expecting, not just the
first one.

hugetlb_no_page() has the same problem, but it's not immediately clear
to me how it would result in incorrect behavior.

>
> > This might seem kind of contrived, but let's say you have a VM with 1T
> > of memory, and you find 100 memory errors all in different 1G pages
> > over the life of this VM (years, potentially). Having 10% of your
> > memory be 4K-mapped is definitely worse than having 10% be 2M-mapped
> > (lost performance and increased memory overhead). There might be other
> > cases in the future where being able to have intermediate mapping
> > sizes could be helpful.
>
> This is not the norm, or is it?  How the possibility of bad pages can
> distribute over hosts over years?  This can definitely affect how we should
> target the intermediate level mappings.

I can't really speak for norms generally, but I can try to speak for
Google Cloud. Google Cloud hasn't had memory error virtualization for
very long (only about a year), but we've seen cases where VMs can pick
up several memory errors over a few days/weeks. IMO, 100 errors in
separate 1G pages over a few years isn't completely nonsensical,
especially if the memory that you're using isn't so reliable or was
damaged in shipping (like if it was flown over the poles or
something!).

Now there is the concern about how an application would handle it. In
a VMM's case, we can virtualize the error for the guest. In the guest,
it's possible that a good chunk of the errors lie in unused pages and
so can be easily marked as poisoned. It's possible that recovery is
much more difficult. It's not unreasonable for an application to
recover from a lot of memory errors.

- James
