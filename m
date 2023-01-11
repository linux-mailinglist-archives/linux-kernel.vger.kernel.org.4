Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42D6651B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjAKCZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjAKCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:25:40 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95983
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=stucP06R0qWVO+IUCALRaxe+XhbUCnMB6X6QtRA9Sko=; b=ZCQNIzOYkwHUig19qLe9/5Og8q
        plEZTfpntHXpPR5LLxIQLVI6G+DN6Javys4capsQOnmps842Cu+tLBfFtfztFEzKVlmJCEsfHWU/a
        jyCuKHe6BUcQyouIjz9X+iHCMgstdtldYHv9cNg9gI3hqDRcAaxZYki0gfRodDeusobi9rAsbcTzX
        kZ9mrhw631XTWHTQ8r+S4ZdWIQdWeNfnTnQNp2ikqynb2zXdB8BbsxdDTAAN5dUFDjRGcBo4JoaYM
        L1mV1XB7xTcS5PcH5zATfz/p/2dJsllUt6dX1cBs2tAZ7U3OXZEh8A+j+eBVB3E+mqc2A2ECwyW4/
        262EZcOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFQo3-0016gd-2Z;
        Wed, 11 Jan 2023 02:25:35 +0000
Date:   Wed, 11 Jan 2023 02:25:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
Message-ID: <Y74eH0+++0HqHXV7@ZenIV>
References: <20230109182843.12056-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109182843.12056-1-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 07:28:43PM +0100, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/cramfs is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
> of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().

Applied (#work.misc).
