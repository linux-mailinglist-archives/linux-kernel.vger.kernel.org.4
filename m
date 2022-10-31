Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BC613F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJaUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJaUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE12102E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667248299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6iglFbtxmswy6Wel7/DoB7/VCgHF3PqnZ3i1JdiWSK0=;
        b=L2QrKSSNLcUy5R6qkvBtlx30SzEUyHQezcsvCteXNgWJQI5ugAwgFRQQN4cPqIUgh6esPv
        UInB80q4aNyOgCzQE0u2RxMSQqP0cmWrJL2cx3CwMcxCO4fm34e9Gsso9Cc5kwpcg9UTTV
        UDVjgfQKIi7iLV9AyZu1d8FYc/Ogp6M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-atHEuvfnPyieQXdCqGdt7g-1; Mon, 31 Oct 2022 16:31:37 -0400
X-MC-Unique: atHEuvfnPyieQXdCqGdt7g-1
Received: by mail-oo1-f69.google.com with SMTP id e9-20020a4a9b49000000b00475ea4651fcso4373852ook.17
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iglFbtxmswy6Wel7/DoB7/VCgHF3PqnZ3i1JdiWSK0=;
        b=2imGLbRymuYm4oYPzAlxRJSC+Qu3aCA4ISUVmjSH+AEFtVam2jnNG95E6Wegb9TpCs
         I6GSOPv9StZ0ZmKW4H/eodwgkANmThU92UUI13fT1FZSSKKyAApH1/2k5AwInBDHM81K
         aUvddJsmEETipC4JPEZXfFWm3yNIYYQcYVtnzwQm34l8n9gQ1LkfFkfnlqzlsnayOO6H
         zcGMf70KDkY962H761NkDporv0zal6n7eOHr2IvwtEQrC/SnNe1K4QaqnLIgqPwrf8RF
         kHZEbPQ6y7I2WeWY3I7lPwp17MY+XAjF3XuyPnqESvPOO96bnafNxhUdMZtlZPoILFxV
         kmfQ==
X-Gm-Message-State: ACrzQf0kkSu/lWke+LETwx2+KghHe4aCzc5Bvu4Du7E67KgwiACFtVPx
        E7bUhqb7lRBDNE2rHdKSDKaTMGyUJ/LGyya5XnyAsMEXKOOnX/eyL0f1pGocxCLzc8KALCkX+JX
        /bMJRMUxmVP2uFsQ+TwYIXx17
X-Received: by 2002:a05:6808:1693:b0:353:e980:30bf with SMTP id bb19-20020a056808169300b00353e98030bfmr7619333oib.206.1667248296673;
        Mon, 31 Oct 2022 13:31:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6B6/z0lcd7D5OLl9WDtE+Mx0BJBDVllYVLYSG10XWz2v15lMdxxewtOH4kYWzU7mQ+tcnlRQ==
X-Received: by 2002:a05:6808:1693:b0:353:e980:30bf with SMTP id bb19-20020a056808169300b00353e98030bfmr7619312oib.206.1667248296393;
        Mon, 31 Oct 2022 13:31:36 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id x13-20020a056830114d00b0066c34486aa7sm3113890otq.73.2022.10.31.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:31:35 -0700 (PDT)
Date:   Mon, 31 Oct 2022 15:31:33 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 13/15] scsi: ufs: ufs-qcom: Factor out the logic
 finding the HS Gear
Message-ID: <20221031203133.vmqqig7wlryrgiwv@halaney-x13s>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-14-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031180217.32512-14-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:32:15PM +0530, Manivannan Sadhasivam wrote:
> In the preparation of adding support for new gears, let's move the
> logic that finds the gear for each platform to a new function. This helps
> with code readability and also allows the logic to be used in other places
> of the driver in future.
> 
> While at it, let's make it clear that this driver only supports symmetric
> gear setting (hs_tx_gear == hs_rx_gear).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 38e2ed749d75..c93d2d38b43e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -278,6 +278,26 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
>  	return 0;
>  }
>  
> +static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	if (host->hw_ver.major == 0x1) {
> +		/*
> +		 * HS-G3 operations may not reliably work on legacy QCOM
> +		 * UFS host controller hardware even though capability
> +		 * exchange during link startup phase may end up
> +		 * negotiating maximum supported gear as G3.
> +		 * Hence downgrade the maximum supported gear to HS-G2.
> +		 */
> +		if (hs_gear > UFS_HS_G2)
> +			return UFS_HS_G2;
> +	}
> +
> +	/* Default is HS-G3 */
> +	return UFS_HS_G3;
> +}
> +
>  static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -692,19 +712,9 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
>  		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>  
> -		if (host->hw_ver.major == 0x1) {
> -			/*
> -			 * HS-G3 operations may not reliably work on legacy QCOM
> -			 * UFS host controller hardware even though capability
> -			 * exchange during link startup phase may end up
> -			 * negotiating maximum supported gear as G3.
> -			 * Hence downgrade the maximum supported gear to HS-G2.
> -			 */
> -			if (ufs_qcom_cap.hs_tx_gear > UFS_HS_G2)
> -				ufs_qcom_cap.hs_tx_gear = UFS_HS_G2;
> -			if (ufs_qcom_cap.hs_rx_gear > UFS_HS_G2)
> -				ufs_qcom_cap.hs_rx_gear = UFS_HS_G2;
> -		}
> +		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> +		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba,
> +									ufs_qcom_cap.hs_tx_gear);
>  
>  		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
>  					       dev_max_params,
> -- 
> 2.25.1
> 

