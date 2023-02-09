Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E16690C61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBIPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBIPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:05:37 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 599906A57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:05:36 -0800 (PST)
Received: (qmail 772606 invoked by uid 1000); 9 Feb 2023 10:05:35 -0500
Date:   Thu, 9 Feb 2023 10:05:35 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <Y+ULv1BpcrPWf5nN@rowland.harvard.edu>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
 <20230209101807.GO10447@pengutronix.de>
 <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
 <20230209114103.GQ10447@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209114103.GQ10447@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:41:03PM +0100, Sascha Hauer wrote:
> I just checked on the host side: With or without my patch I get
> NO-CARRIER on the host. I have to do a 'ip link set usb0 up' on
> the device side, with that I get a <BROADCAST,MULTICAST,UP,LOWER_UP>
> on the host side.
> 
> Could it be that my patch breaks something on the device side that
> prevents the device from bringing the link up?

Sascha:

When you first posted your original patch, I wondered if it was really 
the right thing to do.  Making the net device not be a child of the UDC 
device means you can (in theory) have strange behavior such as the 
kernel suspending the USB device controller while expecting the network 
interface to keep on working.

Is there a different way of solving the original problem?

Alan Stern
