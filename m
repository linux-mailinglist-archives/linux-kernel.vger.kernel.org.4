Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39346649C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiLLKhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiLLKgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:36:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34912A93;
        Mon, 12 Dec 2022 02:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB1F60F91;
        Mon, 12 Dec 2022 10:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4261AC433EF;
        Mon, 12 Dec 2022 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670841071;
        bh=dI96HzBm8XP9otEmF4T5UcXMtOhBqgVcxBe+ytP11y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljv2XyjufJi9wxXZns4IRRy0aw/SFYsxAGq93HPTEDlxydHCMNKOGOr/zL6oyfk2z
         NI1FUu6H4ZI+SGR7hMqtNW0qyqIj19Oq4hUAGY7w9k+EQBgKDbyRN/pQ8W+MJVv7Mb
         Odje4rgEoiRnpOEgfvrNGMfI8XGQ9TvIWNW+B3EGgu3/Ex61hR1E/96Fd5x3gafAWB
         RPUo+Ew3dP5y6IXeEmKhhACaCKwLpqXL7FBkEyMxLyrdPDdl7RlbxMorCfFCO23nSh
         QNPu6bFamZ3+7dooukRwGnrPzAAJNezdfWcD9mxlA0mZX5jFhwbu18jhHtRDy6q+WN
         pgONduXTXsP9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4g5t-0004Ag-4I; Mon, 12 Dec 2022 11:31:33 +0100
Date:   Mon, 12 Dec 2022 11:31:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:19:00AM +0100, Oliver Neukum wrote:
> On 11.12.22 13:06, Johan Hovold wrote:
> 
> > Due to a misunderstanding, a redundant and misleading kernel doc comment
> > for usb_set_intfdata() was recently added which claimed that the driver
> > data pointer must not be cleared during disconnect before "all actions
> > [are] completed", which is both imprecise and incorrect.
> 
> OK, but is that a reason to remove all kerneldoc? Kerneldoc is generally
> a good thing. And if a pointer is NULLed by driver core, that will need
> to be in it. IMHO you'd better just remove the questionable part of the
> kerneldoc.

Yeah, I started off with just rewriting the kernel doc and removing the
obviously incorrect bits, but then there is essentially nothing left of
the documentation.

A driver does not need to care that the pointer is cleared by driver
core after the driver is unbound. The driver is gone.

So this information isn't really useful and trying to document it for
only one of the subsystem wrappers probably only adds to the confusion
(e.g. by signalling that this is in some way relevant information).

Johan
