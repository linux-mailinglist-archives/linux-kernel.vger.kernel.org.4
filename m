Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18F6E71CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjDSDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDSDq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63F3A92
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BidvjcPxv5bVtBPmZvYaf07HxADy64iIUYa9+IepKCI=; b=LM3V3nEoZyBUZ/sGnuQJIQ8ySd
        64Z4mQK2X8i4fGjib1IlmNb0zNz6+VIusENvcct70kufkRghvkU4lQsPEPh1ZRuk80c+qy/SeJ05C
        zaa7F3e/kyAC+k6RZuznt6azwqvPMaPNtZv4W3j3W/Qh6toBXsAvlAWnwgrvMNBR4LP38SxF5LcAH
        L5nAwmCxBl2cILSe4V9vhCXNhSlRrjbXI/um2qltnpVZhXLjNKDlMd5BLXi0CsW8RWSYdxN5uB7+u
        x/kfzYvljfAYOUqhOLDWcVC8RRkjXRtMQ9xIAE2bZQx5D2HrE+lmnBQ+6cBS7andiPysghtYPIMPU
        X15I+B8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poymP-00Cw0o-J5; Wed, 19 Apr 2023 03:46:49 +0000
Date:   Wed, 19 Apr 2023 04:46:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Message-ID: <ZD9kKTsPVlzlEZLp@casper.infradead.org>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:16:37PM -0400, Waiman Long wrote:
>  1) App runs creating lots of threads.
>  2) It mmap's 256K pages of anonymous memory.
>  3) It writes executable code to that memory.
>  4) It calls mprotect() with PROT_EXEC on that memory so
>     it can subsequently execute the code.
> 
> The above mprotect() will fail if the mmap'd region's VMA gets merged with
> the VMA for one of the thread stacks.  That's because the default RHEL
> SELinux policy is to not allow executable stacks.

By the way, this is a daft policy.  The policy you really want is
EXEC|WRITE is not allowed.  A non-writable stack is useless, so it's
actually a superset of your current policy.  Forbidding _simultaneous_
write and executable is just good programming.  This way, you don't need
to care about the underlying VMA's current permissions, you just need
to do:

	if ((prot & (PROT_EXEC|PROT_WRITE)) == (PROT_EXEC|PROT_WRITE))
		return -EACCESS;

