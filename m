Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9E3613997
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiJaPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJaPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:01:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDF71114E;
        Mon, 31 Oct 2022 08:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0549B8189D;
        Mon, 31 Oct 2022 15:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E4C433C1;
        Mon, 31 Oct 2022 15:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667228508;
        bh=rlmhgFAHSlMLUSzmBmDn0F87uYL3lausnNmdgR1mEgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaLX1F6In1WLNvfkw4RCcoPe3U3Htzyrfow7AkuFpztOlWgXEoEy6iEg+tSZP/gKF
         iph7VxOTwVRYohPZTm72WI/9M7pW7PrBMt11us+xSHxNhR5ET3YZr9CYhr5QwmXV2+
         WvnWmwQOwCchQlkp5QE8fPS9SmF5y8wouMg9vlQBIBLvTFHmT+kB3oG4FdrUjFnJlK
         /2vBCCnuZr6bua3YIa5ir9tKUWI/Ss0FLqozRg+hRomCUFMgP5PbvrNQD4jnJXFSYz
         4JugXaZlDCrOPRUhNVGj4+nSq82EqMAcVicUKH0/jp5TkNe/DCL+Zo2VgGirJbIRbv
         qMuF89Jw7PUSw==
Date:   Mon, 31 Oct 2022 15:01:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 06/14] mfd: remove dm355evm_msp driver
Message-ID: <Y1/jVgC76ALyb3Ls@google.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-7-arnd@kernel.org>
 <Y1/jLvg5AYCk1CkD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1/jLvg5AYCk1CkD@google.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Lee Jones wrote:

> On Wed, 19 Oct 2022, Arnd Bergmann wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The DaVinci DM355EVM platform is gone after the removal of all
> > unused board files, so the MTD device along with its sub-devices
> > can be removed as well.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/input/misc/Kconfig         |  11 -
> >  drivers/input/misc/Makefile        |   1 -
> >  drivers/input/misc/dm355evm_keys.c | 238 ---------------
> >  drivers/mfd/Kconfig                |   8 -
> >  drivers/mfd/Makefile               |   1 -
> >  drivers/mfd/dm355evm_msp.c         | 454 -----------------------------
> >  drivers/rtc/Kconfig                |   6 -
> >  drivers/rtc/Makefile               |   1 -
> >  drivers/rtc/rtc-dm355evm.c         | 151 ----------
> >  include/linux/mfd/dm355evm_msp.h   |  79 -----
> >  10 files changed, 950 deletions(-)
> >  delete mode 100644 drivers/input/misc/dm355evm_keys.c
> >  delete mode 100644 drivers/mfd/dm355evm_msp.c
> >  delete mode 100644 drivers/rtc/rtc-dm355evm.c
> >  delete mode 100644 include/linux/mfd/dm355evm_msp.h
> 
> Acked-by: Lee Jones <lee@kernel.org>

Any reason not to do this per-subsystem?

-- 
Lee Jones [李琼斯]
