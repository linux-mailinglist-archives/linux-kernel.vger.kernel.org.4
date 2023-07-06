Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0097496B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjGFHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGFHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE61BD2;
        Thu,  6 Jul 2023 00:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B81E618A8;
        Thu,  6 Jul 2023 07:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AD0C433C7;
        Thu,  6 Jul 2023 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688629641;
        bh=/17w0SovEe1kBtPNU4fHwbUfm3kdD1YiuvUkvWUzO9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9UAhfxGEUdLzhhtlpVKH4g5wIpqrbaDhQhMux/6EZXgYeXS0a3aCq7nw/XUk8BRf
         ULXjj8pTJ2IvrYr//MHSDLZyfF9ZvRYwWO/2uS1ncH3U1PtTK1htaPeMZKO41JjaRq
         oiS5+J8njsZJ5iNch0vbkCBYZ8T6RgVQtwIDGp/I=
Date:   Thu, 6 Jul 2023 08:47:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array
 with flexible array
Message-ID: <2023070609-taco-deviation-3b4b@gregkh>
References: <20230629190900.never.787-kees@kernel.org>
 <2023062950-landowner-goofiness-d5d2@gregkh>
 <202307051408.E16A95E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307051408.E16A95E@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 02:11:03PM -0700, Kees Cook wrote:
> On Thu, Jun 29, 2023 at 09:17:23PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 29, 2023 at 12:09:00PM -0700, Kees Cook wrote:
> > > Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
> > > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> > > bmSublinkSpeedAttr will trigger a warning, so make it a proper flexible
> > > array. Add a union to keep the struct size identical for userspace in
> > > case anything was depending on the old size.
> > > 
> > > False positive warning was:
> > > 
> > > UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31 index 1 is out of range for type '__le32 [1]'
> > > 
> > > for this line of code:
> > > 
> > > 	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);
> > > 
> > > Reported-by: Borislav Petkov <bp@alien8.de>
> > > Closes: https://lore.kernel.org/lkml/2023062945-fencing-pebble-0411@gregkh/
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/uapi/linux/usb/ch9.h | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > Thanks for the quick response, I'll queue it up after 6.5-rc1 is out.
> 
> I'm going to send this before -rc1, since we've had another report[1] that
> was fixed by this. Given the verification there and Boris's testing, I
> think this is good to land. I'll toss it in -next now and send it to
> Linus on Friday after making sure there are no more surprises.
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org/

No problem:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
