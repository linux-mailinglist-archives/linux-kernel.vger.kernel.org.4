Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F166CFC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjC3HL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjC3HLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:11:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299365B7;
        Thu, 30 Mar 2023 00:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27937B8261C;
        Thu, 30 Mar 2023 07:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B75C433D2;
        Thu, 30 Mar 2023 07:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680160279;
        bh=FlHNhQJDZf7ntHD5KuZYR/u8hEWLq2oX8p0cp1xWcnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yDbWpIeQYpXhHJfU8tR8TtzS3ra1g3m/xwutUVSeNMOAvnYaWZDzkTLbhewU7Zihj
         +yYCVMAIQa5Rl3+Q42HNR2OwtHnRmlJ5MH0WarVfORtMsbGmjrJnZKsiaDXYHSmcBf
         U9Wa226GR9b6wjAwnhPpUj1AOUF5Neb4bo0b5d+o=
Date:   Thu, 30 Mar 2023 09:11:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <ZCU2FBWqDQZFuWDL@kroah.com>
References: <ZCTrutoN+9TiJM8u@work>
 <ZCUzw9epJig2rTIY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCUzw9epJig2rTIY@google.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:01:23PM +0800, Tzung-Bi Shih wrote:
> On Wed, Mar 29, 2023 at 07:54:02PM -0600, Gustavo A. R. Silva wrote:
> > In this case, as only enough space for the op field is allocated,
> > we can use an object of type uint32_t instead of a whole
> > struct ec_params_vbnvcontext (for which not enough memory is
> > allocated).
> 
> It doesn't make sense to me.  See comments below.
> 
> > Fix the following warning seen under GCC 13:
> > drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
> > drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
> >    36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
> >       |               ^~
> > In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
> > In function ‘kmalloc’,
> >     inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
> > ./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
> >   580 |                 return kmalloc_trace(
> >       |                        ^~~~~~~~~~~~~~
> >   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
> >       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   582 |                                 flags, size);
> >       |                                 ~~~~~~~~~~~~
> 
> Please trim the commit message a bit and try to wrap at 75 columns as
> [1] suggested.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

For outputs from tools like this, going over 75 columns is fine, no need
to ever line-wrap stuff like this, that would just make it unreadable.

thanks,

greg k-h
