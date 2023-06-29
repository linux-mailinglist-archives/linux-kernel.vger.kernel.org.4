Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35947742D64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjF2TU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjF2TUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:20:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A2C3A98;
        Thu, 29 Jun 2023 12:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CC6361600;
        Thu, 29 Jun 2023 19:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC3FC433C8;
        Thu, 29 Jun 2023 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688066328;
        bh=Hn/Tt7hlIr+QmKqvZiH75scl6AlCHCF2VqhTStwBfRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Piu5rACK+FNY8+FlyN05/7HkZj4V1kPdkUkeuPvQiP7GHkm3wdAji7vjLQYlgXiZk
         k0E4L3o0RSkzIgKjYiIPEFI14C4YYWtWaGPKxPzJ6boApyuuxwwfRkeRrsQxleoXTi
         bSrQpAAAQE3zN8gzLK8j19EPWDLCGjz249qTeGOQ=
Date:   Thu, 29 Jun 2023 21:18:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-usb@vger.kernel.org
Subject: Re: UBSAN spat in valid xhci code in Linus's current tree (6.4+)
Message-ID: <2023062943-sixtyfold-flap-e7a0@gregkh>
References: <2023062945-fencing-pebble-0411@gregkh>
 <202306291147.4CE126CE5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306291147.4CE126CE5@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:58:43AM -0700, Kees Cook wrote:
> On Thu, Jun 29, 2023 at 05:36:51PM +0200, Greg KH wrote:
> > Boris just reported to me a UBSAN splat in the USB xhci driver in
> > Linus's tree that wasn't present in 6.4-final, and given that no USB
> > changes are merged yet there, I was confused.
> > 
> > Turns out, I think you all missed a "variable length" structure in the
> > xhci driver, which UBSAN is calling out a being an overrun, when really
> > it isn't (it's just written that way...)
> > 
> > The splat is:
> > 
> > UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31
> > index 1 is out of range for type '__le32 [1]'
> > CPU: 0 PID: 1556 Comm: kworker/0:2 Not tainted 6.4.0+ #7
> 
> This is fixed here, a couple weeks ago, but maybe it missed your tree:
> https://lore.kernel.org/lkml/20230614181307.gonna.256-kees@kernel.org/
> 
> Would you prefer I carry it?

To confirm, that's already in my tree and will be going to Linus for
6.5-rc1.

thanks,

greg k-h
