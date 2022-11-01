Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B1614E21
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiKAPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKAPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949A1CFC5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667315558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhCfbrC+tKlaqwlNl94RimQiIKrtWvzi9RGBXnP5PaA=;
        b=i2Sqz2pyCUKmYYZV76++4Gj0YRSoInD+4WSDzF4LGw9iPfTvWaONweB6Hj14UIPcGS7rhh
        dNUrMK4Lnp7bRptbnE6Imf1APNdtFI4GHt5YX6YjxlNKW/fAj568r5fKap+q2xvWci647L
        EqQ2DsBwKaSFFNvz9Zu+6mqHcwM/IJc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-WbLyiibeOmmSN80dYVuk_g-1; Tue, 01 Nov 2022 11:12:37 -0400
X-MC-Unique: WbLyiibeOmmSN80dYVuk_g-1
Received: by mail-oi1-f200.google.com with SMTP id o12-20020a056808124c00b00353f308fb4bso6291627oiv.22
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 08:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhCfbrC+tKlaqwlNl94RimQiIKrtWvzi9RGBXnP5PaA=;
        b=YQQGStiwgfTiDB+PwB1jJgwPPCzU7IfkJ+lTYrmB9zLeZzqNYEnt8+8fwE5gFZDmg4
         /UDH9SmHp8fzf2eEIhCfG1jr7otvGs0p+0N1ceKvLkzL13dlSzan/aqp+L1J/kss8SEP
         rJEP8ueG7IswHSu3x5YD8UbVFyW/ruG6TVIenxPklBBtnOir5AUuP0SGEEDk+E1ZyKYc
         gthDKlC7uj/+c9y4QyScB3QvelzU7jyewclytqhpA1VrkzxJewMQ7otSH84S9G/F+LLS
         E/lJ1zKJJ4XXJcin2Mnef0f8XTupOaRm/BXRlmLb5UR/FfwJoxJcluYilY8GRN9jlGz1
         lJtg==
X-Gm-Message-State: ACrzQf0JoqlU2RtYVdil3ldN9vx3XqBiCHg1KaCa+z/v/5eWj4Mie9np
        xWoF9eGES9ZBjR32tcZ+KsmppGRmKXujpqejMpoZNZewLLI2BpkCDAZQcRO/KaoTACsVjO0HuDI
        6Sr9tVEggVg7OX5OvXZMJrLLn
X-Received: by 2002:a05:6830:2693:b0:661:e5be:54d with SMTP id l19-20020a056830269300b00661e5be054dmr10137063otu.365.1667315556272;
        Tue, 01 Nov 2022 08:12:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM793XlwTZxCVNxIGpeJvkdANMVrjJrL3o5j79HVnLEDlz/VJyPLPzK5QdqyGPayhDWk8QyQxQ==
X-Received: by 2002:a05:6830:2693:b0:661:e5be:54d with SMTP id l19-20020a056830269300b00661e5be054dmr10137047otu.365.1667315556035;
        Tue, 01 Nov 2022 08:12:36 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id w67-20020acadf46000000b0035770fc6ca9sm3437879oig.16.2022.11.01.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:12:35 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:12:33 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 12/15] scsi: ufs: ufs-qcom: Fix the Qcom register name
 for offset 0xD0
Message-ID: <20221101151233.gsmmdbz7htkzpbps@halaney-x13s>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031180217.32512-13-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:32:14PM +0530, Manivannan Sadhasivam wrote:
> On newer UFS revisions, the register at offset 0xD0 is called,
> REG_UFS_PARAM0. Since the existing register, RETRY_TIMER_REG is not used
> anywhere, it is safe to use the new name.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9d96ac71b27f..7fe928b82753 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -33,7 +33,8 @@ enum {
>  	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
>  	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
>  	REG_UFS_PA_ERR_CODE                 = 0xCC,
> -	REG_UFS_RETRY_TIMER_REG             = 0xD0,
> +	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
> +	REG_UFS_PARAM0                      = 0xD0,
>  	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
>  	REG_UFS_CFG1                        = 0xDC,
>  	REG_UFS_CFG2                        = 0xE0,
> -- 
> 2.25.1
> 

