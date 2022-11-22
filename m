Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F1633FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiKVPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:06:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9AA6565
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:06:06 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c203so14601175pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFm/hQzp85f9PkuPkdfd/PZMWkQMCDrrQWUl2fEW03w=;
        b=LNABZeRJscon/VHkVveJ+lRDsjpGyOiP9IOwSqUmzdQKKCR9YcvxcJDwYKXoQ31puT
         1HqnkQrRZ/k+3TSJjAgBQ+Kr38QRdX+vbD6LLNCI4Rm1RvfZc5Z5vyUACqBpPu6rIRLx
         t1GdVd7Fk8spxfx32ehpulaunieqgpV/uNMX7QABg6IveP4V2P3HH3odTGTN9wqWK6VZ
         A4hS2GeaolVs6tDiYvsBXUu7E2cey22hii5xm78bilr9FXr7EO8qryDnZYSSc35X1Z9Y
         8PQchihQYpWbWxOsbrC6xgoiwPI0pxmnMZSkMshttOyJ7AVkTteMKSdJBxceEsC4VpbH
         ToWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFm/hQzp85f9PkuPkdfd/PZMWkQMCDrrQWUl2fEW03w=;
        b=jrnWy7OzuIWgykGTMJw2r/2BxtbqYW4fJqI4BwkjU+ZmL5IYlxX2IU4B0GEur15LHa
         RPHEnPkY55u9F3hOHFReHKsW3FZ9ULTpodFpv0SZzjjvLbW6hqmecIS5OXGiVZiBh5ic
         aCED1qxW5mOuwYvPRD+ekl0UkYEWLHuN8Ulc9sqavx+ynv3wvXh03iRp2FRDt4FYMpmH
         QhoJU2Qc/ev/D24y+9v4AUxotpNDwv+/qM0bh0l/hsYKJ/oVYRLyqKIl+ew6bXRy1MrE
         rEjlHfbk4vBJ44575uCMv7ePOb6Y1XltI6IFGSR1IZRavdYKtgt7zxkxb+K/vV+2o47k
         b3PA==
X-Gm-Message-State: ANoB5pkkJvZa3BNvApcLKypqiyQgEo1V3mOxZS0KfnZrvooX/a2KI2XQ
        zst//D4hfr4IvwYHcro6Y1/L
X-Google-Smtp-Source: AA0mqf5GjmHRR2cgKROAhBGQlpp08yLh0IhPhYqC84bGzFy5Jw1en3ayBeCra6H6haMqnZOZo68kzg==
X-Received: by 2002:a63:e44:0:b0:475:2f61:bbc3 with SMTP id 4-20020a630e44000000b004752f61bbc3mr5548600pgo.435.1669129565476;
        Tue, 22 Nov 2022 07:06:05 -0800 (PST)
Received: from thinkpad ([59.92.98.84])
        by smtp.gmail.com with ESMTPSA id b15-20020a1709027e0f00b001869394a372sm12022018plm.201.2022.11.22.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:06:04 -0800 (PST)
Date:   Tue, 22 Nov 2022 20:35:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] ufs: host: ufs-qcom: Clear qunipro_g4_sel for HW
 version major 5
Message-ID: <20221122150555.GE157542@thinkpad>
References: <20221116121732.2731448-1-abel.vesa@linaro.org>
 <20221116121732.2731448-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116121732.2731448-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:17:31PM +0200, Abel Vesa wrote:
> On SM8550, depending on the Qunipro, we can run with G5 or G4.
> For now, when the major version is 5 or above, we go with G5.
> Therefore, we need to specifically tell UFS HC that.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/ufs/host/ufs-qcom.c | 4 ++++
>  drivers/ufs/host/ufs-qcom.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ca60a5b0292b..72334aefe81c 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -227,6 +227,10 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>  	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
>  		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
>  		   REG_UFS_CFG1);
> +
> +	if (host->hw_ver.major == 0x05)
> +		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);

So this means, G5 will be used all the time even if the UFS device doesn't
support it (ie., G4 device), which is not ideal.

Since you have already based this series on my UFS gear 4 series, you should
resend this on top of my next version that I'm about to submit. There I have
proposed reinitializing the UFS device after switching to max gear supported by
both controller and device.

Based on that information, you could do:

```
	if (host->hw_ver.major == 0x05) {
		if (host->hs_hear == UFS_HS_G5)
			ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
		else
			ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 1, REG_UFS_CFG0);
	}
```

By this way, if the device doesn't support G5, G4 will be used.

Btw, please use a valid definition instead of 0/1 above.

> +
>  	/* make sure above configuration is applied before we return */
>  	mb();
>  }
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 751ded3e3531..10621055bf7f 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -36,6 +36,7 @@ enum {
>  	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
>  	REG_UFS_PARAM0                      = 0xD0,
>  	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
> +	REG_UFS_CFG0                        = 0xD8,

Hmm, so what is the offset of REG_UFS_PA_LINK_STARTUP_TIMER?

>  	REG_UFS_CFG1                        = 0xDC,
>  	REG_UFS_CFG2                        = 0xE0,
>  	REG_UFS_HW_VERSION                  = 0xE4,
> @@ -75,6 +76,7 @@ enum {
>  
>  /* bit definitions for REG_UFS_CFG1 register */
>  #define QUNIPRO_SEL		BIT(0)
> +#define QUNIPRO_G4_SEL		BIT(5)

Since this bit belongs to CFG0 register, it should be added separately and not
with CFG1 definitions.

Thanks,
Mani

>  #define UFS_PHY_SOFT_RESET	BIT(1)
>  #define UTP_DBG_RAMS_EN		BIT(17)
>  #define TEST_BUS_EN		BIT(18)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
