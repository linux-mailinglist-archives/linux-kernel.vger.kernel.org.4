Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED16A7973
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCBCVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCBCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:21:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C41ADDB;
        Wed,  1 Mar 2023 18:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE9061500;
        Thu,  2 Mar 2023 02:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F20C433EF;
        Thu,  2 Mar 2023 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677723673;
        bh=BNiSwl5bVs9FfHed24RoPHL5c4YDcOGCzi3T0koCfYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBAhNkJ3gA7Zt6c0zqtbXGrXqwLJQR5uRQ/ynI0UShqYD6DTk/C6Cd4EyzZpxA9fc
         yBYKmxLlC6uuBMIXLxKhcWE7tORTtY1zZdUjI3o9ZeApHpBBeMmy96NWnv/obCT+NA
         9zN14XOa5e0h94MFEXk+xYFwRWjKLAyOltFC2nV9JHIGILZBBMjw6ximn//6nCaJIv
         OL1lRdysofoPsh+X8ssm2rkr8SJ2RfNVrqbnFlJ4VvEdNWpeKw9BpN4RwSu0jVLh0r
         qBR9/KvE8aJOZ1L9wDPv13Xh8BztAQf5ZNdmyrMxsabDDRP3J1lgGCgPPJa6ez16rN
         bRcBiZpD8PXPg==
Date:   Wed, 1 Mar 2023 20:21:09 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        mani@kernel.org, beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ufs: mcq: qcom: Fix passing zero to PTR_ERR
Message-ID: <20230302022109.uhmwbscg4mtofydd@baldur>
References: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:41:06PM -0800, Asutosh Das wrote:
> Fix an error case in ufs_qcom_mcq_config_resource(), where the
> return value is set to 0 before passing it to PTR_ERR.
> 
> This led to Smatch warning:
> drivers/ufs/host/ufs-qcom.c:1455 ufs_qcom_mcq_config_resource() warn:
> passing zero to 'PTR_ERR'
> 
> Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> 
> --
> v1 -> v2
> - Split to 2 patches
> - Addressed Mani's comments
> --
> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 34fc453f3eb1..43b1fc1ad33e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1451,8 +1451,8 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  		if (IS_ERR(res->base)) {
>  			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
>  					 res->name, (int)PTR_ERR(res->base));
> -			res->base = NULL;
>  			ret = PTR_ERR(res->base);
> +			res->base = NULL;
>  			return ret;
>  		}
>  	}
> -- 
> 2.7.4
> 
