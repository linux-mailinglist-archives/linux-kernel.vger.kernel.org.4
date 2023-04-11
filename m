Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB26DE510
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDKTnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKTnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B711BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681242154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDGG6I72DGNLSlLBi7Xz84qe/ZKZYj60eVqrVPgCV+c=;
        b=WSkE7x7MXJlrnIIrOmBmnuE6Qh8Qi4Pdm8AVAyVpL3eAVyNBQdYcTwWkfrH3wCwJY11Ndi
        u9h9sTElJzqYVhAT7Ywra+MAyBUfGUSuT8+uIx5MU1sNRw9Kcoa34KXfiUau6/zgiiK8IZ
        19jfLfX89V+LO9lTOABt5e45d//qmpA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-MYvl6sYANAapU8StQ7OU9A-1; Tue, 11 Apr 2023 15:42:33 -0400
X-MC-Unique: MYvl6sYANAapU8StQ7OU9A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5e8ebec3e31so4263906d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242153; x=1683834153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDGG6I72DGNLSlLBi7Xz84qe/ZKZYj60eVqrVPgCV+c=;
        b=tNaxmz1gZs8AWgoquIcatZQzklbXit1Net1j1EHrgJp3YO8VyBEjozf/gixTEaIhju
         xHZb6LTkDKerke3lHh1jcfMmCyitf7fbIf3PHsYsswyyL/jjqG0Ug3uE0msqrj+ZeCCW
         xnXjNSybp55xrUIbkDTAtvppL832Hp4ag9lpvWGqmiqnuAHMUEz1dbWAP0n73KNX7hGx
         FYRorP5ocCSWUAwH0YAQ3MvfyNB+qDKRXmssI7X9tGUG777XQ/L5gypqt8VchCKc0d2Y
         gXCjWf0/MssJNQ9B6U3Ecd/DtWNfuHfggVGdsiKpEMSLX6ORhZyjvtJkaFjczlUo9Loe
         hMzw==
X-Gm-Message-State: AAQBX9cPl6geEGWoEKX30L6INrxeitbbP1EAZZrYpZ+mQPGCCu4JHAL7
        Folf9+Ikdyw/2NHZOrJaMJpByT1TCqE2Tbr4HrjLepu/7xGOaP2Fc6pPw53RWkvH0RWswomjuU2
        SsDdSVlQO7qo2O99ya+TB1Jq9
X-Received: by 2002:a05:6214:3016:b0:5df:55b5:b1a with SMTP id ke22-20020a056214301600b005df55b50b1amr490752qvb.4.1681242153353;
        Tue, 11 Apr 2023 12:42:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350b1ec2JaF/t4uHrZI54ZzDcHsbsRXV0xnsq3DieFoFTOvn6YjfJs0ypCL9RbMfJELZ9L5H4pg==
X-Received: by 2002:a05:6214:3016:b0:5df:55b5:b1a with SMTP id ke22-20020a056214301600b005df55b50b1amr490720qvb.4.1681242153069;
        Tue, 11 Apr 2023 12:42:33 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a025a00b0070648cf78bdsm4143980qkn.54.2023.04.11.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 12:42:32 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:42:31 -0400
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
Subject: Re: [PATCH 20/29] selftests/mm: Allow allocate_area() to fail
 properly
Message-ID: <ZDW4J5X/fnynwo5L@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160815.3107534-1-peterx@redhat.com>
 <ZDU+Rudfi2BUsMHP@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDU+Rudfi2BUsMHP@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:02:30PM +0300, Mike Rapoport wrote:
> On Thu, Mar 30, 2023 at 12:08:15PM -0400, Peter Xu wrote:
> > Mostly to detect hugetlb allocation errors and skip hugetlb tests when
> > pages are not allocated.
> 
> Wouldn't we want to skip anon and shmem tests as well for consistency?

Much less possibile (and useful) than hugetlb for sure, but it's indeed
more consistent.  Will do.

-- 
Peter Xu

