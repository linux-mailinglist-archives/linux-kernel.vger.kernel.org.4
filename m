Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763370EFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjEXHxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjEXHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E559D;
        Wed, 24 May 2023 00:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07AD63A49;
        Wed, 24 May 2023 07:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A09EC433D2;
        Wed, 24 May 2023 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684914811;
        bh=AD7LEcaMCtJLi7npLhnsfjZKm93qmgeNPCRUWDwWJno=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VNGLf86TMxmkx7FET3zjvs7Rs89YK/oThhi+RnJYKL0sLndSjQR8SvvB8z0YVZApa
         m/dfrwJyj5PkvQoAVlOCYuZFPFGLkzmeUksUESuNbjjjoJm/36dN4Z3bWjgdCv4fPr
         D5qMGQlJ7DxDkgnpDQRBJdCdaWEhzjNrKMqHNOsJUS8bSOV93YTjaPo/1SkIx1eLeh
         0SOvgb23EjAiWMevySHXniixGdgDT5AD69ZjKjMlWgAY3CcbM268WEz7WVS4sll+ew
         rtYUQDEapbc2237J3Vrkf8IQG++fkHDeIeWiOwxiHuFzxkm2bWwYnoWaqcswNwFAvR
         syTx9uNWyr/cQ==
Message-ID: <96ea8d7a-2dca-76b5-4f41-1de3c211d35c@kernel.org>
Date:   Wed, 24 May 2023 16:53:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] scsi: pm80xx: Add fatal error check for
 pm8001_phy_control()
Content-Language: en-US
To:     Pranav Prasad <pranavpp@google.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
References: <20230523214127.4006891-1-pranavpp@google.com>
 <20230523214127.4006891-2-pranavpp@google.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230523214127.4006891-2-pranavpp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 06:41, Pranav Prasad wrote:
> From: Changyuan Lyu <changyuanl@google.com>
> 
> This patch adds a fatal error check for the pm8001_phy_control() function.
> 
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index e5673c774f66..b153f0966e5d 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -167,6 +167,16 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
>  	pm8001_ha = sas_phy->ha->lldd_ha;
>  	phy = &pm8001_ha->phy[phy_id];
>  	pm8001_ha->phy[phy_id].enable_completion = &completion;
> +
> +	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
> +		/* If the controller is in fatal error state,
> +		 *  we will not get a response from the controller
> +		 */

Multi-line comment style: must start with an empty "/*" line.

> +		pm8001_dbg(pm8001_ha, FAIL,
> +				"Phy control failed due to fatal errors\n");

Please align the args together.

> +		return -EFAULT;
> +	}
> +
>  	switch (func) {
>  	case PHY_FUNC_SET_LINK_RATE:
>  		rates = funcdata;

-- 
Damien Le Moal
Western Digital Research

