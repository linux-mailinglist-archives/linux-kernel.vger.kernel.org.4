Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60F5E8BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiIXLpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiIXLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:44:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F43252;
        Sat, 24 Sep 2022 04:44:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28OBiORQ003689;
        Sat, 24 Sep 2022 11:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3N1VaLpXUDkXxS9kSOW/35TYj4yY7CtvK57VDScUYOE=;
 b=Q2wGJMTuP0svRfVDj4EGI97TmocbPgs4sj7oGS39R42NC6s9QqMwtCocsUkOgjLqqcM4
 9B5gGx3NP25kwFGgh6FqlE6Z/42hkUJ+rrPzTteqY6QPARIidav3kOEOQFw4ZmGLmcGD
 E1tk7W4YneIRUqGcXo9HPGCMEzA+4bgtKekxSzxOf06nad1dZShViq9OzOjkuqxBg3qb
 KANZuVO+KiBN9uv21ag69jUjY9swJznhyL7TUADxlZ1QmN9pdBPnmLrCVYF9s8C6cWmL
 dY0Cwn+rzA1x8j3DagQDQjKNMHIVWGdb/H5oYshuH/zULv3XKZoaDXRUvMvXKcmjKnkJ Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsu6frje4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:44:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28OBiZHD015936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:44:35 GMT
Received: from [10.110.112.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 24 Sep
 2022 04:44:30 -0700
Message-ID: <9cba3c3d-c489-d99b-0bf1-81113fd6186f@quicinc.com>
Date:   Sat, 24 Sep 2022 17:14:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V13 2/7] soc: qcom: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <44ca04316e8b67f1662d304d8535236d82710bda.1663642052.git.quic_schowdhu@quicinc.com>
 <fa33589b-7fe1-7be2-8d80-4c81183126c9@kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <fa33589b-7fe1-7be2-8d80-4c81183126c9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D1ViNZuXCqshm-L8q8dUw0YAmA6WaEZk
X-Proofpoint-ORIG-GUID: D1ViNZuXCqshm-L8q8dUw0YAmA6WaEZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209240088
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2022 1:12 AM, Krzysztof Kozlowski wrote:
> On 20/09/2022 05:56, Souradeep Chowdhury wrote:
>> The DCC is a DMA Engine designed to capture and store data
>> during system crash or software triggers. The DCC operates
>> based on user inputs via the debugfs interface. The user gives
>> addresses as inputs and these addresses are stored in the
> (...)
>
>> +
>> +#define DCC_RD_MOD_WR_ADDR              0xC105E
>> +
>> +/*DCC debugfs directory*/
>> +static struct dentry	*dcc_dbg;
>> +
>> +enum dcc_descriptor_type {
>> +	DCC_READ_TYPE,
>> +	DCC_LOOP_TYPE,
>> +	DCC_READ_WRITE_TYPE,
>> +	DCC_WRITE_TYPE
>> +};
>> +
>> +struct dcc_config_entry {
>> +	u32				base;
>> +	u32				offset;
>> +	u32				len;
>> +	u32				loop_cnt;
>> +	u32				write_val;
>> +	u32				mask;
>> +	bool				apb_bus;
>> +	enum dcc_descriptor_type	desc_type;
>> +	struct list_head		list;
>> +};
>> +
>> +/**
>> + * struct dcc_drvdata - configuration information related to a dcc device
>> + * @base:	      Base Address of the dcc device
>> + * @dev:	      The device attached to the driver data
>> + * @mutex:	      Lock to protect access and manipulation of dcc_drvdata
>> + * @ram_base:         Base address for the SRAM dedicated for the dcc device
>> + * @ram_size:         Total size of the SRAM dedicated for the dcc device
>> + * @ram_offset:       Offset to the SRAM dedicated for dcc device
>> + * @mem_map_ver:      Memory map version of DCC hardware
>> + * @ram_cfg:          Used for address limit calculation for dcc
>> + * @ram_start:        Starting address of DCC SRAM
>> + * @sram_dev:	      Micellaneous device equivalent of dcc SRAM
>> + * @cfg_head:	      Points to the head of the linked list of addresses
>> + * @dbg_dir:          The dcc debugfs directory under which all the debugfs files are placed
>> + * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
>> + * @loopoff:          Loop offset bits range for the addresses
> All these entres have messed up spacing.
Ack
>
>> + * @enable:           This contains an array of linkedlist enable flags
> No, this is not an array of linked lists... It's a pointer to bool. This
> is not way to store linked lists.
Ack
>
>
>> +
>> +static int dcc_probe(struct platform_device *pdev)
>> +{
>> +	u32 val;
>> +	int ret = 0, i, size;
>> +	struct device *dev = &pdev->dev;
>> +	struct dcc_drvdata *dcc;
>> +	struct resource *res;
>> +
>> +	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
>> +	if (!dcc)
>> +		return -ENOMEM;
>> +
>> +	dcc->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, dcc);
>> +
>> +	dcc->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(dcc->base))
>> +		return PTR_ERR(dcc->base);
>> +
>> +	dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
>> +	if (IS_ERR(dcc->ram_base))
>> +		return PTR_ERR(dcc->ram_base);
>> +
>> +	dcc->ram_size = resource_size(res);
>> +
>> +	dcc->ram_offset = (size_t)of_device_get_match_data(&pdev->dev);
>> +
>> +	val = dcc_readl(dcc, DCC_HW_INFO);
>> +
>> +	if (FIELD_GET(DCC_VER_INFO_MASK, val)) {
>> +		dcc->mem_map_ver = 3;
>> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +		if (dcc->nr_link_list == 0)
>> +			return	-EINVAL;
>> +	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
>> +		dcc->mem_map_ver = 2;
>> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
>> +		if (dcc->nr_link_list == 0)
>> +			return	-EINVAL;
>> +	} else {
>> +		dcc->mem_map_ver = 1;
>> +		dcc->nr_link_list = DCC_MAX_LINK_LIST;
>> +	}
>> +
>> +	/* Either set the fixed loop offset or calculate it
> Start with /*
> (see coding style)
Ack
>
>> +	 * from ram_size.Max consecutive addresses the
>> +	 * dcc can loop is equivalent to the ram size
>> +	 */
>> +	if (val & DCC_LOOP_OFFSET_MASK)
>> +		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
>> +	else
>> +		dcc->loopoff = get_bitmask_order((dcc->ram_size +
>> +				dcc->ram_offset) / 4 - 1);
>> +
>> +	mutex_init(&dcc->mutex);
>> +	/* Allocate space for all entries at once */
>> +	size = sizeof(*dcc->enable) + sizeof(*dcc->cfg_head);
> This is quite confusing way of handling lists - some parts of drvdata
> are list, some are not.

We are using three things for lists here.  A cfg_head which points to 
the head of the

individual linkedlist of addresses. a nr_linked_list to store the total 
number of lists

supported by dcc and an array of boolean to store the enabled status of 
each individual lists

>> +
>> +	dcc->enable = devm_kcalloc(dev, dcc->nr_link_list, size, GFP_KERNEL);
>> +	if (!dcc->enable)
>> +		return -ENOMEM;
>> +
>> +	dcc->cfg_head = (struct list_head *)(dcc->enable + dcc->nr_link_list);
> That's unusual way to iterate over list...
Here we are instantiating the head of each individual linked lists in 
the array that stores the list.
>
>> +
>> +	for (i = 0; i < dcc->nr_link_list; i++)
>> +		INIT_LIST_HEAD(&dcc->cfg_head[i]);
>> +
>> +	ret = dcc_sram_dev_init(dcc);
>> +	if (ret) {
>> +		dev_err(dcc->dev, "DCC: sram node not registered.\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = dcc_create_debug_dir(dcc);
>> +	if (ret) {
>> +		dev_err(dcc->dev, "DCC: debugfs files not created.\n");
> debugfs failures are not reasons to fail probe. Also no need to print
> errors.

The total functionality of this driver is dependent on the debugfs 
files. That is why

the probe if failed with error message if it is not created. This is 
done as per Alex's

comment on version 8 of the patch.

>> +		dcc_sram_dev_exit(dcc);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dcc_remove(struct platform_device *pdev)
>> +{
>> +	struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
>> +
>> +	dcc_delete_debug_dir(drvdata);
>> +
>> +	dcc_sram_dev_exit(drvdata);
>> +
> No need for blank lines between each calls.
Ack
>
>> +	dcc_config_reset(drvdata);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id dcc_match_table[] = {
>> +	{ .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
>> +	{ .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000 },
>> +	{ .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
>> +	{ .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, dcc_match_table);
>> +
>> +static struct platform_driver dcc_driver = {
>> +	.probe = dcc_probe,
>> +	.remove	= dcc_remove,
>> +	.driver	= {
>> +		.name = "qcom-dcc",
>> +		.of_match_table	= dcc_match_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(dcc_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
>> +
> Best regards,
> Krzysztof
>
