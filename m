Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2D74BB28
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGHBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHBvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:51:31 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 71F952105
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:51:28 -0700 (PDT)
Received: (qmail 1232616 invoked by uid 1000); 7 Jul 2023 21:51:27 -0400
Date:   Fri, 7 Jul 2023 21:51:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        hayeswang@realtek.com, jflf_kernel@gmx.com, bjorn@mork.no,
        svenva@chromium.org, linux-kernel@vger.kernel.org,
        eniac-xw.zhang@hp.com, stable@vger.kernel.org
Subject: Re: [PATCH] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
References: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
 <20230707171225.3cb6e354@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707171225.3cb6e354@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:12:25PM -0700, Jakub Kicinski wrote:
> On Thu,  6 Jul 2023 18:28:58 +0000 Alexandru Gagniuc wrote:
> > For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> > in U3 state. If it is not, and the host "disappears", the chip will
> > no longer respond to WoL triggers.
> >  
> > To resolve this, add a notifier block and register it as a reboot
> > notifier. When WoL is enabled, work through the usb_device struct to
> > get to the suspend function. Calling this function puts the link in
> > the correct state for WoL to function.
> 
> Would be good to hear from USB experts on this one, to an outside seems
> like something that the bus should be doing, possibly based on some
> driver opt-in..

The USB spec does not include any discussion of what things should be 
done when the system is turned off -- it doesn't even really acknowledge 
the existence of different system-wide power states.  As a result, the 
USB subsystem never developed any support for power-off callbacks or 
anything else of the sort.

Of course, this kind of thing can always be added.  But I don't think 
there's any way to distinguish (at the USB level) between wakeup from 
S5-off and wakeup from any other low-power system state.  And the PM 
part of the device model doesn't have multiple types of "enable-wakeup" 
flags -- either a device is enabled for wakeup or it isn't.

Alan Stern
