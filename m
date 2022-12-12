Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E864A2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiLLOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiLLOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:07:09 -0500
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61361F6F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:07:07 -0800 (PST)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 6937B20D75;
        Mon, 12 Dec 2022 09:07:06 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id C97FAA81B8; Mon, 12 Dec 2022 09:07:05 -0500 (EST)
Date:   Mon, 12 Dec 2022 09:07:05 -0500
From:   John Stoffel <john@quad.stoffel.home>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/core for v6.2-rc1
Message-ID: <Y5c1ie+VE3QS5Xhz@quad.stoffel.home>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
 <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:09:01AM +0100, Thomas Gleixner wrote:
> Linus,
> 
> please pull the latest irq/core branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-12-10
> 
> up to:  6132a490f9c8: Merge tag 'irqchip-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
> 
> Updates for the interrupt core and driver subsystem:
> 
>  - Core:
> 
>    The bulk is the rework of the MSI subsystem to support per device MSI
>    interrupt domains. This solves conceptual problems of the current
>    PCI/MSI design which are in the way of providing support for PCI/MSI[-X]
>    and the upcoming PCI/IMS mechanism on the same device.
> 
>    IMS (Interrupt Message Store] is a new specification which allows device
>    manufactures to provide implementation defined storage for MSI messages
>    contrary to the uniform and specification defined storage mechanisms for

This sentence reads strangley to me, I'm not quite clear on what
"uniform and specification" really means here.  Just a minor nit since
I spent three or four re-reads trying to understand this otherwise
really nicely written history!

>    PCI/MSI and PCI/MSI-X. IMS not only allows to overcome the size limitations
>    of the MSI-X table, but also gives the device manufacturer the freedom to
>    store the message in arbitrary places, even in host memory which is shared
>    with the device.
>    
>    There have been several attempts to glue this into the current MSI code,
>    but after lengthy discussions it turned out that there is a fundamental
>    design problem in the current PCI/MSI-X implementation. This needs some
>    historical background.
>    
>    When PCI/MSI[-X] support was added around 2003, interrupt management was
>    completely different from what we have today in the actively developed
>    architectures. Interrupt management was completely architecture specific
>    and while there were attempts to create common infrastructure the
>    commonalities were rudimentary and just providing shared data structures and
>    interfaces so that drivers could be written in an architecture agnostic
>    way.
>    
>    The initial PCI/MSI[-X] support obviously plugged into this model which
>    resulted in some basic shared infrastructure in the PCI core code for
>    setting up MSI descriptors, which are a pure software construct for holding
>    data relevant for a particular MSI interrupt, but the actual association to
>    Linux interrupts was completely architecture specific. This model is still
>    supported today to keep museum architectures and notorious stranglers

I think you mean "stragglers" not "stranglers.  Though I'm sure you
wanted to strangle things at points!

>    alive.
> 
>    In 2013 Intel tried to add support for hot-pluggable IO/APICs to the kernel,
>    which was creating yet another architecture specific mechanism and resulted
>    in an unholy mess on top of the existing horrors of x86 interrupt handling.
>    The x86 interrupt management code was already an incomprehensible maze of
>    indirections between the CPU vector management, interrupt remapping and the
>    actual IO/APIC and PCI/MSI[-X] implementation.
>    
>    At roughly the same time ARM struggled with the ever growing SoC specific
>    extensions which were glued on top of the architected GIC interrupt
>    controller.
>    

[ deleted the rest ... ]
