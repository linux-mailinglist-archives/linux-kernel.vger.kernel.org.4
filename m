Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0693572F46F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbjFNGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjFNGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4AE55;
        Tue, 13 Jun 2023 23:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A107D63D8D;
        Wed, 14 Jun 2023 06:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7329EC433C8;
        Wed, 14 Jun 2023 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686723046;
        bh=8V/Fk/7WEzGUAQBYpatFHYZXl7f2hEpMm3NyHxwcdMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4ymrVeDx/Z9BoPgMy9b53mv0nv6rkNygWU8u3ClW08BJBBxrpAXpj4J7scKfq+sT
         9Ij223+czfOKEi5lNsW7zlliUlWcYkULLVdWcFnmk1J6yzttqXsAqXYwpXHiXkrPti
         9BJQjmA4zbAB+pcRWFs+e2buDjIU2VVUoTY41ZlI=
Date:   Wed, 14 Jun 2023 08:10:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace 1-element array with flexible array
Message-ID: <2023061434-scenic-observer-d1d4@gregkh>
References: <20230613210400.never.078-kees@kernel.org>
 <ZIjzGCMWrar3kf1L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIjzGCMWrar3kf1L@work>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:52:08PM -0600, Gustavo A. R. Silva wrote:
> On Tue, Jun 13, 2023 at 02:04:04PM -0700, Kees Cook wrote:
> > With "-fstrict-flex-arrays=3" enabled, UBSAN_BOUNDS no longer pretends
> > 1-element arrays are unbounded. Walking wData will trigger a warning,
> > so make it a proper flexible array. Add a union to keep the struct size
> > identical for userspace in case anything was depending on the old size.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> 
> I always have mixed feelings about a 'Fixes' tag applied to a commit
> like this (one that enables a compiler option that avoids the introduction
> of buggy code), when we are addressing the potentially buggy code that
> the option is inteded to prevent. (thinkingface)

Yeah, the original code here is not incorrect, it's that you added a new
build warning, so this is more like an "update" :)

> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: kernel test robot <lkp@intel.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: "Jó Ágila Bitsch" <jgilab@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Odd that checkpatch.pl doesn't cc: the usb lists for this file.  I'll go
update the MAINTAINERS file with this location...

thanks,

greg k-h
