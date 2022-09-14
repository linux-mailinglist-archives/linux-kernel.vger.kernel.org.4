Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57AE5B8A67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiINOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiINOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:25:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA087F252;
        Wed, 14 Sep 2022 07:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65016B81BB9;
        Wed, 14 Sep 2022 14:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC2BC433D7;
        Wed, 14 Sep 2022 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663165459;
        bh=NvfoMMo+Nx1efU9lK47+5nG0WFKmIKRgLN1C/9z/3AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRMucNmm2F9xKNj/6lE8j1vzwmz0slpfACJIwrK4skgfU+GB1S/Q8vSSyzm56BIPf
         9VzqutzMfWJToZLukvbl0u8Pp8DlzsOc1Of7EcsrcWVkwv5MKaHdRGohUFHq0BXCRv
         fPH2VOqwUoUCvOPqOFqNykCOTe7chYVgBRgPt9GZ27XLxSqUyJFhCI9Hs168XZMra0
         Bx1sY81PbHoptwNWoF9eox/KpFynuEQGh6INA2ZpzkW6ZToO32o7gicesKeihf77Rf
         LL8M2Hh24Q1v1Mp02HpAwpI/OAuTitV5tqsWjxdJNea0dG+gNdPEkCE+VogeyLbPZ0
         MHcPnUTzIpaQw==
Date:   Wed, 14 Sep 2022 09:24:16 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Huang Yiwei <quic_hyiwei@quicinc.com>
Cc:     djakov@kernel.org, agross@kernel.org, konrad.dybcio@somainline.org,
        dmitry.baryshkov@linaro.org, leo.yan@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: qcom: Kconfig: Make INTERCONNECT_QCOM
 tristate
Message-ID: <20220914142416.iuqqlwxaqywnwdlv@builder.lan>
References: <20220914064122.16222-1-quic_hyiwei@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914064122.16222-1-quic_hyiwei@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:41:22PM +0800, Huang Yiwei wrote:
> Make INTERCONNECT_QCOM tristate so that icc-common.c can be
> compiled as a module.
> 
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>

Looks like this could be useful to other platforms that need of_xlate
with tags, so we should be able to push this helper into the
interconnect core and get rid of icc-common.c.

But in the meantime, I like your change.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/interconnect/qcom/Kconfig      | 2 +-
>  drivers/interconnect/qcom/icc-common.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 25d5b4baf6f6..1a1c941635a2 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config INTERCONNECT_QCOM
> -	bool "Qualcomm Network-on-Chip interconnect drivers"
> +	tristate "Qualcomm Network-on-Chip interconnect drivers"
>  	depends on ARCH_QCOM
>  	help
>  	  Support for Qualcomm's Network-on-Chip interconnect hardware.
> diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
> index 0822ce207b5d..f27f4fdc4531 100644
> --- a/drivers/interconnect/qcom/icc-common.c
> +++ b/drivers/interconnect/qcom/icc-common.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/module.h>
>  
>  #include "icc-common.h"
>  
> @@ -32,3 +33,5 @@ struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void
>  	return ndata;
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_xlate_extended);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 
