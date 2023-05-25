Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178C7110F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjEYQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjEYQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:27:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D8E6E;
        Thu, 25 May 2023 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=spc29Cm0a+oO128y4mo0IaM9JJ5/Y6pCdvJ8tr2Dfag=; b=sEI6Kn0a/+TFGY+DqA8SqsqAMN
        r7wV/N+GHENm2Gx0P3CUwavLtTrdIDeJfvkRnuCSc3HzFZzTQd67RxcBAT3dA7+CfxrwV85NQuG10
        zRwGHZMZ79ECgzmQGchKlnTlACoWCjc7DnZDP+G0S405EljESD4eSB/MtdNl5raXm245Eg0NWlGEf
        Hz6I5Yc+uVW2wh1GyuVmvu2tBufkFykrDMWiVbr6lPOV1EJhjKd5789WUng75huN0nTLl4IE+AMb0
        xJvhIHyFZSAAZIqnh4u87tCrTL07cphpiuPcS3XioCP/E/HEguj6wQubhuKM3Y84R3pHu+rEEvh5q
        KO5lmlHQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Dnk-00H5bT-26;
        Thu, 25 May 2023 16:26:56 +0000
Message-ID: <dd0e4fac-16ef-5ca6-db8d-21ecf1c0e802@infradead.org>
Date:   Thu, 25 May 2023 09:26:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] soc: fsl: cpm1: Fix TSA and QMC dependencies in
 case of COMPILE_TEST
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel test robot <lkp@intel.com>
References: <20230523085902.75837-1-herve.codina@bootlin.com>
 <20230523085902.75837-2-herve.codina@bootlin.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230523085902.75837-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 01:59, Herve Codina wrote:
> In order to compile tsa.c and qmc.c, CONFIG_CPM must be set.
> 
> Without this dependency, the linker fails with some missing
> symbols for COMPILE_TEST configurations that need QMC without
> enabling CPM.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/

Fixes all of my CPM build issues. (with patch 2/2 also applied)
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  drivers/soc/fsl/qe/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> index 7268c2fbcbc1..e0d096607fef 100644
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -36,7 +36,7 @@ config UCC
>  config CPM_TSA
>  	tristate "CPM TSA support"
>  	depends on OF && HAS_IOMEM
> -	depends on CPM1 || COMPILE_TEST
> +	depends on CPM1 || (CPM && COMPILE_TEST)
>  	help
>  	  Freescale CPM Time Slot Assigner (TSA)
>  	  controller.
> @@ -47,7 +47,7 @@ config CPM_TSA
>  config CPM_QMC
>  	tristate "CPM QMC support"
>  	depends on OF && HAS_IOMEM
> -	depends on CPM1 || (FSL_SOC && COMPILE_TEST)
> +	depends on CPM1 || (FSL_SOC && CPM && COMPILE_TEST)
>  	depends on CPM_TSA
>  	help
>  	  Freescale CPM QUICC Multichannel Controller

-- 
~Randy
