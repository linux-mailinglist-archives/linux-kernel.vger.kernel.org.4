Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF7967844F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjAWSSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjAWSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:18:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B586A75;
        Mon, 23 Jan 2023 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oIJtijJAfo7pkYR5UjBbFNIZgVF+VVBQIc+R8PBD3Zk=; b=augdeIPTUoKE/vgKlD6Pf9JBUK
        26l9wI+rlvx50HNr67FttXDJ7BrEngcLZUd/xhsA12HrsaKM+Epz7YLgQk+Cvw4OC3p8T9IJkzhEs
        NV7aSfnLxJMzuIID6a4CnZ4ZpGNb4zKERpLGQBqVd7itPqQjuBAPPbM0p+dE9pWwdiLrTibLVaT3J
        OMdgCLcBeVbKcsj0s6Vc+3bJG7h7DkLiV886LJbEdXYi4wveWiD6bN8jvyg7D8gJfkZAAM3YyRiWn
        1PEJtrViUT3f/3OWisCbWJccE0eXH+mDw3e/7lDHR3xnGi1LNfHtwj4Ny33xoFeHDduxNyDKRF59n
        V/PMv1Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK1Ok-004Qs4-Be; Mon, 23 Jan 2023 18:18:26 +0000
Date:   Mon, 23 Jan 2023 18:18:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] printk: Document that CONFIG_BOOT_PRINTK_DELAY required
 for boot_delay=
Message-ID: <Y87Pcu0ZJKOiQQRY@casper.infradead.org>
References: <20230123180440.901793-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123180440.901793-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:04:40PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Document the fact that CONFIG_BOOT_PRINTK_DELAY must be enabled for the
> "boot_delay" kernel parameter to work.  Also mention that "lpj=" may be
> necessary.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..b0b40b6a765c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -480,8 +480,9 @@
>  			See Documentation/block/cmdline-partition.rst
>  
>  	boot_delay=	Milliseconds to delay each printk during boot.
> -			Values larger than 10 seconds (10000) are changed to
> -			no delay (0).
> +			Enable CONFIG_BOOT_PRINTK_DELAY and also specify
> +			"lpj=".  Boot_delay values larger than 10 seconds
> +			(10000) are changed to no delay (0).

That's counterintuitive.  I'd understand clamping it to 10 seconds,
but not setting it to zero.

Also, there are two ways of reading this.  One is that by specifying
boot_delay=, lpj= is set to a sane value.  The other (intended?) is
that in order to use this option, you must also specify lpj=.
