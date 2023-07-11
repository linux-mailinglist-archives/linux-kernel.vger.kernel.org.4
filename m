Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7574F7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjGKSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGKSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:00:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4F10EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:00:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668709767b1so3511530b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689098413; x=1691690413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYr+ZO+NYmJdb7MPE1fofBZFIpqkB6XpnPXWvFUmGNc=;
        b=BthEe4hEYJGjsFRRaeqqMaWfPxp5OUjcW6Yw5onaee8D98oTLUxT3GP6J5Bdt9Qw7s
         gU8T07ZJKJyF5rBbw/KkgCCaG0Yz6/ncybdJ+DCet+tdn+RYKNymwjJ3jF5Dzkz70zoO
         j9O50jvs2VMWDMm5UYdtL2R7e2C38LmNqkDzYsh1UvLu9XLql7AvsSKqbyEtl4SapAhW
         EjE7fZgvM4AhgKTMmL2bgkr/tL7+Q0Wv4X2g42wszldVhH/qnMJPsJsS5rhmjF973wck
         nhl1+4BLKeOIwilM+bP4qf0qzNf+zBrDWnYqvj+RywRykafrKsC8fA1tOnFUndYWKOLR
         jIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098413; x=1691690413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYr+ZO+NYmJdb7MPE1fofBZFIpqkB6XpnPXWvFUmGNc=;
        b=LopJ8NjNbiQaQhtWxJttg+kK6ceZZs5Q0IMIIC7x36Mp/i+F6CnWUfs+rPZTtrRduR
         kYjAxTBcEM12deoyd4fQRXf9KkMOlMkxoCCAKSXiTERGBs5Au528yEbmJUR0ru43yGaH
         4RBRzD56RtWotWlsQoACD/dKjPw5tKHS4P9GqI4PnQwxzZ9xuUqqOGBJ9rbKPkLK7Kwz
         DGHmOfw4tOock8wZsELkONcOrjFQIlkC7XFmIBEEzhSZO6Tj+8rvuFOY421QU8PQOJMo
         clV6BPqsidV9ypDJIHYHJhteW1mAIGOMqDylIfoY8xHpOSFIAYyHPXIwg9Dx0246lQsw
         /wlA==
X-Gm-Message-State: ABy/qLZAT9OwUKrvmWNxbNJQQKLxAhXUi355S4iMsU4/xWa6BQmANakG
        OsCkY6bbfmz1dtA+mLg2CvsvPg==
X-Google-Smtp-Source: APBJJlFqH2uc/SbrLdGAXjl+CNQB3sVEUvTQdJ9NUnshYLJ1PnuDjMUmKV6ZfLdrkVy7Y8X+BXSh8g==
X-Received: by 2002:a05:6a20:4283:b0:12d:7d21:eadf with SMTP id o3-20020a056a20428300b0012d7d21eadfmr16576371pzj.52.1689098413541;
        Tue, 11 Jul 2023 11:00:13 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9b4d:d526:6948:59a2])
        by smtp.gmail.com with ESMTPSA id r4-20020a63b104000000b00553b546a638sm1866753pgf.67.2023.07.11.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:00:13 -0700 (PDT)
Date:   Tue, 11 Jul 2023 12:00:10 -0600
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
Subject: Re: [PATCH v14 07/12] remoteproc: mediatek: Remove dependency of
 MT8195 SCP L2TCM power control on dual-core SCP
Message-ID: <ZK2YqtlMPWdQzG0l@p14s>
References: <20230707052612.27521-1-tinghan.shen@mediatek.com>
 <20230707052612.27521-8-tinghan.shen@mediatek.com>
 <ZK2WS+cldx/8+VGA@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK2WS+cldx/8+VGA@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:50:03AM -0600, Mathieu Poirier wrote:
> On Fri, Jul 07, 2023 at 01:26:07PM +0800, Tinghan Shen wrote:
> > Previously, SCP core 0 controlled the power of L2TCM and dictated that
> > SCP core 1 could only boot after SCP core 0. To address this constraint,
> > extracted the power control flow of L2TCM and made it shared
> > between both cores, enabling support of arbitrary boot order.
> 
> Definitely an improvement.
> 
> > 
> > The flow for controlling L2TCM power has been incorporated into the
> > mt8195_scp_before_load() and mt8195_scp_stop() APIs, which are
> > respectively invoked during the rproc->ops->start() and
> > rproc->ops->stop() operations. These APIs effectively serve the same
> > purpose as the rproc prepare()/unprepare() APIs."
> 
> I'm not fond of that custom API but it is so widespread in this driver that I
> will go with it.
> 
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  drivers/remoteproc/mtk_common.h |  1 +
> >  drivers/remoteproc/mtk_scp.c    | 80 ++++++++++++++++++++++++++-------
> >  2 files changed, 66 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> > index 56395e8664cb..41e1b4732b75 100644
> > --- a/drivers/remoteproc/mtk_common.h
> > +++ b/drivers/remoteproc/mtk_common.h
> > @@ -130,6 +130,7 @@ struct mtk_scp {
> >  	struct rproc_subdev *rpmsg_subdev;
> >  
> >  	struct list_head elem;
> > +	struct platform_device *cluster_pdev;
> 
> This isn't needed.  rproc->dev.parent is pdev->dev.  Use container_of() to
> get to the platform device. 
> 
> 
> >  };
> >  
> >  /**
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index 3349488e5f21..94602272c05f 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -29,6 +29,10 @@ struct mtk_scp_of_cluster {
> >  	size_t l1tcm_size;
> >  	phys_addr_t l1tcm_phys;
> >  	struct list_head mtk_scp_list;
> > +
> > +	/* Prevent concurrent operations of L2TCM power control. */
> > +	struct mutex l2tcm_lock;
> > +	u32 l2tcm_refcnt;
> >  };
> >  
> >  /**
> > @@ -449,7 +453,7 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
> >  
> >  	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> >  
> > -	/* enable SRAM clock */
> > +	/* enable SRAM power */
> >  	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> >  	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> >  	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > @@ -462,19 +466,38 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
> >  	return 0;
> >  }
> >  
> > -static int mt8195_scp_before_load(struct mtk_scp *scp)
> > +static int mt8195_scp_l2tcm_on(struct mtk_scp *scp)
> >  {
> > -	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> > -	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> > +	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(scp->cluster_pdev);
> > +
> > +	mutex_lock(&scp_cluster->l2tcm_lock);
> > +
> > +	if (scp_cluster->l2tcm_refcnt == 0) {
> > +		/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> > +		writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> > +
> > +		/* Power on L2TCM */
> > +		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > +		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > +		scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > +		scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> > +				  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> > +	}
> > +
> > +	scp_cluster->l2tcm_refcnt += 1;
> >  
> > +	mutex_unlock(&scp_cluster->l2tcm_lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mt8195_scp_before_load(struct mtk_scp *scp)
> > +{
> >  	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> >  
> > +	mt8195_scp_l2tcm_on(scp);
> > +
> >  	/* enable SRAM clock */
> > -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > -	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > -	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> > -			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> >  	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> >  
> >  	/* enable MPU for all memory regions */
> > @@ -487,6 +510,8 @@ static int mt8195_scp_c1_before_load(struct mtk_scp *scp)
> >  {
> >  	scp->data->scp_reset_assert(scp);
> >  
> > +	mt8195_scp_l2tcm_on(scp);
> > +
> >  	scp_sram_power_on(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> >  
> >  	/* enable MPU for all memory regions */
> > @@ -653,14 +678,30 @@ static void mt8192_scp_stop(struct mtk_scp *scp)
> >  	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
> >  }
> >  
> > +static void mt8195_scp_l2tcm_off(struct mtk_scp *scp)
> > +{
> > +	struct mtk_scp_of_cluster *scp_cluster = platform_get_drvdata(scp->cluster_pdev);
> > +
> > +	mutex_lock(&scp_cluster->l2tcm_lock);
> > +
> 
> What happens if ->l2tcm_refcnt is 0 and this function is called?
>

More comments to come tomorrow.

Thanks,
Mathieu

> 
> > +	scp_cluster->l2tcm_refcnt -= 1;
> > +
> > +	if (scp_cluster->l2tcm_refcnt == 0) {
> > +		/* Power off L2TCM */
> > +		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > +		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > +		scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > +		scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN, 0);
> > +		scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> > +	}
> > +
> > +	mutex_unlock(&scp_cluster->l2tcm_lock);
> > +}
> > +
> >  static void mt8195_scp_stop(struct mtk_scp *scp)
> >  {
> > -	/* Disable SRAM clock */
> > -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > -	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > -	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> > -			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> > +	mt8195_scp_l2tcm_off(scp);
> > +
> >  	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> >  
> >  	/* Disable SCP watchdog */
> > @@ -669,6 +710,8 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
> >  
> >  static void mt8195_scp_c1_stop(struct mtk_scp *scp)
> >  {
> > +	mt8195_scp_l2tcm_off(scp);
> > +
> >  	/* Power off CPU SRAM */
> >  	scp_sram_power_off(scp->reg_base + MT8195_CPU1_SRAM_PD, 0);
> >  
> > @@ -976,6 +1019,8 @@ static int scp_add_single_core(struct platform_device *pdev)
> >  	if (IS_ERR(scp))
> >  		return PTR_ERR(scp);
> >  
> > +	scp->cluster_pdev = pdev;
> > +
> >  	ret = rproc_add(scp->rproc);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to add rproc\n");
> > @@ -1028,6 +1073,8 @@ static int scp_add_multi_core(struct platform_device *pdev)
> >  			goto init_fail;
> >  		}
> >  
> > +		scp->cluster_pdev = pdev;
> > +
> >  		ret = rproc_add(scp->rproc);
> >  		if (ret) {
> >  			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
> > @@ -1114,6 +1161,7 @@ static int scp_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
> > +	mutex_init(&scp_cluster->l2tcm_lock);
> >  	platform_set_drvdata(pdev, scp_cluster);
> >  
> >  	ret = devm_of_platform_populate(dev);
> > @@ -1137,6 +1185,8 @@ static void scp_remove(struct platform_device *pdev)
> >  		rproc_del(scp->rproc);
> >  		scp_free(scp);
> >  	}
> > +
> > +	mutex_destroy(&scp_cluster->l2tcm_lock);
> >  }
> >  
> >  static const struct mtk_scp_of_data mt8183_of_data = {
> > -- 
> > 2.18.0
> > 
