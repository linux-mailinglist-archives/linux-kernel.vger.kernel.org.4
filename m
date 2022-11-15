Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F962A3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiKOVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKOVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:04:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED962872E;
        Tue, 15 Nov 2022 13:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAEBD61A1B;
        Tue, 15 Nov 2022 21:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD99C433C1;
        Tue, 15 Nov 2022 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668546253;
        bh=IQp5PvpVrLHqluau2ET/oLQk26sLCLIwFwznF7rMJkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQmsEYOO8GNbgdiDosfd0WbABwy0irIcwelsfmBmwdiKjdR1th/p7RJbRRWCSrgq4
         RCJhYR+bjDhIxqecSXPEjogA3fyTabwM91qRGHA8hZVqKY7nrMJUdqGaHOQKzHN3s2
         J8CY2b7nxFJ4MPEVzh1AIyVgmOx3bbUxFTQNDCjPVJeF7h6wTVybrpXxvO6XuyJ+Gf
         z1EoIhZcbrPDHvh8WK8bIcJ9yY7gJCjKQSpqwZ0OWlG2EbAZtSqkYA2YeAXbJGxlpv
         cWb1tHpcYf+/DKXo5lQU8QKggz3Sc5GibY0CX6w0S6+QO/Fv6U6/F9mW5CMsCAbwNA
         IYh49IPYodAZA==
Received: by pali.im (Postfix)
        id 16569805; Tue, 15 Nov 2022 22:04:10 +0100 (CET)
Date:   Tue, 15 Nov 2022 22:04:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
Message-ID: <20221115210409.4xe7awv4ybjks2e3@pali>
References: <20221115193155.mqdh6pzhiba4v4pa@pali>
 <20221115205343.GA1038784@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115205343.GA1038784@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2022 14:53:43 Bjorn Helgaas wrote:
> On Tue, Nov 15, 2022 at 08:31:55PM +0100, Pali Rohár wrote:
> > On Tuesday 15 November 2022 12:07:34 Bjorn Helgaas wrote:
> > > On Tue, Nov 15, 2022 at 04:56:10PM +0100, Geert Uytterhoeven wrote:
> > > > On Tue, Oct 25, 2022 at 9:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > Many drivers depend on OF interfaces, so they won't be functional if
> > > > > CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
> > > > > the OF dependencies so we can at least compile-test the drivers.
> > > 
> > > > > --- a/drivers/pci/controller/Kconfig
> > > > > +++ b/drivers/pci/controller/Kconfig
> > > > > @@ -8,7 +8,6 @@ config PCI_MVEBU
> > > > >         depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> > > > >         depends on MVEBU_MBUS
> > > > >         depends on ARM
> > > > > -       depends on OF
> > > > 
> > > > This is exactly why we have the COMPILE_TEST symbol.
> > > > There is no point in bothering all users who configure kernels with
> > > > questions about drivers that won't function anyway due to missing
> > > > dependencies, unless the user explicitly wants to do compile-testing.
> > > > 
> > > > So all of these should become:
> > > > 
> > > >     depends on OF || COMPILE_TEST
> > > 
> > > Oh, yes, thanks for pointing this out, I totally blew it here.  I
> > > dropped this while we figure it out.
> > 
> > I agree too, it really makes sense to not provide pci-mvebu driver to
> > end users without OF - it would not work.
> > 
> > Anyway, it is needed to declare "depends on ARM" for pci-mvebu?
> > Both supported architectures (mvebu and dove) are ARM.
> 
> If you're asking whether "depends on ARM" can be removed for
> PCI_MVEBU, I don't know the answer.  I do see that CONFIG_ARCH_MVEBU
> is mentioned in arch/arm64, which doesn't seem to set CONFIG_ARM.

Ou, you are right. Correct interpretation is "depends on 32-bit mvebu".
And because ARCH_MVEBU means "32-bit mvebu OR 64-bit mvebu" there is
additional "depends on ARM" to filter-out 64-bit mvebu.

So _architecture_ dependency based on intention should be:

(ARCH_MVEBU && ARM) || ARCH_DOVE || COMPILE_TEST

But because there is no 64-bit Dove, it has same meaning as moving ARM
from inner conjunction to outer.

I do not know which syntax is better. So choose what you prefer (current
version or some modification).

> In any event, I would consider a change like that to be a separate
> patch.  Here I just want to focus on CONFIG_OF.
> 
> Bjorn
