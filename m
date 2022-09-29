Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187B5EFA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiI2Q1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiI2Q00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:26:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64A1E1136;
        Thu, 29 Sep 2022 09:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88261B82494;
        Thu, 29 Sep 2022 16:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D122C433C1;
        Thu, 29 Sep 2022 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468640;
        bh=MMJQWPnFWJB4yk0k49ZLZN1KMz9PDhmPnioeFwJfW8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM9srBH27iDcKNisMkeT0bZxH8O/n+UAkxZ3o+uQH8+UA0m4uh5x4k1tYUunN9SDq
         3HpvfgO23zx8WR8qn2V51lSw0gFwu91vU5I0ZunEEoRTjJYplSOQxeiYenC/dKRnnQ
         kFXUE5lSBpJz1hBFBYoXm3Gn/kGBRoC7gs7ZmHd5AcDoMvK5wqBXFew9cYeorX8nl3
         yuEnxHVW7Vnx3gKYK8649Wk32XzqKxqvMb4jB1A2W+ZKL6TYEKjcdTZPRnIymc0Olj
         fuf+UrqzrXJnxQn83Y2z3+3wNS3h05+SFzpDfQQ0HF6Oe2hdfZnEihZVcDqAQJ+FAu
         ohdbwImqoc/cg==
Date:   Thu, 29 Sep 2022 11:23:57 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alex Elder <elder@ieee.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
Subject: Re: [PATCH V14 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <20220929162357.53u5shcmdrkivzue@builder.lan>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <c286f5e35348253809146ef45840339509e36ff8.1664383851.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c286f5e35348253809146ef45840339509e36ff8.1664383851.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:41:12PM +0530, Souradeep Chowdhury wrote:
[..]
> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
[..]
> +/**
> + * struct dcc_drvdata - configuration information related to a dcc device
> + * @base:		Base Address of the dcc device
> + * @dev:		The device attached to the driver data
> + * @mutex:		Lock to protect access and manipulation of dcc_drvdata
> + * @ram_base:		Base address for the SRAM dedicated for the dcc device
> + * @ram_size:		Total size of the SRAM dedicated for the dcc device
> + * @ram_offset:	Offset to the SRAM dedicated for dcc device
> + * @mem_map_ver:	Memory map version of DCC hardware
> + * @ram_cfg:		Used for address limit calculation for dcc
> + * @ram_start:		Starting address of DCC SRAM
> + * @sram_dev:		Miscellaneous device equivalent of dcc SRAM
> + * @cfg_head:		Points to the head of the linked list of addresses
> + * @dbg_dir:		The dcc debugfs directory under which all the debugfs files are placed
> + * @nr_link_list:	Total number of linkedlists supported by the DCC configuration
> + * @loopoff:		Loop offset bits range for the addresses
> + * @enable;		This contains an array of linkedlist enable flags
> + */
> +struct dcc_drvdata {
> +	void __iomem		*base;
> +	void                    *ram_base;
> +	struct device		*dev;
> +	struct mutex		mutex;
> +	size_t			ram_size;
> +	size_t			ram_offset;
> +	int			mem_map_ver;
> +	phys_addr_t		ram_cfg;
> +	phys_addr_t		ram_start;
> +	struct miscdevice	sram_dev;
> +	struct list_head	*cfg_head;
> +	struct dentry		*dbg_dir;
> +	size_t			nr_link_list;
> +	u8			loopoff;
> +	bool                    *enable;

It's idiomatic to carry such information in a bitmap, and if
DCC_MAX_LINK_LIST applies to all versions (not obvious from the code
below) then replacing this with just a fixed unsigned long would be a
good move.

Use set_bit(), clear_bit() and test_bit() as needed to access the
individual bits.

> +};
> +
> +struct dcc_cfg_attr {
> +	u32	addr;
> +	u32	prev_addr;
> +	u32	prev_off;
> +	u32	link;
> +	u32	sram_offset;
> +};
> +
> +struct dcc_cfg_loop_attr {
> +	u32	loop;
> +	u32	loop_cnt;
> +	u32	loop_len;
> +	u32	loop_off;
> +	bool    loop_start;
> +};
> +
[..]
> +static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
> +{
> +	int list;
> +
> +	for (list = 0; list < DCC_MAX_LINK_LIST; list++)

It's possible that there's only dcc->nr_link_list entries in the enable
array.

> +		if (drvdata->enable[list])
> +			return true;
> +
> +	return false;
> +}
[..]
> +static int dcc_probe(struct platform_device *pdev)
> +{
> +	u32 val;
> +	int ret = 0, i, size;
> +	struct device *dev = &pdev->dev;
> +	struct dcc_drvdata *dcc;
> +	struct resource *res;
> +
> +	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
> +	if (!dcc)
> +		return -ENOMEM;
> +
> +	dcc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dcc);
> +
> +	dcc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dcc->base))
> +		return PTR_ERR(dcc->base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -ENODEV;
> +
> +	dcc->ram_base = memremap(res->start, resource_size(res), MEMREMAP_WB);
> +	if (!dcc->ram_base)
> +		return -ENODEV;
> +
> +	dcc->ram_size = resource_size(res);
> +
> +	dcc->ram_offset = (size_t)of_device_get_match_data(&pdev->dev);
> +
> +	val = dcc_readl(dcc, DCC_HW_INFO);
> +
> +	if (FIELD_GET(DCC_VER_INFO_MASK, val)) {
> +		dcc->mem_map_ver = 3;
> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
> +		if (dcc->nr_link_list == 0)
> +			return	-EINVAL;
> +	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
> +		dcc->mem_map_ver = 2;
> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
> +		if (dcc->nr_link_list == 0)
> +			return	-EINVAL;
> +	} else {
> +		dcc->mem_map_ver = 1;
> +		dcc->nr_link_list = DCC_MAX_LINK_LIST;
> +	}
> +
> +	/* Either set the fixed loop offset or calculate it
> +	 * from ram_size. Max consecutive addresses the
> +	 * dcc can loop is equivalent to the ram size
> +	 */
> +	if (val & DCC_LOOP_OFFSET_MASK)
> +		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
> +	else
> +		dcc->loopoff = get_bitmask_order((dcc->ram_size +
> +				dcc->ram_offset) / 4 - 1);
> +
> +	mutex_init(&dcc->mutex);
> +	/* Allocate space for all entries at once */
> +	size = sizeof(*dcc->enable) + sizeof(*dcc->cfg_head);
> +
> +	dcc->enable = devm_kcalloc(dev, dcc->nr_link_list, size, GFP_KERNEL);
> +	if (!dcc->enable)
> +		return -ENOMEM;
> +
> +	dcc->cfg_head = (struct list_head *)(dcc->enable + dcc->nr_link_list);

Turning enable into a unsigned long bitmap, will clean this stuff up as
well, as you won't have the need/urge to allocate the two components at
once and then do pointer math on them...

Regards,
Bjorn

> +
> +	for (i = 0; i < dcc->nr_link_list; i++)
> +		INIT_LIST_HEAD(&dcc->cfg_head[i]);
> +
> +	ret = dcc_sram_dev_init(dcc);
> +	if (ret) {
> +		dev_err(dcc->dev, "DCC: sram node not registered.\n");
> +		return ret;
> +	}
> +
> +	ret = dcc_create_debug_dir(dcc);
> +	if (ret) {
> +		dev_err(dcc->dev, "DCC: debugfs files not created.\n");
> +		dcc_sram_dev_exit(dcc);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
