Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FEB6BEAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCQOPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:15:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC434C10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FBFCB825A0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A696C433D2;
        Fri, 17 Mar 2023 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679062503;
        bh=yaUsQyTlpSNYGoONyu7R2bK4kMxz6ppXwht4RU5qJdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUhhbMyVWigDXyw8fXAWkaLsYVk8qFz8puoHWP7SUCQS67PTp9yapRyPAbCcaBwIE
         PITDBqBcmg45lmblFDpLYA3s9OIR0ihNETqNStD1oGwdLWxIzS17X02JpiguPkrDtm
         nqBc1/Cn2t2MTC1t10Vt8DeaxsH4Jxsva7xBL3gY=
Date:   Fri, 17 Mar 2023 15:15:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4] firmware_loader: Add debug message with checksum for
 FW file
Message-ID: <ZBR15Qy0F6bianXR@kroah.com>
References: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:04:59PM +0100, Amadeusz Sławiński wrote:
> Enable dynamic-debug logging of firmware filenames and SHA256 checksums
> to clearly identify the firmware files that are loaded by the system.
> 
> Example output:
> [   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
> [   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
> [   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
> [   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
> [   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
> 
> Changes in v4:
>  * update menuconfig prompt and help message (Russ)
> 
> Changes in v3:
>  * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
> enabled (kernel test robot)
> 
> Changes in v2:
>  * allocate buffers (Greg)
>  * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
> dependencies without introducing circular dependency (Greg)
>  * add new line between includes and function name (Cezary)
> 
> ---
>  drivers/base/firmware_loader/Kconfig | 13 ++++++++
>  drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5166b323a0f8..6520e8c9cb38 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -3,6 +3,7 @@ menu "Firmware loader"
>  
>  config FW_LOADER
>  	tristate "Firmware loading facility" if EXPERT
> +	select FW_LOADER_DEBUG if DYNAMIC_DEBUG

Why the select?  that prevents anyone from actually choosing this if
they want to or not.  It also prevents them from disabling this option
if they want to, while still keeping DYNAMIC_DEBUG enabled.

So please don't make this change.

thanks,

greg k-h
