Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A72470373E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbjEORSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbjEORSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:18:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A17100F3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AHOYe2O6ipqjEKRaZZV4XWwm4ubOqD2yjYCpCULGvl4=; b=RigTjP8Wce5qVC3pSlw+MZrqCq
        FjKPVUoS1wIdITC1nUL4KnFM1LQk06Fek+poL/kXYmaMZMdC7Hsbt/0z4wDw9GuqR9plPp+aSM5Bx
        Qd2dLvf5jMyosX+34l7D5SpE6XktPMSxiK6Wi9iN2ibOWrglwdbB4coSiRsjPblGqKVRDvU0Qswfm
        u7pMedrYy7eD5VL5OMoV1TeuhRv2NdQekQs4wcYKiPi+3YzYZQ8Ek8b80pe103Ui8GiOErYGRZvjD
        BFzKekwQxhgvNDR088YATrg0pgHVHMdFSJeAJJ7Bdf7RsmkQX3ScEQ3UpYHEvfyhFDa1B0CSDfCqt
        8sen7vzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pybo1-003bwj-SW; Mon, 15 May 2023 17:16:17 +0000
Date:   Mon, 15 May 2023 18:16:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <ZGJo4UhdyakGFwP7@casper.infradead.org>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515170809.284680-1-tsahu@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:38:09PM +0530, Tarun Sahu wrote:
> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	struct page *p;
>  
>  	__folio_clear_reserved(folio);
> -	__folio_set_head(folio);
> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
> -	folio_set_order(folio, order);
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		if (i != 0)
>  			set_compound_head(p, &folio->page);
>  	}
> +	__folio_set_head(folio);
> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
> +	folio_set_order(folio, order);

This makes me nervous, as I said before.  This means that
compound_head(tail) can temporarily point to a page which is not marked
as a head page.  That's different from prep_compound_page().  You need to
come up with some good argumentation for why this is safe, and no amount
of testing you do can replace it -- any race in this area will be subtle.
