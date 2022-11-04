Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B16196A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKDM5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E826129;
        Fri,  4 Nov 2022 05:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70D462188;
        Fri,  4 Nov 2022 12:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B904C433C1;
        Fri,  4 Nov 2022 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667566633;
        bh=KuVTIs698EEiMtO2v0TB5wgsiCGrjXYfsEWLWFVUQGM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iOCFHVwzehKg74QV6hcvqhUwTAQe1qcPUkZoRmurL8Suu/DRTD1OD23PJK40Ue3/t
         jLT3vofgYUSjxnZJj1G8Zq5NJdoOOdyUDNExdyDdFvwnmYMnqtRQZd00A8xYLDb10/
         vITe3avFalS0HW7W2bE/idRKGp2lcsHOQ5X7u2gHYAGz9IsPMS+J1a4jlIQWClwzRI
         zFCN3avf3xCocrlwKTwNgRFCE+3dwXRTRdL5Ep1XVnAOgf4Wf/CBfX8/DOtnMNMSYT
         iSJdg9F1BEh33Xt4mWhO1cLh7BW0WihuNi5+GJu5BbB1fKy6ovBwcfCimy+3o11Yji
         AbNQeHSY8SIww==
Message-ID: <1f1552cd-d16b-fea0-2816-9bb3a2373ff5@kernel.org>
Date:   Fri, 4 Nov 2022 14:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 3/5] remoteproc: pru: Make sysfs entries read-only for
 PRU client driven boots
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Suman Anna <s-anna@ti.com>, "Andrew F . Davis" <afd@ti.com>,
        nm@ti.com, vigneshr@ti.com, srk@ti.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221031073801.130541-1-danishanwar@ti.com>
 <20221031073801.130541-4-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221031073801.130541-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2022 09:37, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The PRU remoteproc driver is not configured for 'auto-boot' by default,
> and allows to be booted either by in-kernel PRU client drivers or by
> userspace using the generic remoteproc sysfs interfaces. The sysfs
> interfaces should not be permitted to change the remoteproc firmwares
> or states when a PRU is being managed by an in-kernel client driver.
> Use the newly introduced remoteproc generic 'sysfs_read_only' flag to
> provide these restrictions by setting and clearing it appropriately
> during the PRU acquire and release steps.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
>  drivers/remoteproc/pru_rproc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 9ba73cfc29e2..14eb27bb5f3f 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -230,6 +230,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>  	}
>  
>  	pru->client_np = np;
> +	rproc->sysfs_read_only = true;
>  
>  	mutex_unlock(&pru->lock);
>  
> @@ -268,6 +269,7 @@ void pru_rproc_put(struct rproc *rproc)
>  	}
>  
>  	pru->client_np = NULL;
> +	rproc->sysfs_read_only = false;
>  	mutex_unlock(&pru->lock);
>  
>  	rproc_put(rproc);
