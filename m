Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22776B14D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCHWLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCHWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC336920C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678313445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLI1QWpHEK+fkiyGobonFz4t1x0nPDcqaex7e9/jd/s=;
        b=MmdWSIT/HdYxtGhj0Vp66kg7pfexx8aboF9uPn/jsmivcQUa4KI4IcmieyZBB7hCB3Z+Zn
        ywznZVs2qUtVLcPXZ1xCA/3WrsbSmP7WOR5wsNjwWxTkAYhmxNd1aAwa07x1J+LiIjUJGN
        iyp2rIZDfG6TcuFO5jLDsioEYH/3q8E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-tIQXreGTNb2TBzxlc3fZ8Q-1; Wed, 08 Mar 2023 17:10:44 -0500
X-MC-Unique: tIQXreGTNb2TBzxlc3fZ8Q-1
Received: by mail-qt1-f200.google.com with SMTP id x21-20020ac86b55000000b003c01d1a0708so7803579qts.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLI1QWpHEK+fkiyGobonFz4t1x0nPDcqaex7e9/jd/s=;
        b=Dr7gtgJlEMSj75OBVZ0qTPjQ4Yj8A+RSq1diPQQlLNLJiIOwCnVlO0jvwGtQHlFfZV
         Z2UWTKX50KbB0Ptugcz0Ak7N8G9oV7X4IIeYF99rQ9BdhcwuOCA5I7YxUoPgeMiBUxAX
         f3IGOj+PGWT4bzL1n9yOpWoerK3wzh85dWtu/QrDi0H7q8i/P5azHlCHf2CVQSgsZjX8
         2cwrxu2+JHVA7opCx4KsRDxb4dcYEZQkKBGO+hMwxOHTdZb77zE8hlshH42t/JoXWk3u
         XKQTlQF690f6lGsGjZ+4qxKH+bbKUM03e7pOKlH/XXnhOAqtJXi0aoN21yiI45mf3sLs
         Cw1A==
X-Gm-Message-State: AO0yUKXjq9gnx7KYPrhotbK/QijcKtC01tKwHpJMRVbJSvg7z2afR7hP
        XamSqV2rUThY/WNQKupRWrYI8nIdY+6i7YWD3YWXW9lOpm0j7u0V706x4K5UR6BoMLU6QxVejtr
        eI/1+akRMdwFULG65VXQkX8KT
X-Received: by 2002:a05:622a:148:b0:3bf:da3a:4e0f with SMTP id v8-20020a05622a014800b003bfda3a4e0fmr39521226qtw.0.1678313443625;
        Wed, 08 Mar 2023 14:10:43 -0800 (PST)
X-Google-Smtp-Source: AK7set9nA/PJr6/P2QgGqqNjvT5/5QEJGMCQvFsq7BnOQ74jn8PmCHuaIjguwIy5yx3L8S2JOLWqjQ==
X-Received: by 2002:a05:622a:148:b0:3bf:da3a:4e0f with SMTP id v8-20020a05622a014800b003bfda3a4e0fmr39521165qtw.0.1678313443276;
        Wed, 08 Mar 2023 14:10:43 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85bc3000000b003bfb820f17csm12660930qtb.63.2023.03.08.14.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:10:42 -0800 (PST)
Date:   Wed, 8 Mar 2023 17:10:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: rmap: merge HugeTLB mapcount logic with THPs
Message-ID: <ZAkH4cImuFttLuDQ@x1n>
References: <20230306230004.1387007-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306230004.1387007-1-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:00:02PM +0000, James Houghton wrote:
> HugeTLB pages may soon support being mapped with PTEs. To allow for this
> case, merge HugeTLB's mapcount scheme with THP's.
> 
> The first patch of this series comes from the HugeTLB high-granularity
> mapping series[1], though with some updates, as the original version
> was buggy[2] and incomplete.
> 
> I am sending this change as part of this smaller series in hopes that it
> can be more thoroughly scrutinized.
> 
> I haven't run any THP performance tests with this series applied.
> HugeTLB pages don't currently support being mapped with
> `compound=false`, but this mapcount scheme will make collapsing
> compound=false mappings in HugeTLB pages quite slow. This can be
> optimized with future patches (likely by taking advantage of HugeTLB's
> alignment guarantees).
> 
> Matthew Wilcox is working on a mapcounting scheme[3] that will avoid
> the use of each subpage's mapcount. If this series is applied, Matthew's
> new scheme will automatically apply to HugeTLB pages.

Is this the plan?

I may have not followed closely on the latest development of Matthew's
idea.  The thing is if the design requires ptes being installed / removed
at the same time for the whole folio, then it may not work directly for HGM
if HGM wants to support at least postcopy, iiuc, because if we install the
whole folio ptes at the same time it seems to beat the whole purpose of
having HGM..

The patch (especially patch 1) looks good.  So it's a pure question just to
make sure we're on the same page.  IIUC your other mapcount proposal may
work, but it still needs to be able to take care of ptes in less-than-folio
sizes whatever it'll look like at last.

A trivial comment on patch 2 since we're at it: does "a future plan on some
arch to support 512GB huge page" justify itself?  It would be better
justified, IMHO, when that support is added (and decided to use HGM)?

What I feel like is missing (rather than patch 2 itself) is some guard to
make sure thp mapcountings will not be abused with new hugetlb sizes
coming.

How about another BUG_ON() squashed into patch 1 (probably somewhere in
page_add_file|anon_rmap()) to make sure folio_size() is always smaller than
COMPOUND_MAPPED / 2)?

-- 
Peter Xu

