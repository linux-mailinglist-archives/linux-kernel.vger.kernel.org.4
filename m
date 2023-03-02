Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FFD6A7BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCBHbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCBHbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:31:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0765410CB;
        Wed,  1 Mar 2023 23:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9D32B811F5;
        Thu,  2 Mar 2023 07:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F70C433EF;
        Thu,  2 Mar 2023 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677742261;
        bh=5BstzKIT0fhodURY653dvqYIWJJkLcEZPsUozhZoqEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcIs7hCzEVtm6SoRb/iwxRYFKtvzdOSDtBPNar35D1id/5/6IVb/qXbDqndWu0DK9
         Qebn/gttN46WM4HAOXWVLP3tWwm3k9Z+SJTlfZpyHePwRWJk9CH/MQd9mKJrwtg7aa
         QpP6mQF4LVFW2AhA5YUAQYj07Iz73VHqR7EbBIAwucKIFSJaO6jG/98vr0eOwjp0G0
         E4puI8g3MhJJyFUYdoPLC84UjHoF0UQVHNWBot/NE88roAL8ndwoyD2kxq51CdnXwh
         FaqTAPpbMxB9pw2MVKti/4A/7h3PAiWKnGegTTwX4F8yYyX6a13UWAHIN2P/Lrk3iu
         jboT8MHIPXGxg==
Date:   Thu, 2 Mar 2023 13:00:51 +0530
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
Subject: Re: [PATCH v2 1/1] ufs: mcq: qcom: Fix passing zero to PTR_ERR
Message-ID: <20230302073051.GC2890@thinkpad>
References: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94ca99b327af634799ce5f25d0112c28cd00970d.1677721072.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

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

-- 
மணிவண்ணன் சதாசிவம்
