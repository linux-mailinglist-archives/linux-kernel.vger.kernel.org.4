Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00964A51D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiLLQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiLLQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:41:32 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AC11E17053
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:39:16 -0800 (PST)
Received: (qmail 857704 invoked by uid 1000); 12 Dec 2022 11:39:15 -0500
Date:   Mon, 12 Dec 2022 11:39:15 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5dZM68riR/EGn8W@rowland.harvard.edu>
References: <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
 <Y5cvPulXceujfZv6@hovoldconsulting.com>
 <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
 <Y5c3WWKyohzkspnw@hovoldconsulting.com>
 <Y5dH5RqY2yOK1bVj@rowland.harvard.edu>
 <Y5dR8X2mnytSCWrp@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5dR8X2mnytSCWrp@hovoldconsulting.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:08:17PM +0100, Johan Hovold wrote:
> The fact that USB core and driver core clears the pointer is an
> implementation detail which in principle could change.

With the new kerneldoc, the fact that the USB core clears the pointer 
becomes part of the API.  It is no longer an implementation detail but 
rather a guarantee that drivers can depend on.  (I.e., if it does 
change, all the USB drivers will need to be audited.)

>  The important
> part is that drivers generally should not touch the struct device or
> containing structure after unbind (and must do so with care otherwise).

While that certainly is an important point, it is not the point of 
usb_set_intfdata() or its kerneldoc.  The main reason for adding the 
kerneldoc -- Vincent's original motivation -- was to inform coders that 
drivers generally don't need to worry about clearing the data pointer.

A subtext was that clearing the pointer while the driver is still using 
it can lead to problems, but I don't think we need to mention this.  
It's pretty obvious.

Alan Stern
