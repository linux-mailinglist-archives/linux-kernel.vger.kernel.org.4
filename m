Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935776D8473
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjDERCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjDERCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:02:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4646A63
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:00:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso40184541pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680713989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwKkt8UZiD6fRvOx9rvYnVXlwR4u+FrQ9QF6T/cZZ2g=;
        b=K0VXt7uzMbgeVdLQlGWjVFdFVdL2wVsoMEWVeT63P3jknf0qvrRohz3eZ2D96Vkso5
         bjvvI5yDDjeoJx5vzt0xpQZk59equg1a0ShTWy/kQofIjMboQL4aTDSYUYVmZ32bZLH2
         R0JpLjorAL2vKr2EHj0m2F2GYS70yeh3yhoRGidaG6PG8VS6KEsTpmbVFHHT5r5EGjuE
         uXkAkhKHcMYTjAkkzhxaFdyllF/8L5teR8f1+yuKF654OHlN1Eitguh4YOE4x0wKHHtU
         jsiYKFCykDbQG9qKckPJSDchmm8/000DTTaJxA8CqmlxZdtljmSCKJCXP2HF6BBTBasy
         0mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwKkt8UZiD6fRvOx9rvYnVXlwR4u+FrQ9QF6T/cZZ2g=;
        b=KeCKOdfA1Rhz7oTbJ1A5QTN1xjcDmLnBkVxpJu47zH8p1ehwPZSRIRXLrVcBny0Mbc
         iksFxJRqrHPSKKhcZOml4pZ25b9bV1lfkA4X7ojIKWiug8yZoT/qTV4iXDbvcVCK5voR
         GQ/oaIkeMXsJPPKlilJEg9+u1D4yRddD6wQRBykWObszIXRPXFC3KRVOj+rARQNhvMS2
         JnJxYR9wLJK83q8BU/sP7b2qjjAMF3IFlBetpX8DsZ+TU7dF2w/jPpezCtoDiZuuPgBS
         cCY2Xb0mTPaz2CdyUUJqSPjkZhkf+j0MLYBC7UDPg2HPtDveVLJzJfOMg1Ag7iUJYWCS
         9MyQ==
X-Gm-Message-State: AAQBX9fV2u/ScdsWtAEvdXC5FytmeivmC4kXDdFyJzWi3pLDJQMrNhEP
        JUjBvHWqHEsGz0t7+PQDQXWo8VIUsmWSAb9479w=
X-Google-Smtp-Source: AKy350bGw9ye0QyyHuauw+aT8RcP5GbRWyMs9bq4TNM0KhIyUtjWQiDxlmKbWulcAimscfqzgrrhBQ==
X-Received: by 2002:a17:90b:3511:b0:22c:afd6:e597 with SMTP id ls17-20020a17090b351100b0022cafd6e597mr7288067pjb.17.1680713989285;
        Wed, 05 Apr 2023 09:59:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c807:a26a:a179:b5ec])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001a24cded097sm10339946pld.236.2023.04.05.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:59:48 -0700 (PDT)
Date:   Wed, 5 Apr 2023 10:59:46 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] remoteproc: pru: remove always true check positive
 unsigned value
Message-ID: <20230405165946.GA3812912@p14s>
References: <20230404-pru-always-true-v1-1-b1b55eeff188@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-pru-always-true-v1-1-b1b55eeff188@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:44:53PM +0200, Simon Horman wrote:
> In both cases they type of da is u32. And PRU_PDRAM_DA is 0.
> So the check da >= PRU_PDRAM_DA is always true and can be removed.
> 
> Flagged by Smatch:
> 
>  drivers/remoteproc/pru_rproc.c:660 pru_d_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'
>  drivers/remoteproc/pru_rproc.c:709 pru_i_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'
> 
> No functional changes intended.
> Compile tested only.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://www.spinics.net/lists/kernel/msg4025983.html
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/remoteproc/pru_rproc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Applied

Thanks,
Mathieu


> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index b76db7fa693d..095f66130f48 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -657,7 +657,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  		swap(dram0, dram1);
>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>  
> -	if (da >= PRU_PDRAM_DA && da + len <= PRU_PDRAM_DA + dram0.size) {
> +	if (da + len <= PRU_PDRAM_DA + dram0.size) {
>  		offset = da - PRU_PDRAM_DA;
>  		va = (__force void *)(dram0.va + offset);
>  	} else if (da >= PRU_SDRAM_DA &&
> @@ -706,8 +706,7 @@ static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  	 */
>  	da &= 0xfffff;
>  
> -	if (da >= PRU_IRAM_DA &&
> -	    da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
> +	if (da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
>  		offset = da - PRU_IRAM_DA;
>  		va = (__force void *)(pru->mem_regions[PRU_IOMEM_IRAM].va +
>  				      offset);
> 
