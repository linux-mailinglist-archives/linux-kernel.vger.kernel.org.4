Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54571603443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJRUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJRUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:48:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313D992F46
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D17CCE1F44
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126F6C433C1;
        Tue, 18 Oct 2022 20:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666126115;
        bh=P6k+X2Ai9pNSICARBLUIHi5bfxxrR8+fcrOLLgDCqoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nDutzFJoC2fg7q4fAovUcZqagUmLNWvHfLO6OmKj3YCfcnRcalNXlr7tYnssu7LXK
         0peKP7CSS/qgOF49UbaSPJgBvsERlIo0GXjS/q2Ia6G3zH9XsWOWRa9kxt+fJcrwHW
         ThW6O2OU4LZ0iQsrMSUi1pZX39CYdC8DNE0mkca8=
Date:   Tue, 18 Oct 2022 13:48:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tuo Cao <91tuocao@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: folio-compat: fix bug for pagecache_get_page
Message-Id: <20221018134834.97e685f9a9445c4553ce158b@linux-foundation.org>
In-Reply-To: <Y066q/QNrBSRjPux@casper.infradead.org>
References: <20221018143639.5099-1-91tuocao@gmail.com>
        <Y066q/QNrBSRjPux@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 15:39:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Oct 18, 2022 at 10:36:39PM +0800, Tuo Cao wrote:
> > The folio returned from __filemap_get_folio may be a NULL, it will
> > causes the kernel crash when access folio->page.
> 
> This is not a bug.  &folio->page does not dereference folio but performs
> pointer arithmetic.

This is the third attempt to "fix" this.  So far.  I think we should
take the hint and make the check for a null pointer more explicit.

