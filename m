Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09BC68662B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBAMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:44:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10DC15E;
        Wed,  1 Feb 2023 04:44:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 725AFB8215F;
        Wed,  1 Feb 2023 12:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86BC433D2;
        Wed,  1 Feb 2023 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675255466;
        bh=1YxA1u8MlOPrRvH4KNo29BIw/DFjPlSZKW0yMcJyCEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ft2e22Q91Rw62Pv5gGIV1d1lFgE+Y8AILLUvibdELl3qq6UJoSww6HJ4qFIXTYKPz
         ubeyEtiv46LVJ5rPZbYq7Y6kdTPcejLaNTwnMUKX27ZKJ13yzFKDLcdriBrYTjlPTV
         561txRmFP2Vr3PwJU/Z94qlavOcUb81tzDJ8RX9A=
Date:   Wed, 1 Feb 2023 13:44:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <Y9pep+GBBaTiN/sN@kroah.com>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <Y9peNbWUR9JmTJbo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9peNbWUR9JmTJbo@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:42:29PM +0100, Greg KH wrote:
> On Wed, Feb 01, 2023 at 12:52:30PM +0100, Thorsten Leemhuis wrote:
> > Add a text explaining how to quickly build a kernel, as that's something
> > users will often have to do when they want to report an issue or test
> > proposed fixes. This is a huge and frightening task for quite a few
> > users these days, as many rely on pre-compiled kernels and have never
> > built their own. They find help on quite a few websites explaining the
> > process in various ways, but those howtos often omit important details
> > or make things too hard for the 'quickly build just for testing' case
> > that 'localmodconfig' is really useful for. Hence give users something
> > at hand to guide them, as that makes it easier for them to help with
> > testing, debugging, and fixing the kernel.
> 
> First off, this is great, thanks for doing this.
> 
> One minor comment, to prevent people from "overloading" the
> git.kernel.org systems:
> 
> > +.. _sources_sbs:
> > +
> > + * Retrieve the sources of the Linux version you intend to build; then change
> > +   into the directory holding them, as all further commands in this guide are
> > +   meant to be executed from there.
> > +
> > +   If you plan to only build one particular kernel version, download its source
> > +   archive from https://kernel.org; afterwards extract its content to '~/linux/'
> > +   and change into the directory created during extraction.
> > +
> > +   In most other situations your best choice is to fetch the sources using git::
> > +
> > +          git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
> > +            ~/linux/sources
> > +          cd ~/linux/sources/
> 
> Ideally you should never do a "full clone from scratch" like this, as it
> takes up loads of server resources.  The "best" way to do this is to
> download the kernel git bundle, and then pull and resolve the remaining
> bits.  It's explained, with a script to do the work for you, here:
> 
> 	https://kernel.org/best-way-to-do-linux-clones-for-your-ci.html

Oops, here's the full steps involved:
	https://www.kernel.org/cloning-linux-from-a-bundle.html
the first link above has a script that does it all for you, but you
probably just want to copy the steps at this last link instead.

thanks,

greg k-h
