Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95573A65F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFVQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjFVQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E31FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687452356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6LLoDXAD0fPuc6AsW0BAVbjdcqFGmumwyZ+jo/wBt4=;
        b=EAP0luXV8HS3pyarly0r2FpVdEmrbuF6Y6ZF5yYbviIT+LfW9xFnqYjES2Tha7w7GX5mdr
        tmQMkk+yBcCLeJtXd9yaI1LFweZP+lzja15RUHvftL9R8qOL5FZWtuTOXzzmiFdIWzZbGW
        sXRWINhhNVKlpaXCcRqB8mnE6o6YOxs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-cUCP10kKMh-Ex1YhINPNxA-1; Thu, 22 Jun 2023 12:45:54 -0400
X-MC-Unique: cUCP10kKMh-Ex1YhINPNxA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b58a12d65dso4242748a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687452348; x=1690044348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6LLoDXAD0fPuc6AsW0BAVbjdcqFGmumwyZ+jo/wBt4=;
        b=GNCqNlc0hmwotpLjiW7AuTJNjKNzG6CJKoEEzCgp715N/h2pV0jCXPHziF6rTdekm6
         x1YpTB6YZtCg1snQKePqYQENLYEmKte/zd1FEFrM8Nd3IAdRCrFhnoKWSvqbaKa737M0
         NzcIBQAQoKdprwmjDr786xOgwWRBcvQiIeovJpBLEo9C/ijNFXOqLzKzonsjKXEn9on0
         C1/BLaD4fBLFsPtLsIgFIUyxjy6+YEzdGUFAABWS+MV7vI6+79tbxxc8TSdBPK6GghaO
         4i1Zj3R3SMkCLySY0EICoZECh4vmnPK4N4z563uLoMGD+5YmaHtAbm0F2Ea9bS6OpKgy
         53Lg==
X-Gm-Message-State: AC+VfDz5c+/OcqfnSGJkeABuN48PYHryKXfQyZ9FCcilLKRuJVyQ39dX
        un7OPQ4/MU6TDXiamfZDxQFgcN6XcxrM0Oq5133NVRSdJqs7DTUbfV9l4Pkd9BeZU0P0iBc3Ovs
        L2YG4yhem8uA/+CJAIslqnxZ3
X-Received: by 2002:a9d:7cc9:0:b0:6b5:b654:6d52 with SMTP id r9-20020a9d7cc9000000b006b5b6546d52mr5972040otn.8.1687452348486;
        Thu, 22 Jun 2023 09:45:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58fV++PhlPXYEECuy/QGlkeVFyp9FOiUQFioQbIDyJnts066atIqJRXo+P+fhPbGGa+c0vZw==
X-Received: by 2002:a9d:7cc9:0:b0:6b5:b654:6d52 with SMTP id r9-20020a9d7cc9000000b006b5b6546d52mr5972023otn.8.1687452348243;
        Thu, 22 Jun 2023 09:45:48 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id p13-20020a056830130d00b006b469ace1b1sm3007058otq.22.2023.06.22.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:45:47 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:45:44 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RESEND v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <20230622164544.4exzdv2hoptgitdx@halaney-x13s>
References: <20230612192847.1599416-1-abel.vesa@linaro.org>
 <20230612192847.1599416-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612192847.1599416-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:28:46PM +0300, Abel Vesa wrote:
> Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
> use the new ICE api provided by the Qualcomm soc driver ice. The platforms
> that already have ICE support will use the API as library since there will
> not be a devicetree node, but instead they have reg range. In this case,
> the of_qcom_ice_get will return an ICE instance created for the consumer's
> device. But if there are platforms that do not have ice reg in the
> consumer devicetree node and instead provide a dedicated ICE devicetree
> node, the of_qcom_ice_get will look up the device based on qcom,ice
> property and will get the ICE instance registered by the probe function
> of the ice driver.
> 
> The ICE clock is now handle by the new driver. This is done by enabling
> it on the creation of the ICE instance and then enabling/disabling it on
> UFS runtime resume/suspend.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/ufs/host/Kconfig        |   2 +-
>  drivers/ufs/host/Makefile       |   4 +-
>  drivers/ufs/host/ufs-qcom-ice.c | 244 --------------------------------
>  drivers/ufs/host/ufs-qcom.c     |  99 ++++++++++++-
>  drivers/ufs/host/ufs-qcom.h     |  32 +----
>  5 files changed, 104 insertions(+), 277 deletions(-)
>  delete mode 100644 drivers/ufs/host/ufs-qcom-ice.c
> 
> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> index 8793e3433580..16624ba08050 100644
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -59,7 +59,7 @@ config SCSI_UFS_QCOM
>  	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
>  	depends on GENERIC_MSI_IRQ
>  	depends on RESET_CONTROLLER
> -	select QCOM_SCM if SCSI_UFS_CRYPTO
> +	select QCOM_INLINE_CRYPTO_ENGINE if SCSI_UFS_CRYPTO
>  	help
>  	  This selects the QCOM specific additions to UFSHCD platform driver.
>  	  UFS host on QCOM needs some vendor specific configuration before
> diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
> index d7c5bf7fa512..4573aead02eb 100644
> --- a/drivers/ufs/host/Makefile
> +++ b/drivers/ufs/host/Makefile
> @@ -3,9 +3,7 @@
>  obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) += tc-dwc-g210-pci.o ufshcd-dwc.o tc-dwc-g210.o
>  obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-dwc-g210.o
>  obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
> -obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
> -ufs_qcom-y += ufs-qcom.o
> -ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
> +obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o

The change from ufs_qcom.o to ufs-qcom.o here makes ufs_qcom.ko turn
into ufs-qcom.ko.

That broke a (fragile :P ) initramfs development script I play with. Not
sure if that's any sort of contract with userspace or not, but thought
I'd report it at least in case someone has a strong opinion.

Thanks,
Andrew

