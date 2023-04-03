Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E476F6D4D58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B3A1725
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680538566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3WVVlCgDVu+so3CtUZvMFVtwTzfAtjj67XqfHbOtAk=;
        b=E6S52dVQoKjnxdDXUGoABHN/kng6Quo1jHQcTyxEhawIRmH5YS9/IYDuvMVXk74VUpyRDa
        e0goexJUVNxwRuuhQq55uHMIic7fjAqKMngKDXT+FfD1SdzUJicQLu+vdEuyMMrtioJHZs
        Q8KMJWlV+DYLQWok0Ebc1S2b2xdcHNw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Q7PsTagSP1OkfRWsW2pHRg-1; Mon, 03 Apr 2023 12:16:05 -0400
X-MC-Unique: Q7PsTagSP1OkfRWsW2pHRg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3e2daffa0d4so9301731cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3WVVlCgDVu+so3CtUZvMFVtwTzfAtjj67XqfHbOtAk=;
        b=0l3CYaq/yWYEyncB2mKwk6TXBOzVch02tY+1CO/3NpghbHiCOVkIxvjdbEwDWAdR87
         OJHjUKNjHmy43ywuY4zvptMCwejx58SB1tHocS1Kt+aeY4l1uXXCDB3eluyEpLKIujlq
         sLqHSWxRiIw+ryH28ysunw6r/plKL3UyY7qU2KumugyliQtOzsqRRmOyfeQmhDGEcIRO
         88PleweBV9a9ZRQuMbv1Qai+6ShEnmnNKxi0R3a9M/SB0ETEJ4VAR3DoFjZOl4CdIhCo
         O75tRRsVumlgtrUNodzD1nRnNfvZzwGZYULJIOVs6/RxNrevi20Sqb/KMj7ZlsfBiIw0
         LGxw==
X-Gm-Message-State: AAQBX9c16zjfUjOjsKdzdHvsZol69ClJDcGpqFr/6MP60wsv3rxTJYaq
        4J1wC9JLH2NTCkEDbj3SaFdpv2mTMAn0r0JI7aJurwRkRsJti195WqtwDMe6eB1QdCZrSergPUA
        RhctUd6HPBkbpk6wGPiJ3X0OvXqRmHk1d
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr25404665qtc.3.1680538564163;
        Mon, 03 Apr 2023 09:16:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350auaIF1EPMeG/FZ05u3bLup8PpepYVe1UIip6Lm/q9oxc9sQKzvvEMdN/9/Vh965nKg3bZ3Zw==
X-Received: by 2002:a05:622a:1802:b0:3e2:4280:bc58 with SMTP id t2-20020a05622a180200b003e24280bc58mr25404641qtc.3.1680538563912;
        Mon, 03 Apr 2023 09:16:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 203-20020a3707d4000000b00742a23cada8sm2854660qkh.131.2023.04.03.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:16:03 -0700 (PDT)
Date:   Mon, 3 Apr 2023 12:16:01 -0400
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
Subject: Re: [PATCH 11/29] selftests/mm: Drop test_uffdio_zeropage_eexist
Message-ID: <ZCr7wRBuhzupX06j@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160717.3107010-1-peterx@redhat.com>
 <20230401000317.GF12460@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401000317.GF12460@monkey>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 05:03:17PM -0700, Mike Kravetz wrote:
> On 03/30/23 12:07, Peter Xu wrote:
> > The idea was trying to flip this var in the alarm handler from time to time
> > to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
> > zeropage test so probably only used once, meanwhile we passed
> > "retry==false" so it'll never got tested anyway.
> > 
> > Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
> > is set (!hugetlb).
> > 
> > One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
> > because otherwise the test won't even pass!  We were just lucky that this
> > test never really got ran at all.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/mm/userfaultfd.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> Thanks!  With only passing "retry==false", that code is indeed dead.  I had
> to read the code again to understand area_dst_alias.  Thanks for taking this
> on as the code is difficult to understand.

Yes it's very confusing.  I plan to move on the cleanup to remove all these
global variables at least in the unit tests, but I'll first see how this
one goes.

> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks,

-- 
Peter Xu

