Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E09560B281
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiJXQrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiJXQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:46:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F319E931;
        Mon, 24 Oct 2022 08:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E61DDB818F8;
        Mon, 24 Oct 2022 12:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFB3C433B5;
        Mon, 24 Oct 2022 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615185;
        bh=Cqr4+bBL7oNYcnofbEaCz0+7Ljp5GAyhgX+SKELtivc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqEaMY22acfVwNO2wynM6QjybdGs+CcFDoBsFM3cDIFU+RP3TyvzA9RsAFav3wVTu
         fCRe1dwk2kiMRIO5Ao/IrtkhHYYGlJzWO8Pul3X1IzNMmvh+7dp2GDlSanQ5yy7kxG
         Qupf6JuPrH7u++Wi8dsEFNu8BEJ32qaEm9C4WFQaj0f8h4n0LHxZWimIuPMwh21oqa
         pKZ27Ct2kTlPgXe8xLjFHs7HJtN10XyF+NgZ5jpBYH6zS3mhn/M2K0LTYugV/ohsBm
         n1xxFcHrQL/A+8paIvPns1Ve66DGcIQqGm6H9ts6ILKrjVj1N69rWXth72FsxaHBEk
         /HIzltdBcepow==
Date:   Mon, 24 Oct 2022 13:39:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Bagas Sanjaya <bagasdotme@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 8/9] mfd: Add Ampere's Altra SMpro MFD driver
Message-ID: <Y1aHiaZ1OpHZIzS9@google.com>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-9-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929094321.770125-9-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022, Quan Nguyen wrote:

> Adds Multi-function devices driver for SMpro co-processor found on the
> Mt.Jade hardware reference platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> 
> Changes in v9:
>   + Rename smpro-mfd.c to smpro-core.c                   [Lee Jones]
>   + Fix include files in alphabetical order              [Lee Jones]
>   + Add defines to avoid using magic numbers             [Lee Jones]
>   + Return -EINVAL if device does not match              [Lee Jones]
>   + Remove unneccessary comment                          [Lee Jones]
>   + Refactor error path handling in smpro_core_read/write()   [Quan]
> 
> Changes in v8:
>   + None
> 
> Changes in v7:
>   + Smpro-mfd now significant changes in compare with simple-mfd-i2c
>     driver, remove the copyright note about simple-mfd-i2c    [Quan]
>   + Install bus->read/write()  to handle multiple types of bus
>     access.                                                   [Quan]
>   + Update license to MODULE_LICENSE("GPL")                   [Quan]
>   + Add others minor refactor the code                        [Quan]
> 
> Changes in v6:
>   + Update license part to reflect that this driver is clone from
>   simple-mfd-i2c driver [Quan]
> 
> Changes in v5:
>   + Dropped the use of simple-mfd-i2c driver [Quan]
>   + Introduced drivers/mfd/smpro-mfd.c driver to instantiate
>   sub-devices. This is to avoid DT nodes without resource issue [Quan]
>   + Revised commit message [Quan]
> 
> Changes in v4:
>   + Add "depends on I2C" to fix build issue found by kernel test
>   robot [Guenter]
> 
> Changes in v3:
>   + None
> 
> Changes in v2:
>   + Used 'struct of_device_id's .data attribute [Lee Jones]
> 
>  drivers/mfd/Kconfig      |  12 ++++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/smpro-core.c | 138 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 drivers/mfd/smpro-core.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
