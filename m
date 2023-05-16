Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09B705661
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjEPSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C981FD4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3776E630AB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B413C433D2;
        Tue, 16 May 2023 18:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684263243;
        bh=Y29ciGsqbYK4aeA9R00cOYH1MS2t61zQJwlFBgifawk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jssn2VyKDq8zz69hFz2NfP+8chmdjxly5blQwS/tntPZ9RwClaVaC995/sMQSeCx8
         3m43c0bXxAJE+s9JxQ3Voj70RSGKPchFcJx21ZEbiFCVn9mGyeFTS5NveVXbsxftix
         mkL4+jw+jx4/ScXe/1q821JhDxTVCes+lZcd4GsKfsZnPHYLRKh4S0xv4fF6/6HATA
         iK0VCyIY63Sei//q2cV+0vojQc5uTomXokd87DNDxT8llhERXxJD59oWXCONw49Ljg
         8ey4WhM0+5A71CDFxQbXx6yKIxZiQoNQz2f77eaaaThwNeCgPpXlkxzW5BkhgVuDrl
         bjEwS6pAQiDhg==
Received: by pali.im (Postfix)
        id AEDEBA47; Tue, 16 May 2023 20:54:00 +0200 (CEST)
Date:   Tue, 16 May 2023 20:54:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
Message-ID: <20230516185400.urjy6y3kh4grbagt@pali>
References: <20230516152854.22465-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516152854.22465-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2023 08:28:54 Randy Dunlap wrote:
> In a randconfig with CONFIG_SERIAL_CPM=m and
> CONFIG_PPC_EARLY_DEBUG_CPM=y, there is a build error:
> ERROR: modpost: "udbg_putc" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
> 
> Prevent the build error by allowing PPC_EARLY_DEBUG_CPM only when
> SERIAL_CPM=y.
> 
> Fixes: c374e00e17f1 ("[POWERPC] Add early debug console for CPM serial ports.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org

Looks good,

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  arch/powerpc/Kconfig.debug |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -240,7 +240,7 @@ config PPC_EARLY_DEBUG_40x
>  
>  config PPC_EARLY_DEBUG_CPM
>  	bool "Early serial debugging for Freescale CPM-based serial ports"
> -	depends on SERIAL_CPM
> +	depends on SERIAL_CPM=y
>  	help
>  	  Select this to enable early debugging for Freescale chips
>  	  using a CPM-based serial port.  This assumes that the bootwrapper
