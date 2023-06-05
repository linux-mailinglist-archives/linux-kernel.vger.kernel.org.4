Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8172D7233A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFEXVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjFEXVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0377EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRXQhr6Dm3ymhC0jzT0pfYiXzM0Uq7n/YxR/cyHEmIA=; b=YSdVKC3fWOJS70SlEOhFjVfyFP
        JTP4wwHp9sCyg4swkQXruPp+3qPadUhnKb7/My3XHSnm0fQxdnb4fKtonOeC0h10fP8p6XZQeYni3
        cXqiXPGR1YXB/rpy812QdT/6qHpNmndRwMqi9QMjjSQZTxFV3hRryf0TZIhtTztRPAgpInP91syzh
        rx51Rsl9RxbYEIzAVhxQfNq/tHIlFMe7CADDmA8FMHnNimjxWUaG0zqXyU/M3DSP5+1vFWP0pXrc0
        ZbkOByPTlajykwnq5Or36m+TZciMwAkaIx6Njc9JKkvnhEkbsCV2McE00dw9bqYN14gs5j+9RyRtk
        xmnD31/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6JW4-00H812-04;
        Mon, 05 Jun 2023 23:21:36 +0000
Date:   Mon, 5 Jun 2023 16:21:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] kthread: Unify kernel_thread() and user_mode_thread()
Message-ID: <ZH5t/7OTE8mC+RVh@bombadil.infradead.org>
References: <20230603015302.1768127-1-chenhuacai@loongson.cn>
 <20230605161052.033ebe4cecc0a9c879d43f56@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605161052.033ebe4cecc0a9c879d43f56@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:10:52PM -0700, Andrew Morton wrote:
> On Sat,  3 Jun 2023 09:53:02 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:
> 
> > Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> > and umh") introduces a new function user_mode_thread() for init and umh.
> > 
> > init and umh are different from typical kernel threads since the don't
> > need a "kthread" struct and they will finally become user processes by
> > calling kernel_execve(), but on the other hand, they are also different
> > from typical user mode threads (they have no "mm" structs at creation
> > time, which is traditionally used to distinguish a user thread and a
> > kernel thread).
> > 
> > So I think it is reasonable to treat init and umh as "special kernel
> > threads". Then let's unify the kernel_thread() and user_mode_thread()
> > to kernel_thread() again, and add a new 'user' parameter for init and
> > umh.
> > 
> > This also makes code simpler. 
> 
> Seems fair enough.

I thought Eric still disagreed?

  Luis
