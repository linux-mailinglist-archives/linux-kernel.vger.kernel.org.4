Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC74696DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBNTRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:17:17 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE2265BD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676402226; bh=l8yDtff1gWXfO5fO3HZQNDZSBJwMKEmNdwoGk2RtnFQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=V7A2Ai5xJS/RkU6cwNTgfu50506vYpHkXfnX6zR3+EZXsoBo1kx7HTHVrwPPyg5Pi
         J6USsfh5plu+zK5yQ1XjT6o0qiV4hg1MlUnd25ErrrACopEwcICQ6jxiNwCTcZ7Qao
         rean3sWdq3FYkXTlPmYJkGphbrAy7wZCjhARogns=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 14 Feb 2023 20:17:06 +0100 (CET)
X-EA-Auth: iIdBw9XMBoC/vIgII4q+yFa2w1RPR985bKWVI40ONeCX+BFAA8s/qw9VGGQFHay/NJAzJfRUabl46ClwnF9EmiZGlGaoZjTK
Date:   Wed, 15 Feb 2023 00:47:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: Query on mm/folio-compat: pagecache_get_page
Message-ID: <Y+veLBmkWIfOpWzL@ubun2204.myguest.virtualbox.org>
References: <Y+vRpvwNgwDB4MS0@ubun2204.myguest.virtualbox.org>
 <ce84bac6-b868-76f9-4678-d3eeed42eae3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce84bac6-b868-76f9-4678-d3eeed42eae3@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:35:33AM -0800, Sidhartha Kumar wrote:
> On 2/14/23 10:23 AM, Deepak R Varma wrote:
> > Hello,
> > Could someone comment if it is safe to access the page member variable as
> > written on line #100 when folio is NULL as returned from the
> 
> It is safe to access the page member variable when folio is NULL because the
> offset of page within struct folio is 0.[1]

Wow. This is so well thought. Thank you Sidhartha.

./drv

> 
> 
> [1] https://lore.kernel.org/lkml/Y7h4jsv6jl0XSIsk@casper.infradead.org/T/
> 
> Thanks,
> Sidhartha Kumar
> 
> > __filemap_get_folio() function call? Is this kind of intentional page-fault
> > trigger for the system to handle a new/fresh page allocation?
> > 
> > 	  2         folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> > 	  1         if (!folio || xa_is_value(folio))
> > 	100                 return &folio->page;
> > 	  1         return folio_file_page(folio, index);
> > 
> > The code is part of commit ID c5255b421fd04
> > 
> > Thank you,
> > ./drv
> > 
> > 
> > 
> 


