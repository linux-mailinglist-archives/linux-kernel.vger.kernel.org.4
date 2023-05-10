Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA36FE78A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjEJWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEJWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD80271F;
        Wed, 10 May 2023 15:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EB4640FE;
        Wed, 10 May 2023 22:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E3DC433D2;
        Wed, 10 May 2023 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683759124;
        bh=SfC29pkbPFsP7SvqkKQKsejqsVIjIBqmlouYzbhT+ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Erg8wLctyK2t2eLGbGIDKzcYMYdynzb6YP0fvPYdtvmRCA0HIUkXiKkOf4F86i4On
         /gAoGwte4tnDWGWIrYUDuYIg+I9Znik+4KZVnp+lMxH3g2x/3Fe3eDa0iD7K811y6r
         n4pD/uLiIJGwrvwTzme6mcOYZfRdLIABA20NFbMM=
Date:   Thu, 11 May 2023 07:51:58 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <2023051108-lens-unsocial-8425@gregkh>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085527.57953-1-lrh2000@pku.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:55:23PM +0800, Ruihan Li wrote:
> Recently, syzbot reported [1] ("kernel BUG in page_table_check_clear").
> The root cause is that usbdev_mmap calls remap_pfn_range on kmalloc'ed
> memory, which leads to type confusion between struct page and slab in
> page_table_check. This series of patches fixes the usb side by avoiding
> mapping slab pages into userspace, and fixes the mm side by enforcing
> that all user-accessible pages are not slab pages. A more detailed
> analysis and some discussion of how to fix the problem can also be found
> in [1].
> 
>  [1] https://lore.kernel.org/lkml/20230507135844.1231056-1-lrh2000@pku.edu.cn/T/

Can you see if you can implement Christoph's proposed change instead:
	https://lore.kernel.org/r/ZFuZVDcU81WmqEvJ@infradead.org

As it might not actually be as bad as you think to require this type of
churn.

thanks,

greg k-h
