Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFF742965
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjF2PWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF2PW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:22:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A262952
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:22:26 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7659dc74da1so74193985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1688052145; x=1690644145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=52QGPi56OcZzeoQSr1+Puoh9x/N7TMLxPpl1Fa9yAkI=;
        b=bQ+QaBv9kQgn0a/ZUWEzUp17QKK8mKbvu7OHRhiOucSgX3eSl924Wd32DWKpaETuWG
         AJZQFb8MZEkw10neO7Emyiwf0zs4rexcslIhj26xYbfhNY61Fs/S3zXUfnMd8nKlLHbq
         CU/gaxpgXz0Fcq+WROZl7v82TmZhyriMp8ghnPjAipqNQvOQZDcDHIDAAILg7qaaRj4g
         cROZVqbL1LvLpBfUtSNqoHdAU+QoeC+43TKUBXk9yEuGi9WwmY8edNie6xIXgtH/0lEz
         iYMbIENsQdCcb6GkheV3Ph/F1WPNpdDYyBYfX2SSNtzeR7J1HM4TRkmoUI53LbULfuQV
         wSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052145; x=1690644145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52QGPi56OcZzeoQSr1+Puoh9x/N7TMLxPpl1Fa9yAkI=;
        b=EoT3DZ8eJlbZV1P6WH06qhc9pIvGndjoCVTYM57JWbRbrij9gakFXqJdPWw3tC7WXk
         qVaoF4iqQeIVhi5kMKnaQhJ7jdb1anAoimiMS2v85aHArpF6Af85ZQF3l5JBAq8/iheF
         hi5vAmcKcahmp4LRA0SSLgpf0w6zykHKS1ZF2AI+U0fPZ2NzJLWSqKiwzxNu1Md6Yf88
         zUYJdD27g1uQp398IVouuSlljEczzDhXC8dZpfxTefOCKsPFZBAdIfDq2GMRqp/4bA+z
         WG1LZvlGcZl+d4+5g++UvGXbSOGMJOMXi23XmNzcH729awokf3t64VQngUzMhQ0sBwWe
         lkhQ==
X-Gm-Message-State: AC+VfDx0SSqo1mPPhRpUqS2B/edQhPr90QzHGPfyBzaNfoB6oqWKvea4
        WNCZmLzEfQZNFAy/VTE5yvPaeg==
X-Google-Smtp-Source: ACHHUZ49j4zxCkMnm+oSSx+2qlaiByXDG1BTDACn1CIjXnwSTZE7XCbDUFEFLrSlPKTofnqYvOeuSg==
X-Received: by 2002:a05:620a:e92:b0:767:90a:ae9e with SMTP id w18-20020a05620a0e9200b00767090aae9emr8621873qkm.65.1688052145311;
        Thu, 29 Jun 2023 08:22:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id r15-20020a05620a03cf00b0074e0951c7e7sm6340805qkm.28.2023.06.29.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:22:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEtTU-009snj-1H;
        Thu, 29 Jun 2023 12:22:24 -0300
Date:   Thu, 29 Jun 2023 12:22:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
 <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com>
 <20230628211624.531cdc58@thinkpad-T15>
 <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7c2851-1440-7220-6c53-16b343b1474@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:08:08PM -0700, Hugh Dickins wrote:
> On Wed, 28 Jun 2023, Gerald Schaefer wrote:
> > 
> > As discussed in the other thread, we would rather go with less complexity,
> > possibly switching to an approach w/o the list and fragment re-use in the
> > future. For now, as a first step in that direction, we can try with not
> > adding fragments back only for pte_free_defer(). Here is an adjusted
> > version of your patch, copying most of your pte_free_defer() logic and
> > also description, tested with LTP and all three of your patch series applied:
> 
> Thanks, Gerald: I don't mind abandoning my 13/12 SLAB_TYPESAFE_BY_RCU
> patch (posted with fewer Cc's to the s390 list last week), and switching
> to your simpler who-cares-if-we-sometimes-don't-make-maximal-use-of-page
> patch.
> 
> But I didn't get deep enough into it today to confirm it - and disappointed
> that you've found it necessary to play with pt_frag_refcount in addition to
> _refcount and HH bits.  No real problem with that, but my instinct says it
> should be simpler.

Is there any reason it should be any different at all from what PPC is
doing?

I still think the right thing to do here is make the PPC code common
(with Hugh's proposed RCU modification) and just use it in both
arches....

Jason
