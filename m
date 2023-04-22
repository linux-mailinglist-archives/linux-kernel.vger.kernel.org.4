Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3A6EBA9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDVRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB52E2;
        Sat, 22 Apr 2023 10:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620EC60EEE;
        Sat, 22 Apr 2023 17:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4246DC433EF;
        Sat, 22 Apr 2023 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682183830;
        bh=yMvcQ0Mfs5JyiYJA0eohYMJjhPUy6hXaykaujc3e6lE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uNlAtCvunMGbVUUs7/2o8RXl72q8wn7/zgt9ogkKPJpZNGRTUpJGnTdkKk9mzZW5D
         8p1n9hv68MKgMTqm2EivY9ar/7C/zSu5tEDQVoKBkCUYlhHhdC+70HVpAxwbuI8S4M
         bcCPtowWuau017gbdNO8Yfrfct6b3ySdfJB8Mhjioz/GpQuoqH7V/qDAm+dP8PkXRQ
         0xUXtKWWTG7nk9jnItCHDrSM73+OWPdyLIArske5CVGVhjl7AQbnraHArRTdDgo9+K
         8K9/I9S83u1nB1UlWoF1Tb6zB0/MLDto3LuacpOylh3pI30R2gNRig8WBiyxxeWeMC
         TV9vAdXCZgkBw==
Date:   Sat, 22 Apr 2023 18:32:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230422183246.3b18be8f@jic23-huawei>
In-Reply-To: <ffae181f-f235-2767-b8fe-e8c4f2e69ccd@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
        <e0b599e3f1d1fe0c68e4e0083c8d51fbf0834059.1682019544.git.mehdi.djait.k@gmail.com>
        <ffae181f-f235-2767-b8fe-e8c4f2e69ccd@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 09:19:32 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Mehdi,
> 
> Thanks for working on this driver :) Much appreciated!
> 
> On 4/20/23 23:22, Mehdi Djait wrote:
> > Refactor the kx022a driver implementation to make it more generic and
> > extensible.
> > Introduce an i2c_device_id table.
> > Add the chip_info structure to the driver's private data to hold all
> > the device specific infos.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v2:
> > - mentioned the introduction of the i2c_device_id table in the commit  
> 
> Maybe adding the i2c_device_id table could be done in a separate patch 
> with a Fixes tag? That would help backporting (and I think changes like 
> this are worth it).

Is it technically a fix?  I thought it was but turned out my reasoning only
applied to spi.   Agreed it would be nice as a separate patch though.
It's not directly related to the rest of what is happening here.

