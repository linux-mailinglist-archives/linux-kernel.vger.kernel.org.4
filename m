Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCD65F529
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAEUY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjAEUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:24:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0CD6339C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:24:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3175271pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdPQnZPsNbU7v8vdnBDPJX4Ei7uk+/hU47MzzdZv4JY=;
        b=ZJHtyhEbEExG2mK0lt1w8Q95zOYeqLbYfa2RGWpffEkSjaoUfhTWukEDeXUBn1RHCM
         fpt/aRXL7SJietjXBvp3Qdpm7J8Xd3BeZdDX7EKMJEhuic0nFlOveIf+X7mLwyIi5ep2
         B60IIcWgy33ab0hKe1nIEGIRLXP/Zqq7i0auZB0hKMF0wCXyYupOmr0GorHRDLETpQcR
         HqnLX9VK100Ft4wEykjD/Pp8UrkpsaRHRSKc74MRDpr+YZQyvGJOlQt9zyrUyALJsT8P
         1Ik0zpFAlUB6sV0TG3P5zFVUMPUKeMGHniNV98i4EHVRhgZ/dARSooUlS5xbCYRFzaIx
         dkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdPQnZPsNbU7v8vdnBDPJX4Ei7uk+/hU47MzzdZv4JY=;
        b=oniiCYQIJn5XsblW4RNWWH/VzS63BV1X1XDQcGG/4EE3mbdPVVJB7G1GiIW2crbnUk
         3F5eltlxghZtxXbnggk4xHx2YiwOkBv52CmXvR35TEZ/hiBY6V6Gd40+c6/3Dgr/JwXI
         0JftglZafqe1Hr6sffpUpn1WYhjWdKKmDHPjAiZQXe6ot34HG8cB6OLFklmFFO6OQmGA
         LZTkYIVhdnq8lD9RcT87J2x8oLwdUfR01DHq57GLUu+8VBh1MlkgnO0WJoxJfEy6+3kw
         HKK5TXaHvVHHJc3QW3jrV5v1nIJ5VUUyQcoYcegXsT7ob3bWPOP3CW2gQx3Gy2zcJ6P/
         yyiA==
X-Gm-Message-State: AFqh2koY5JWRIdtRYkc5ViD1sDZKSdkXyBmIQKWUkQZkOUDdS+75gRUh
        fIl3NyaT06P4kjcHeVgZYuKBjiwND3DNoddX
X-Google-Smtp-Source: AMrXdXsSdNJpdEDK6HJVJgTdEB6KWYZUS7shO4sAk0iXvj/JheXjC6QWpmD7mmCU+NMPyL2hCoJzYg==
X-Received: by 2002:a17:902:c102:b0:192:8e05:1505 with SMTP id 2-20020a170902c10200b001928e051505mr36182840pli.31.1672950240412;
        Thu, 05 Jan 2023 12:24:00 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:1328:ca09:d4c2:fcbc])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b00187033cac81sm19030920plh.145.2023.01.05.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 12:23:59 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:23:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, nm@ti.com, vigneshr@ti.com,
        srk@ti.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 2/6] remoteproc: pru: Add enum for PRU Core
 Identifiers.
Message-ID: <20230105202356.GA2281956@p14s>
References: <20230105092149.686201-1-danishanwar@ti.com>
 <20230105092149.686201-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105092149.686201-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:51:45PM +0530, MD Danish Anwar wrote:
> Introducing enum pruss_pru_id for PRU Core Identifiers.
> PRUSS_PRU0 indicates PRU Core 0.
> PRUSS_PRU1 indicates PRU Core 1.
> PRUSS_NUM_PRUS indicates the total number of PRU Cores.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/remoteproc/pru_rproc.c |  7 ++++---
>  include/linux/pruss.h          | 31 +++++++++++++++++++++++++++++++

Please add this under include/linux/remoteproc/ to avoid adding an orphan file
under include/linux/.

Thanks,
Mathieu

>  2 files changed, 35 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/pruss.h
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 128bf9912f2c..a1a208b31846 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/pruss.h>
>  #include <linux/pruss_driver.h>
>  #include <linux/remoteproc.h>
>  
> @@ -438,7 +439,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
>  	dram0 = pruss->mem_regions[PRUSS_MEM_DRAM0];
>  	dram1 = pruss->mem_regions[PRUSS_MEM_DRAM1];
>  	/* PRU1 has its local RAM addresses reversed */
> -	if (pru->id == 1)
> +	if (pru->id == PRUSS_PRU1)
>  		swap(dram0, dram1);
>  	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
>  
> @@ -747,14 +748,14 @@ static int pru_rproc_set_id(struct pru_rproc *pru)
>  	case RTU0_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU0_IRAM_ADDR_MASK:
> -		pru->id = 0;
> +		pru->id = PRUSS_PRU0;
>  		break;
>  	case TX_PRU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case RTU1_IRAM_ADDR_MASK:
>  		fallthrough;
>  	case PRU1_IRAM_ADDR_MASK:
> -		pru->id = 1;
> +		pru->id = PRUSS_PRU1;
>  		break;
>  	default:
>  		ret = -EINVAL;
> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> new file mode 100644
> index 000000000000..e94a81e97a4c
> --- /dev/null
> +++ b/include/linux/pruss.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/**
> + * PRU-ICSS Subsystem user interfaces
> + *
> + * Copyright (C) 2015-2022 Texas Instruments Incorporated - http://www.ti.com
> + *	Suman Anna <s-anna@ti.com>
> + */
> +
> +#ifndef __LINUX_PRUSS_H
> +#define __LINUX_PRUSS_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +
> +#define PRU_RPROC_DRVNAME "pru-rproc"
> +
> +/**
> + * enum pruss_pru_id - PRU core identifiers
> + * @PRUSS_PRU0: PRU Core 0.
> + * @PRUSS_PRU1: PRU Core 1.
> + * @PRUSS_NUM_PRUS: Total number of PRU Cores available.
> + *
> + */
> +
> +enum pruss_pru_id {
> +	PRUSS_PRU0 = 0,
> +	PRUSS_PRU1,
> +	PRUSS_NUM_PRUS,
> +};
> +
> +#endif /* __LINUX_PRUSS_H */
> -- 
> 2.25.1
> 
