Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F46DE50A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDKThl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDKThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A9170D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681241810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2iLylKyf9CWd+Ko8Fo82kxeTfBeJkxjxQ+kN++CquoQ=;
        b=BrWSFnj8gKvaauaLJKc3G7eCWpPXk2BxNnEFJvw3oC/BrA0Mt7GDf5yvRovjaGgQfRps4o
        YXIJMTwYDVW8Rc0UOtSnkWsghk0PzR+y3ANhQj3dN/wBruqgQ6KHQCTlcmhOxkIrA/kwab
        xzy7407f4oD3aulovlOWNihIZFtxqCI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292--63_7VDAO_-8d06lemEC-Q-1; Tue, 11 Apr 2023 15:36:48 -0400
X-MC-Unique: -63_7VDAO_-8d06lemEC-Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74a25fcda05so62347385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241808; x=1683833808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iLylKyf9CWd+Ko8Fo82kxeTfBeJkxjxQ+kN++CquoQ=;
        b=lgTaMSqSSHQ4FCzaks9BD3TJ1ZRtwPfwHmRpaNv9/iO9L4qLe+KlEURrd+wvc7hcfB
         qCbzAyw7Dfy5fmvKI+FXZ+bIPzmVGFUYlC1WtVfrjPnGYZY8I3h5ACDbUStRh/BHabpt
         4Mjjt1tGzNO2RrthKgHYa+Hyi7nsWV2S0THIgDWVQcuSt6MHa+yanJDOl4K0XTzrhAeA
         C1Ij+HMdEZG8QXbEqFrFATXgBS1Db30+5YuK9+vv5jz9EzPfYK1Sf2agSOE0F2D1Aiy6
         vdeRSANTmCWIIbG6vFvI4NpixXZkWJjs9I9CVL8X8Q9n/QGk03mAA6Uo0o5sgmgDlItI
         wUKw==
X-Gm-Message-State: AAQBX9fXue9yxoA9NFGFx/5hIpAJrZjajgACFcySOti/mPEv5p1pDg7A
        HXV+GvTjYBYefo5apP5Dg39bbU8qDNJF82SnFgW318G/Gk59EUQ0kG9F9VSagFylkghSFP4AEdF
        LBIeHFQpIgLHr7E9TEbt6Dddb
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr291616qta.0.1681241808265;
        Tue, 11 Apr 2023 12:36:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXJ+//63+GCuRoUpJa34Zp5n07IJmCf8T5KTS/fp15gAFqW94VPnIi+HqI9tyJrIUPd2e1Gw==
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr291576qta.0.1681241807906;
        Tue, 11 Apr 2023 12:36:47 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o191-20020a3741c8000000b0074abe1e1457sm151734qka.76.2023.04.11.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:36:47 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:36:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 19/29] selftests/mm: Let uffd_handle_page_fault() takes
 wp parameter
Message-ID: <ZDW2zvnbbOfQt4/o@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160812.3107522-1-peterx@redhat.com>
 <ZDU8CrPcr1Dclehj@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDU8CrPcr1Dclehj@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 01:52:58PM +0300, Mike Rapoport wrote:
> On Thu, Mar 30, 2023 at 12:08:12PM -0400, Peter Xu wrote:
> > Subject: selftests/mm: Let uffd_handle_page_fault() takes wp parameter
> 
> Nit:                                                 ^ take
> 
> > Make the handler optionally apply WP bit when resolving page faults for
> > either missing or minor page faults.  This move towards removing global
> 
> Nit:                                        ^ moves

Will fix.

> 
> > test_uffdio_wp outside of the common code.
> > 
> > For this, slightly abuse uffd_stats to keep one more parameter on whether
> > we'd like to resolve page faults with WP bit set.  Note that only the name
> > is abused, it'll be better to be called uffd_args or similar but let's not
> > bother for now.
> 
> Maybe one of the first commits in the series should have been
> s/uffd_stats/uffd_args/g, but I realize that it's PITA, so I won't insist.

It's fine, I'll add one patch.  The rebase does take some more minutes, but
it's manageable.  I'll drop this paragraph then.

Thanks,

-- 
Peter Xu

