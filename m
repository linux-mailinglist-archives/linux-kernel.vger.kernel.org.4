Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72FD613EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJaUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJaUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8913EB2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667246749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H3ZU5SpqvPjaqpTfjZ04SSbHmjl8vKSTt7kMWQY1QWg=;
        b=LB61e3idhadxPd0DIWx5e40WqqdqnEoADf4ZxPCVMJVWXkI9kpbwFosZIniXRpc8p5uCn7
        mVhfsSHA+7bGGinybO0ZQ15foS4FsnC9dm8BkugmrRFuGVJ/Hj64J/uK8LS8rnmlOOpiuB
        MHhr8YzcJS8bFLffX/cChzRqZXTtbts=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-EBGhp6N8OR-rWwZvotRQvg-1; Mon, 31 Oct 2022 16:05:47 -0400
X-MC-Unique: EBGhp6N8OR-rWwZvotRQvg-1
Received: by mail-ot1-f72.google.com with SMTP id l4-20020a9d7344000000b0066ac21d7252so6840477otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3ZU5SpqvPjaqpTfjZ04SSbHmjl8vKSTt7kMWQY1QWg=;
        b=K6ZLp4xCCz/lPhm9aEK45Cg9FqUEsSEv2TqrbsrR5y+xUtpakgoNxiBi6Uaf38+qk8
         /YjVehCNlHsXdLZJigJ6Ne6exTmpfSZFy49Zq2HuYCP5rtVyyxzRa4ujmg8Gula7xdlx
         H3jMHmdvZSuYfvnhOvRQpjX7e7ae6AFX58pcW7RerhQewQM55/NdLCSGKtLDrLkxIL1i
         /zx6+J0lzyVuHd3Bkp+81q+3AhQYdyUbBqYBzFPikZVi/ytago1UYWcSqtcQh+nSyZRx
         axp0AcBnK4yAJRUhASqpnLfeE9a/7DhVTwwz5+HxTMrturaPQZ6fhlED+S+gu4pPmiSW
         SR7Q==
X-Gm-Message-State: ACrzQf3j1a3Zc25eQRQCHfXoyZnYU/aA8BISsyyIwtr+QU6n8v2HL+Yt
        3JpMSpWmiiHBP0Jv35DZrWbWaw7P/voq0KysJNB535XxlaKgU1v6GGWfEh9IE9AsDI2LLXMmv/p
        aYCuAn2e8OSn9nMn6TVrqVF/r
X-Received: by 2002:a05:6830:6401:b0:661:c74e:6b03 with SMTP id cj1-20020a056830640100b00661c74e6b03mr7158963otb.291.1667246746799;
        Mon, 31 Oct 2022 13:05:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4UUO37SZvA4qjX9uf7dmQCxxsJtcyXRaXYuTlx2k2AoBUUULV+m0zUJOEaCdymKZ+gqdzveQ==
X-Received: by 2002:a05:6830:6401:b0:661:c74e:6b03 with SMTP id cj1-20020a056830640100b00661c74e6b03mr7158939otb.291.1667246746589;
        Mon, 31 Oct 2022 13:05:46 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id y1-20020a056830108100b00660fe564e12sm3092167oto.58.2022.10.31.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:05:46 -0700 (PDT)
Date:   Mon, 31 Oct 2022 15:05:43 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 11/15] scsi: ufs: ufs-qcom: Use dev_err_probe() for
 printing probe error
Message-ID: <20221031200543.7j3pw4idrawxge2h@halaney-x13s>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-12-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031180217.32512-12-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:32:13PM +0530, Manivannan Sadhasivam wrote:
> Make use of dev_err_probe() for printing the probe error.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8bb0f4415f1a..38e2ed749d75 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1441,9 +1441,9 @@ static int ufs_qcom_probe(struct platform_device *pdev)
>  	/* Perform generic probe */
>  	err = ufshcd_pltfrm_init(pdev, &ufs_hba_qcom_vops);
>  	if (err)
> -		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
> +		return dev_err_probe(dev, err, "ufshcd_pltfrm_init() failed\n");
>  
> -	return err;
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.25.1
> 

