Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E568661B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBAMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:42:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729ECC;
        Wed,  1 Feb 2023 04:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92EAF616B5;
        Wed,  1 Feb 2023 12:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E1C433EF;
        Wed,  1 Feb 2023 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675255353;
        bh=B/9yrCHIcQUofIyFV+uTLHtBaZhO5omPRzVaS8zAKyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8oe/0Gjt6kJUa2ASSOy+5tFHMZPUBRAdwVkRZvGa8hhIubYhnkpNHyc3wLvptni8
         XPfR6GLFNA4djG5ADJuQt88bw3eU7XUL7evQP1asWstJjboZwWSaD4Yj7zEc5pIlns
         M/cpnN5N4VOXCWOSrNharsKdsdjaKoefxyM8pDM8=
Date:   Wed, 1 Feb 2023 13:42:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <Y9peNbWUR9JmTJbo@kroah.com>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:52:30PM +0100, Thorsten Leemhuis wrote:
> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes. This is a huge and frightening task for quite a few
> users these days, as many rely on pre-compiled kernels and have never
> built their own. They find help on quite a few websites explaining the
> process in various ways, but those howtos often omit important details
> or make things too hard for the 'quickly build just for testing' case
> that 'localmodconfig' is really useful for. Hence give users something
> at hand to guide them, as that makes it easier for them to help with
> testing, debugging, and fixing the kernel.

First off, this is great, thanks for doing this.

One minor comment, to prevent people from "overloading" the
git.kernel.org systems:

> +.. _sources_sbs:
> +
> + * Retrieve the sources of the Linux version you intend to build; then change
> +   into the directory holding them, as all further commands in this guide are
> +   meant to be executed from there.
> +
> +   If you plan to only build one particular kernel version, download its source
> +   archive from https://kernel.org; afterwards extract its content to '~/linux/'
> +   and change into the directory created during extraction.
> +
> +   In most other situations your best choice is to fetch the sources using git::
> +
> +          git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
> +            ~/linux/sources
> +          cd ~/linux/sources/

Ideally you should never do a "full clone from scratch" like this, as it
takes up loads of server resources.  The "best" way to do this is to
download the kernel git bundle, and then pull and resolve the remaining
bits.  It's explained, with a script to do the work for you, here:

	https://kernel.org/best-way-to-do-linux-clones-for-your-ci.html

Using that will save you time (the CI bundles are mirrored around the
world), and greatly reduce the server load (which is already high
enough.)

thanks,

greg k-h
