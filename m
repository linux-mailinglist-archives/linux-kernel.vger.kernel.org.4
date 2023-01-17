Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7566E581
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjAQSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAQRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:54:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F88303FB;
        Tue, 17 Jan 2023 09:46:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 612D3CE1901;
        Tue, 17 Jan 2023 17:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FD7C433D2;
        Tue, 17 Jan 2023 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673977575;
        bh=X+5pQ/u9z975cmm+OsOZ/pVDq62L5Tb0fkVLAvQJxWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1/GnuPLdg824f+JxBdZdeBlTCR6AGQ4/iYWf9+euuF7YfBq8BbO0G3kmsEF9so+t
         fRcE1ts4ewXJ8aZmC8dTvVhSQFPnXC1f5QljogSNm5mORMWbj5dr/SXWSf8WQwCGkl
         ucL7X+YQTGa+V8/u67ESG31NNJYnHMu+L4gsLOBU=
Date:   Tue, 17 Jan 2023 18:46:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: stop drivers from selecting CONFIG_HID
Message-ID: <Y8be5Px4FYnunrhR@kroah.com>
References: <20230117172121.2715953-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172121.2715953-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:20:55PM +0100, Arnd Bergmann wrote:
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
> ---
>  drivers/hid/amd-sfh-hid/Kconfig   |  2 +-
>  drivers/hid/i2c-hid/Kconfig       | 31 ++++++++++++++++---------------
>  drivers/hid/intel-ish-hid/Kconfig |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
