Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7F730433
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbjFNPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjFNPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F8A1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686757892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gx5mIGJbC2RshKNPwZeqJT3qT5qrlHQNaZU0SSca/wY=;
        b=PDppFL9x0lA7sSA0kDBgZxRCBtzvcM7Za9gAR/SOg4oozOtno6oJST+F1JTX1y75ZSGx01
        /rnKYVzdA1mexonF1CpG/3KYy3Z1/WcDpLG4JHBG/kdsygznfCChYuVChOvM2PTRKs6ni7
        ZwysWeIAXYtr/m/607zqztcJ+yKgMA8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IzGFfriXN-evX8R48sYipw-1; Wed, 14 Jun 2023 11:51:30 -0400
X-MC-Unique: IzGFfriXN-evX8R48sYipw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-78f229d2217so33977241.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757890; x=1689349890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx5mIGJbC2RshKNPwZeqJT3qT5qrlHQNaZU0SSca/wY=;
        b=MArWT3McY3K1yDYyqjLMtDpQQ3qITbQnf3F4an2UHXETkt1yz3t47TwKnAr5o7Y0lU
         NTKBQzMuDuia2vSgBJJg/NgI3r2r2444F0/525kF+TEzp8dpdSbmGVcGvCyuF4k8i0nQ
         aFg0jpPaN2zmILH2eUYFavkM1TRsil0JOQ0nt4T4aH/LFU0/5TfV0pTTL6/CvJSnL2aE
         tyAJcVC+HvaEZnP0HNKorpwudfTjlRYEitHC0xss7humopAKCc9m5l9eAUttpUInypaY
         4mX2LMaFw21ojEs6pYbf7BsmlTpdJw912kB+py6T8ZDse+vvdLqUdU0RoVvbsYzU5bFA
         WYLA==
X-Gm-Message-State: AC+VfDyMAYZUzm6LsLrE1db7JM7Iw2e+KXRJ/bRx8acxJkQAL7Ee/4Cn
        M6iKbfvNcrBZESmAR6XbxVpe791oxFfRvwkaYxOSsPxioBvEU8hIqEjHCRwc7vq5c1Biljxnmd1
        xZbasods4vwPg0q4TSVMyJ9KU
X-Received: by 2002:a05:6102:390e:b0:43d:ecba:57d3 with SMTP id e14-20020a056102390e00b0043decba57d3mr5809633vsu.3.1686757890158;
        Wed, 14 Jun 2023 08:51:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YWRXgNTEb2Dq8Ia2QatMeTechjbZLoRWlFtVHbRiS/UMriwUxzHyaITTrU68b4zQk7vMUXA==
X-Received: by 2002:a05:6102:390e:b0:43d:ecba:57d3 with SMTP id e14-20020a056102390e00b0043decba57d3mr5809614vsu.3.1686757889866;
        Wed, 14 Jun 2023 08:51:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id n9-20020a0ce489000000b006260c683bf2sm1493153qvl.53.2023.06.14.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:51:29 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:51:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Message-ID: <ZInh//34yuKNuuX8@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
 <ZInYh3cVUil9R/cf@x1n>
 <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
 <ZIndN9isc4pTp2zK@x1n>
 <38574ed3-ea96-a72e-00dd-4e6204413a86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38574ed3-ea96-a72e-00dd-4e6204413a86@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:47:31PM +0200, David Hildenbrand wrote:
> Right. Then just call patch #2 "Add missing write-permission check" and this
> patch "Support FOLL_PIN in hugetlb_follow_page_mask()" or sth. like that.
> 
> Regarding the backport, I really wonder if patch #2 is required at all,
> because I didn't sport any applicable FOLL_WRITE users. Maybe there were
> some? Hm. If it's not applicable, a single "Support FOLL_PIN in
> hugetlb_follow_page_mask()" patch might be cleanest.

Yeah, I agree.  The code is definitely needed, not the split of patches if
no need for a backport.  Let me merge then.

-- 
Peter Xu

