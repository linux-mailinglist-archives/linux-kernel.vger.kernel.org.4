Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032647013FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjEMChC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbjEMCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6948D4687
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 19:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Wk+ym5kpqN+r2McL+81J+S8O6L6Yg4SLALm7z013ufw=; b=YNLxI+8pEZoIU8g8Iqkpm8l0sq
        pxMwCe9lvQxlpIKUCdrZD4WC3Z5SkoopIjksgYIz0uo7XHHnYZFTmwVnzJJAuIdzoiyz6CnbG5ydB
        0ONsqb4uPPZVt8Dv0XKYO1ogJMlHcacvmVpOwOJJJqJjMXxerx+mvW8NfBXc7vzEmT53WPGJO6sjx
        0JgVSGoy6b6le+YRdnNWtWcp9cNiCleF2+BhzAlrRDlLI8fHZUOs4k5FNxvx9jjvw9afqGo0IYtOL
        62Klht7dMYx1oX/WtCiWFrazXXFXNufpTOABdaafGYX/ljLzciVVxGdwzF9NlAAsVmGx94EtEDP2D
        G9xZWRRw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxf7m-00DXnw-1B;
        Sat, 13 May 2023 02:36:46 +0000
Message-ID: <e933e663-9bf6-dd20-c55a-17a88bc86201@infradead.org>
Date:   Fri, 12 May 2023 19:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] soc/fsl/qe: fix usb.c build errors
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Leo Li <leoyang.li@nxp.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        Kumar Gala <galak@kernel.crashing.org>
References: <20230410011254.25675-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230410011254.25675-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this patch?

I am still seeing this build error.

On 4/9/23 18:12, Randy Dunlap wrote:
> Fix build errors in soc/fsl/qe/usb.c when QUICC_ENGINE is not set.
> This happens when PPC_EP88XC is set, which selects CPM1 & CPM.
> When CPM is set, USB_FSL_QE can be set without QUICC_ENGINE
> being set. When USB_FSL_QE is set, QE_USB deafults to y, which
> causes build errors when QUICC_ENGINE is not set. Making
> QE_USB depend on QUICC_ENGINE prevents QE_USB from defaulting to y.
> 
> Fixes these build errors:
> 
> drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
> usb.c:(.text+0x1e): undefined reference to `qe_immr'
> powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
> powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
> powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
> powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'
> 
> Fixes: 5e41486c408e ("powerpc/QE: add support for QE USB clocks routing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202301101500.pillNv6R-lkp@intel.com/
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Leo Li <leoyang.li@nxp.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> v2: drop Anton Vorontsov <avorontsov@ru.mvista.com>; rebase/resend
> 
>  drivers/soc/fsl/qe/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -62,6 +62,7 @@ config QE_TDM
>  
>  config QE_USB
>  	bool
> +	depends on QUICC_ENGINE
>  	default y if USB_FSL_QE
>  	help
>  	  QE USB Controller support

-- 
~Randy
