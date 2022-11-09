Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2E622CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKINz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKINzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:55:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E13EA5;
        Wed,  9 Nov 2022 05:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2B861AC4;
        Wed,  9 Nov 2022 13:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E484C433D6;
        Wed,  9 Nov 2022 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668002110;
        bh=4NwwsEbCbswN53T4UEwwOlgLBEjJU2ohr2t1zlmAODw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eU/+cyvmee3zNEITLx3DRExwDjKNI1MyQPOiKwJ8pkJiB8+lO6ZdrkPOeyh8qRjo0
         jasOtJGBm/3IGYdBP0DutC+AUlfxlHPZfOOkaZ+gQ/abdkK8WYRlEFllxKXN3k57m4
         UHZgropZD6h+fPVrS4G8qpKiNlBEuhWHkujLuEgSiomSHUs+kYwzJya2tLYmJ/dP1c
         eEPQihYi27GO0jS7PnjMD/buLcTXZ/uBwuUhrq2KbKv0f0SHX77Eg3+4vF/ote9AT9
         Ekz4UyfTSmSxh9M0OVMaqiOhDIcJngBmktu9pZRuK21eoePTGui18TxaSQYp5mQH0M
         J7qvg7QO5yIcw==
Message-ID: <4de6be5d-b23e-5927-515c-233f697d0be1@kernel.org>
Date:   Wed, 9 Nov 2022 15:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/5] firmware: ti_sci: Introduce system suspend support
Content-Language: en-US
To:     Georgi Vlaev <g-vlaev@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20221108224527.137179-1-g-vlaev@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221108224527.137179-1-g-vlaev@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 00:45, Georgi Vlaev wrote:
> This series introduces necessary ti_sci driver functionality in
> preparation of supporting DeepSleep mode for suspend to mem on TI
> K3 AM62x. This version is a fixup and rebase of the patch series by
> Dave Gerlach [1]. It applies on top of v6.1-rc4.
> 
> Deep Sleep mode is described in section "5.2.4.4 DeepSleep" of the
> AM62x Technical Reference Manual [2].
> 
> The kernel triggers entry to Deep Sleep mode through the mem suspend
> transition with the following:
> 
> * Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
>   system to use PSCI system suspend as last step of mem sleep.
> 
> * The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
>   message in order to provide details about suspend, so we must add the
>   ability to send this message. We also add TISCI_MSG_LPM_WAKE_REASON
>   and TISCI_MSG_SET_IO_ISOLATION messages as part of a new PM ops. These
>   messages are part of the TISCI PM Low Power Mode API [3]. (Patch 2)
> 
> * A memory address must be provided to the firmware using the above
>   message, which is allocated and managed by dma_alloc_coherent()
>   and friends. (Patch 3)
> 
> * System must load firmware to a specific location before Deep Sleep is
>   entered, and this is accomplished using a memory region in device
>   tree to indicate where this firmware should be loaded, and also a
>   "firmware-name" property to indicate the name of the firmware
>   to load. The ti_sci driver checks in its pm handler to see if
>   the firmware has been loaded and if not, loads it. (Patch 4)
> 
> * Finally, the ti_sci driver must actually send TISCI_MSG_PREPARE_SLEEP
>   message to firmware with the above information included, which it
>   does during the driver suspend handler when PM_MEM_SUSPEND is the
>   determined state being entered. (Patch 5)
> 
> This is tested on am625-sk using a limited dts with all devices disabled
> apart from cpu0, main_uart0, i2c, rtc, mmc/sd, dmsc, and secure_proxy_main.
> 
> Testing this sequence requires K3 sdhci suspend/resume support [4],
> enable the wkup_rtc in the am625-sk.dts, disable devices that don't
> support system suspend/resume like OSPI and CPSW3G.
> 
> In can be tested on the following branch:
> https://github.com/gvlaev/linux/tree/upstream-v6.2/lpm-ti-sci-v1
> 
> Changelog:
> v2:
> - Addressed comments received for v1 series [1].
> - Updated v1 patch 5 to use pm notifier to avoid firmware loading
>   issues.
> - Dropped the reserved region requirement and allocate DMA memory
>   instead. The reserved region binding patch is also removed.
> - Introduce two more TISCI LPM messages that are supported in SysFW.
> - Fixes in error handling.
> 
> [1] https://lore.kernel.org/lkml/20220421203659.27853-1-d-gerlach@ti.com
> [2] https://www.ti.com/lit/pdf/spruiv7
> [3] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> [4] https://lore.kernel.org/lkml/20220408124338.27090-1-a-govindraju@ti.com
> 
> Dave Gerlach (5):
>   dt-bindings: ti, sci: Add lpm region and firmware-name
>   firmware: ti_sci: Introduce Power Management Ops
>   firmware: ti_sci: Allocate memory for the LPM modes
>   firmware: ti_sci: Use dt provided fw name and address to load at
>     suspend time
>   firmware: ti_sci: Introduce prepare system suspend call
> 
>  .../bindings/arm/keystone/ti,sci.yaml         |  21 +-
>  drivers/firmware/ti_sci.c                     | 356 ++++++++++++++++++
>  drivers/firmware/ti_sci.h                     |  64 +++-
>  include/linux/soc/ti/ti_sci_protocol.h        |  44 +++
>  4 files changed, 480 insertions(+), 5 deletions(-)
> 
> 
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc

Tested-by: Roger Quadros <rogerq@kernel.org>

Tested this with am65-CPSW suspend/resume patches [1]
[1] - https://lore.kernel.org/netdev/20221104132310.31577-3-rogerq@kernel.org/T/

-- 
