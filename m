Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20A6DDA97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDKMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjDKMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98535BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSKpztcZcWeU0kqRgz9frUyvV6Ecus1e6AXUQcG7EVg=; b=iIm8ek+8RoCroDqOegul4nnU9G
        fn+k7FBPrkSlGGlzMcBn1uip3KN+bWl5RrpHgjUiGpUThJ9ehvN6HtImi0PApeN20gma3lcr9DwYs
        GBbjYODLzLZAdzuYWya9CRZCpqn3YdGE/preUDPlc21mbwCr4p0ltdSXHiA1KGZvaReegUbopnFzl
        CJ6kNV62NZwbRdj/0rBGMGcHAGOZpfLtwZ+ZMMNIA9kPze5y+3zpq3vabFw4iJ/4SrVwk1Ze52BIp
        q3PsGFHHvPHbSXO8zO4XNCErP99CHupr22ClPJ9FEavw9unyEp7QcZLszAadOJIQ3jJzuJM6oDog6
        xkMJDkrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmCv4-005t7p-O1; Tue, 11 Apr 2023 12:16:18 +0000
Date:   Tue, 11 Apr 2023 13:16:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "xiaosong.ma" <Xiaosong.Ma@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        yuming.han@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH V2] fs: perform the check when page without mapping but
 page->mapping contains junk or random bitscribble
Message-ID: <ZDVPkljntjCr9/nX@casper.infradead.org>
References: <1681091102-31907-1-git-send-email-Xiaosong.Ma@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681091102-31907-1-git-send-email-Xiaosong.Ma@unisoc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 09:45:02AM +0800, xiaosong.ma wrote:
> perform the check in dump_mapping() to print warning info and avoid crash with invalid non-NULL page->mapping.
> For example, a panic with following backtraces show dump_page will show wrong info and panic when the bad page
> is non-NULL mapping and page->mapping is 0x80000000000.
> 
>     crash_arm64> bt
>     PID: 232    TASK: ffffff80e8c2c340  CPU: 0   COMMAND: "Binder:232_2"
>      #0 [ffffffc013e5b080] sysdump_panic_event$b2bce43a479f4f7762201bfee02d7889 at ffffffc0108d7c2c
>      #1 [ffffffc013e5b0c0] atomic_notifier_call_chain at ffffffc010300228
>      #2 [ffffffc013e5b2c0] panic at ffffffc0102c926c
>      #3 [ffffffc013e5b370] die at ffffffc010267670
>      #4 [ffffffc013e5b3a0] die_kernel_fault at ffffffc0102808a4
>      #5 [ffffffc013e5b3d0] __do_kernel_fault at ffffffc010280820
>      #6 [ffffffc013e5b410] do_bad_area at ffffffc01028059c
>      #7 [ffffffc013e5b440] do_translation_fault$4df5decbea5d08a63349aa36f07426b2 at ffffffc0111149c8
>      #8 [ffffffc013e5b470] do_mem_abort at ffffffc0100a4488
>      #9 [ffffffc013e5b5e0] el1_ia at ffffffc0100a6c00
>      #10 [ffffffc013e5b5f0] __dump_page at ffffffc0104beecc

This doesn't show a crash in dump_mapping(), it shows a crash in
__dump_page().

> diff --git a/fs/inode.c b/fs/inode.c
> index f453eb5..c9021e5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -564,7 +564,8 @@ void dump_mapping(const struct address_space *mapping)
>  	 * If mapping is an invalid pointer, we don't want to crash
>  	 * accessing it, so probe everything depending on it carefully.
>  	 */
> -	if (get_kernel_nofault(host, &mapping->host) ||
> +	if (get_kernel_nofault(mapping, &mapping) ||
> +	    get_kernel_nofault(host, &mapping->host) ||

This patch makes no sense.  Essentially, you're saying
	mapping = &mapping
which is obviously wrong.

