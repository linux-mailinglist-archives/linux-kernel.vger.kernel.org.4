Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9B6A79A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCBCqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCBCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:46:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1B311EB;
        Wed,  1 Mar 2023 18:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E85ADB811EA;
        Thu,  2 Mar 2023 02:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDCC433EF;
        Thu,  2 Mar 2023 02:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677725193;
        bh=Th9GPEJwbxkkHQNfDEXRhB2oqull8FRq78QD5fRh7xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKRGowW6BljXEJhaQ844rGIituUTlJ31XzpefOG+zN7ptTqIgI3DO/jpHMYr7Utib
         dzq74rxMEVLLIaY6f78Ep9XRNX4aMAhE2fG7xxZ4jz6bH5EDaOoNQK1Z/WYHBTzkhB
         kUcSDj/jfTwDNqhpXLcA8r5tUKsiXUJ/MrCOHBJFLKadKaxjTVbCG/SK+PH6jzM0Ew
         Q9arjoKoh73PNcAEAkK4Epy51hnBz0QqbrskC7kFoe8reHmlvI8BnwTEdTJfy1StCN
         6mABuIO9qxeF6COXJLAmJnD1G/V2Adu1p9BlyvDMh8mfzuD6j+ibDBSHRyAZV3ViMx
         CcKEXXiNE7y2g==
Date:   Wed, 1 Mar 2023 20:46:30 -0600
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
Subject: Re: [PATCH v1 1/1] ufs: mcq: qcom: Clean the return path of
 ufs_qcom_mcq_config_resource
Message-ID: <20230302024630.urqhzzvdl3ekrxzt@baldur>
References: <3ebd2582af74b81ef7b57149f57c6a3bf0963953.1677721229.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebd2582af74b81ef7b57149f57c6a3bf0963953.1677721229.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 05:42:56PM -0800, Asutosh Das wrote:
> Smatch static checker reported:
> drivers/ufs/host/ufs-qcom.c:1469
> ufs_qcom_mcq_config_resource() info: returning a literal zero is
> cleaner
> 
> Fix the above warning by returning in place instead of a jump to a
> label.
> Also remove the usage of devm_kfree() as it's unnecessary in this
> function.
> 
> Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 43b1fc1ad33e..cb20c7136c2c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1466,7 +1466,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  	/* Explicitly allocate MCQ resource from ufs_mem */
>  	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
>  	if (!res_mcq)
> -		return ret;
> +		return -ENOMEM;

This is a bug fix, so this needs to go in v6.3-rc

>  
>  	res_mcq->start = res_mem->start +
>  			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
> @@ -1478,7 +1478,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  	if (ret) {
>  		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
>  			ret);
> -		goto insert_res_err;
> +		return ret;
>  	}
>  
>  	res->base = devm_ioremap_resource(hba->dev, res_mcq);
> @@ -1495,8 +1495,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  ioremap_err:
>  	res->base = NULL;
>  	remove_resource(res_mcq);
> -insert_res_err:
> -	devm_kfree(hba->dev, res_mcq);

This is just a cleanup, so there's no rush here.

So I would have preferred that these where split. But unless Martin
insist, I don't think it's worth the churn of spinning this one more
time...

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 
