Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76C735F55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFSVog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFSVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637FA4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687211032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RLoob+M/nR1AIL2pYIs2Zh5ySzQr5e7siB01cUwFeGY=;
        b=Qn2UC0RRo8BmxharEwDTT/aLnujW7qZyo4P4S0izSZcHMgnjoPDjQlLWV3JNBwBXFKXOBM
        5zt+JdfN5WTzvj/BvD+TLp1+/+IAe0jnscaoI1g31FU3L17a02z6G2INXNVDgzOGpbXtCD
        TTNdQuh0oEUIkZC56rZseFeZ7/G5rXw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-uIiWVrQQPnOFswHMfA7_jA-1; Mon, 19 Jun 2023 17:43:51 -0400
X-MC-Unique: uIiWVrQQPnOFswHMfA7_jA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62ffa1214edso8231326d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687211031; x=1689803031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLoob+M/nR1AIL2pYIs2Zh5ySzQr5e7siB01cUwFeGY=;
        b=k2WjI6Mnbwx02RpGjCIWoMjqqha0R6jQcRokSQMjuVyqpM7ywNRd3ZrYc1jT6tO3W5
         jcN4SCUTBtt6Ht97xFszSpv3IzVxqLcVqPcgdEnHRA5HLQRzTYQvV+1nT/VzFOqt+RJX
         bbNpqK1nf5f1f+oTVqQXN4vw9+xscgQFhNyxOz293l5oJ4KGS3fxQodmJHOJ/xIQRrWz
         3NP+2jaRfGXEiGxSLh2Uks76t8i6noJmZYmU0dQCF2qCOFlHZU5hx8TmnwG2sP48wEeN
         xRg3tceOxvkO/WP7K3gkAC8kdKPQBGSScT4qlAjA+BqJ4BYAtDp2HxtLDIDP2fkCdmHU
         Q6mw==
X-Gm-Message-State: AC+VfDxe46ktI8klU25G7LqqvcyyoUqN1Li9LgXs50fMcZ2X2RTcXIwG
        mMAgDO6qwwQSozUiB1tJaQBrNorntGGYP79P0AOotwIz6rMiofhoJS4LVex/tDR/bs26Tpq3v2g
        nTuk8jZGMsJ4ZV4mDVzU2PCJaNeq3xSKOdOH/+JzhfKtXcA5IW79sSmq22e0HuAqjqN+nREXmlR
        +sNakjjQ==
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr13057103qvb.3.1687211030790;
        Mon, 19 Jun 2023 14:43:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nTJLtt5TUY5GP0l3LO0MdhzE5hTrhflyMc4sxVPF63LR69+bfy2e06TzUrA2twyZRV0FFnA==
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr13057083qvb.3.1687211030448;
        Mon, 19 Jun 2023 14:43:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w1-20020a0ca801000000b006301bae200bsm429214qva.15.2023.06.19.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 14:43:49 -0700 (PDT)
Date:   Mon, 19 Jun 2023 17:43:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 3/7] mm/hugetlb: Add page_mask for
 hugetlb_follow_page_mask()
Message-ID: <ZJDMFDUZdGngQbzw@x1n>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-4-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:53:42PM -0400, Peter Xu wrote:
> @@ -6506,6 +6507,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>  		 * because we hold the ptl lock and have verified pte_present().
>  		 */
>  		WARN_ON_ONCE(try_grab_page(page, flags));
> +		*page_mask = huge_page_mask(h);

Sorry, I was wrong this line.  It should be:

		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;

This can be exposed if we bypass fast-gup and also specify pin npages>1.
Probably overlooked in my initial round and I'd guess fast-gup just all
succeeded there..

I'll temporarily drop the R-bs for this patch, so reviewers can have
another closer look in this one.

-- 
Peter Xu

