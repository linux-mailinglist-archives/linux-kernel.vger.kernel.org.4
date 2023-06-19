Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8C735DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjFSTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52F3118
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687203684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKoKC0b+LCjcSl2EVWbdFRgACSV8gQthNjDiIthburU=;
        b=CZSIYjYILznvOaWyV7XdNytwygJU4wNDSfKMIPqOGiM6004pr+nfpUDzSZlZUzZed22iO6
        Iydu++cWIx8gyTWTPWhsgwU/FRZU/ITXOlyT6FpwcZ+fjSSxWCSm6pf6KRCQtSLEM0xvyI
        Aa6RhE7NYg7B3UZ7AxYqiFYyNaz62WI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-PGwI8LK-MtG0uTRcO5ItAw-1; Mon, 19 Jun 2023 15:41:23 -0400
X-MC-Unique: PGwI8LK-MtG0uTRcO5ItAw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f871a1e3f9so6857181cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203683; x=1689795683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKoKC0b+LCjcSl2EVWbdFRgACSV8gQthNjDiIthburU=;
        b=RU54m/NOfiS3ex8q/c4RISTbe0RHJZbePejCAlLpNm95WDm2+IskUwAa5nnlevi115
         494Urpic+YOk2dH4EgTpkrA9eAE08FaQ+Fipb7K7uQqzXoGxj3EMTZqExm0l+dNv2Co3
         ULjZd3VSRs4AWR0SmplwwuYWRpFv5I8H0/EhFsh6eNw1/zZIg61UEkNSeWLzmoJPaMJN
         5Y5nu5eo05bqF4ajXSkvM21WTldK9RGVFHh2Rr5EpQNtj5Bj2Uzm3AECnfcJzUlm1EAZ
         hxbvX3616U/NVmE5gacmSxPuSzEXc1SnowXs6r3txU5Z/7Uo+C8aEyxyovnmOxa+wveM
         6zuQ==
X-Gm-Message-State: AC+VfDwx26MvULdFEir6s+joXKwkNREdCRBquc3fGFS4D60qugSQ9say
        NquyJ4/uCAmnOKZE+qkqzugBmqWQINTFO+J0QvHeJ23e49nlDOHD91TNoJLc1oc3CcP1A3yV3RR
        3uDFLcG+8+Mkg/WXH+bU7wTy2
X-Received: by 2002:ac8:5842:0:b0:3f9:ab2c:8895 with SMTP id h2-20020ac85842000000b003f9ab2c8895mr14600248qth.3.1687203682937;
        Mon, 19 Jun 2023 12:41:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZzRjTvhMgkKAzruDtjbgbAepbDf8LrZ+k0sJu+iGWmbjsg+ceTUlHogXIsQHR6jn4iNlczA==
X-Received: by 2002:ac8:5842:0:b0:3f9:ab2c:8895 with SMTP id h2-20020ac85842000000b003f9ab2c8895mr14600233qth.3.1687203682664;
        Mon, 19 Jun 2023 12:41:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g4-20020ac84684000000b003ef1586721dsm227166qto.26.2023.06.19.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:41:22 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:41:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 7/7] mm/gup: Retire follow_hugetlb_page()
Message-ID: <ZJCvYOLhBH3H6CLT@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-8-peterx@redhat.com>
 <c1d768b3-f573-42f1-8c11-f2e5c05f72d4@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d768b3-f573-42f1-8c11-f2e5c05f72d4@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:40:41PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jun 13, 2023 at 05:53:46PM -0400, Peter Xu wrote:
> > Now __get_user_pages() should be well prepared to handle thp completely,
> > as long as hugetlb gup requests even without the hugetlb's special path.
> >
> > Time to retire follow_hugetlb_page().
> 
> Nit, but there's a couple left over references to this function in comments
> in fs/userfaultfd.c and mm/hugetlb.c.

Indeed, let me touch those too when respin.

> Absolutely wonderful to see such delightful code deletion :)
> 
> I haven't really dug into the huge page side of this in great detail, so I
> can't give a meaningful tag, but I can certainly appreciate the code you're
> removing here!

Yeah, hopefully it'll make the code also cleaner.  Thanks a lot,

-- 
Peter Xu

