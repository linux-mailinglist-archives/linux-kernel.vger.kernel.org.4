Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C34748EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjGEUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGEUNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD4E173B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TAqSZvBrVA5ulnUR04yLKG/QIDGzGFDcBotXrFut/iI=; b=VY2XPKhwqq4d9GAo+TWyqUYjxt
        imEkEQPBHIcaXVfMFRRqHGrnZaR4U0ogZOS5ExntaaMm1bgZ5IDUF9xTuWbEzQD109kVG9sJui4ar
        fRMqCmG4yFTA+mifhSr/Ur4agB/xSPx2QkcbD6ogkciR3uJTF+fvbmKYQybyiABsRdMDqILpdHiO6
        bcZggAZXJKk9t0f3dy3lR2oKJuQKNvwsL9GegqqrQG1Oe34yCkHj3Lb2XE6pk+hVHbv6NYMGOyaq6
        6wM/veh8j2HhRZeTn5NbrYtyyuIBSRPopaD8Bdsf8WwQeTc45d/En8wb7RAag8vXJBlJCcjE5ELaS
        b5pA6NNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH8s7-00AOCy-Ko; Wed, 05 Jul 2023 20:13:07 +0000
Date:   Wed, 5 Jul 2023 21:13:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/4] mm/memory: convert do_shared_fault() to folios
Message-ID: <ZKXO0/2sC3/dvLO7@casper.infradead.org>
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-3-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705194335.273790-3-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:43:34PM -0700, Sidhartha Kumar wrote:
>  	/*
>  	 * Check if the backing address space wants to know that the page is
>  	 * about to become writable
>  	 */
>  	if (vma->vm_ops->page_mkwrite) {
> -		unlock_page(vmf->page);
> +		folio_unlock(folio);
>  		tmp = do_page_mkwrite(vmf);
>  		if (unlikely(!tmp ||
>  				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> -			put_page(vmf->page);
> +			folio_put(folio);

This is _probably_ OK.  However, do_page_mkwrite() calls
vm_ops->page_mkwrite(), and I think it's theoretically possible for the
driver to replace vmf->page with a different one.  The chance of them
actually doing that is pretty low (particularly if they return error or
nopage!), but I'm going to flag it just in case it comes up.

Also, should we pass a folio to do_page_mkwrite() instead of having it
extract the folio from vmf->page?

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
