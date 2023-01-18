Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7D67210B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjARPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:20:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55221965;
        Wed, 18 Jan 2023 07:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C406B81D7E;
        Wed, 18 Jan 2023 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB517C433EF;
        Wed, 18 Jan 2023 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674054989;
        bh=om/bRyK6aiyNR+pwzYnLAB12Psugl9/MwqjElPrPtx4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bjlgGLBbCuNrJ5pwY5jYYRmTqodNZrWm5TdnDdCUBLczo7JdZ0KM/1HUPk4Cac1Ik
         ExjwwjZAtSU7Zlb6NAC0Ij1zhsfXvtB1F8EcJkj0bwi04N0UdppSaPouFEZGfPG5pK
         JCHULNzy1dX3OwjxF30xftwxJMwSt/eedb9CpcXrIGPs78AOu4npg7Tv/BKh9wxS4R
         bgYaWn3gDPoy9KfYyu0Gc4q6LVdQEG+0ETojqOA2rEQqjWV1p8TcsRXjbpLJilBDhj
         zdX8vP3rsJSXj7Jhpx+f3GouORoLjUp9OCuAKjhsiYr3kzo79mRAWpCfvrWj2kltyv
         DgNDqwwwfNScw==
Date:   Wed, 18 Jan 2023 16:16:29 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: stop drivers from selecting CONFIG_HID
In-Reply-To: <20230117172121.2715953-1-arnd@kernel.org>
Message-ID: <nycvar.YFH.7.76.2301181616140.1734@cbobk.fhfr.pm>
References: <20230117172121.2715953-1-arnd@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is a mix of drivers using either 'depends on HID' or 'select HID',
> which causes both circular dependencies and missed dependencies for
> a 'select':
> 
> WARNING: unment direct dependencies for HID
>   Depends on [m]: HID_SUPPORT [=y] && INPUT [=m]
>   Selected by [y]:
>   - AMD_SFH_HID [=y] && HID_SUPPORT [=y] && (X86_64 || COMPILE_TEST [=y]) && PCI [=y]
>   Selected by [m]:
>   - I2C_HID_CORE [=m] && HID_SUPPORT [=y]
> 
> WARNING: unmet direct dependencies detected for INPUT_FF_MEMLESS
>   Depends on [m]: INPUT [=m]
>   Selected by [y]:
>   - DRAGONRISE_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_DRAGONRISE [=y]
>   - HID_MICROSOFT [=y] && HID_SUPPORT [=y] && HID [=y]
>   - GREENASIA_FF [=y] && HID_SUPPORT [=y] && HID [=y] && HID_GREENASIA [=y]
>   Selected by [m]:
>   - INPUT_ARIZONA_HAPTICS [=m] && INPUT [=m] && INPUT_MISC [=y] && MFD_ARIZONA [=y] && SND_SOC [=m]
>   - INPUT_PM8XXX_VIBRATOR [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_PM8XXX [=m] || MFD_SPMI_PMIC [=n])
>   - INPUT_MAX8997_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y] && MFD_MAX8997 [=y]
>   - INPUT_GPIO_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - INPUT_REGULATOR_HAPTIC [=m] && INPUT [=m] && INPUT_MISC [=y] && REGULATOR [=y]
>   - INPUT_TWL6040_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && TWL6040_CORE [=y]
>   - INPUT_PWM_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && PWM [=y]
>   - INPUT_DRV260X_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - INPUT_DRV2665_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
>   - INPUT_DRV2667_HAPTICS [=m] && INPUT_MISC [=y] && INPUT [=m] && I2C [=y]
>   - INPUT_SC27XX_VIBRA [=m] && INPUT [=m] && INPUT_MISC [=y] && (MFD_SC27XX_PMIC [=y] || COMPILE_TEST [=y])
>   - HID_MAYFLASH [=m] && HID_SUPPORT [=y] && HID [=y]
> 
> Avoid this by changing all HID client drivers to use 'depends on HID'.
> For I2C_HID, this requires a larger rework of the Kconfig description,
> but it hopefully becomes easier to understand without the complex
> I2C_HID_CORE definition.
> 
> Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to hid.git#for-6.3/hid-bpf. Thanks,

-- 
Jiri Kosina
SUSE Labs

