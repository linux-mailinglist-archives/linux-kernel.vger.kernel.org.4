Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275A718826
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjEaRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEaRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:10:19 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8B951197
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:10:16 -0700 (PDT)
Received: (qmail 443922 invoked by uid 1000); 31 May 2023 13:10:15 -0400
Date:   Wed, 31 May 2023 13:10:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v2] usb: core: add sysfs entry for usb device state
Message-ID: <e63bd494-69f4-4c89-b761-93fd1dd420d8@rowland.harvard.edu>
References: <20230531010134.1092942-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531010134.1092942-1-royluo@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 01:01:34AM +0000, Roy Luo wrote:
> Expose usb device state to userland as the information is useful in
> detecting non-compliant setups and diagnosing enumeration failures.
> For example:
> - End-to-end signal integrity issues: the device would fail port reset
>   repeatedly and thus be stuck in POWERED state.
> - Charge-only cables (missing D+/D- lines): the device would never enter
>   POWERED state as the HC would not see any pullup.
> 
> What's the status quo?
> We do have error logs such as "Cannot enable. Maybe the USB cable is bad?"
> to flag potential setup issues, but there's no good way to expose them to
> userspace.
> 
> Why add a sysfs entry in struct usb_port instead of struct usb_device?
> The struct usb_device is not device_add() to the system until it's in
> ADDRESS state hence we would miss the first two states. The struct
> usb_port is a better place to keep the information because its life
> cycle is longer than the struct usb_device that is attached to the port.
> 
> Signed-off-by: Roy Luo <royluo@google.com>
> ---
> Changes since v1:
> * Address Greg Kroah-Hartman's comment: replace sysfs_notify with
>   sysfs_notify_dirent and remove the workqueue.
> * Address Alan Stern's comment: replicate port_dev->child->state
>   in port_dev->state instead of using a pointer to link them.
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
