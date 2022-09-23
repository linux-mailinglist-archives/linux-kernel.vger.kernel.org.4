Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482875E829E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiIWTnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiIWTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:42:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AA11D600;
        Fri, 23 Sep 2022 12:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 188DBB82153;
        Fri, 23 Sep 2022 19:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DF4C433C1;
        Fri, 23 Sep 2022 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663962173;
        bh=Y0GK27HriGK1CenoOx7n+sXWQGZIWWq+apTVtRSFstM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qoqngcFkaVYhxKX1ekOizxC/cDw5cxGSSd+E0qRgZQf1sY5iUhTuf/yEzP1Qfsqxu
         n6BmwAhZUvkZwvOatNtoV3GHbvhDPbQNIPbK0+DLoZzdEGKTN90yMPxB1X8lVfaScP
         6qPWOiNQACjP17YfWCslLUy8R9ozwStjqTWyZ2PVOfSaeKwby/xzFuDmdm9Ylhr/Sx
         GvDS882q7IRFhmqaYwnyR0BvkRMo1oLgWfEb3XIeptiwijdjHpFyhKpS45o7XG5DCe
         SPA/RIBZT+OgK/HEvwk2SIw9uAzxAvXlX2EXhT5RVQO1QyabuHHGnpunZ99Sifujmy
         yUlRXRuugIiFw==
Message-ID: <fa33589b-7fe1-7be2-8d80-4c81183126c9@kernel.org>
Date:   Fri, 23 Sep 2022 21:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V13 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <44ca04316e8b67f1662d304d8535236d82710bda.1663642052.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <44ca04316e8b67f1662d304d8535236d82710bda.1663642052.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 05:56, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the debugfs interface. The user gives
> addresses as inputs and these addresses are stored in the

(...)

> +
> +#define DCC_RD_MOD_WR_ADDR              0xC105E
> +
> +/*DCC debugfs directory*/
> +static struct dentry	*dcc_dbg;
> +
> +enum dcc_descriptor_type {
> +	DCC_READ_TYPE,
> +	DCC_LOOP_TYPE,
> +	DCC_READ_WRITE_TYPE,
> +	DCC_WRITE_TYPE
> +};
> +
> +struct dcc_config_entry {
> +	u32				base;
> +	u32				offset;
> +	u32				len;
> +	u32				loop_cnt;
> +	u32				write_val;
> +	u32				mask;
> +	bool				apb_bus;
> +	enum dcc_descriptor_type	desc_type;
> +	struct list_head		list;
> +};
> +
> +/**
> + * struct dcc_drvdata - configuration information related to a dcc device
> + * @base:	      Base Address of the dcc device
> + * @dev:	      The device attached to the driver data
> + * @mutex:	      Lock to protect access and manipulation of dcc_drvdata
> + * @ram_base:         Base address for the SRAM dedicated for the dcc device
> + * @ram_size:         Total size of the SRAM dedicated for the dcc device
> + * @ram_offset:       Offset to the SRAM dedicated for dcc device
> + * @mem_map_ver:      Memory map version of DCC hardware
> + * @ram_cfg:          Used for address limit calculation for dcc
> + * @ram_start:        Starting address of DCC SRAM
> + * @sram_dev:	      Micellaneous device equivalent of dcc SRAM
> + * @cfg_head:	      Points to the head of the linked list of addresses
> + * @dbg_dir:          The dcc debugfs directory under which all the debugfs files are placed
> + * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
> + * @loopoff:          Loop offset bits range for the addresses

All these entres have messed up spacing.

> + * @enable:           This contains an array of linkedlist enable flags

No, this is not an array of linked lists... It's a pointer to bool. This
is not way to store linked lists.


> +
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
> +	dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> +	if (IS_ERR(dcc->ram_base))
> +		return PTR_ERR(dcc->ram_base);
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

Start with /*
(see coding style)

> +	 * from ram_size.Max consecutive addresses the
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

This is quite confusing way of handling lists - some parts of drvdata
are list, some are not.

> +
> +	dcc->enable = devm_kcalloc(dev, dcc->nr_link_list, size, GFP_KERNEL);
> +	if (!dcc->enable)
> +		return -ENOMEM;
> +
> +	dcc->cfg_head = (struct list_head *)(dcc->enable + dcc->nr_link_list);

That's unusual way to iterate over list...

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

debugfs failures are not reasons to fail probe. Also no need to print
errors.

> +		dcc_sram_dev_exit(dcc);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dcc_remove(struct platform_device *pdev)
> +{
> +	struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	dcc_delete_debug_dir(drvdata);
> +
> +	dcc_sram_dev_exit(drvdata);
> +

No need for blank lines between each calls.

> +	dcc_config_reset(drvdata);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dcc_match_table[] = {
> +	{ .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
> +	{ .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000 },
> +	{ .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
> +	{ .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dcc_match_table);
> +
> +static struct platform_driver dcc_driver = {
> +	.probe = dcc_probe,
> +	.remove	= dcc_remove,
> +	.driver	= {
> +		.name = "qcom-dcc",
> +		.of_match_table	= dcc_match_table,
> +	},
> +};
> +
> +module_platform_driver(dcc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
> +

Best regards,
Krzysztof

