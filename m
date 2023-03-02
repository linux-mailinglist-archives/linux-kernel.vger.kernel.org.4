Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7441B6A7BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCBHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCBHaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:30:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F940D1;
        Wed,  1 Mar 2023 23:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E35C614B3;
        Thu,  2 Mar 2023 07:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21595C433D2;
        Thu,  2 Mar 2023 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677742205;
        bh=0jInCulAYvxpvR6qRc+YIfvF1Bh3US1vitFk/y2Z9Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUEnvHcyLH3+rI+/rP4jSlhiIxWMf7tyVz6/GRTplYU4bC1DlqzFYVwI0DUP7Hn2U
         Ohb2Qlk1EmgZ2KLvZYlN7f6qOmebjpFLwvPpotESCgek74DzHKXmkHhEJzcnvjOT6p
         7bsPnYaYtvmXczQFNnZr5/SZRr9C3YHJ2rh3e49Sop5HSs37NZYcB6u6dcZbAM0X7O
         Ph6FcTHcuioJ1zQeTDgylujb8TV8xRdUkBwO5nxeh8MdzWsS+riETgm2b9RL6i7/hj
         GrgVLrtUqsxFTmyCfS3x6mI4NbKWnZDSXXWOjauthXXbA0ejqnU5FjIhpPHbl6pRhw
         MhxDbwgAj0PsA==
Date:   Thu, 2 Mar 2023 12:59:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ufs: mcq: qcom: Clean the return path of
 ufs_qcom_mcq_config_resource
Message-ID: <20230302072953.GB2890@thinkpad>
References: <3ebd2582af74b81ef7b57149f57c6a3bf0963953.1677721229.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ebd2582af74b81ef7b57149f57c6a3bf0963953.1677721229.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

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
>  	return ret;
>  }
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
