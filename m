Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D1636B86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiKWUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiKWUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:48:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07E2D1D9;
        Wed, 23 Nov 2022 12:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691FF61F09;
        Wed, 23 Nov 2022 20:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09FEC433D7;
        Wed, 23 Nov 2022 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236499;
        bh=RYM0ZVfQo37kojwDQYWBQz6lC3vEa60h8jFcKimdRX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hslFglZ+XfllEFhU0oLjGluIc98RcRLJHWcwyaE61A7muWAGXE+P45ERpW+4MFjpl
         MT8FMk2fjr2qr9as1vBZpvWvp2OJxS1SCVwjLmqw+V+17p7TxxycDk4LHJ5uwhkHNa
         VtHCAJVMb9500UAPrBzRoOiRUJ+UhY3GZmgDG879zjwqAHRaFcp9D6BNjW6KtpF1qG
         Hb2gBv0rsjD3aCYzog+KcDU1zKfKFyBAJqoZdV5N0qRcxNnhGOFWEx8AgGB+qLEZP+
         eyOpXVtCn8MAA8MHC53rQgAuAx2CWTX6oMXIlDZZYr7aMBsFiZx/KKr5oXFde7CAEA
         xUTVEBjtWFVGA==
Date:   Wed, 23 Nov 2022 21:00:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc128s052: add proper .data members in
 adc128_of_match table
Message-ID: <20221123210052.4c1796f9@jic23-huawei>
In-Reply-To: <d8e3b536-06ac-2346-3fe1-90ed2fb1127d@rasmusvillemoes.dk>
References: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
        <d8e3b536-06ac-2346-3fe1-90ed2fb1127d@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 15:41:21 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 15/11/2022 14.23, Rasmus Villemoes wrote:
> > Prior to commit bd5d54e4d49d ("iio: adc128s052: add ACPI _HID
> > AANT1280"), the driver unconditionally used spi_get_device_id() to get
> > the index into the adc128_config array.
> > 
> > However, with that commit, OF-based boards now incorrectly treat all
> > supported sensors as if they are an adc128s052, because all the .data
> > members of the adc128_of_match table are implicitly 0. Our board,
> > which has an adc122s021, thus exposes 8 channels whereas it really
> > only has two.
> > 
> > Fixes: bd5d54e4d49d ("iio: adc128s052: add ACPI _HID AANT1280")
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---  
> 
> Ping. Any chance this could be picked up before the merge window for 6.2
> opens?

Given it is a clear fix, but for an issue that is multiple versions old
(so I'm not sneaking it in post rc6)..
No actual rush on this, but meh I'm queuing a bunch of other stuff that
will hopefully just make it this cycle so applied to the togreg branch of iio.git
and marked for stable.

Thanks,

Jonathan
