Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A305D6F1247
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjD1HTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbjD1HTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274419D;
        Fri, 28 Apr 2023 00:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C93611B9;
        Fri, 28 Apr 2023 07:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736EFC4339C;
        Fri, 28 Apr 2023 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682666362;
        bh=SBNac9jS/BNRjGAVVN/JSSN0yPxOjtUBPHY5Mv3soH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQccHbknLU/UZyOV6gPCWgClywqH+bzAnio+39gZpuQ3d+ZnPpZ3bQWZ240uny4fD
         HxJARrL3JyA6bTkL4CaoAuaIQox5L/svg7saVXXbsV+UynGV7jjOOhUgJ4KwhPi1jx
         NavFzDtn3nTyzphYDAoo5kGu8groasq8DMDmk/MI=
Date:   Fri, 28 Apr 2023 09:19:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Konrad =?iso-8859-1?Q?Gr=E4fe?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Message-ID: <2023042842-embattled-collected-8638@gregkh>
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
 <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 08:56:59AM +0200, Rasmus Villemoes wrote:
> On 27/04/2023 13.51, Konrad Gräfe wrote:
> > The CDC-ECM specification requires an USB gadget to send the host MAC
> > address as uppercase hex string. This change adds the appropriate
> > modifier.
> 
> Thinking more about it, I'm not sure this is appropriate, not for a
> single user like this. vsprintf() should not and cannot satisfy all
> possible string formatting requirements for the whole kernel. The %pX
> extensions are convenient for use with printk() and friends where one
> needs what in other languages would be "string interpolation" (because
> then the caller doesn't need to deal with temporary stack buffers and
> pass them as %s arguments), but for single items like this, snprintf()
> is not necessarily the right tool for the job.

But sprintf() already creates mac address strings today, adding
yet-another-modifier makes it so that we don't have to hand-roll this
type of logic in the individual drivers that require it.

thanks,

greg k-h
