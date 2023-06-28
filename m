Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE38740F56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjF1Kwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjF1KwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC28F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044756124A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BCAC433C9;
        Wed, 28 Jun 2023 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687949534;
        bh=XOk+D0ptRLMiKQhTIq0ppgcPPwQq7tyALdYYcUu+pjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vc62TVnKNu+AsmUZlVev8f1ajPfxYoCSc+Ez6rX7BtIKFXY7tLhtKc/RXtVjyBfqW
         KW7HcEhl2YN7vsr6oRjWMuj48tZOkUAWGL2ZREe5I9KdDr2sU64RuKiKozLxCQMGrT
         V+4sFzIN5SOoBEKa9CFwUfZ5dOPD5SEbr6nzcrl8=
Date:   Wed, 28 Jun 2023 12:52:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmap: Fix error return in do_vmi_align_munmap()
Message-ID: <2023062852-cyclic-presuming-6490@gregkh>
References: <ef2c7c0eeb166acf050597f49eb118d94f18bd39.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef2c7c0eeb166acf050597f49eb118d94f18bd39.camel@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:42:45AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> If mas_store_gfp() in the gather loop failed, the 'error' variable that
> ultimately gets returned was not being set. In many cases, its original
> value of -ENOMEM was still in place, and that was fine. But if VMAs had
> been split at the start or end of the range, then 'error' could be zero.
> 
> Change to the 'error = foo(); if (error) goto …' idiom to fix the bug.
> 
> Also clean up a later case which avoided the same bug by *explicitly*
> setting error = -ENOMEM right before calling the function that might
> return -ENOMEM.
> 
> In a final cosmetic change, move the 'Point of no return' comment to
> *after* the goto. That's been in the wrong place since the preallocation
> was removed, and this new error path was added.
> 
> Fixes: 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  mm/mmap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
