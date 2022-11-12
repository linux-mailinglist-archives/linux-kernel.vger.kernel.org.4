Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7E626664
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiKLCLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiKLCLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:11:18 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8781EEF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668219077; x=1699755077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tVnzCIB/D4Hs8hr4UQqxx65RGUiscS9RdxgdHub7Ww8=;
  b=m2+Aqi5EIdO2a61NBv36Xt7gmV6EVHX7YZzuSjFbkwmW8Cj2uQ1vFfO7
   SIlPLAqERIMZX+LFGnkZLxeGWtVKIF/ElFkxkMV9ZnAjENbzn4qrmRnaY
   CA9rqx6woo+KoluBtBXtPSO2FNt6kWpqTRvjdReaNw/WrzXx/MULo7ZdO
   /xGqAzJ3rNtAvJH0RajU7Hvl2ec8LMlPVu7TvbX7nURVWGi9WUp73Iyv8
   aVXO5dLQESePh9lt34eKWy+Wa/T/6X4tKWcRrY5sUv4JYv5iQKyB7bKX5
   4KtndtDdgv8v63+eujnHm7ABjGHBmJL6rpn2K8nJebhA0x1dbtD2WXbAQ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="328193773"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 10:11:15 +0800
IronPort-SDR: +ZqbBMwGsYFPL7TDvtQ9U8eAjUYbl7BKUJut7aCkc4CbyAWMhFvfH1QJ+DN5Me0BTMrONRM7AI
 7tk/6OysCoJpCtOoEMm/78SdfnNaaSDpEcQWaqSJNAnbgVbIU1/TXePeWuNedt1nosZcrQVnFX
 u+xkEqPKH2ynOCnF5sWAicl06YnBRzKceXgqtLfwwdrF9hNNVDy2fNSf7s/4qGFyuMSBUqa9XG
 1nZiF7wTxgf8R86OhIyYnkS4bcddqHXWzme0MFw4vUNjHPpytk6MJRwnaArCnuqEmq+s/lGJAn
 Hxo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:30:17 -0800
IronPort-SDR: BfWzwIgEEBVPzMxikzpFcQiMVB7KEz4swywf1qVTjknEcZprY1phgOtwQmfcKZ1WPJfHcA8XZs
 j//rMl5Ye7F0dYPFMuq8rk9NFOFYoZr4GaeyLCKyPyaBXHRo71qlzYoMEfGu78HcBVLZnw8ku4
 2UzQXs+bbpGwouFUUn8umHx51fQZxrhdAoWjMGrKapxOhb0kFzmnlnMWse6WjJ30hhcih7MZS8
 Aq2oIpXQp0lAa6qzu8BlouF6rHa7XKlfYBCuCki8lSIrRo3sIlkpf8kK3q3AV5TzHURWYlj1XY
 9BM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 18:11:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jw33sr2z1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:11:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668219074; x=1670811075; bh=tVnzCIB/D4Hs8hr4UQqxx65RGUiscS9Rdxg
        dHub7Ww8=; b=lrwVaEUeAZSAaKpdTNpkJ3GE/AIl4RokhhuiCRbPybEbVCg7uLB
        misKBM+ilt66cPBhlqgfv/tNfBKRMOyVBumzP6ysKAdhy49wumXz54ndevqziFc6
        ayVbjfi7VXVjI/f/lWMNdLISXoL2Zvt9YTByqxjG1BeaGL1jfXqgeD+D5ooxg234
        e796zoEswOQIf+rqWGPsKpEN4h8hZ6gMu+Xpqu85KQoaechNDi9G2lC8x9QK79gX
        5QITXevD/z9ZqajV1GnyphPY29gP2tva5xVo4caPH/AGk4KN8q29aLgaGSzM9q4f
        c85YxWjLVwusf37cznL9rgzP34Jj8pS6VBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9aGQzmU7eqqG for <linux-kernel@vger.kernel.org>;
        Fri, 11 Nov 2022 18:11:14 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jw22W0mz1RvLy;
        Fri, 11 Nov 2022 18:11:14 -0800 (PST)
Message-ID: <f46021a8-03f1-60ea-a783-5626272de2a6@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 11:11:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] ata: sata_dwc_460ex: Check !irq instead of irq ==
 NO_IRQ
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <146506d93c96b842422d31a90b5d23c98b70a111.1668155425.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <146506d93c96b842422d31a90b5d23c98b70a111.1668155425.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 17:30, Christophe Leroy wrote:
> NO_IRQ is a relic from the old days. It is not used anymore in core
> functions. By the way, function irq_of_parse_and_map() returns value 0
> on error.
> 
> In some drivers, NO_IRQ is erroneously used to check the return of
> irq_of_parse_and_map().
> 
> It is not a real bug today because the only architectures using the
> drivers being fixed by this patch define NO_IRQ as 0, but there are
> architectures which define NO_IRQ as -1. If one day those
> architectures start using the non fixed drivers, there will be a
> problem.
> 
> Long time ago Linus advocated for not using NO_IRQ, see
> https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
> recently in https://lkml.org/lkml/2022/10/12/622
> 
> So test !irq instead of tesing irq == NO_IRQ.
> 
> And remove the fallback definition of NO_IRQ at the top of the file.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to for-6.2. Thanks !

> ---
> v2: Also removed the #ifndef NO_IRQ #define NO_IRQ 0 at the top
> ---
>  drivers/ata/sata_dwc_460ex.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index e3263e961045..7b7e1516dbdd 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -42,10 +42,6 @@
>  #define sata_dwc_writel(a, v)	writel_relaxed(v, a)
>  #define sata_dwc_readl(a)	readl_relaxed(a)
>  
> -#ifndef NO_IRQ
> -#define NO_IRQ		0
> -#endif
> -
>  #define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length */
>  
>  enum {
> @@ -242,7 +238,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  
>  	/* Get SATA DMA interrupt number */
>  	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
> -	if (hsdev->dma->irq == NO_IRQ) {
> +	if (!hsdev->dma->irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}
> @@ -1180,7 +1176,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  
>  	/* Get SATA interrupt number */
>  	irq = irq_of_parse_and_map(np, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}

-- 
Damien Le Moal
Western Digital Research

