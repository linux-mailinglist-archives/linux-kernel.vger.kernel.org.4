Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F680651BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiLTHgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:36:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AC963AE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 257376117F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE88C433EF;
        Tue, 20 Dec 2022 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671521792;
        bh=qOZ8rPxjWtvs/ARHDbnq/Qy51AqKDtbTT6pIgRvsZJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scJKmSREJF7y1HMqj0bhtQxwZUr2ZFlGjbTX0fLiIpfxaECPup4FG94ogb2dp/sUW
         4t8kU133Dwuw54/+vPZiXf5eGuYtoy6MV6JUZVHMGdpKwrVUFGHFAyUtlawh+esOQ5
         1dVSHmo3zBeVAKYhSddaaLPbPyy2bMvKQk649uL9UeijNq8Ndxv+IJY7ER/pbkk7hw
         ApbGDzwoPVYqGFk5yhBo0GoEnFEh5Az337vXHmalkbTMLx8jw23PRb1YfcpXiL4cPB
         XJzHbUEYcPL1wfod9u97XvXpFQzTFKWTyCmvxDSF/c9RYeY1f662DHFmhkT7YZe+LM
         uKmBuJc5+WDvw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7XBd-0000qW-4n; Tue, 20 Dec 2022 08:37:17 +0100
Date:   Tue, 20 Dec 2022 08:37:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] random number generator fixes for 6.2-rc1, part 2
Message-ID: <Y6FmLZqcf0nmcEMV@hovoldconsulting.com>
References: <20221220022458.11682-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220022458.11682-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:24:58AM +0100, Jason A. Donenfeld wrote:

> In addition, there is one fix:
> 
> - Check efi_rt_services_supported() before attempting to use an EFI runtime
>   function. This affected EFI systems that disable runtime services yet still
>   boot via EFI (e.g. the reporter's Dell arm64 laptop), as well systems where

Nit: This caused trouble on the Lenovo Thinkpad X13s that we're working
on supporting in mainline (i.e. not Dell).

>   EFI runtime services have been forcibly disabled, such as on PREEMPT_RT. On
>   those machines, a very early and hard to diagnose crash would happen,
>   preventing boot.

Johan
