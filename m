Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09169C063
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 14:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBSNkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 08:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBSNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 08:39:59 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DDEFB3;
        Sun, 19 Feb 2023 05:39:58 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C00FD3004D11C;
        Sun, 19 Feb 2023 14:39:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B53C435CCF; Sun, 19 Feb 2023 14:39:56 +0100 (CET)
Date:   Sun, 19 Feb 2023 14:39:56 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230219133956.GA4946@wunner.de>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-5-orlandoch.dev@gmail.com>
 <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
 <20230217110531.6d3c07a1@redecorated-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217110531.6d3c07a1@redecorated-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 11:05:31AM +1100, Orlando Chamberlain wrote:
> On Thu, 16 Feb 2023 14:27:13 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
> It looks like iMac20,1, iMac20,2, and iMacPro1,1 have APP000B:
> 
> apple_gmux: Failed to find gmux I/O resource
> 
> iMac20,2: https://linux-hardware.org/?probe=ec2af584b3&log=dmesg
> iMac20,1: https://linux-hardware.org/?probe=fee7644b9c&log=dmesg
> iMacPro1,1: https://linux-hardware.org/?probe=6c26c9ff8c&log=dmesg
> 
> But I'm not sure if they actually have it or not.

A number of iMacs support Target Display Mode, i.e. you can plug in
an external computer to the iMac's DisplayPort and use the iMac as
its screen.  Those iMac models do contain a gmux to mux the display
between internal GPU and external DisplayPort connection.  Linux
does not have support for this, sadly.  It would require generalizing
vga_switcheroo for use cases beyond dual GPU laptops.  Florian Echtler
has been looking into Target Display Mode but I'm not sure he got it
working:

https://lore.kernel.org/all/e6b44662-8b05-fb8d-660e-77153680d11b@butterbrot.org/
https://lore.kernel.org/all/71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org/
https://lore.kernel.org/all/1497603751-22360-1-git-send-email-floe@butterbrot.org/

I believe the Mac Pro (the trashcan one) also contains a gmux and
an APP000B device in DSDT.  I recall seeing a bug report due to a
splat in the gmux driver on that machine.  Back then I confirmed
in the schematics that it does contain a gmux, though I think it's
only used for brightness, not GPU switching.

Thanks,

Lukas
