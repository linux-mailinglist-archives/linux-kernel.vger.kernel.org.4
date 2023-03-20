Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C546C0FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCTKvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCTKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:51:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC34E298C8;
        Mon, 20 Mar 2023 03:48:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D103FEC;
        Mon, 20 Mar 2023 03:48:39 -0700 (PDT)
Received: from bogus (unknown [10.57.52.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B463F67D;
        Mon, 20 Mar 2023 03:47:52 -0700 (PDT)
Date:   Mon, 20 Mar 2023 10:47:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Message-ID: <20230320104719.mane5faxvv6ofpiv@bogus>
References: <20230319024314.3540573-1-sdonthineni@nvidia.com>
 <20230319024314.3540573-2-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319024314.3540573-2-sdonthineni@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 09:43:14PM -0500, Shanker Donthineni wrote:
> The T241 platform suffers from the T241-FABRIC-4 erratum which causes
> unexpected behavior in the GIC when multiple transactions are received
> simultaneously from different sources. This hardware issue impacts
> NVIDIA server platforms that use more than two T241 chips
> interconnected. Each chip has support for 320 {E}SPIs.
> 
> This issue occurs when multiple packets from different GICs are
> incorrectly interleaved at the target chip. The erratum text below
> specifies exactly what can cause multiple transfer packets susceptible
> to interleaving and GIC state corruption. GIC state corruption can
> lead to a range of problems, including kernel panics, and unexpected
> behavior.
> 
> From the erratum text:
>   "In some cases, inter-socket AXI4 Stream packets with multiple
>   transfers, may be interleaved by the fabric when presented to ARM
>   Generic Interrupt Controller. GIC expects all transfers of a packet
>   to be delivered without any interleaving.
> 
>   The following GICv3 commands may result in multiple transfer packets
>   over inter-socket AXI4 Stream interface:
>    - Register reads from GICD_I* and GICD_N*
>    - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
>    - ITS command MOVALL
> 
>   Multiple commands in GICv4+ utilize multiple transfer packets,
>   including VMOVP, VMOVI, VMAPP, and 64-bit register accesses."
> 
>   This issue impacts system configurations with more than 2 sockets,
>   that require multi-transfer packets to be sent over inter-socket
>   AXI4 Stream interface between GIC instances on different sockets.
>   GICv4 cannot be supported. GICv3 SW model can only be supported
>   with the workaround. Single and Dual socket configurations are not
>   impacted by this issue and support GICv3 and GICv4."
> 
> Link: https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf
> 
> Writing to the chip alias region of the GICD_In{E} registers except
> GICD_ICENABLERn has an equivalent effect as writing to the global
> distributor. The SPI interrupt deactivate path is not impacted by
> the erratum.
> 
> To fix this problem, implement a workaround that ensures read accesses
> to the GICD_In{E} registers are directed to the chip that owns the
> SPI, and disable GICv4.x features. To simplify code changes, the
> gic_configure_irq() function uses the same alias region for both read
> and write operations to GICD_ICFGR.
> 
> Co-developed-by: Vikram Sethi <vsethi@nvidia.com>
> Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
> Changes since v4:
>  - Resolve Marc's comments https://lore.kernel.org/all/871qlqif9v.wl-maz@kernel.org/
> Changes since v3:
>  - Fix the build issue for the 32bit arch
> Changes since v2:
>  - Add accessors for the SOC-ID version & revision

SMCCC/SOC ID part looks good to me. In case you spin another version for any
reason, I would prefer you split those changes into separate patch. Otherwise

Acked-by: Sudeep Holla <sudeep.holla@arm.com> (for SMCCC/SOC ID bits)

-- 
Regards,
Sudeep
