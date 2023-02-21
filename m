Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705F769E60C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjBURd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBURdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:33:24 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41646CA01;
        Tue, 21 Feb 2023 09:33:20 -0800 (PST)
Received: from [192.168.4.137] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8E66220B9C3D;
        Tue, 21 Feb 2023 09:33:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E66220B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677000799;
        bh=kKi0N4EszwVCj0VywnzfrWO8zvwdXe+htSOdeZZnwps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ssdiSMnzNZ2muyfYqtaQuCdWg4MFQsUi/eVle/aVUyxi86XudHkyISr7UXAXHgfT4
         tywFkY3/FSfYSR0fzmXvxF+8/mRJsWjDfkA5mGQz1Fg1lzevXtZsl32WLahM0FCOh6
         4dQlyDrEKQHIiVfLZomFKlqgSkVi3XOM17HgUTx4=
Message-ID: <9f33c874-17ef-ddd8-041c-e1f9995385fa@linux.microsoft.com>
Date:   Tue, 21 Feb 2023 09:33:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Content-Language: en-US
To:     meenakshi.aggarwal@nxp.com, horia.geanta@nxp.com, V.sethi@nxp.com,
        pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        franck.lenormand@nxp.com
Cc:     code@tyhicks.com
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
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



On 2/20/2023 9:42 PM, meenakshi.aggarwal@nxp.com wrote:
> From: Horia Geanta <horia.geanta@nxp.com>
> 
> Issues:
> - Job ring device is busy when do kexec reboot
> - Failed to flush job ring when do system suspend-resume
> 
> Fix:
> Flush the job ring to stop the running jobs.
> 
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>

Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

Thanks,
Vijay


> ---
>   drivers/crypto/caam/jr.c | 53 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> index 724fdec18bf9..8745fe3cb575 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -72,19 +72,27 @@ static void caam_jr_crypto_engine_exit(void *data)
>   	crypto_engine_exit(jrpriv->engine);
>   }
>   
> -static int caam_reset_hw_jr(struct device *dev)
> +/*
> + * Put the CAAM in quiesce, ie stop
> + *
> + * Must be called with itr disabled
> + */
> +static int caam_jr_stop_processing(struct device *dev, u32 jrcr_bits)
>   {
>   	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
>   	unsigned int timeout = 100000;
>   
> -	/*
> -	 * mask interrupts since we are going to poll
> -	 * for reset completion status
> -	 */
> -	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
> +	/* Check the current status */
> +	if (rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_INPROGRESS)
> +		goto wait_quiesce_completion;
>   
> -	/* initiate flush (required prior to reset) */
> -	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
> +	/* Reset the field */
> +	clrsetbits_32(&jrp->rregs->jrintstatus, JRINT_ERR_HALT_MASK, 0);
> +
> +	/* initiate flush / park (required prior to reset) */
> +	wr_reg32(&jrp->rregs->jrcommand, jrcr_bits);
> +
> +wait_quiesce_completion:
>   	while (((rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_MASK) ==
>   		JRINT_ERR_HALT_INPROGRESS) && --timeout)
>   		cpu_relax();
> @@ -95,8 +103,35 @@ static int caam_reset_hw_jr(struct device *dev)
>   		return -EIO;
>   	}
>   
> +	return 0;
> +}
> +
> +/*
> + * Flush the job ring, so the jobs running will be stopped, jobs queued will be
> + * invalidated and the CAAM will no longer fetch fron input ring.
> + *
> + * Must be called with itr disabled
> + */
> +static int caam_jr_flush(struct device *dev)
> +{
> +	return caam_jr_stop_processing(dev, JRCR_RESET);
> +}
> +
> +static int caam_reset_hw_jr(struct device *dev)
> +{
> +	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
> +	unsigned int timeout = 100000;
> +	int err;
> +	/*
> +	 * mask interrupts since we are going to poll
> +	 * for reset completion status
> +	 */
> +	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
> +	err = caam_jr_flush(dev);
> +	if (err)
> +		return err;
> +
>   	/* initiate reset */
> -	timeout = 100000;
>   	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
>   	while ((rd_reg32(&jrp->rregs->jrcommand) & JRCR_RESET) && --timeout)
>   		cpu_relax();
