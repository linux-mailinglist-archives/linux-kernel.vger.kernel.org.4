Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9F69CC39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBTNiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjBTNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:38:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA381814D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:38:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB6CFB80D43
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D27EC433D2;
        Mon, 20 Feb 2023 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676900294;
        bh=oTzrZocAYGbdhdnAhGZtK2DtSqKzMXr/X+9a3jvGwpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD4/7J/UFBGEqxlJniplvn5nAX+3wcclTe/YeSq6PHsXIunf4xlDXY8wuhd2AmqJn
         VmesBRHQpikEu7pdiO32rPE7ov2BO4e9zI9/PEBzSnQGZLuw8XMvCFr5YMKQyR9Ujf
         1j3eW39LVSBTiAx7Wr/85m/ouZtsy7K1xkFgQq0fLV+juW0ZcAGUOusoiqSbeP9xmA
         kWERxPup4i7vdFvvXF03KJxE/IExfv8IwL0m2fadqsS8AVJYyEEXO/iArJ4hcppOQj
         mqCUCZaMVg2/ai59sPLdcEpV33ObKcuqi5syn2r1tYN88tp22wb+v0gVNfB1MteXS1
         y1Z17RJznpPjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pU6Mw-0008M1-H4; Mon, 20 Feb 2023 14:38:14 +0100
Date:   Mon, 20 Feb 2023 14:38:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/core for v6.3-rc1
Message-ID: <Y/N3xmigc7l80ea7@hovoldconsulting.com>
References: <167689254797.295764.1600565060995031919.tglx@xen13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167689254797.295764.1600565060995031919.tglx@xen13>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 12:32:52PM +0100, Thomas Gleixner wrote:
> Linus,
> 
> please pull the latest irq/core branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-02-20
> 
> up to:  6f3ee0e22b4c: Merge tag 'irqchip-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
> 
> 
> Updates for the interrupt subsystem:
> 
>   Core:

>     - Improve irqdomain locking to close a number race conditions which
>       can be observed with massive parallel device driver probing.

Actually, all that is needed to hit the shared-interrupt mapping race is
a single driver opting for asynchronous probing (e.g. i2c_hid_of) and
probing two devices that share an interrupt in parallel. 

Johan
