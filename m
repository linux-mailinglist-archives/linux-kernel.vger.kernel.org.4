Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526F5F37AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJCV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJCV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB595B7B8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664831821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDq2aLp/FgG9bJgxiiUy2Vo1uVdxseE75P7hxe9A1A0=;
        b=bM+jm6Qe8UbVG38HepGU5+rzNGUQCDFAmr7ux2FlH8JWtVtPA6IPXH1E1uyaUIajDCzeSI
        w9pGKAP85vhJGReWW6t8FAN8b/iW3SSmCSMi+CJibDbXTiPgnf6pEFqiE3In0ZuTQdGnoo
        5G5abjflfg0OO/mGAoTMU8e723JR5iI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-VtHNbt3TPaiK94zqz0r8DQ-1; Mon, 03 Oct 2022 17:17:00 -0400
X-MC-Unique: VtHNbt3TPaiK94zqz0r8DQ-1
Received: by mail-qt1-f199.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so8109801qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yDq2aLp/FgG9bJgxiiUy2Vo1uVdxseE75P7hxe9A1A0=;
        b=Z3EFEhpq01rRbeNnk1JIxkHu+L/Ur6MlAYMi4y5pizUXY9PkAz4eaVDujJRVp2Y+nr
         mNqw5NZNizMH8J/O3uuSIHixFu3rpxAseIJ8Ly8B4zmA2QeB70T4pa1xuWggC2wH3lIZ
         6OFz+TN4jPiPRl/gNffJCOQVhuYnFSZWyv5E4w0OkYEpfTNfoFaQ9bos2lyOgyHTldm3
         dhwrZLKiWJ86tO8XMSmzPZ/hiwfWBgAkh3/jnoaIFKJz81+wwefQes62QN/F3kJEQDtb
         9WdYQ4WrixE7V0HyLdczGHLfw3PzO4mgj8vi4WlRB8XvK8vWqSLbquqwf0/lIQ0NyvJ3
         W/gQ==
X-Gm-Message-State: ACrzQf3Vfrxwub2Z6hrBZldSaFilzwHnukiPEaOAMEc+R/dVgBtzazGh
        /PzdKvWjRxfZtLJod+QYLyRAhjAxKbaj3tQMMthlsWy8KkjESb3SIa5YkKxbh0q43+PVtbNxzMK
        Sq9QbJvRRecUqciBcY1jAtK92
X-Received: by 2002:ae9:e8c3:0:b0:6cf:5ed0:2109 with SMTP id a186-20020ae9e8c3000000b006cf5ed02109mr14877016qkg.253.1664831819458;
        Mon, 03 Oct 2022 14:16:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SZlqkT0U+6Cvh13pMnEk4getg+MtGiZceGmAdqfbS5hL6KnwRj4x/XoNJ6dcyGlP6cJcwwg==
X-Received: by 2002:ae9:e8c3:0:b0:6cf:5ed0:2109 with SMTP id a186-20020ae9e8c3000000b006cf5ed02109mr14877001qkg.253.1664831819281;
        Mon, 03 Oct 2022 14:16:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id e9-20020ac86709000000b0035d44917542sm10363073qtp.37.2022.10.03.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 14:16:58 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:16:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
Message-ID: <YztRR35U6gI/CA4r@x1n>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
 <BBCFE41B-9ABB-49C1-BDC7-EAF07964A6FF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BBCFE41B-9ABB-49C1-BDC7-EAF07964A6FF@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 02:00:36PM -0700, Nadav Amit wrote:
> On Oct 3, 2022, at 8:56 AM, Peter Xu <peterx@redhat.com> wrote:
> 
> > 
> > +			 */
> > +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
> > +				ret = hugetlb_handle_userfault(
> > +				    vma, mapping, idx, flags, haddr,
> > +				    address, VM_UFFD_MISSING);
> > +			else
> > +				/* Retry the fault */
> > +				ret = 0;
> 
> Might be unrelated, but at least for the sake of consistency if not
> potential GUP issues, don’t you want to return VM_FAULT_RETRY ?

VM_FAULT_RETRY implies releasing of mmap sem, while we didn't?

-- 
Peter Xu

