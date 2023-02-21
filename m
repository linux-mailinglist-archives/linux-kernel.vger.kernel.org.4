Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CE269E609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjBURcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBURcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:32:20 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F1982C671;
        Tue, 21 Feb 2023 09:32:19 -0800 (PST)
Received: from [192.168.4.137] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1FFC8209A932;
        Tue, 21 Feb 2023 09:32:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FFC8209A932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677000738;
        bh=UrXErgl/q/ax1SVIKnwoa08TmyMJOtQDMok5VA/M6Sw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k3pTi8NX9wO5r4pzZxU0++ohEaAlrEyi+Muy3e25ptfm6aZes6nq80+rWGybnaLbS
         pEe0Aotu2C/gLZLqZYLy1buuEueITuqEywXTyJQXHHFefo1tng13mfTCQQlz+2Fpat
         7JfhndNPP4okBGY1zaNrEoLyhNVQxI2TUIX8xhqA=
Message-ID: <d253d5ba-8e57-dc20-dfb4-08aac9e92a4c@linux.microsoft.com>
Date:   Tue, 21 Feb 2023 09:32:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Content-Language: en-US
To:     meenakshi.aggarwal@nxp.com, horia.geanta@nxp.com, V.sethi@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        franck.lenormand@nxp.com
Cc:     code@tyhicks.com
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2023 9:40 PM, meenakshi.aggarwal@nxp.com wrote:
> From: Gaurav Jain <gaurav.jain@nxp.com>
> 
> add .shutdown hook in caam_jr driver to support kexec boot
> 
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>

Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

Thanks,
Vijay

> ---
>   drivers/crypto/caam/jr.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index 8745fe3cb575..a2a99d09b4ad 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -198,6 +198,11 @@ static int caam_jr_remove(struct platform_device *pdev)
>   	return ret;
>   }
>   
> +static void caam_jr_platform_shutdown(struct platform_device *pdev)
> +{
> +	caam_jr_remove(pdev);
> +}
> +
>   /* Main per-ring interrupt handler */
>   static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
>   {
> @@ -653,6 +658,7 @@ static struct platform_driver caam_jr_driver = {
>   	},
>   	.probe       = caam_jr_probe,
>   	.remove      = caam_jr_remove,
> +	.shutdown = caam_jr_platform_shutdown,
>   };
>   
>   static int __init jr_driver_init(void)
