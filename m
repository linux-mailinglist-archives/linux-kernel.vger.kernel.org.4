Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D805B3E21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiIIRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIIRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:47:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9AB5A6A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qfnke7dblFKnShWAE8ZArMDaS/a0/dP7yRank+zcTk=; b=USwc5j3XgrJaRE3PhufuvlzUPu
        q6I4EfGwx3VrN0XeWlw4EKJirsh0SkRyI8qdTBZXJ3jMk1uNgeNLkKnPH+5P6BPV/FtHwoC0t7OJE
        VnIpBHEBmnZjIKIsW45kqKDEav7vS7PHxRHLlxAjWeXIAxiquSLGZeb8gcy7hShUYxh6rvE9X8Iuv
        dyzfe/vFUrCio8plN4izduLpH0uFovOt81N/EAoOttYZvHCVmqeNM1CO47dqN/UxYWyzxA6mRmwsq
        DspeoROkoPNQOoQPz6O5C/YbcPPCAfTUEYbV91JxFaWfMZhuc0ms8ftgKOx7PueP7o85qXDhhGEdU
        CwIH4dOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWi5X-00DRY8-5w; Fri, 09 Sep 2022 17:46:47 +0000
Date:   Fri, 9 Sep 2022 18:46:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Cheng Li <lic121@chinatelecom.cn>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: use nth_page instead of mem_map_offset
 mem_map_next
Message-ID: <Yxt8B0zLImwXZLxR@casper.infradead.org>
References: <1662708669-9395-1-git-send-email-lic121@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662708669-9395-1-git-send-email-lic121@chinatelecom.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:31:09AM +0000, Cheng Li wrote:
> To handle discontiguity case, mem_map_next() has a parameter named
> `offset`. As a function caller, one would be confused why "get
> next entry" needs a parameter named "offset". The other drawback of
> mem_map_next() is that the callers must take care of the map between
> parameter "iter" and "offset", otherwise we may get an hole or
> duplication during iteration. So we use nth_page instead of
> mem_map_next.
> 
> And replace mem_map_offset with nth_page() per Matthew's comments.
> 
> Signed-off-by: Cheng Li <lic121@chinatelecom.cn>
> Fixes: 69d177c2fc70 ("hugetlbfs: handle pages higher order than MAX_ORDER")

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
