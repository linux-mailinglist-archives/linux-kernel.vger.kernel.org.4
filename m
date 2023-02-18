Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26169B700
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBRAnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBRAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:43:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923AE17CD4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:43:06 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r7so929752ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNr8+Ev/ajh46J6kogGWSKhKYMQoFqNMu4CknNIEA0U=;
        b=ojwEF4Jz1NAU7iRdG9ucYN86C1nnr3deyRvZetcTtuI3vXL7Rs9qLj0PDMqrXH+mmZ
         D3EiCENVHgrY0MGpO6k3OAJKQlHVSwpWO+aUIgOGHKjepn7/b5yzpmnyDyqFykJV9vnk
         fsDf/7+dgJ2C4GBOepVzA485VsR+3yFfbo7eSL/7jNPa0sU5Et1g+akY2ODhicKxlm81
         lBBdaKphLwwdScAfCMzS03R7QeJInWfDn+jO0BuE4O2JDDrbc+rcNx3F/Zlf6fUEnZue
         zNLPooxCefi//rRTLtRc8GxpALZG7JkG0MLWKAEgBG08OhZegBEee8b6ATOxzCuOh7xm
         1JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNr8+Ev/ajh46J6kogGWSKhKYMQoFqNMu4CknNIEA0U=;
        b=RpEvOIBV/hhffHrSQ5jS+qB7/Izq5GhEhOag58A1cRCUoRLcQedJNQeqOPkv+AaIVg
         gNj3HkNbama7JuVFAvKsrDnJo9RWSwBbUukTCMcemJ4Lnn0rEZHRig1DlNmy4d4z5LTZ
         +c3Ws6IuudQjCGPGi8lQseukB12rjHudon7lowSDZ6K3cQKdhRhK3pNYh0qWy3RhTipW
         TRo0gidkif8uUyI4GQ+PHtIfY8BvVLbLhev+DRqlVfv0f3BmZ5PhGVixixZrXrWsvj1B
         uj98HCT/F+3A+BJN8QS1Z3G3C198n03g5/lDFAjlqynWVti3AqDb9G/+o+LC5Eg+wUWf
         P1HQ==
X-Gm-Message-State: AO0yUKU/57+Q3VY5PcGUFWafx/Aivh1jdBhaP8e1vRRv1jCe1TDLezjl
        LHQN4VKUBqXUzCdpyyrj9cvhTDKdS7KP7U/wjrx3mQ==
X-Google-Smtp-Source: AK7set+UV03bLdBjk+KBEt9VTtAJcQEQd+V1YHA+/eL7PobusGFAWHmOYyir7gSztpWBY2Su/cNKZson9N++2Ckz7/I=
X-Received: by 2002:a92:330d:0:b0:313:cc98:7eee with SMTP id
 a13-20020a92330d000000b00313cc987eeemr699425ilf.1.1676680929628; Fri, 17 Feb
 2023 16:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-2-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-2-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Feb 2023 16:41:57 -0800
Message-ID: <CAHS8izM5Es+DMiOyPt93o6Xw+SeuOR45r+MMoeagiYN594NiyQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/46] hugetlb: don't set PageUptodate for UFFDIO_CONTINUE
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
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
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> If would be bad if we actually set PageUptodate with UFFDIO_CONTINUE;
> PageUptodate indicates that the page has been zeroed, and we don't want
> to give a non-zeroed page to the user.
>
> The reason this change is being made now is because UFFDIO_CONTINUEs on
> subpages definitely shouldn't set this page flag on the head page.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 07abcb6eb203..792cb2e67ce5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6256,7 +6256,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst=
_mm,
>          * preceding stores to the page contents become visible before
>          * the set_pte_at() write.
>          */
> -       __folio_mark_uptodate(folio);
> +       if (!is_continue)
> +               __folio_mark_uptodate(folio);
> +       else if (!folio_test_uptodate(folio)) {
> +               /*
> +                * This should never happen; HugeTLB pages are always Upt=
odate
> +                * as soon as they are allocated.
> +                */

if (is_continue) then we grab a page from the page cache, no? Are
pages in page caches always uptodate? Why? I guess that means they're
mapped hence uptodate?

Also this comment should explain why pages in the page cache are
always uptodate, no? Because this error branch is hit if (is_continue
&& !folio_test_uptodate()), not when pages are freshly allocated.

> +               ret =3D -EFAULT;
> +               goto out_release_nounlock;
> +       }
>
>         /* Add shared, newly allocated pages to the page cache. */
>         if (vm_shared && !is_continue) {
> --
> 2.39.2.637.g21b0678d19-goog
>
