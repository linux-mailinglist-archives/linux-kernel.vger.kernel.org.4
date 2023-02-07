Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1E68DA34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBGOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjBGOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:11:29 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B21701;
        Tue,  7 Feb 2023 06:11:28 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A239C87;
        Tue,  7 Feb 2023 15:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675779086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHWftBSiKcTAso/6ZrqA8yWfIyAtYxTeobf9TqWW8r4=;
        b=PNx3xBolIsFyfKtFrxmH5KPyek49Po6XgHsBEY5JY8wjqRbx8G/J+GFlDihQYtsoGU7izI
        EKMZkG/CIAF5M0Vpglip9LzZ9kohWgj7TZAGQybKIu7SbMtQ0eImZMR2Va9R/6dWeoPs2Q
        rymxGDi/2m4B3wo/sf09S7QMDnJARGGhilsxAo61wQhZGJMpFHMppzdVrFaTl0GZlRkSIN
        qMtEY2eFwbyp7dquHDAKDGHesowhFYQEoB1W+bqpSSsJ8WCDXhkk5EHqzpNp+CBlv0Zbvj
        pY5Sgw3UXLlh/PAgNGPr+aDnm1Mai0afiQpKHt7td1EROaWXWDM+8FUku0NHEg==
MIME-Version: 1.0
Date:   Tue, 07 Feb 2023 15:11:26 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     mauro.lima@eclypsium.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: intel: Remove DANGEROUS tag from pci driver
In-Reply-To: <Y+JaKF4FZQKqeGs7@black.fi.intel.com>
References: <20230206183143.75274-2-mauro.lima@eclypsium.com>
 <20230207135254.2465816-1-michael@walle.cc>
 <Y+JaKF4FZQKqeGs7@black.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8797addc6c063b867b94cce352191aab@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

Am 2023-02-07 15:03, schrieb Mika Westerberg:
> On Tue, Feb 07, 2023 at 02:52:54PM +0100, Michael Walle wrote:
>> > Modern CPUs exposes this controller as PCI device that only uses
>> > hardware sequencing capabilities which is safer than software
>> > sequencing.
>> > Leave the platform driver as *DANGEROUS* and update help text since
>> > most of these controllers are using software sequencing.
>> 
>> Out of curiosity, what is hardware sequencing? Maybe this should
>> be explained a bit more in the Kconfig help text. Looks like the
>> dangerous was there because you can update the bios and that
>> could eventually lead to a bricked mainboard. So hardware
>> sequencing helps there? how?
> 
> Hardware sequencing means the controller exposes just a bunch of "high
> level" operations to the software.

Ok, I figured it would have been something to do with the SPI driver
just supporting these high level ops. But even with that background
it was hard to connect that to the "hardware sequencing". The help
text should be somewhat understandable to the user/distro 
people/whoever,
right? So I'd suggest to explain that a bit more in detail, or don't
use the term hardware sequencing at all. I'm not sure.

> Such as read, write, erase and so on
> but does not allow running the actual "low level" SPI-NOR opcodes.
> Software sequencing on the other hand allows running pretty much any
> opcode and this is what caused problems for certain Lenovo laptops few
> years back that then resulted adding DANGEROUS to the Kconfig.

That information should go into the commit message.

> Typically the flash is locked by the BIOS so ordinary users cannot
> really overwrite it, even by accident.

I see, thanks for the explanation!

-michael
