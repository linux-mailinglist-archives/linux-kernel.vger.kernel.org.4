Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3646D4CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjDCQBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjDCQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19509198C;
        Mon,  3 Apr 2023 09:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61990620B9;
        Mon,  3 Apr 2023 16:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DFC433EF;
        Mon,  3 Apr 2023 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680537700;
        bh=S0wrhQf1xkX4hkrC4Q9bMLfjBCQPk4ChYmPap7j4OeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G46Hf5wKA8mrDrgtLiYeTG6invMxAmJPmBUkXKilTqvvQzh+He1Mza4H6IF3uj/0h
         A55wWuyW3dTBJ9vQbys6HNu4qkxSiEu9WjgpjgGOSuHSYonTg7s7U0vQyb5GG6SZtV
         jbLVCjzCwmAxkUyU8EywMhTzFCgZWeL8Zg5eIDMI=
Date:   Mon, 3 Apr 2023 18:01:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 3
Message-ID: <2023040305-childlike-stew-4f8e@gregkh>
References: <20230403202412.66d43f13@canb.auug.org.au>
 <20230403155147.GA239124@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403155147.GA239124@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:51:47AM -0700, Nathan Chancellor wrote:
> Hi Stephen (and Greg, just as an FYI):
> 
> On Mon, Apr 03, 2023 at 08:24:12PM +1000, Stephen Rothwell wrote:
> 
> ...
> 
> > Merging driver-core/driver-core-next (43ba3d4af7a7 pktcdvd: simplify the class_pktcdvd logic)
> 
> ...
> 
> > Merging char-misc/char-misc-next (48a6c7bced2a cdx: add device attributes)
> 
> There is a semantic conflict between these two trees:
> 
>   drivers/cdx/cdx.c:393:8: error: incompatible function pointer types initializing 'ssize_t (*)(const struct bus_type *, const char *, size_t)' (aka 'long (*)(const struct bus_type *, const char *, unsigned long)') with an expression of type
>    'ssize_t (struct bus_type *, const char *, size_t)' (aka 'long (struct bus_type *, const char *, unsigned long)') [-Wincompatible-function-pointer-types]
>   static BUS_ATTR_WO(rescan);
>          ^~~~~~~~~~~~~~~~~~~
>   include/linux/device/bus.h:129:42: note: expanded from macro 'BUS_ATTR_WO'
>           struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
>                                                   ^~~~~~~~~~~~~~~~
>   include/linux/sysfs.h:135:11: note: expanded from macro '__ATTR_WO'
>           .store  = _name##_store,                                        \
>                     ^~~~~~~~~~~~~
>   <scratch space>:30:1: note: expanded from here
>   rescan_store
>   ^~~~~~~~~~~~
>   1 error generated.
> 
> caused by commit 75cff725d956 ("driver core: bus: mark the struct
> bus_type for sysfs callbacks as constant") in the driver-core tree
> interacting with commit 2959ab247061 ("cdx: add the cdx bus driver") in
> the char-misc tree. The following diff fixes it for me, could it be
> applied to the merge of the char-misc tree (if I am reading the order of
> your merges correctly)?
> 
> If there is a better or more appropriate way to report this, please let
> me know.
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 67c32cb2c006..38511fd36325 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -363,7 +363,7 @@ static struct attribute *cdx_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cdx_dev);
>  
> -static ssize_t rescan_store(struct bus_type *bus,
> +static ssize_t rescan_store(const struct bus_type *bus,
>  			    const char *buf, size_t count)
>  {
>  	struct cdx_controller *cdx;


A patch was already sent for this:
	https://lore.kernel.org/r/20230403140416.28183-1-nipun.gupta@amd.com

and yeah, I knew this would happen, I'll fix it up when the trees go to
Linus for -rc1.

thanks,

greg k-h
