Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312D748E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjGEUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjGEUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:03:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE118B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hYu/o3mpdq+vSG0rEUxmM7nw3556mrzLaeAJu/zu1Qs=; b=aZl41unkOjryNr+eFfIF42oXWU
        jOwgmOQmLrp6G7WW9S63RIPCZ2hiLgPxisQ+80/X9THBVSTXUg6p3ugVFumbTcjrgLUXGO1qq4uuR
        GGHASJA2Pp3fiwDakd2kGZT3YRPO/CQqGckFoQ6sE0M2+VkXWuOpGXP+LARV7YiBoNH6ItUfaiP6U
        TyJIgjPjUOzOHh3EXs5jaIeXA9djKcxKEXxKSn8omhSaqDC+hkvHK/nhifwj7LAdeRZ/VY+TmgXwo
        Gzo6eMbeC1cUm495Sl6RTbztKcONMs1iLnV2jC4eMUtn+wLfmAEuPthCLDaXoDJenTQR3F5qOOp5a
        KiZkA3kg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH8jA-00ANt8-05; Wed, 05 Jul 2023 20:03:52 +0000
Date:   Wed, 5 Jul 2023 21:03:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/4] mm/memory: convert wp_page_shared() to use folios
Message-ID: <ZKXMp84KxEvlsWKi@casper.infradead.org>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705194335.273790-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:43:33PM -0700, Sidhartha Kumar wrote:
> @@ -3375,7 +3375,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 */
>  		if (!vmf->page)
>  			return wp_pfn_shared(vmf);
> -		return wp_page_shared(vmf);
> +		return wp_page_shared(vmf, page_folio(vmf->page));
>  	}
>  
>  	if (vmf->page)

I was actually hoping you'd move:

        if (vmf->page)
                folio = page_folio(vmf->page);

up to immediately after the call to vm_normal_page(), and avoid even
this call to page_folio().
