Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256772CD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjFLRzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbjFLRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:54:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0F19B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-655fce0f354so3660245b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686592497; x=1689184497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3QVmqP35ml+Zcd/ACOdBpI7Nl407UcaAzEIMqiZ+kc=;
        b=EKX5sORL5xWywKAInrL8721zWX/+Td5IhSfbCg0UB2+aOGAnbONy7wM7llHRvCN4pj
         ENHSqSPG5zQwAIhuwG21Y0WFEXml9YJx1GhSTR2fQSEB5B5QN3ii+aQsr+15Z3iQSK2p
         CWyR0TJE/TZYDQlPeQHqAFC+sATrLr1MOL8pnwjW8SnI80u6oJK+MQAqwi81FNnnIVpj
         FT0+k1xj8CQ04ygLZSgo+kTEfJt25w3jadn0FUj9I6aDrnEiCY5x85zFiZH6UEKA0H15
         9HJT5jAH3z/KRTcPDbl0Xzuw9P/ZQtYWVeSXhyLmTQm4lWA8HVLHymgqizhW29nzXHGa
         KuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592497; x=1689184497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3QVmqP35ml+Zcd/ACOdBpI7Nl407UcaAzEIMqiZ+kc=;
        b=byrOFrhQ3PmmYExWABz/sL9SJzhkz5sVSZSJVUc9dTwJhpYEf/kUtEqEEQSAXuIGR/
         6P7jlAib6A0hWhwCaKpvFauWYweRUZX5WgqKJ/2QNVDOiBRmUkawWi4Q3Um50vl9UnVr
         VJzyUi3evYxFPRM5OjlK0tfrSVOdauzBTQanKPItANgg7hDAeMdn0eyrLPZ5/U9kluZg
         YV71h62D/3VmWkmmvScIPa8UdEEA0FodS3aV47jMZAt45y04wBy9AZ3imxi38TsYvUu3
         YKwsNkde7a8I26T5y9azysBmyS8QcEmUoGu/JCUoD7G0A/IoprC8svLQX2zyXuTL5hBd
         yzZA==
X-Gm-Message-State: AC+VfDxegt9pp57g8RpVhHTwpwgg3su6Tr5qHj0WvNc2tUzU1405YSX/
        Ft2EPE/wOeBY+zKfxrbIhoWSSg==
X-Google-Smtp-Source: ACHHUZ7c3dE4bFyUEg0IBA9gRJo/g3kfgnIer48hTU53YCzcy0yu3zeW7SAdtKluX0MICYM4Pb3iPg==
X-Received: by 2002:a05:6a00:1401:b0:661:4a00:1e8b with SMTP id l1-20020a056a00140100b006614a001e8bmr11394543pfu.23.1686592497280;
        Mon, 12 Jun 2023 10:54:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8960:fd1b:9d08:8ca1])
        by smtp.gmail.com with ESMTPSA id x21-20020aa784d5000000b0064d566f658esm7155939pfn.135.2023.06.12.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:54:56 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:54:54 -0600
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
Subject: Re: [PATCH v13 07/11] remoteproc: mediatek: Add scp_boot_peers and
 scp_shutdown_peers operations
Message-ID: <ZIdb7n3LWKRekOdu@p14s>
References: <20230607072222.8628-1-tinghan.shen@mediatek.com>
 <20230607072222.8628-8-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607072222.8628-8-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 03:22:18PM +0800, Tinghan Shen wrote:
> Due to that SCP core 0 controls the SCP clock and SRAM power, add two
> new mtk_scp_of_data operations, scp_boot_peers and scp_shutdown_peers,
> to manage the boot sequence and watchdog timeout handling of SCP core 1.
> It ensures that core 1 boots after or shuts down before core 0 for
> maintaining the proper control flow over SCP core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_common.h |  3 ++
>  drivers/remoteproc/mtk_scp.c    | 55 +++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index 56395e8664cb..0bfd242c41cc 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -93,6 +93,8 @@ struct mtk_scp_of_data {
>  	void (*scp_reset_deassert)(struct mtk_scp *scp);
>  	void (*scp_stop)(struct mtk_scp *scp);
>  	void *(*scp_da_to_va)(struct mtk_scp *scp, u64 da, size_t len);
> +	void (*scp_boot_peers)(struct mtk_scp *scp);
> +	void (*scp_shutdown_peers)(struct mtk_scp *scp);

This isn't what I suggested in my previous email.  This solution will not work
if a user is looking to independently start/stop CPU1 from sysfs.

I will not go further with this revision.

Mathieu

>  
>  	u32 host_to_scp_reg;
>  	u32 host_to_scp_int_bit;
> @@ -130,6 +132,7 @@ struct mtk_scp {
>  	struct rproc_subdev *rpmsg_subdev;
>  
>  	struct list_head elem;
> +	struct list_head *cluster;
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d644e232dfec..edbf71f4c21e 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -74,8 +74,21 @@ void scp_put(struct mtk_scp *scp)
>  }
>  EXPORT_SYMBOL_GPL(scp_put);
>  
> +static void mt8195_scp_shutdown_peers(struct mtk_scp *scp)
> +{
> +	struct mtk_scp *next_scp;
> +
> +	next_scp = list_next_entry(scp, elem);
> +	list_for_each_entry_from(next_scp, scp->cluster, elem) {
> +		rproc_shutdown(next_scp->rproc);
> +	}
> +}
> +
>  static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
>  {
> +	if (scp->data->scp_shutdown_peers)
> +		scp->data->scp_shutdown_peers(scp);
> +
>  	dev_err(scp->dev, "SCP watchdog timeout! 0x%x", scp_to_host);
>  	rproc_report_crash(scp->rproc, RPROC_WATCHDOG);
>  }
> @@ -539,6 +552,18 @@ static int scp_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> +static void mt8195_scp_boot_peers(struct mtk_scp *scp)
> +{
> +	struct mtk_scp *next_scp;
> +
> +	if (scp->cluster && !list_empty(scp->cluster)) {
> +		next_scp = list_next_entry(scp, elem);
> +		list_for_each_entry_from(next_scp, scp->cluster, elem) {
> +			rproc_boot(next_scp->rproc);
> +		}
> +	}
> +}
> +
>  static int scp_start(struct rproc *rproc)
>  {
>  	struct mtk_scp *scp = rproc->priv;
> @@ -574,6 +599,9 @@ static int scp_start(struct rproc *rproc)
>  	clk_disable_unprepare(scp->clk);
>  	dev_info(dev, "SCP is ready. FW version %s\n", run->fw_ver);
>  
> +	if (scp->data->scp_boot_peers)
> +		scp->data->scp_boot_peers(scp);
> +
>  	return 0;
>  
>  stop:
> @@ -977,6 +1005,8 @@ static int scp_add_single_core(struct platform_device *pdev)
>  	if (IS_ERR(scp))
>  		return PTR_ERR(scp);
>  
> +	scp->cluster = cluster;
> +
>  	ret = rproc_add(scp->rproc);
>  	if (ret) {
>  		dev_err(dev, "Failed to add rproc\n");
> @@ -989,6 +1019,15 @@ static int scp_add_single_core(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void scp_rproc_boot_core0(const struct firmware *fw, void *context)
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
> @@ -1029,6 +1068,10 @@ static int scp_add_multi_core(struct platform_device *pdev)
>  			goto init_fail;
>  		}
>  
> +		/* boot after all cores are discovered */
> +		scp->rproc->auto_boot = false;
> +		scp->cluster = cluster;
> +
>  		ret = rproc_add(scp->rproc);
>  		if (ret) {
>  			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
> @@ -1041,6 +1084,16 @@ static int scp_add_multi_core(struct platform_device *pdev)
>  		core_id++;
>  	}
>  
> +	/* boot core 0, and other cores are booted following core 0 */
> +	scp = list_first_entry(cluster, struct mtk_scp, elem);
> +	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +				      scp->rproc->firmware, &scp->rproc->dev, GFP_KERNEL,
> +				      scp->rproc, scp_rproc_boot_core0);
> +	if (ret < 0) {
> +		dev_err(dev, "request_firmware_nowait err: %d\n", ret);
> +		goto init_fail;
> +	}
> +
>  	return 0;
>  
>  init_fail:
> @@ -1198,6 +1251,8 @@ static const struct mtk_scp_of_data mt8195_of_data = {
>  	.scp_reset_deassert = mt8192_scp_reset_deassert,
>  	.scp_stop = mt8195_scp_stop,
>  	.scp_da_to_va = mt8192_scp_da_to_va,
> +	.scp_boot_peers = mt8195_scp_boot_peers,
> +	.scp_shutdown_peers = mt8195_scp_shutdown_peers,
>  	.host_to_scp_reg = MT8192_GIPC_IN_SET,
>  	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
>  };
> -- 
> 2.18.0
> 
