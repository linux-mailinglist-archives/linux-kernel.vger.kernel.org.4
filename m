Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D4645D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLGP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLGP2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:28:32 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128C442DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=zj38BmnGOye72rpiBgZnGVHn0M0x17AYI3xiFJfGamY=; b=MD
        yre4p9nlS6VFm88/M8cPU1gOy1YXjfBRqWchbz3CCvi7RrMj8hkRNuUPAiYKRc/euU/RV/151R8Nb
        bJntvRsGagibx2zMo5zJTUkq4dSc1wnV+XE/4TleHSPgZTBnun43Vczgel+3iv8glVXR/RG3bnVDh
        mRG5YOb+E/d8rro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1p2wL9-004fNs-43; Wed, 07 Dec 2022 16:28:07 +0100
Date:   Wed, 7 Dec 2022 16:28:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5CxBzy47Gjn/V5a@lunn.ch>
References: <Y5B4QeNMNboJ42n4@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5B4QeNMNboJ42n4@probook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:25:53PM +0100, Jonathan Neuschäfer wrote:
> Hello,
> 
> I am currently trying to bring up Linux 6.1-rcX on a PXA255 board, using a
> devicetree. One problem I encountered is that the PXA GPIO driver fails to
> probe because it uses the same MMIO register range as the pinctrl driver:
> 
> [    0.666169] pxa25x-pinctrl 40e00054.pinctrl: initialized pxa2xx pinctrl driver
> [    0.694407] pxa-gpio 40e00000.gpio: can't request region for resource [mem 0x40e00000-0x40e0ffff]
> [    0.695050] pxa-gpio: probe of 40e00000.gpio failed with error -16
> 
> Before I try to fix this myself: Is GPIO on PXA25x currently expected to
> work and when has it last been seen working?
> 
> What would be a good way to fix this?

How are the registers arranged? Is 0x40e00000-0x40e0ffff simply too
large, and making it smaller would fix the issue? Or are the registers
interleaved? It is possible to request a region in a non-exclusive
manor. Or is it more than interleaving, individual registers need to
be shared between the two drivers? If so, you have the locking issues
you mentioned.

    Andrew
