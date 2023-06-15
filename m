Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904ED732075
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFOTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFOTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1E2956
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686858147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcOpteduUqck9yvQgpJHjo+JwyvicD28FUiieKHhaT8=;
        b=coBraIC8yPmLTLDfhHZjQ8IQkkR9JGzCXb7WOaw9rINsvbqPbTVkJSMb8//8PSD1AeE58/
        GjV1oJVYTDheohFJSP+eooF4KBV5AdjORn9juh252d9IZZGdQDV7eff5mZpHpnXLTk2UbK
        AQ0XoP9nyXAYaION297HflTltpQlQ3I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-v45Pmu4INMyH2Y-O6hWOqQ-1; Thu, 15 Jun 2023 15:42:26 -0400
X-MC-Unique: v45Pmu4INMyH2Y-O6hWOqQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7621c759972so17356085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686858145; x=1689450145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcOpteduUqck9yvQgpJHjo+JwyvicD28FUiieKHhaT8=;
        b=YWJ02F2wDbIGZTT5sS3q272DUG2H4c8WcYiqxP7jOLlxmKdIOd301py6uUE7v+bICm
         Ygd1RF632P3o/y3IfvAOIqN7VSszjGve517TqYDGWgAGTJ6lkuZIQGIoJdSdXxwoIADT
         Ak/OuTQmLMGjGdTYm7U/oYiPkb2A288nbcsnPXP0P8gKIbl+cmGxDf5DVG7sv97LyLUS
         Y0fYPzGOyQhGRSjb3Jgf8wD91kMoRvXuE/+hcPu5K/xC06UwPa+aDOBbVPqfaXYsP1aT
         PfOVUHDMRs3ky225ETBK93qrtShN9kBzvmf8kHXrNP1Eipy4eOq0wyHWztbFOyzYDvrb
         NYOA==
X-Gm-Message-State: AC+VfDwiMXt5UinwUoLbQUPoREuMb035aMNVskuJGg+1ItIgoVfZNesJ
        7d4Hpe/vo/4QvPCs/mLJji3IHWfwKZK3izKHPW93w4xsJ0C3WdJvKd2VDWn434wE5CE0Vhd6EPe
        udC4x6xpAkoIrEceJtUak6A8c
X-Received: by 2002:a05:6214:f22:b0:625:8684:3406 with SMTP id iw2-20020a0562140f2200b0062586843406mr34400qvb.0.1686858145570;
        Thu, 15 Jun 2023 12:42:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eG2fiy35s+OEj/WEhtEEjuGtnQktBQRKTkC3B9+KcNyvhYrS9tXTaM3JWpqtH3iGie7+hlQ==
X-Received: by 2002:a05:6214:f22:b0:625:8684:3406 with SMTP id iw2-20020a0562140f2200b0062586843406mr34304qvb.0.1686858143137;
        Thu, 15 Jun 2023 12:42:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l19-20020a0ce513000000b006262725bc89sm249428qvm.73.2023.06.15.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:42:22 -0700 (PDT)
Date:   Thu, 15 Jun 2023 15:42:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Message-ID: <ZItpnQ/lW0kzaCKG@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
 <ZInYh3cVUil9R/cf@x1n>
 <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
 <ZIndN9isc4pTp2zK@x1n>
 <38574ed3-ea96-a72e-00dd-4e6204413a86@redhat.com>
 <ZInh//34yuKNuuX8@x1n>
 <20230615002525.GD38211@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615002525.GD38211@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:25:25PM -0700, Mike Kravetz wrote:
> On 06/14/23 11:51, Peter Xu wrote:
> > On Wed, Jun 14, 2023 at 05:47:31PM +0200, David Hildenbrand wrote:
> > > Right. Then just call patch #2 "Add missing write-permission check" and this
> > > patch "Support FOLL_PIN in hugetlb_follow_page_mask()" or sth. like that.
> > > 
> > > Regarding the backport, I really wonder if patch #2 is required at all,
> > > because I didn't sport any applicable FOLL_WRITE users. Maybe there were
> > > some? Hm. If it's not applicable, a single "Support FOLL_PIN in
> > > hugetlb_follow_page_mask()" patch might be cleanest.
> > 
> > Yeah, I agree.  The code is definitely needed, not the split of patches if
> > no need for a backport.  Let me merge then.
> > 
> 
> Should have read this before adding my RB to patch 2.  I assumed no
> backport.  Agree, than merging the gup_must_unshare here makes more sense.

Thanks for taking a look!

No worries, I'll make bold to just take your R-b over the merged patch when
I repost, according to your R-b in patch 2 and the comment here.  I hope
it's fine to you.

-- 
Peter Xu

