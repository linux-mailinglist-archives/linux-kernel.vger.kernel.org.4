Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFC61F3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKGMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiKGMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:45:49 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E151BE94
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9KonJ34QfgPDfIJuoNhPmpY9xXFmGAUYSZ6OQb3Nbz4=;
  b=VO74rI2qk2scUtuYWLPgR3k2KR2nd1LZ/T9tZva03BZmyfSKUV7ib9yj
   sSNR4+zSFDku15GSJdjiRpnjaV7yaC0s04zi/34SHbflnGEGNI3tLtWiD
   k77np/px48QkI3wbWl61W5iDwaM0WSfo1Y3Dc1Rp6ITFAT4c58vxblmDf
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="77014486"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:45:43 +0100
Date:   Mon, 7 Nov 2022 20:45:38 +0800 (+08)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr, kernel@pengutronix.de
Subject: Re: [PATCH v1] coccinelle: api: Don't use devm_platform_get_and_ioremap_resource
 with res==NULL
In-Reply-To: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
Message-ID: <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-169836557-1667825144=:3632"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-169836557-1667825144=:3632
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Nov 2022, Uwe Kleine-König wrote:

> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
> the shorter devm_platform_ioremap_resource(pdev, index).
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> a potential improvement is to check for invocations of
> devm_platform_get_and_ioremap_resource() where the res parameter isn't
> used afterwards, but my coccinelle foo isn't strong enough for that.

... when != res

I'm not sure where you wanted to put it though.

julia

>
> Best regards
> Uwe
>
>  .../api/devm_platform_ioremap_resource.cocci  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
>
> diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> new file mode 100644
> index 000000000000..401610b9a17d
> --- /dev/null
> +++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Don't use devm_platform_get_and_ioremap_resource with NULL as third parameter
> +// Confidence: High
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r1@
> +position p;
> +@@
> + devm_platform_ioremap_resource(...) {
> +	...
> +	devm_platform_get_and_ioremap_resource@p(...)
> +	...
> + }
> +
> +@depends on patch@
> +expression pdev,index;
> +position p != r1.p;
> +@@
> +
> +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> ++  devm_platform_ioremap_resource(pdev, index)
> +
> +@r2 depends on !patch exists@
> +expression pdev,index;
> +position p;
> +@@
> +
> +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> +
> +@script:python depends on org@
> +p << r2.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource", p)
> +
> +@script:python depends on report@
> +p << r2.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_ioremap_resource")
> --
> 2.38.1
>
>
--8323329-169836557-1667825144=:3632--
