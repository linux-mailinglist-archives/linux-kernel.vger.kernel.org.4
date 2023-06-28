Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83042740FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1LUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1LUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204F268F;
        Wed, 28 Jun 2023 04:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7E86123F;
        Wed, 28 Jun 2023 11:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29716C433C0;
        Wed, 28 Jun 2023 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687951234;
        bh=LHMT+jMyh1KgFrukNaOe3u2A8SgHf2NfxYFrhk1vdmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dim2nTJfoViufV/g4QdmoE3rL60fjPTE6rPVToK5vJylxAw5lm4eBIw1zdKvpjT+8
         MyT2EJxk0lt+cGMmsGaeTA6MLsegf81GBvcCczcvCiWjCl942yXgzcWsofoPGAjNRW
         bDnGpJwpQBL6VhYMuWw6RIjlXQ8/vAiWjdLvaWZsznwAkAN74Vxm/rQ04ex+NxoaoS
         xexy44Y96qa73/H9wxKK7sL2GJC26tU+v3UoVDHCI01vX7mtpGG4HvTc3Ved/sThXu
         BGFjxk0qKx5suM3XqC5k7kviVbhGfUL7QRhFdKftRjwTHFP28FF2QWvYg/MtSE2NIF
         sF01ZRvitO7hQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qETDu-0003xa-FA; Wed, 28 Jun 2023 13:20:34 +0200
Date:   Wed, 28 Jun 2023 13:20:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] firmware: qcom_scm: Clear scm pointer on probe
 failure
Message-ID: <ZJwXgqmu_zpV46lu@hovoldconsulting.com>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-3-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528230351.168210-3-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 01:03:49AM +0200, Maximilian Luz wrote:
> When setting-up the IRQ goes wrong, the __scm pointer currently remains
> set even though we fail to probe the driver successfully. Due to this,
> access to __scm may go wrong since associated resources (clocks, ...)
> have been released. Therefore, clear the __scm pointer when setting-up
> the IRQ fails.
> 
> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Patch introduced in v4
> 
> ---
>  drivers/firmware/qcom_scm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..d0070b833889 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1488,8 +1488,10 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	} else {
>  		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
>  						IRQF_ONESHOT, "qcom-scm", __scm);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			__scm = NULL;

This looks fragile at best. Clients use qcom_scm_is_available() to see
if __scm is available and do not expect it to go away once it is live.

It looks like you can hold off on initialising __scm until you've
requested the interrupt, either by using IRQ_NOAUTOEN or fixing
qcom_scm_waitq_wakeup() so that it doesn't use __scm directly.

That would also take care of the previous branch which may also leave
__scm set after the structure itself has been released on errors.

You'll have similar problems when registering qseecom which currently
depend on __scm being set, though. Clearing the pointer in that case is
clearly broken as you currently rely on devres for deregistering the aux
clients on errors (i.e. the clients using __scm are still registered
when you clear the pointer in patch 3/4).

>  			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
> +		}
>  	}
>  
>  	__get_convention();

Johan
