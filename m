Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924156D4B96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjDCPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDCPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914DB3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680534988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lK5YNXaya6hGDvluarLJ3PrXroCIynGO5rYCK52f0Ys=;
        b=do1OdaJ1H/7qE9bnvwkguTTevHdXWdf9D3wTB8GLmWdWup2dp6U3wv90bKgALn+0FIbHpG
        xFwo0nSMEgxtaDgKZWMbK+hbOPA6drM2kD1U6VtUNUPJkXhjebxZt3IcNFHeblhYZ39mVm
        np0NIff/aTdfnzcLKzY4eTb8YyYSFHM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Ce9JcU4RMqSm2meC-Plqqg-1; Mon, 03 Apr 2023 11:16:25 -0400
X-MC-Unique: Ce9JcU4RMqSm2meC-Plqqg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e1522cf031so9196231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK5YNXaya6hGDvluarLJ3PrXroCIynGO5rYCK52f0Ys=;
        b=ohQCMp4m2g+rfuAXicF8mKY34kYjZK1AzOQKd661+KDStSc+KUaGBZCtNAK7+9TI3f
         SBjiFjmrbZ9HBBNEtHvlJrDJVhdB0O1+6pez8QJ5lfJCYJ++Fl6U1p6kR+TtizeomROS
         atd4i4QU/LuX2z7cYQw6rxJEmOrdBEAEkgfBE3XA2mIUcesKKGMTnOuHF7UI57MViR9q
         NZELOGnSVn87jrhN3UkhiFPttMrWG6twpLBFr/szQELO91ABzAMfvPtyAW0l+1Txv4pJ
         izenPwF4nHFgaunSGRul0TgY8m8C7E7bs610l3HAJ7e2F0MzbVM2DUNhPPm+BdRLKI77
         6csQ==
X-Gm-Message-State: AAQBX9c4VThFtIVvWmzW8X9h+QspxaeH8WrYOwMExMs7MzmHmz/ocKg+
        kCNKu8JgYzMzt1APU+z3T5cJqgLMtultZAnBlLdOWeJaCahBDiSM5ujudpzvatXkAdo2FYNRzKh
        vSXm/6blYLw1ANtnO+89Teldm
X-Received: by 2002:a05:622a:1aa1:b0:3e3:8e1a:c30b with SMTP id s33-20020a05622a1aa100b003e38e1ac30bmr25606610qtc.1.1680534984889;
        Mon, 03 Apr 2023 08:16:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAzDpim/v9s09Ky3zn1VEBB9zCqh+JtA3x9ZFNrz9AYL43VbUuDGmBlYyzt5tUCR+ZmEHzGw==
X-Received: by 2002:a05:622a:1aa1:b0:3e3:8e1a:c30b with SMTP id s33-20020a05622a1aa100b003e38e1ac30bmr25606583qtc.1.1680534984587;
        Mon, 03 Apr 2023 08:16:24 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id z5-20020ac87105000000b003e64303bd2dsm2197685qto.63.2023.04.03.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:16:23 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:16:22 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into
 one
Message-ID: <ZCrtxs8Bc4MT9nYA@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160705.3106966-1-peterx@redhat.com>
 <20230331181535.GA12460@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331181535.GA12460@monkey>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:15:35AM -0700, Mike Kravetz wrote:
> On 03/30/23 12:07, Peter Xu wrote:
> > There're already 3 same definitions of the three functions.  Move it into
> > vm_util.[ch].
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/mm/hugetlb-madvise.c | 25 +-------------------
> >  tools/testing/selftests/mm/thuge-gen.c       | 19 +--------------
> >  tools/testing/selftests/mm/userfaultfd.c     | 24 -------------------
> >  tools/testing/selftests/mm/vm_util.c         | 21 ++++++++++++++++
> >  tools/testing/selftests/mm/vm_util.h         |  1 +
> >  5 files changed, 24 insertions(+), 66 deletions(-)
> 
> Thanks!
> 
> Some of those copies were make by me.  Sorry.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

> 
> BTW - The same code (even with '... copied from mlock2-tests.c) resides
> in the selftests/memfd directory.  I did that as well. :( Suspect it is OK
> to leave the copy there.  But, it does make me wonder why memfd is not in
> the mm directory?

I don't know either, I suspect it was just a personal preference when it
was firstly introduced in:

        commit 4f5ce5e8d7e2da3c714df8a7fa42edb9f992fc52
        Author: David Herrmann <dh.herrmann@gmail.com>
        Date:   Fri Aug 8 14:25:32 2014 -0700

        selftests: add memfd_create() + sealing tests

So I left all those alone for now. Logically they should be merged into mm/
indeed, perhaps in some future cleanups.

-- 
Peter Xu

