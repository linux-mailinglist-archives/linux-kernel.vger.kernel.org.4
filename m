Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5079369B8AE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBRIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:17:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB62C649;
        Sat, 18 Feb 2023 00:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD00CB82EB1;
        Sat, 18 Feb 2023 08:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036B4C433EF;
        Sat, 18 Feb 2023 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676708234;
        bh=BNbl3BOcb+TlBY9OXcmytUp8bjBVyH+3E4aP7IoRNH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWJYFb5xLWZn4MAB7/ao/J1LRMuU1xsaMmdRB79QEBVq4atB/HfbpRH6JVr3J0sjw
         krdibM1Q7MV4zfR2QmsCk/RPIPeSGhNkSunqTYhWSxTvmahfgTwPK9NUgMfuFPIcXf
         QYeOLp65+hSqgEP2QbMbHQfcRUHhOn3YpBtQSJc8=
Date:   Sat, 18 Feb 2023 09:17:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Moon <quic_johmoo@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, Jordan Crouse <jorcrous@amazon.com>
Subject: Re: [PATCH RESEND 1/1] check-uapi: Introduce check-uapi.sh
Message-ID: <Y/CJhzSJ5YKvD7my@kroah.com>
References: <20230217202234.32260-1-quic_johmoo@quicinc.com>
 <20230217202234.32260-2-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217202234.32260-2-quic_johmoo@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:22:34PM -0800, John Moon wrote:
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a patch introduces changes that break backwards
> compatibility.
> 
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
> 
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
> 
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the patch to detect any changes.
> 
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
> 
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>  scripts/check-uapi.sh | 245 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100755 scripts/check-uapi.sh

Ok, this is very cool, thank you so much for doing this.

I know Randy Dunlap was also looking into this previously, so I've cc:ed
him and bounced him the original.

I tried this out, and at first glance, this felt like it was just "too
fast" in that nothing actually was being tested.  So I manually added a
field to a structure I know would break the abi, and:

	$ ./scripts/check-uapi.sh
	!!! ABI differences detected in include/uapi/linux/usb/ch9.h (compared to file at HEAD^1) !!!

	    [C] 'struct usb_ctrlrequest' changed:
	      type size changed from 64 to 72 (in bits)
	      1 data member insertion:
		'__u8 abi_break', at offset 16 (in bits) at ch9.h:216:1
	      3 data member changes:
		'__le16 wValue' offset changed from 16 to 24 (in bits) (by +8 bits)
		'__le16 wIndex' offset changed from 32 to 40 (in bits) (by +8 bits)
		'__le16 wLength' offset changed from 48 to 56 (in bits) (by +8 bits)

	0/1 UAPI header file changes are backwards compatible
	UAPI header ABI check failed

So it worked!

There is a mismatch of different bash coding styles in the document, which
isn't a big deal, and one warning produced by the `shellcheck` tool, but that
can all be fixed up later.  I'll go queue this up now, as a starting point for
people to play with, thanks!

Also, it would be nice to be able to check if the current tree with changes in
it (not checked in, just modified) breaks the abi, without having to go and
check the change in.  But again, future fixups for people to do!

thanks,

greg k-h
