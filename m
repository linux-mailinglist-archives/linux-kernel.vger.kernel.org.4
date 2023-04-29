Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4586F23D6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjD2J1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2J1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67431BD2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 02:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 378A7611A3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 09:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660B1C433EF;
        Sat, 29 Apr 2023 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682760452;
        bh=C7dMA9Z/iKBRGFbjoyJ2bomBnZC1VqbWRGo6yQ1QK1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xw8o4gM3slKEVPD0DLEt33s9B70AcPKChr00qgQtKpr/PZKiMrxklFOy7baTp3231
         oHk//apL5S1GCTw9iqrVsPUGFWR56Fr2lgTUT9IMdD+ILga/uhLYMfK121jPrtjUYk
         WUuYacFZVScLrSVVzzpmNRGO5G1qjahKsJguMlcPWQxRSHE8/BQT+i/goWA6AACf41
         nd+hqL8bjS4+FE+EvxrL7TqNtmPMqx14CWIQCR7x+reMgk2jATlwiHgK+WRsyl4PsW
         1Sa0HhBuoOezZy4H+Wf7yW1mVXZ2itHXsOxMRmcpWlHuBfgIoE8ZBZSK4OPqJr19bv
         EAY1D4nr046fA==
Received: by pali.im (Postfix)
        id 3821D7AC; Sat, 29 Apr 2023 11:27:29 +0200 (CEST)
Date:   Sat, 29 Apr 2023 11:27:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next?] powerpc/fsl_uli1575: fix kconfig warnings and
 build errors
Message-ID: <20230429092729.znfdx7tlcpz7ce63@pali>
References: <20230429043519.19807-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230429043519.19807-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2023 21:35:19 Randy Dunlap wrote:
> Neither FSL_SOC_BOOKE nor PPC_86xx enables CONFIG_PCI by
> default, so it may be unset in some randconfigs.
> When that happens, FSL_ULI1575 may be set when it should not be
> since it is a PCI driver. When it is set, there are 3 kconfig
> warnings and a slew of build errors
> 
> WARNING: unmet direct dependencies detected for PCI_QUIRKS
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - FSL_PCI [=y]
> 
> WARNING: unmet direct dependencies detected for GENERIC_ISA_DMA
>   Depends on [n]: ISA_DMA_API [=n]
>   Selected by [y]:
>   - FSL_ULI1575 [=y] && (FSL_SOC_BOOKE [=n] || PPC_86xx [=y])
> 
> WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - FSL_PCI [=y]
> 
> and 30+ build errors.
> 
> Fixes: 22fdf79171e8 ("powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -265,6 +265,7 @@ config CPM2
>  config FSL_ULI1575
>  	bool "ULI1575 PCIe south bridge support"
>  	depends on FSL_SOC_BOOKE || PPC_86xx
> +	depends on PCI
>  	select FSL_PCI
>  	select GENERIC_ISA_DMA
>  	help

Ok, looks like a reasonable solution for this issue.

These kind of cleanups (as done in uli1575 patch series) are always
problematic as they can break some unusual configuration...

Reviewed-by: Pali Rohár <pali@kernel.org>
