Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B468F737933
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFUCfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFUCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:35:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1066F1;
        Tue, 20 Jun 2023 19:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5QVde+aCtkyeO9PhvNS7dvhtdA2REJAUQtT0F17oHaM=; b=l/6hFWRYwykPTVQI99vIiBeIDC
        JabZgEyC9JZtOXI9aMkLciMaVL5v2v5PF9jTZ4E4E2xf/6AcjuFs3Ydi1+VmJwAJNsD1PfRiKwtFW
        +FhjG2lMD7PXe5IQKUFhzmo7eggcW3MFvLyQwjAUubCsOufg0/NzTV31g+50jhVi+5OJ9AmB0iC0x
        AAdK3POkVRB6sfOdhkLn0iLPQ+g3LQVmW1RIbqnGbpCupMN/RcWQfpU7INH6gyIfgqySH0TqOdgs1
        T5RO8U38FH7gNuDrcIXlapadFpVBuylxpjVbN6nu9V7buxnKOsXXeqiKJGR1YIARAh4aRNHteaELA
        fRs5zR6w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBngk-00CxNp-1S;
        Wed, 21 Jun 2023 02:35:18 +0000
Message-ID: <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
Date:   Tue, 20 Jun 2023 19:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230615222152.13250-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230615222152.13250-1-rdunlap@infradead.org>
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

Hi,

On 6/15/23 15:21, Randy Dunlap wrote:
> When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
> warnings:
> 
> ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
>    40 | #error Cannot compile lcs.c without some net devices switched on.
> ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
> ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
>  1601 |         int rc;
> 
> Solve this by using IS_ENABLED(CONFIG_symbol) instead of ifdef
> CONFIG_symbol. The latter only works for builtin (=y) values
> while IS_ENABLED() works for builtin or modular values.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> ---
>  drivers/s390/net/lcs.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> --- a/drivers/s390/net/lcs.c
> +++ b/drivers/s390/net/lcs.c
> @@ -36,7 +36,7 @@
>  #include "lcs.h"
>  
>  
> -#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
> +#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
>  #error Cannot compile lcs.c without some net devices switched on.
>  #endif
>  
> @@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
>  	int rc;
>  
>  	LCS_DBF_TEXT(2, trace, "strtauto");
> -#ifdef CONFIG_ETHERNET
> +#if IS_ENABLED(CONFIG_ETHERNET)
>  	card->lan_type = LCS_FRAME_TYPE_ENET;
>  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
>  	if (rc == 0)
>  		return 0;
>  
>  #endif
> -#ifdef CONFIG_FDDI
> +#if IS_ENABLED(CONFIG_FDDI)
>  	card->lan_type = LCS_FRAME_TYPE_FDDI;
>  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
>  	if (rc == 0)
> @@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
>  		goto netdev_out;
>  	}
>  	switch (card->lan_type) {
> -#ifdef CONFIG_ETHERNET
> +#if IS_ENABLED(CONFIG_ETHERNET)
>  	case LCS_FRAME_TYPE_ENET:
>  		card->lan_type_trans = eth_type_trans;
>  		dev = alloc_etherdev(0);
>  		break;
>  #endif
> -#ifdef CONFIG_FDDI
> +#if IS_ENABLED(CONFIG_FDDI)
>  	case LCS_FRAME_TYPE_FDDI:
>  		card->lan_type_trans = fddi_type_trans;
>  		dev = alloc_fddidev(0);


kernel test robot reports build errors from this patch when
ETHERNET=y, FDDI=m, LCS=y:

  https://lore.kernel.org/all/202306202129.pl0AqK8G-lkp@intel.com/

Since the code before my patch expected (supported) FDDI=y only
(by checking for CONFIG_FDDI only and not checking for CONFIG_FDDI_MODULE),
the best solution that I can see is to enforce that expectation in
drivers/s390/net/Kconfig:

diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -5,7 +5,7 @@ menu "S/390 network device drivers"
 config LCS
 	def_tristate m
 	prompt "Lan Channel Station Interface"
-	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+	depends on CCW && NETDEVICES && (ETHERNET || FDDI = y)
 	help
 	  Select this option if you want to use LCS networking on IBM System z.
 	  This device driver supports FDDI (IEEE 802.7) and Ethernet.

What do people think of that change?
Any other ideas/suggestions?

thanks.
-- 
~Randy
