Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760F6D6EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjDDVSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjDDVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974C4C08
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B54638C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C3C433EF;
        Tue,  4 Apr 2023 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680643044;
        bh=+e7SqpyZGiTrfR3lUQklNbqi4pTd3BmIJ0/CVHKgypE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CwmncR1kjliO9eTCZUICtnvkbDgebhr9QKeBjXAjLYTrM0RoU1hemb79pqnLIVFQU
         yy1d8xTomcuMKXr3qRmUsDRGrkPJAAY5YIUFvu2VsShGZsiYSZsCIV1h4zK+vz64Xj
         VxQyZvEC0YROFPIXpcvAJaQQE3QPYnIWS0lO9Tg8=
Date:   Tue, 4 Apr 2023 14:17:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "xiaosong.ma" <Xiaosong.Ma@unisoc.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [PATCH] mm: check mapping addr is correct when dump page
Message-Id: <20230404141722.45dbdc377e7e1547e302ffa5@linux-foundation.org>
In-Reply-To: <1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com>
References: <1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 13:50:25 +0800 "xiaosong.ma" <Xiaosong.Ma@unisoc.com> wrote:

> when we debug with slub_debug_on, the following backtraces show dump_page
> will show wrong info when the bad page is non-NULL mapping and page->mapping
> is 0x80000000000 so do virt_addr valid check is needed when dump mapping page.

How did this page get ->mapping=0x80000000?  I don't recall anywhere
where we deliberately set this state.

Maybe a random bitscribble?  I guess being defensive in __dump_page()
is sensible - we have reason to believe that the page is in some bad
state.

> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -109,7 +109,7 @@ static void __dump_page(struct page *page)
>                 type = "ksm ";
>         else if (PageAnon(page))
>                 type = "anon ";
> -       else if (mapping)
> +       else if (mapping && virt_addr_valid(mapping))
>                 dump_mapping(mapping);

I expect the user will be interested in knowing that ->mapping contains
junk, so perhaps we should print some information telling them this.

In which case, dump_mapping() would be a better place to perform the
check.

And lo, dump_mapping() already did this, so I think all we need is

--- a/fs/inode.c~a
+++ a/fs/inode.c
@@ -565,7 +565,8 @@ void dump_mapping(const struct address_s
 	 * If mapping is an invalid pointer, we don't want to crash
 	 * accessing it, so probe everything depending on it carefully.
 	 */
-	if (get_kernel_nofault(host, &mapping->host) ||
+	if (get_kernel_nofault(mapping) ||
+	    get_kernel_nofault(host, &mapping->host) ||
 	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
 		pr_warn("invalid mapping:%px\n", mapping);
 		return;
_



