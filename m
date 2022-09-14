Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A45B8FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiINU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiINU6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7F482F8F;
        Wed, 14 Sep 2022 13:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE1261EFA;
        Wed, 14 Sep 2022 20:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC3BC433D6;
        Wed, 14 Sep 2022 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663189107;
        bh=13Kqr57N7WjSLCxogiNCCLJj2p5+iCJdoNC3K8yMzSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Akde85+OMf9K7zWrWyB8xjCRDyztlflzLDljpgIRiaNvhG1YuewX3TzsCsos/n0CF
         FSDkgjnoPrs/wbb6mdVtNpr9V/SIgYlHlSPnP5rKQDodKX5TsEBKejNy96oj2yAlrw
         8/yUPR2n+bMbVgfeBxozthIYbqniW3FLwGUj1BG0=
Date:   Wed, 14 Sep 2022 13:58:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Doug Berger <opendmb@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Message-Id: <20220914135825.88814aa1699e93c8a782abc6@linux-foundation.org>
In-Reply-To: <YyIN+bpKdCb3JuuY@monkey>
References: <20220913195508.3511038-1-opendmb@gmail.com>
        <20220913195508.3511038-3-opendmb@gmail.com>
        <YyIN+bpKdCb3JuuY@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 10:23:05 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 09/13/22 12:54, Doug Berger wrote:
> > When demoting a hugepage to a smaller order, the number of pages
> > added to the target hstate will be the size of the large page
> > divided by the size of the smaller page.
> > 
> > Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> > Signed-off-by: Doug Berger <opendmb@gmail.com>
> > ---
> >  mm/hugetlb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e070b8593b37..79949893ac12 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
> >  	 * based on pool changes for the demoted page.
> >  	 */
> >  	h->max_huge_pages--;
> > -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> > +	target_hstate->max_huge_pages += pages_per_huge_page(h) /
> > +					 pages_per_huge_page(target_hstate);
> >  
> >  	return rc;
> >  }
> 
> This has already been fixed here,
> 
> https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com/

Neither version tells us the user-visible runtime effects of the change :(
