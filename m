Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998C65CF8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjADJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjADJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:30:21 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BE12D3A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672824620; x=1704360620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rlN+2bLa8bUAn6Ge1/hCOYZUPOXVa3e1x+lsQpG/kU=;
  b=MarxyVBnWpP5RrAoOHnq8iVRipM0i40zswaMJnwngw/sZNaXJcowfp49
   gH3iZ1sx6yAxRvT1w4Ch05nRPEr3gumYFNdFsflwdPwL3hiA9e5xZxwq2
   T6j7XiwLg84mpNp0OoB7Jg2W9vbsFoURy5A7wupUI7ZOLO5Jj8l2PfI3s
   nGZ0lR6Ph4sQiRbHqCpMfaLLKVrZcDWtbQaJ2a38q2povBqQbCco8JkOJ
   iYlNQlc8Bj6Qh/FaIaTG4RvZwC2lh0zOWihHIkWCROI4TbkSByIAUzjB7
   j2u1HSWW5yoB6R3V55YdLCtp9ZPxfFwJ7JUbMxhQsepd0YlkBiT3g1X0b
   g==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28236673"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Jan 2023 10:30:18 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 04 Jan 2023 10:30:18 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 04 Jan 2023 10:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672824618; x=1704360618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rlN+2bLa8bUAn6Ge1/hCOYZUPOXVa3e1x+lsQpG/kU=;
  b=ShmhkEiMN2n1ebr2n6yXW+XAUdKY4lOQ6/RT6Wct0D/xANF1Ysoi2kTG
   3rrslthe4crX0h9eENsDtMBGEYJgHZBR7XwfOtaAwU+7mC0na0qEnq+kf
   WOCsYytr8J7tbi0IXCSmynNAqkEg/3OGhC37BQbGxkBPkpxrkQIZpEGR/
   4OPF8oa9dfU4rfMandJ3kNQhd38FJsxEdDQHKwwLm1aHg4eHIADiLSszo
   18XCgzC1aBIYnqso75g6wvjRraFGuA3iBjPnYg7R4QTVSMFyWLBKY8WaW
   JGdlWUQED0yAEtlB2yU28CqzG1mq6w/CRaKYtDL+3gaYxj//btA44zTZi
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28236672"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Jan 2023 10:30:18 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 43851280056;
        Wed,  4 Jan 2023 10:30:18 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiaolei.wang@windriver.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH v2] soc: imx8m: fix wrong return value check of of_clk_get_by_name()
Date:   Wed, 04 Jan 2023 10:30:15 +0100
Message-ID: <2597043.tIAgqjz4sF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230104092702.2553290-1-yangyingliang@huawei.com>
References: <20230104092702.2553290-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the update.

Am Mittwoch, 4. Januar 2023, 10:27:02 CET schrieb Yang Yingliang:
> of_clk_get_by_name() never returns NULL pointer, it will return
> ERR_PTR() when it fails, so replace the check with IS_ERR().
> 
> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> register") Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Check WARN_ON() instead of checking IS_ERR().
> ---
>  drivers/soc/imx/soc-imx8m.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 28144c699b0c..d1dbe318be53 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -66,10 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
>  	ocotp_base = of_iomap(np, 0);
>  	WARN_ON(!ocotp_base);
>  	clk = of_clk_get_by_name(np, NULL);
> -	if (!clk) {
> -		WARN_ON(!clk);
> +	if (WARN_ON(IS_ERR(clk)))
>  		return 0;
> -	}
> 
>  	clk_prepare_enable(clk);

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>



