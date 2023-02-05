Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4E68B207
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 22:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBEVyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 16:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 16:54:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC51817F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RqB01JKJ480rGCRYi3MYvZSD9xmxNgFCHWnDzGevnWU=; b=b/jQmwus8UqBO52yi5yoAjs+0+
        Qw1bl6n+lZ9ZuOrJcqjq0IJgLrLDVUlOjceBHenJBVxLOt6Qbj4t6VeiKA278aVxgNzWOyYNej8V5
        /YUQB1g58PWDL0XIVIWWYJvGiZtmpsJ/DmXVfZ1ldbZ6Z4w5Sjv9OSNZ6rE/D/zMlWU95llRlRDRR
        liWAo1GAe72kIuEYSooheLW3qizvGCZqzReY1H1huZkG0hN+GrAv3TGu/PddXJg+NeWg4T4ViQYs4
        RJ2VhHyk5M+P7uUF7qjHW9AhO1mA6v3xE51797pvc7vxI7YtImQAjewi5z6TQCpbuuyO/y6WxEL+H
        fc7w34Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOmxN-00GFYS-NP; Sun, 05 Feb 2023 21:53:53 +0000
Date:   Sun, 5 Feb 2023 21:53:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: eliminate function call overhead during
 copy_page_range()
Message-ID: <Y+AlcdA3fH0FiJGO@casper.infradead.org>
References: <20230205150602.GA25866@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205150602.GA25866@haolee.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 03:06:02PM +0000, Hao Lee wrote:
> vm_normal_page() is called so many times that its overhead is very high.
> After changing this call site to an inline function, copy_page_range()
> runs 3~5 times faster than before.

So you're saying that your compiler is making bad decisions?  What
architecture, what compiler, what version?  Do you have
CONFIG_ARCH_HAS_PTE_SPECIAL set?

Is there something about inlining it that makes the compiler able to
optimise away code, or is it really the function call overhead?  Can
you share any perf results?

