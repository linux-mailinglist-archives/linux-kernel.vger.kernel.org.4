Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8D73D946
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFZIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFZIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3DAE7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687767075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUsVECAHLrmaJYpk+Nn2dS1lmU/QQyFZdqFXTwAdThA=;
        b=e9VZRzNe2hkkcWkdDYRXzvJ5vCI6R+j5O6rOYI7lJrxzsXoORi/3G3W1dJ/9VfqnEzuYA+
        zk0p7d5K5SUm1F3Ogz+Xm/xcFhmub+SdqlQhCBFgUwYfaufT3rJvJctKAdZOvShFUk9qsw
        Rr94WfikaBuF38MucU2tOwiJjTIiGF0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-kBXmB8qWOh2PTsjummTHYg-1; Mon, 26 Jun 2023 04:11:14 -0400
X-MC-Unique: kBXmB8qWOh2PTsjummTHYg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31275586740so1717770f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687767073; x=1690359073;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUsVECAHLrmaJYpk+Nn2dS1lmU/QQyFZdqFXTwAdThA=;
        b=CLPb4gZQ/SCUlzPpbxsadCXtpkynUyHF0GDNaG25NZ7mzymNAq+wh1OKhpAuqjc9W1
         IW7xL+nZV5g353cNeqc2qb4Kmp+uOcTIwa8VMefJ226VnWBfoIJqI/Gs1y4U5lTwa0dl
         b+cymdUDc6IsLsy6W1ueBIiGBWWPSHiktNP1w64TxE4v8h7Rsjw+NU7EG0xfTC0mEUk+
         +qSnKvnlc1BSD//EzUgW0x8Q2HF3Ac9WOEaiMFpNnthsD5h5IfLIdvwDuRQMkvHVmXHm
         SmA858AX/M8ryjCYuFuRsq5WpezFu6zEWtWWh2IIQiYLKGuaSC13TYD0VBT3+ljZ+RXH
         NH4w==
X-Gm-Message-State: AC+VfDzJLtG5/qP8nkggDE+0QdEuoKm9OIoqUT7j3oiLs+H3+oFnYsi5
        Lnygr9ctHo13kp9eULSeyvAso/omQd3dOK3jnB0C8LbeZrkPeXyNANNhDKRLuz9rJJGH9R54mz1
        xrSch7qCWD4C3DLjOoMLYc4Vt
X-Received: by 2002:a5d:4dc7:0:b0:30f:d12a:d0b5 with SMTP id f7-20020a5d4dc7000000b0030fd12ad0b5mr21970865wru.55.1687767073233;
        Mon, 26 Jun 2023 01:11:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Gtp8sZIKIhnkPVgSBJnBy5AnfsqhjWuG0Ovror8xCc17YdLNdfEMgobWcv+EIg2anXWJLvg==
X-Received: by 2002:a5d:4dc7:0:b0:30f:d12a:d0b5 with SMTP id f7-20020a5d4dc7000000b0030fd12ad0b5mr21970853wru.55.1687767072971;
        Mon, 26 Jun 2023 01:11:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:7300:2ef6:6cd6:703c:e498? (p200300cbc74b73002ef66cd6703ce498.dip0.t-ipconnect.de. [2003:cb:c74b:7300:2ef6:6cd6:703c:e498])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030aefa3a957sm6573001wrs.28.2023.06.26.01.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:11:12 -0700 (PDT)
Message-ID: <2e8bb0a4-b887-deaf-898b-75226313127d@redhat.com>
Date:   Mon, 26 Jun 2023 10:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 8/8] selftests/mm: Add gup test matrix in
 run_vmtests.sh
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-9-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230623142936.268456-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.23 16:29, Peter Xu wrote:
> Add a matrix for testing gup based on the current gup_test.  Only run the
> matrix when -a is specified because it's a bit slow.
> 
> It covers:
> 
>    - Different types of huge pages: thp, hugetlb, or no huge page
>    - Permissions: Write / Read-only
>    - Fast-gup, with/without
>    - Types of the GUP: pin / gup / longterm pins
>    - Shared / Private memories
>    - GUP size: 1 / 512 / random page sizes
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

