Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195166E1143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDMPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDMPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D382D43
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681400201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnRAYqvrD1PmMuBt3nn+tHPRfmulmbMbex6mnUU2ySE=;
        b=Te5BVWW3OWeffKyYCyWOSRr6gAUFKxWTi6SHjnHrewDYunHSuRURVx7qmtLNM7QaRgUt1O
        G4rLYK1N62Db/z6zMmBNI5Q1qJm/HPFoIk/U6oqOy5JFsM8W6up/rKQ8rV7w8MHYgyjPdM
        BgCda4tkCrc/9O5SGRhqAeYuEkRghW8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-87a08EHWMSarKiiAMlsFrw-1; Thu, 13 Apr 2023 11:36:40 -0400
X-MC-Unique: 87a08EHWMSarKiiAMlsFrw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e948dfe9c9so2693461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400200; x=1683992200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnRAYqvrD1PmMuBt3nn+tHPRfmulmbMbex6mnUU2ySE=;
        b=MCPDL2TUFyByDz8vc26pFdJgjEUCbOB8av4xWVmdE+TUfbERswHdLlhGPbsHoeTEcs
         poZdYHfhScTNNvqiHg/xoIxzoUEnLAGbzZMsj3iH+3wMgTuM7cUYqWVXeusj7cER703N
         CwkuldCwCFlRcGM5ulFXb9pWJjjilaUJsdTBhphKfFKVP0CvzPdFfoJjM9SIGAyHgAas
         yDSz2coGZsTHH4g/+U0Qz5+xd1iUtX0V6i4x21qr/Bhe7RpFknr52Iscpbf/TpW2NWNp
         CHJWfD/zA0KQhc3WC1NoIAaLl3tlZpA23aAMzpUr+YrUkVNyRn/SQwPn1aERhnfDioO+
         DFxQ==
X-Gm-Message-State: AAQBX9daK1J+0wIyWOUA87d0LmdSvFjWSW5QRYpmwfM360/ipOVX8/ck
        8r5R0TR3NngXI985uAY5M4sLv+Jcp5Y1BPJ9KKeBZFYsyVaOQxJVlD6e+XsUuXQoRi7S8Tnn/vr
        fDCP35L5y+jc4XqgB2d3E//zF
X-Received: by 2002:ac8:5908:0:b0:3e3:1d31:e37 with SMTP id 8-20020ac85908000000b003e31d310e37mr3730138qty.1.1681400200141;
        Thu, 13 Apr 2023 08:36:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350b9vhzrEvX5swzCb6Tu1bRcs4y8CYUACyKkpbNiFtUZnC80EHG2i4IDDk21vIwOyku+6MDBAQ==
X-Received: by 2002:ac8:5908:0:b0:3e3:1d31:e37 with SMTP id 8-20020ac85908000000b003e31d310e37mr3730104qty.1.1681400199852;
        Thu, 13 Apr 2023 08:36:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d23-20020ac847d7000000b003e4ee0f5234sm555068qtr.87.2023.04.13.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:36:39 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:36:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: RFC for new feature to move pages from one vma to another
 without split
Message-ID: <ZDghhTH2KtCeAwcZ@x1n>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n>
 <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n>
 <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
> So instead, we consider the whole address space as a virtual, anon file,
> starting at offset 0. The pgoff of a VMA is then simply the offset in that
> virtual file (easily computed from the start of the VMA), and VMA merging is
> just the same as for an ordinary file.

Interesting point, thanks!

-- 
Peter Xu

