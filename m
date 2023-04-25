Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33AE6EDB21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjDYFT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDYFTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:19:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06E1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 22:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6593C62B61
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F5FC433D2;
        Tue, 25 Apr 2023 05:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682399963;
        bh=JzbtWfpHA7agQRdePHrbhbGiywJxe0fEQ297CfKr1H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pEoRb03u6A8QPS9o7aSkRe6brpj1QYhGiX3LM7/Us1hQvAQwwvfGUFqymsX1DQItj
         qHBxYPC06d+ZZZnWj/adu0ALPFFs2Oehu4d/xPNzCsXxN0mMv6bCqiaGPA2D5hSlNS
         Wj4r3VUt8QO2evwI7R6L+2HPkRaVnovM/v4pGZNM=
Date:   Tue, 25 Apr 2023 07:19:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [RFC PATCH 1/3] Revert "binder_alloc: add missing mmap_lock
 calls when using the VMA"
Message-ID: <ZEdi2Gd_eWiJ1CrP@kroah.com>
References: <20230424205548.1935192-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424205548.1935192-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:55:46PM +0000, Carlos Llamas wrote:
> This reverts commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde.
> 
> This caused a performance regression particularly when pages are getting
> reclaimed. We don't need to acquire the mmap_lock to determine when the
> binder buffer has been fully initialized. A subsequent patch will bring
> back the lockless approach for this.
> 
> [cmllamas: resolved trivial conflicts with renaming of alloc->mm]
> 
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)

Why is this series "RFC"?  What needs to be done to be able to submit it
as a real patch series?

Also, as the commits you are reverting are in older kernels, please
properly cc: stable in the signed-off-by area, and add a fixes: tag for
the commit you are reverting when you resend these as a real series.

thanks,

greg k-h
