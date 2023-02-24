Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B46A2095
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBXRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:42:55 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420219036
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:42:53 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a3so573772vsi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImfHWq2alcMESc+jlZwm6NFsn5wdlz4TeCafnSlnQRY=;
        b=a5/uEcnSHAw3vjGfVMDszS2akB2i9mpVfz/PyhLG3EbUelFnXQdjWguWYRK7rLj+Ba
         T732vrPBnEMWStHMrOvCrZdmOxGOPoh+0PHTvGvb9TPJvBsWLLru/SgiMsNP67YVAmfY
         VROMsr6Gstg0TU6qN9Dzrlb0bu3U0GongYwWh3m8hgnAE/ze4LzTb5084gxtNHpLPoCK
         78DvVHHjTdMQinQxw5VU8SIZJ74hFa2IrpM5AtyLgv3z4QTUqKib7wbYVG6u35jifcSH
         41CBzXc/o+C8zei2jOJBL72pBnC16bSeSW8MFGdm/o6kevvGm5a77MAxP/kZXRf8vy3h
         omNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImfHWq2alcMESc+jlZwm6NFsn5wdlz4TeCafnSlnQRY=;
        b=dPOe5jshTo7NmvcWbej7MCO6jj3Au/rD+mLjffASgfPPzI9PGEQbGYcosTqe6lR/Nd
         /Ims33VvzSLVYGSDyYzgz51LrdwxaEZH6itzlz8CO0KQzrWZx24jc/irAOfPdcbmfy9e
         yHVN3ZFWzPDgl6FD0udqRm8y/yecrQGv2JbjZDpRBrZmrJnQg3bYuScHsHQEdWBMn0OU
         vi+1WC/Gf+53q6NRzEc1EzL3KnixOOnaIrSISUdazX88053qe932HSJTQGilYyv3T51A
         CwVW3ayFNxcFAzjfvyx9NBCJZzMvULqNi5kAo4hvhV8+StmjdbYWUQS54P0H7z+VvGQf
         owvg==
X-Gm-Message-State: AO0yUKU9ZDM596KD5inprP2ZWurqj3pWtz8uBXrTcsScZkfFhFaMNBgn
        NJjcIno+5A2+WvHpTvOMU7ZHofDMyi5t5f7rRdCsUg==
X-Google-Smtp-Source: AK7set8XJ+X/I7BuVEK4uI2uLjeWUMpq+1S58VzfWVUN+y/M/G72dDeRJ2+H+BRiYY/inCy8ILlhax+H7H7dwCSZ/wk=
X-Received: by 2002:a05:6102:1264:b0:412:d18:c718 with SMTP id
 q4-20020a056102126400b004120d18c718mr2889952vsg.3.1677260572300; Fri, 24 Feb
 2023 09:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-36-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-36-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Fri, 24 Feb 2023 09:42:16 -0800
Message-ID: <CADrL8HUNO83XtYKxnrm_iWXweP4Wthy2TiodBZ3Tp=FOVa=ZPA@mail.gmail.com>
Subject: Re: [PATCH v2 35/46] hugetlb: add check to prevent refcount overflow
 via HGM
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

> @@ -5397,7 +5397,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>                 } else {
>                         ptepage = pte_page(entry);
>                         hpage = compound_head(ptepage);
> -                       get_page(hpage);
> +                       if (try_get_page(hpage)) {
> +                               ret = -EFAULT;
> +                               break;

spin_unlock(src_ptl) and spin_unlock(dst_ptl) is required here.

I'll make sure there's a selftest that actually makes sure that
refcount overflowing is handled gracefully for v3.

> +                       }
>
>                         /*
>                          * Failing to duplicate the anon rmap is a rare case
> @@ -6132,6 +6135,30 @@ static bool hugetlb_pte_stable(struct hstate *h, struct hugetlb_pte *hpte,
>         return same;
>  }
