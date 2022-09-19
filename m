Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6945BCE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiISOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISOWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:22:35 -0400
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB91D316;
        Mon, 19 Sep 2022 07:22:34 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 518A07F011; Mon, 19 Sep 2022 17:22:32 +0300 (EEST)
Date:   Mon, 19 Sep 2022 17:22:32 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <Yyh7KK7ttqT+M8s3@wantstofly.org>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
 <YyG2tDdq9PWTlaBQ@wantstofly.org>
 <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
 <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
 <YyRiPMa26qDptj3L@wantstofly.org>
 <YyhyvazTBBmMSnXk@smile.fi.intel.com>
 <d5bc5b97-25db-d70-17dc-aab49f8fbc77@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5bc5b97-25db-d70-17dc-aab49f8fbc77@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:19:35PM +0300, Ilpo Järvinen wrote:

> > > > [...] I'm far from sure if it's the 
> > > > best fix though as I don't fully understand what causes the faults during 
> > > > the THRE tests because the port->irq is disabled by the THRE test block.
> > > 
> > > If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> > > address/data registers.  Disabling the IRQ at the interrupt controller
> > > won't stop the UART from performing a DMA write to the address programmed
> > > in its MSI address register (zero) when it wants to signal an interrupt.
> > > 
> > > (These UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> > > capability, so there is no way to mask the interrupt at the source PCI
> > > function level, except disabling the MSI capability entirely, but that
> > > would cause it to fall back to INTx# assertion, and the PCI specification
> > > prohibits disabling the MSI capability as a way to mask a function's
> > > interrupt service request.)
> > 
> > This sounds to me like a good part to be injected into commit message of
> > the proposed fix.
> 
> I added my own wording already but I could adds of Lennert's far superior 
> descriptions verbatim if he is OK with that?

No objections from me.
