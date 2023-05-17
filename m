Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB38B70703D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjEQR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEQR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:58:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1D2726
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae4e49727eso12145275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684346310; x=1686938310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRGNMLfUfmstzWu7T2z9+f63mnhBNH1tSnmTg/DwAEQ=;
        b=Jm35xW1cRZ/F90wt0h3bGOPCTen8c2gmnjncdgF7e6KT31+WA4SPRSQyhim1XvnVLE
         QKtw0N3QiJoYq245Fn8iEDOje5JMajAUKJzEvXg/XZdy5c2MJNZDvfBf6WY6A+5bBmMb
         aLVuWby9tuvdq7cnnCX9aZ1luqZccYwz9WuLTE3f1ezVy/t4hOCUexz/VbmWXVin3zhn
         kZCn41MWOIvMjVM/tirechE8eoAPoKpBGBYKADjnAcmkVw5d9qzR9vx1FE/s1FvNiFPR
         U+47siOH7AKayqHhSZpPNQkXWJxiBro6iWDzR30Ug2oZidtNvtgR/plTAlyJ0xObY9MI
         CZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346310; x=1686938310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRGNMLfUfmstzWu7T2z9+f63mnhBNH1tSnmTg/DwAEQ=;
        b=Oa1sIrKiM5pWKPwh5aWOCyZjuMKdU8lbQBdYsihvyC4Z4FW0AW0ViYGEC3FdFf6tW+
         kGnnSbanW/j64Tg/GIRZpvbw65BLas3GdlgkiQUdGXYT6rOcxyf7GrljqvrAgvUd3Ua6
         97khfjp6NcN7EljB4tWal4BHzOAw3TMWKOqNLuaCPkOFZx+bpfJKAjaulELRYV3VrsrN
         tC9XRzJdN/DLApbDZyKah2bYfFvuDNtPUelU9nFx0sjqUhBLBk8gieNO6eP84foH76Cx
         9+o/4go7Um39wgxM6kIIorHEZ91zuHwvAATTitTzfk2JlslzxJRK4/Id7SEEdja19tRj
         pW5w==
X-Gm-Message-State: AC+VfDzDYJTojoJYMDmU5IF+o5g4TrOaA5EZMlDqT/E9mdUKP2oVkQab
        VKLfIjbM32WjOSUnuoFNYTaTdw==
X-Google-Smtp-Source: ACHHUZ7fbLj71H3Bwby0ODNkhv4RQWQwdhA80KwYsAbIM+bAk2Oy0dY4Cocm5quS5tQgZjjK5i/igQ==
X-Received: by 2002:a17:903:234c:b0:1ab:289f:65cf with SMTP id c12-20020a170903234c00b001ab289f65cfmr56070844plh.54.1684346310357;
        Wed, 17 May 2023 10:58:30 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fd0b:2592:d377:e4e3])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902b60f00b001aafe232bcfsm17853795pls.44.2023.05.17.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:58:29 -0700 (PDT)
Date:   Wed, 17 May 2023 11:58:27 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12 07/11] remoteproc: mediatek: Control SCP core 1 by
 rproc subdevice
Message-ID: <ZGUVw1VIq8LAm8mj@p14s>
References: <20230517043449.26352-1-tinghan.shen@mediatek.com>
 <20230517043449.26352-8-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517043449.26352-8-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:34:45PM +0800, Tinghan Shen wrote:
> Register SCP core 1 as a subdevice of core 0 for the boot sequence
> and watchdog timeout handling. The core 1 has to boot after core 0
> because the SCP clock and SRAM power is controlled by SCP core 0.
> As for watchdog timeout handling, the remoteproc framework helps to
> stop/start subdevices automatically when SCP driver receives watchdog
> timeout event.
>

Subdevices should be reserved for virtio devices and not used for remote
processors.  Mixing both will get us into trouble at some point in the future.
The way to address power and clock dependencies is to use a different rproc_ops
for SCP1.  That rproc_ops would implemented the prepare() and unprepare()
functions to power up SCP1's power domain and deal with its clock.  

I will stop here for this revision.

Thanks,
Mathieu


> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_common.h |  9 ++++
>  drivers/remoteproc/mtk_scp.c    | 88 +++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 56395e8664cb..85afed2e6928 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -100,6 +100,13 @@ struct mtk_scp_of_data {
>  	size_t ipi_buf_offset;
>  };
>  
> +struct mtk_scp_core_subdev {
> +	struct rproc_subdev subdev;
> +	struct mtk_scp *scp;
> +};
> +
> +#define to_core_subdev(d) container_of(d, struct mtk_scp_core_subdev, subdev)
> +
>  struct mtk_scp {
>  	struct device *dev;
>  	struct rproc *rproc;
> @@ -130,6 +137,8 @@ struct mtk_scp {
>  	struct rproc_subdev *rpmsg_subdev;
>  
>  	struct list_head elem;
> +	struct list_head *cluster;
> +	struct mtk_scp_core_subdev *core_subdev;
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d644e232dfec..18534b1179b5 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -863,6 +863,60 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  	}
>  }
>  
> +static int scp_core_subdev_start(struct rproc_subdev *subdev)
> +{
> +	struct mtk_scp_core_subdev *core_subdev = to_core_subdev(subdev);
> +	struct mtk_scp *scp = core_subdev->scp;
> +
> +	rproc_boot(scp->rproc);
> +
> +	return 0;
> +}
> +
> +static void scp_core_subdev_stop(struct rproc_subdev *subdev, bool crashed)
> +{
> +	struct mtk_scp_core_subdev *core_subdev = to_core_subdev(subdev);
> +	struct mtk_scp *scp = core_subdev->scp;
> +
> +	rproc_shutdown(scp->rproc);
> +}
> +
> +static int scp_core_subdev_register(struct mtk_scp *scp)
> +{
> +	struct device *dev = scp->dev;
> +	struct mtk_scp_core_subdev *core_subdev;
> +	struct mtk_scp *scp_c0;
> +
> +	scp_c0 = list_first_entry(scp->cluster, struct mtk_scp, elem);
> +	if (!scp_c0)
> +		return -ENODATA;
> +
> +	core_subdev = devm_kzalloc(dev, sizeof(*core_subdev), GFP_KERNEL);
> +	if (!core_subdev)
> +		return -ENOMEM;
> +
> +	core_subdev->scp = scp;
> +	core_subdev->subdev.start = scp_core_subdev_start;
> +	core_subdev->subdev.stop = scp_core_subdev_stop;
> +
> +	scp->core_subdev = core_subdev;
> +	rproc_add_subdev(scp_c0->rproc, &scp->core_subdev->subdev);
> +
> +	return 0;
> +}
> +
> +static void scp_core_subdev_unregister(struct mtk_scp *scp)
> +{
> +	struct mtk_scp *scp_c0;
> +
> +	if (scp->core_subdev) {
> +		scp_c0 = list_first_entry(scp->cluster, struct mtk_scp, elem);
> +		rproc_remove_subdev(scp_c0->rproc, &scp->core_subdev->subdev);
> +		devm_kfree(scp->dev, scp->core_subdev);
> +		scp->core_subdev = NULL;
> +	}
> +}
> +
>  static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  				      struct mtk_scp_of_cluster *scp_cluster,
>  				      const struct mtk_scp_of_data *of_data)
> @@ -957,6 +1011,7 @@ static void scp_free(struct mtk_scp *scp)
>  {
>  	int i;
>  
> +	scp_core_subdev_unregister(scp);
>  	scp_remove_rpmsg_subdev(scp);
>  	scp_ipi_unregister(scp, SCP_IPI_INIT);
>  	scp_unmap_memory_region(scp);
> @@ -989,6 +1044,15 @@ static int scp_add_single_core(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void scp_rproc_boot_callback(const struct firmware *fw, void *context)
> +{
> +	struct rproc *rproc = context;
> +
> +	rproc_boot(rproc);
> +
> +	release_firmware(fw);
> +}
> +
>  static int scp_add_multi_core(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1029,6 +1093,20 @@ static int scp_add_multi_core(struct platform_device *pdev)
>  			goto init_fail;
>  		}
>  
> +		scp->cluster = cluster;
> +		if (!list_empty(cluster)) {
> +			ret = scp_core_subdev_register(scp);
> +			if (ret) {
> +				dev_err(dev, "Failed to register core %d as subdev\n", core_id);
> +				of_node_put(child);
> +				scp_free(scp);
> +				goto init_fail;
> +			}
> +		}
> +
> +		/* boot after all cores finished rproc_add() */
> +		scp->rproc->auto_boot = false;
> +
>  		ret = rproc_add(scp->rproc);
>  		if (ret) {
>  			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
> @@ -1041,6 +1119,16 @@ static int scp_add_multi_core(struct platform_device *pdev)
>  		core_id++;
>  	}
>  
> +	/* boot core 0, and other cores are booted following core 0 as subdevices */
> +	scp = list_first_entry(cluster, struct mtk_scp, elem);
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +				      scp->rproc->firmware, &scp->rproc->dev, GFP_KERNEL,
> +				      scp->rproc, scp_rproc_boot_callback);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware_nowait err: %d\n", ret);
> +		goto init_fail;
> +	}
> +
>  	return 0;
>  
>  init_fail:
> -- 
> 2.18.0
> 
