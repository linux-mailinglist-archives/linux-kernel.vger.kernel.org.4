Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE076285B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiKNQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiKNQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:41:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9441169
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:41:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21266B81084
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F4C433D6;
        Mon, 14 Nov 2022 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444101;
        bh=sJlYpdlEpWSZJfz2x3sOrQSeKfAOLQ7Vr/1pDVDUXAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cob+4nSMOS4k0r4QdKG7oEHPcdxmUh9+ev/F3T2LYs1yRQ3kDwtiDs7b1PK+ciUff
         9IWJcHZiRs7CsoGwbp88dhGHpAOilcdhF1xXarW4dcHwQWFpPNR7+92fNSD3NCbJpQ
         XsKfiOOroj7w7DLF52MCEk08btswoUJJP6xXD0Y39pD1abSZrCXs0kTidyzPLHwJXc
         LyuxOTDN936sTl5oaabV1p7bJo/JZ3w6rX3BSsB7IH107k0mp9zfTUPHJR9W1pLHpV
         ID2W6PgOO0wfH3wGlMp7UKimnB/6Yf5m//i3kCCoLa3RsO8VuXZmauvizF/BFuCY6D
         WnsTNemuxffyg==
Date:   Mon, 14 Nov 2022 16:41:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add PMEM support for RISC-V
Message-ID: <Y3JvwagRsMOJyayy@spud>
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Anup,

Looks like patches 2 and 3 are failing for the nommu defconfigs:
https://patchwork.kernel.org/project/linux-riscv/list/?series=694995
Unfortunately, if the build fails NIPA doesn't appear to save a log.

In case it's relevant, should be gcc-11 & bintutils 2.37.

Thanks,
Conor.

On Mon, Nov 14, 2022 at 02:35:33PM +0530, Anup Patel wrote:
> The Linux NVDIMM PEM drivers require arch support to map and access the
> persistent memory device. This series adds RISC-V PMEM support using
> recently added Svpbmt and Zicbom support.
> 
> First two patches are fixes and remaining two patches add the required
> PMEM support for Linux RISC-V.
> 
> These patches can also be found in riscv_pmem_v6 branch at:
> https://github.com/avpatel/linux.git
> 
> Changes since v5:
>  - Rebased on Linux-6.1-rc5
>  - Directly add pmem.o in obj-y of PATCH3
>  - Dropped PATCH1 since this is already merged.
> 
> Changes since v4:
>  - Simplify PATCH2 by implementing RISC-V specific arch_memremap_wb()
> 
> Changes since v3:
>  - Pickup correct version of Drew's patch as PATCH1
> 
> Changes since v2:
>  - Rebased on Linux-6.1-rc1
>  - Replaced PATCH1 with the patch proposed by Drew
> 
> Changes since v1:
>  - Fix error reported by test bot
>    https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/
> 
> Anup Patel (3):
>   RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
>   RISC-V: Implement arch specific PMEM APIs
>   RISC-V: Enable PMEM drivers
> 
>  arch/riscv/Kconfig           |  1 +
>  arch/riscv/configs/defconfig |  1 +
>  arch/riscv/include/asm/io.h  |  5 +++++
>  arch/riscv/mm/Makefile       |  1 +
>  arch/riscv/mm/pmem.c         | 21 +++++++++++++++++++++
>  5 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/mm/pmem.c
> 
> -- 
> 2.34.1
> 
