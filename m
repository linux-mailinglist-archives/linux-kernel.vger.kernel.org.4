Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4A5B99C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIOLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIOLig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:38:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D09A9E4;
        Thu, 15 Sep 2022 04:38:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBcG3p018847;
        Thu, 15 Sep 2022 11:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hTIVbURAgARCq7bIHw538YX8w4ssrXx1MEH1xoedeGM=;
 b=YJyizms/DrDnXJ1vDuD1iG4WbRD1JHQe/TyjfIUJ+NhORmuebfmIBl/XkVEpDw1L21c+
 pjg5OLWzfvmnbt5C1wVPOJ5FLwWv9EJ7WQ8ccMPW5SzbWnEOJ5Y6DI09FN9Li0OqMtF3
 DizKEhAXzqMV9xAcsqJrTXCXwhlxCtdL9vq2vdeM0InzgH1eqUqRVRwG5p1r7yLLNDJR
 c09ewyL+qNrXl2Nq01evnsCr4Wxs6psGtiqxUyn4uMWDNI5L+TnnMSmNJgudNRpOtQK5
 m3G7c1DAGZgwdXd7U/BTghNdDMEeu6hxmt3KSOQCY9wW4a0WE2pFc4HTWMbHGEgHp1Kg gw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkp8at8ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:38:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28FBXFKF027700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 11:33:15 GMT
Received: from [10.79.142.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 04:33:10 -0700
Message-ID: <b39f61b1-6236-ab61-4df2-84159e6409fe@quicinc.com>
Date:   Thu, 15 Sep 2022 17:02:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V9 2/7] soc: qcom: dcc:Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663173477.git.quic_schowdhu@quicinc.com>
 <a0b830e557754f479027e34b5dd65558c7e0d375.1663173478.git.quic_schowdhu@quicinc.com>
 <20220915033357.7tpenh2adodvaulg@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20220915033357.7tpenh2adodvaulg@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pL029JKqSVvj9FZqUhR1zjwr6gi9YTne
X-Proofpoint-ORIG-GUID: pL029JKqSVvj9FZqUhR1zjwr6gi9YTne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150064
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/2022 9:03 AM, Bjorn Andersson wrote:
> On Wed, Sep 14, 2022 at 10:31:12PM +0530, Souradeep Chowdhury wrote:
>> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
> [..]
>> +static inline void dcc_ll_writel(struct dcc_drvdata *drvdata,
>> +				u32 ll, u32 val, u32 off)
>> +{
>> +	u32 offset = DCC_LL_OFFSET(drvdata->mem_map_ver) + off;
>> +
>> +	writel((val), drvdata->base + ll * 0x80 + offset);
> Extra () around val.
Ack
>
>> +}
>> +
>> +static inline u32 dcc_ll_readl(struct dcc_drvdata *drvdata, u32 ll, u32 off)
>> +{
>> +	u32 offset = DCC_LL_OFFSET(drvdata->mem_map_ver) + off;
>> +
>> +	return readl(drvdata->base + ll * 0x80 + offset);
>> +}
>> +
>> +static void dcc_sram_write_auto(struct dcc_drvdata *drvdata,
>> +					u32 val, u32 *off)
>> +{
>> +	writel(val, drvdata->ram_base + *off);
>> +
>> +	*off += 4;
>> +}
>> +
>> +static int dcc_read_and_clear(struct dcc_drvdata *drvdata)
>> +{
>> +	int i;
>> +	u32 bus_status;
>> +	u32 ll_cfg;
>> +	u32 tmp_ll_cfg;
>> +
>> +	for (i = 0; i < drvdata->nr_link_list; i++) {
>> +		if (!drvdata->enable[i])
>> +			continue;
>> +
>> +		bus_status = dcc_ll_readl(drvdata, i, DCC_LL_BUS_ACCESS_STATUS);
>> +		if (!bus_status)
>> +			continue;
>> +
>> +		dev_err(drvdata->dev,
>> +			"Read access error for list %d err: 0x%x.\n", i, bus_status);
>> +		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
>> +		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
>> +		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
>> +		dcc_ll_writel(drvdata, DCC_STATUS_MASK, i,
>> +					DCC_LL_BUS_ACCESS_STATUS);
>> +		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
>> +		return -ENODATA;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
>> +{
>> +	void __iomem *addr;
>> +	int ret;
>> +	int i;
>> +	u32 ll_cfg;
>> +	u32 tmp_ll_cfg;
>> +	u32 val;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	for (i = 0; i < drvdata->nr_link_list; i++) {
>> +		if (!drvdata->enable[i])
>> +			continue;
>> +		ll_cfg = dcc_ll_readl(drvdata, i, DCC_LL_CFG);
>> +		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
>> +		dcc_ll_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
>> +		dcc_ll_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
>> +		dcc_ll_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
>> +	}
>> +
>> +	addr = drvdata->base + DCC_STATUS(drvdata->mem_map_ver);
>> +	if (readl_poll_timeout(addr, val, (FIELD_GET(DCC_STATUS_MASK, val) == 0),
>> +		1, STATUS_READY_TIMEOUT)) {
> Please align wrapped line with the open parenthesis.
Ack
>
>> +		dev_err(drvdata->dev,
>> +			"DCC is busy after receiving sw tigger.\n");
>> +		ret = -EBUSY;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = dcc_read_and_clear(drvdata);
>> +
>> +out_unlock:
>> +	mutex_unlock(&drvdata->mutex);
>> +	return ret;
>> +}
>> +
>> +static void _dcc_ll_cfg_reset_link(struct dcc_cfg_attr *cfg)
>> +{
>> +	cfg->addr = 0x00;
>> +	cfg->link = 0;
>> +	cfg->prev_off = 0;
>> +	cfg->prev_addr = cfg->addr;
>> +}
>> +
>> +static void _dcc_emit_read_write(struct dcc_drvdata *drvdata,
>> +				  struct dcc_config_entry *entry,
>> +				  struct dcc_cfg_attr *cfg)
>> +{
>> +	if (cfg->link) {
>> +		/*
>> +		 * write new offset = 1 to continue
>> +		 * processing the list
>> +		 */
>> +
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +		/* Reset link and prev_off */
>> +		_dcc_ll_cfg_reset_link(cfg);
>> +	}
>> +
>> +	cfg->addr = DCC_RD_MOD_WR_DESCRIPTOR;
>> +	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->mask, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
>> +
>> +	cfg->addr = 0;
>> +}
>> +
>> +static void _dcc_emit_loop(struct dcc_drvdata *drvdata, struct dcc_config_entry *entry,
>> +			    struct dcc_cfg_attr *cfg,
>> +			    struct dcc_cfg_loop_attr *cfg_loop,
>> +			    u32 *total_len)
>> +{
>> +	/* Check if we need to write link of prev entry */
>> +	if (cfg->link)
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +	if (cfg_loop->loop_start) {
>> +		cfg_loop->loop = (cfg->sram_offset - cfg_loop->loop_off) / 4;
>> +		cfg_loop->loop |= (cfg_loop->loop_cnt << drvdata->loopoff) &
>> +		GENMASK(DCC_ADDR_LIMIT, drvdata->loopoff);
>> +		cfg_loop->loop |= DCC_LOOP_DESCRIPTOR;
>> +		*total_len += (*total_len - cfg_loop->loop_len) * cfg_loop->loop_cnt;
>> +
>> +		dcc_sram_write_auto(drvdata, cfg_loop->loop, &cfg->sram_offset);
>> +
>> +		cfg_loop->loop_start = false;
>> +		cfg_loop->loop_len = 0;
>> +		cfg_loop->loop_off = 0;
>> +	} else {
>> +		cfg_loop->loop_start = true;
>> +		cfg_loop->loop_cnt = entry->loop_cnt - 1;
>> +		cfg_loop->loop_len = *total_len;
>> +		cfg_loop->loop_off = cfg->sram_offset;
>> +	}
>> +
>> +	/* Reset link and prev_off */
>> +	_dcc_ll_cfg_reset_link(cfg);
>> +}
>> +
>> +static void _dcc_emit_write(struct dcc_drvdata *drvdata,
>> +			     struct dcc_config_entry *entry,
>> +			     struct dcc_cfg_attr *cfg,
>> +			     u32 *total_len)
>> +{
>> +	u32 off;
>> +
>> +	if (cfg->link) {
>> +		/*
>> +		 * write new offset = 1 to continue
>> +		 * processing the list
>> +		 */
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +		/* Reset link and prev_off */
>> +		cfg->addr = 0x00;
>> +		cfg->prev_off = 0;
>> +		cfg->prev_addr = cfg->addr;
>> +	}
>> +
>> +	off = entry->offset/4;
>> +	/* write new offset-length pair to correct position */
>> +	cfg->link |= ((off & GENMASK(7, 0)) | BIT(15) | ((entry->len << 8) & GENMASK(14, 8)));
>> +	cfg->link |= DCC_LINK_DESCRIPTOR;
>> +
>> +	/* Address type */
>> +	cfg->addr = (entry->base >> 4) & GENMASK(DCC_ADDR_LIMIT, 0);
>> +	if (entry->apb_bus)
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_APB_IND;
>> +	else
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_WRITE_IND | DCC_AHB_IND;
>> +	dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +
>> +	dcc_sram_write_auto(drvdata, entry->write_val, &cfg->sram_offset);
>> +
>> +	cfg->addr = 0x00;
>> +	cfg->link = 0;
>> +}
>> +
>> +static int _dcc_emit_read(struct dcc_drvdata *drvdata,
>> +			       struct dcc_config_entry *entry,
>> +			       struct dcc_cfg_attr *cfg,
>> +			       u32 *pos, u32 *total_len)
>> +{
>> +	int ret = 0;
>> +	u32 off;
>> +	u32 temp_off;
>> +
>> +	cfg->addr = (entry->base >> 4) & GENMASK(27, 0);
>> +
>> +	if (entry->apb_bus)
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_APB_IND;
>> +	else
>> +		cfg->addr |= DCC_ADDR_DESCRIPTOR | DCC_READ_IND | DCC_AHB_IND;
>> +
>> +	off = entry->offset/4;
>> +
>> +	*total_len += entry->len * 4;
>> +
>> +	if (!cfg->prev_addr || cfg->prev_addr != cfg->addr || cfg->prev_off > off) {
>> +		/* Check if we need to write prev link entry */
>> +		if (cfg->link)
>> +			dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +		dev_dbg(drvdata->dev, "DCC: sram address 0x%x\n", cfg->sram_offset);
>> +
>> +		/* Write address */
>> +		dcc_sram_write_auto(drvdata, cfg->addr, &cfg->sram_offset);
>> +
>> +		/* Reset link and prev_off */
>> +		cfg->link = 0;
>> +		cfg->prev_off = 0;
>> +	}
>> +
>> +	if ((off - cfg->prev_off) > 0xFF || entry->len > MAX_DCC_LEN) {
>> +		dev_err(drvdata->dev, "DCC: Programming error Base: 0x%x, offset 0x%x\n",
>> +		entry->base, entry->offset);
>> +		ret = -EINVAL;
>> +		return ret;
> return -EINVAL;
Ack
>
>> +	}
>> +
>> +	if (cfg->link) {
>> +		/*
>> +		 * link already has one offset-length so new
>> +		 * offset-length needs to be placed at
>> +		 * bits [29:15]
>> +		 */
>> +		*pos = 15;
>> +
>> +		/* Clear bits [31:16] */
>> +		cfg->link &= GENMASK(14, 0);
>> +	} else {
>> +		/*
>> +		 * link is empty, so new offset-length needs
>> +		 * to be placed at bits [15:0]
>> +		 */
>> +		*pos = 0;
>> +		cfg->link = 1 << 15;
>> +	}
>> +
>> +	/* write new offset-length pair to correct position */
>> +	temp_off = (off-cfg->prev_off) & GENMASK(7, 0);
>> +	cfg->link |= temp_off |((entry->len << 8) & GENMASK(14, 8)) << *pos;
>> +
>> +	cfg->link |= DCC_LINK_DESCRIPTOR;
>> +
>> +	if (*pos) {
>> +		dcc_sram_write_auto(drvdata, cfg->link, &cfg->sram_offset);
>> +		cfg->link = 0;
>> +	}
>> +
>> +	cfg->prev_off  = off + entry->len - 1;
>> +	cfg->prev_addr = cfg->addr;
>> +	return ret;
> ret is 0 here, so return 0.
Ack
>
>> +}
>> +
>> +static int __dcc_emit_config(struct dcc_drvdata *drvdata, int curr_list)
>> +{
>> +	int ret;
>> +	u32 total_len, pos;
>> +	struct dcc_config_entry *entry;
>> +	struct dcc_cfg_attr cfg;
>> +	struct dcc_cfg_loop_attr cfg_loop;
>> +
>> +	memset(&cfg, 0, sizeof(cfg));
>> +	memset(&cfg_loop, 0, sizeof(cfg_loop));
>> +	cfg.sram_offset = drvdata->ram_cfg * 4;
>> +	total_len = 0;
>> +
>> +	list_for_each_entry(entry, &drvdata->cfg_head[curr_list], list) {
>> +		switch (entry->desc_type) {
>> +		case DCC_READ_WRITE_TYPE:
>> +			_dcc_emit_read_write(drvdata, entry, &cfg);
>> +			break;
>> +
>> +		case DCC_LOOP_TYPE:
>> +			_dcc_emit_loop(drvdata, entry, &cfg, &cfg_loop, &total_len);
>> +			break;
>> +
>> +		case DCC_WRITE_TYPE:
>> +			_dcc_emit_write(drvdata, entry, &cfg, &total_len);
>> +			break;
>> +
>> +		case DCC_READ_TYPE:
>> +			ret = _dcc_emit_read(drvdata, entry, &cfg, &pos, &total_len);
>> +			if (ret)
>> +				goto overstep;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (cfg.link)
>> +		dcc_sram_write_auto(drvdata, cfg.link, &cfg.sram_offset);
>> +
>> +	if (cfg_loop.loop_start) {
>> +		dev_err(drvdata->dev, "DCC: Programming error: Loop unterminated\n");
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	/* Handling special case of list ending with a rd_mod_wr */
>> +	if (cfg.addr == DCC_RD_MOD_WR_DESCRIPTOR) {
>> +		cfg.addr = (DCC_RD_MOD_WR_ADDR) & GENMASK(27, 0);
>> +		cfg.addr |= DCC_ADDR_DESCRIPTOR;
>> +		dcc_sram_write_auto(drvdata, cfg.addr, &cfg.sram_offset);
>> +	}
>> +
>> +	/* Setting zero to indicate end of the list */
>> +	cfg.link = DCC_LINK_DESCRIPTOR;
>> +	dcc_sram_write_auto(drvdata, cfg.link, &cfg.sram_offset);
>> +
>> +	/*Check if sram offset exceeds the ram size*/
>> +	if (cfg.sram_offset > drvdata->ram_size)
>> +		goto overstep;
>> +
>> +	/* Update ram_cfg and check if the data will overstep */
>> +	drvdata->ram_cfg = (cfg.sram_offset + total_len) / 4;
>> +
>> +	if (cfg.sram_offset + total_len > drvdata->ram_size) {
>> +		cfg.sram_offset += total_len;
>> +		goto overstep;
>> +	}
>> +
>> +	drvdata->ram_start = cfg.sram_offset/4;
>> +	return 0;
>> +overstep:
>> +	ret = -EINVAL;
>> +	memset_io(drvdata->ram_base, 0, drvdata->ram_size);
>> +
>> +err:
>> +	return ret;
>> +}
>> +
>> +static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
>> +{
>> +	u32 lock_reg;
>> +
>> +	if (list_empty(&drvdata->cfg_head[curr_list]))
>> +		return -EINVAL;
>> +
>> +	if (drvdata->enable[curr_list]) {
>> +		dev_err(drvdata->dev, "List %d is already enabled\n",
>> +				curr_list);
> Write your code to look good in 80 chars, but you may use up to 100
> chars if that looks better. So please unwrap lines like this.
Ack
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	lock_reg = dcc_ll_readl(drvdata, curr_list, DCC_LL_LOCK);
>> +	if (lock_reg & DCC_LOCK_MASK) {
>> +		dev_err(drvdata->dev, "List %d is already locked\n",
>> +				curr_list);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
>> +{
>> +	bool dcc_enable = false;
>> +	int list;
>> +
>> +	for (list = 0; list < DCC_MAX_LINK_LIST; list++) {
>> +		if (drvdata->enable[list]) {
>> +			dcc_enable = true;
> Just return true;
Ack
>
>> +			break;
>> +		}
>> +	}
>> +
>> +	return dcc_enable;
> return false;
>
> And you can drop all the {}
Ack
>
>> +}
>> +
>> +static int dcc_enable(struct dcc_drvdata *drvdata, int curr_list)
>> +{
>> +	int ret;
>> +	u32 ram_cfg_base;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	ret = dcc_valid_list(drvdata, curr_list);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	/* Fill dcc sram with the poison value.
>> +	 * This helps in understanding bus
>> +	 * hang from registers returning a zero
>> +	 */
>> +	if (!is_dcc_enabled(drvdata)) {
>> +		memset_io(drvdata->ram_base,
>> +			0xde, drvdata->ram_size);
> This isn't even 80 chars, please unwrap.
Ack
>
>> +	}
>> +
>> +	/* 1. Take ownership of the list */
>> +	dcc_ll_writel(drvdata, DCC_LOCK_MASK, curr_list, DCC_LL_LOCK);
>> +
>> +	/* 2. Program linked-list in the SRAM */
>> +	ram_cfg_base = drvdata->ram_cfg;
>> +	ret = __dcc_emit_config(drvdata, curr_list);
>> +	if (ret) {
>> +		dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_LOCK);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* 3. Program DCC_RAM_CFG reg */
>> +	dcc_ll_writel(drvdata, ram_cfg_base +
>> +			drvdata->ram_offset/4, curr_list, DCC_LL_BASE);
>> +	dcc_ll_writel(drvdata, drvdata->ram_start +
>> +			drvdata->ram_offset/4, curr_list, DCC_FD_BASE);
>> +	dcc_ll_writel(drvdata, 0xFFF, curr_list, DCC_LL_TIMEOUT);
>> +
>> +	/* 4. Clears interrupt status register */
>> +	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_INT_ENABLE);
>> +	dcc_ll_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
>> +					curr_list, DCC_LL_INT_STATUS);
>> +
>> +	drvdata->enable[curr_list] = true;
>> +
>> +	/* 5. Configure trigger */
>> +	dcc_ll_writel(drvdata, DCC_TRIGGER_MASK,
>> +					curr_list, DCC_LL_CFG);
>> +
>> +out_unlock:
>> +	mutex_unlock(&drvdata->mutex);
>> +	return ret;
>> +}
>> +
>> +static void dcc_disable(struct dcc_drvdata *drvdata, int curr_list)
>> +{
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	if (!drvdata->enable[curr_list])
>> +		goto out_unlock;
>> +	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_CFG);
>> +	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_BASE);
>> +	dcc_ll_writel(drvdata, 0, curr_list, DCC_FD_BASE);
>> +	dcc_ll_writel(drvdata, 0, curr_list, DCC_LL_LOCK);
>> +	drvdata->enable[curr_list] = false;
>> +out_unlock:
>> +	mutex_unlock(&drvdata->mutex);
>> +}
>> +
>> +static u32 dcc_filp_curr_list(struct file *filp)
>> +{
>> +	struct dentry *dentry = file_dentry(filp);
>> +	int curr_list, ret;
>> +
>> +	ret = kstrtoint(dentry->d_parent->d_name.name, 0, &curr_list);
> ret is unused.
>
> I do find the use of the d_name non-standard, wonder if there's a better
> way?

Ack.

This is the only way to access the parent directory name from the 
debugfs file hierarchy.

>
>> +	return curr_list;
>> +}
>> +
>> +static ssize_t enable_read(struct file *filp, char __user *userbuf,
>> +				size_t count, loff_t *ppos)
>> +{
>> +	int curr_list;
>> +	char *buf;
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	curr_list = dcc_filp_curr_list(filp);
> curr_list is unused after assignment?
Ack
>
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	if (is_dcc_enabled(drvdata))
>> +		buf = "Y\n";
>> +	else
>> +		buf = "N\n";
>> +
>> +	mutex_unlock(&drvdata->mutex);
>> +
>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf) + 1);
>> +}
>> +
>> +static ssize_t enable_write(struct file *filp, const char __user *userbuf,
>> +				size_t count, loff_t *ppos)
>> +{
>> +	int ret = 0, curr_list;
>> +	bool val;
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	curr_list = dcc_filp_curr_list(filp);
>> +
>> +	ret = kstrtobool_from_user(userbuf, count, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (val)
>> +		ret = dcc_enable(drvdata, curr_list);
>> +	else
>> +		dcc_disable(drvdata, curr_list);
>> +
>> +	if (!ret)
>> +		ret = count;
> Rather than relying on ret being left unmodified in the !val case, I
> would prefer that you check dcc_enable() for error and return ret there,
> and then just return count at the end.
Ack
>
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations enable_fops = {
>> +	.read = enable_read,
>> +	.write = enable_write,
>> +	.open = simple_open,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +static ssize_t trigger_write(struct file *filp,
>> +				const char __user *user_buf, size_t count,
>> +				loff_t *ppos)
>> +{
>> +	int ret = 0;
> First access is assignment.
     Ack
>
>> +	unsigned int val;
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	ret = kstrtouint_from_user(user_buf, count, 0, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (val != 1)
>> +		return -EINVAL;
>> +
>> +	ret = dcc_sw_trigger(drvdata);
>> +	if (!ret)
>> +		ret = count;
> I would prefer
>
> 	if (ret < 0)
> 		return ret;
>
> 	return count;
Ack
>
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations trigger_fops = {
>> +	.write = trigger_write,
>> +	.open = simple_open,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +static int dcc_config_add(struct dcc_drvdata *drvdata, unsigned int addr,
>> +				unsigned int len, int apb_bus, int curr_list)
>> +{
>> +	int ret = 0;
>> +	struct dcc_config_entry *entry, *pentry;
>> +	unsigned int base, offset;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	if (!len || len > drvdata->ram_size / DCC_ADDR_OFF_RANGE) {
>> +		dev_err(drvdata->dev, "DCC: Invalid length\n");
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	base = addr & DCC_ADDR_RANGE_MASK;
>> +
>> +	if (!list_empty(&drvdata->cfg_head[curr_list])) {
>> +		pentry = list_last_entry(&drvdata->cfg_head[curr_list],
>> +			struct dcc_config_entry, list);
>> +
>> +		if (pentry->desc_type == DCC_READ_TYPE &&
>> +				addr >= (pentry->base + pentry->offset) &&
>> +				addr <= (pentry->base +
>> +					pentry->offset + MAX_DCC_OFFSET)) {
>> +
>> +			/* Re-use base address from last entry */
>> +			base = pentry->base;
>> +
>> +			if ((pentry->len * 4 + pentry->base + pentry->offset)
>> +					== addr) {
>> +				len += pentry->len;
>> +
>> +				if (len > MAX_DCC_LEN)
>> +					pentry->len = MAX_DCC_LEN;
>> +				else
>> +					pentry->len = len;
>> +
>> +				addr = pentry->base + pentry->offset +
>> +					pentry->len * 4;
>> +				len -= pentry->len;
>> +			}
>> +		}
>> +	}
>> +
>> +	offset = addr - base;
>> +
>> +	while (len) {
>> +		entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
>> +		if (!entry) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		entry->base = base;
>> +		entry->offset = offset;
>> +		entry->len = min_t(u32, len, MAX_DCC_LEN);
>> +		entry->desc_type = DCC_READ_TYPE;
>> +		entry->apb_bus = apb_bus;
>> +		INIT_LIST_HEAD(&entry->list);
>> +		list_add_tail(&entry->list,
>> +			&drvdata->cfg_head[curr_list]);
>> +
>> +		len -= entry->len;
>> +		offset += MAX_DCC_LEN * 4;
>> +	}
>> +
>> +err:
> Name it "out_unlock" instead, as it's not only the error path and that
> make the unlock significant.
Ack
>
>> +	mutex_unlock(&drvdata->mutex);
>> +	return ret;
>> +}
>> +
>> +static ssize_t dcc_config_add_read(struct dcc_drvdata *drvdata, char *buf, int curr_list)
>> +{
>> +	int ret, len, nval, bus;
>> +	unsigned int base;
>> +	char apb_bus[4];
>> +
>> +	nval = sscanf(buf, "%x %i %s", &base, &len, apb_bus);
>> +	if (nval <= 0 || nval > 3)
>> +		return -EINVAL;
>> +
>> +	if (nval == 1) {
>> +		len = 1;
>> +		bus = 0;
>> +	} else if (nval == 2) {
>> +		bus = 0;
>> +	} else if (!strcmp("apb", apb_bus)) {
>> +		bus = 1;
>> +	} else if (!strcmp("ahb", apb_bus)) {
>> +		bus = 0;
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = dcc_config_add(drvdata, base, len, bus, curr_list);
>> +	return ret;
> No need for a local variable, just return dcc_config_add(...);
Ack
>
>> +
>> +}
>> +
>> +static void dcc_config_reset(struct dcc_drvdata *drvdata)
>> +{
>> +	struct dcc_config_entry *entry, *temp;
>> +	int curr_list;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
>> +		list_for_each_entry_safe(entry, temp,
>> +			&drvdata->cfg_head[curr_list], list) {
>> +			list_del(&entry->list);
>> +			devm_kfree(drvdata->dev, entry);
> You do invoke dcc_config_reset() on remove() already, so skip the devm,
> as you don't actually seem to use it.
Ack
>
>> +		}
>> +	}
>> +	drvdata->ram_start = 0;
>> +	drvdata->ram_cfg = 0;
>> +	mutex_unlock(&drvdata->mutex);
>> +}
>> +
>> +static ssize_t config_reset_write(struct file *filp,
>> +				const char __user *user_buf, size_t count,
>> +				loff_t *ppos)
>> +{
>> +	unsigned int val, ret;
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	ret = kstrtouint_from_user(user_buf, count, 0, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (val)
>> +		dcc_config_reset(drvdata);
>> +
>> +	return count;
>> +}
>> +
>> +static const struct file_operations config_reset_fops = {
>> +	.write = config_reset_write,
>> +	.open = simple_open,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +static ssize_t ready_read(struct file *filp, char __user *userbuf,
>> +			size_t count, loff_t *ppos)
>> +{
>> +	int ret = 0;
>> +	char *buf;
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	if (!is_dcc_enabled(drvdata)) {
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	if (!FIELD_GET(BIT(1), readl(drvdata->base + DCC_STATUS(drvdata->mem_map_ver))))
>> +		buf = "Y\n";
>> +	else
>> +		buf = "N\n";
>> +err:
> out_unlock:
Ack
>
>> +	mutex_unlock(&drvdata->mutex);
>> +
>> +	if (ret >= 0)
>> +		return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf) + 1);
>> +	else
>> +		return ret;
> Although this might be cleaner with just a mutex_unlock(); return
> -EINVAL; in the conditioanl above and then
>
> 	return simple_read_from_buffer();
>
> here.
>
> If not it's idiomatic to handle the error case first.
Ack
>
>> +}
>> +
>> +static const struct file_operations ready_fops = {
>> +	.read = ready_read,
>> +	.open = simple_open,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +static int dcc_add_loop(struct dcc_drvdata *drvdata, unsigned long loop_cnt, int curr_list)
>> +{
>> +	struct dcc_config_entry *entry;
>> +
>> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	entry->loop_cnt = min_t(u32, loop_cnt, MAX_LOOP_CNT);
>> +	entry->desc_type = DCC_LOOP_TYPE;
>> +	INIT_LIST_HEAD(&entry->list);
>> +	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t dcc_config_add_loop(struct dcc_drvdata *drvdata, char *buf, int curr_list)
>> +{
>> +	int ret, cnt = 2, i = 0;
>> +	char *token, *input;
>> +	char delim[2] = " ";
>> +	unsigned int val[MAX_LOOP_ADDR];
>> +
>> +	input = buf;
>> +
>> +	token = strsep(&input, delim);
>> +	while (token != NULL) {
>> +		ret = kstrtoint(token, 0, &val[i++]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		token = strsep(&input, delim);
>> +	}
>> +
>> +	ret = dcc_add_loop(drvdata, val[0], curr_list);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < val[1]; i++)
>> +		dcc_config_add(drvdata, val[cnt++], 1, 0, curr_list);
>> +
>> +	ret = dcc_add_loop(drvdata, 1, curr_list);
> return dcc_add_loop();
Ack
>
>> +
>> +	return ret;
>> +}
>> +
>> +static int dcc_rd_mod_wr_add(struct dcc_drvdata *drvdata, unsigned int mask,
>> +				unsigned int val, int curr_list)
>> +{
>> +	int ret = 0;
>> +	struct dcc_config_entry *entry;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +
>> +	if (list_empty(&drvdata->cfg_head[curr_list])) {
>> +		dev_err(drvdata->dev, "DCC: No read address programmed\n");
>> +		ret = -EPERM;
>> +		goto err;
>> +	}
>> +
>> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
>> +	if (!entry) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	entry->desc_type = DCC_READ_WRITE_TYPE;
>> +	entry->mask = mask;
>> +	entry->write_val = val;
>> +	INIT_LIST_HEAD(&entry->list);
>> +	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
>> +err:
> out_unlock:
Ack
>
>> +	mutex_unlock(&drvdata->mutex);
>> +	return ret;
>> +}
>> +
>> +static ssize_t dcc_config_add_read_write(struct dcc_drvdata *drvdata, char *buf, int curr_list)
>> +{
>> +	int ret;
>> +	int nval;
>> +	unsigned int addr, mask, val;
>> +
>> +	nval = sscanf(buf, "%x %x %x", &addr, &mask, &val);
>> +
>> +	if (nval <= 1 || nval > 3)
>> +		return -EINVAL;
>> +
>> +	ret = dcc_config_add(drvdata, addr, 1, 0, curr_list);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = dcc_rd_mod_wr_add(drvdata, mask, val, curr_list);
>> +	return ret;
> return dcc_rd_mod_wr_add()
Ack
>
>> +
>> +}
>> +
>> +static int dcc_add_write(struct dcc_drvdata *drvdata, unsigned int addr,
>> +				unsigned int write_val, int apb_bus, int curr_list)
>> +{
>> +	struct dcc_config_entry *entry;
>> +
>> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	entry->desc_type = DCC_WRITE_TYPE;
>> +	entry->base = addr & GENMASK(31, 4);
>> +	entry->offset = addr - entry->base;
>> +	entry->write_val = write_val;
>> +	entry->len = 1;
>> +	entry->apb_bus = apb_bus;
>> +	INIT_LIST_HEAD(&entry->list);
>> +	list_add_tail(&entry->list, &drvdata->cfg_head[curr_list]);
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t dcc_config_add_write(struct dcc_drvdata *drvdata, char *buf, int curr_list)
>> +{
>> +	int ret, bus;
>> +	int nval;
>> +	unsigned int addr, write_val;
>> +	char apb_bus[4];
>> +
>> +	nval = sscanf(buf, "%x %x %s", &addr, &write_val, apb_bus);
>> +
>> +	if (nval <= 1 || nval > 3)
>> +		return -EINVAL;
>> +
>> +	if (nval == 3) {
>> +		if (!strcmp("apb", apb_bus))
>> +			bus = 1;
>> +		else if (!strcmp("apb", apb_bus))
>> +			bus = 0;
>> +		else
>> +			return -EINVAL;
>> +	}
>> +
>> +	ret = dcc_add_write(drvdata, addr, write_val, bus, curr_list);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t config_read(struct file *filp, char __user *userbuf,
>> +				size_t count, loff_t *ppos)
>> +{
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +	struct dcc_config_entry *entry;
>> +	char local_buf[64], buf[100] = "\0";
>> +	int len = 0, tot_len = 0, index = 0, curr_list;
>> +
>> +	mutex_lock(&drvdata->mutex);
>> +	curr_list = dcc_filp_curr_list(filp);
>> +
>> +	list_for_each_entry(entry,
>> +	&drvdata->cfg_head[curr_list], list) {
>> +		index++;
>> +		switch (entry->desc_type) {
>> +		case DCC_READ_WRITE_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +					"Index: 0x%x, mask: 0x%x, val: 0x%x\n",
>> +					index, entry->mask, entry->write_val);
>> +			break;
>> +		case DCC_LOOP_TYPE:
>> +			len = snprintf(local_buf, 64, "Index: 0x%x, Loop: %d\n",
>> +					index, entry->loop_cnt);
>> +			break;
>> +		case DCC_WRITE_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +					"Write Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
>> +					index, entry->base, entry->offset, entry->len,
>> +					entry->apb_bus);
>> +			break;
>> +		case DCC_READ_TYPE:
>> +			len = snprintf(local_buf, 64,
>> +					"Read Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
>> +					index, entry->base, entry->offset,
>> +					entry->len, entry->apb_bus);
>> +		}
>> +		tot_len += len;
>> +		strlcat(buf, local_buf, sizeof(local_buf));
>> +	}
>> +	mutex_unlock(&drvdata->mutex);
>> +	return simple_read_from_buffer(userbuf, count, ppos, buf, tot_len);
>> +}
>> +
>> +static ssize_t config_write(struct file *filp,
>> +				const char __user *user_buf, size_t count,
>> +				loff_t *ppos)
>> +{
>> +	int ret, curr_list;
>> +	char *token, buf[50];
>> +	char *delim = " ";
>> +	struct dcc_drvdata *drvdata = filp->private_data;
>> +
>> +	ret = copy_from_user(buf, user_buf, count);
>> +	if (ret)
>> +		return -EFAULT;
>> +
>> +	curr_list = dcc_filp_curr_list(filp);
>> +
>> +	if (buf[count - 1] == '\n')
>> +		buf[count - 1] = '\0';
>> +
>> +	token = strsep((char **)&buf, delim);
>> +
>> +	if (!strcmp("R", token))
>> +		ret = dcc_config_add_read(drvdata, buf, curr_list);
>> +	else if (!strcmp("W", token))
>> +		ret = dcc_config_add_write(drvdata, buf, curr_list);
>> +	else if (!strcmp("RW", token))
>> +		ret = dcc_config_add_read_write(drvdata, buf, curr_list);
>> +	else if (!strcmp("L", token))
>> +		ret = dcc_config_add_loop(drvdata, buf, curr_list);
>> +	else {
>> +		dev_err(drvdata->dev, "%s is not a correct input\n", token);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static const struct file_operations config_fops = {
>> +	.read = config_read,
>> +	.write = config_write,
>> +	.open = simple_open,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +void dcc_delete_debug_dir(struct dcc_drvdata *dcc)
>> +{
>> +	 debugfs_remove_recursive(dcc->dbg_dir);
>> +};
>> +
>> +int dcc_create_debug_dir(struct dcc_drvdata *dcc)
>> +{
>> +	int i;
>> +	char list_num[10];
>> +	struct dentry *list;
>> +	struct device *dev = dcc->dev;
>> +
>> +	if (debugfs_initialized()) {
> I'm not able to see the purpose of this check, you should be able to
> just start calling the debugfs_create functions and let them fail if
> this is the case.
Ack
>
>> +		dcc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
>> +		if (!dcc_dbg) {
>> +			pr_err("can't create debugfs dir\n");
>> +			return -1;
>> +		}
>> +	}
> But in particular, if !debugfs_initialized() you will continue and do
> this part, why?
Ack. Will remove the initialized check.
>
>> +
>> +	dcc->dbg_dir = debugfs_create_dir(dev_name(dev), dcc_dbg);
>> +	if (!dcc->dbg_dir)
>> +		return -1;
>> +	for (i = 0; i <= dcc->nr_link_list; i++) {
>> +		sprintf(list_num, "%d", i);
>> +		list = debugfs_create_dir(list_num, dcc->dbg_dir);
>> +		debugfs_create_file("enable", 0600, list, dcc, &enable_fops);
>> +		debugfs_create_file("config", 0600, list, dcc, &config_fops);
>> +	}
>> +
>> +	debugfs_create_file("trigger", 0200, dcc->dbg_dir, dcc, &trigger_fops);
>> +	debugfs_create_file("ready", 0400, dcc->dbg_dir, dcc, &ready_fops);
>> +	debugfs_create_file("config_reset", 0200, dcc->dbg_dir,
>> +						dcc, &config_reset_fops);
>> +	return 0;
>> +
>> +}
>> +
>> +static ssize_t dcc_sram_read(struct file *file, char __user *data,
>> +						size_t len, loff_t *ppos)
>> +{
>> +	unsigned char *buf;
>> +	struct dcc_drvdata *drvdata = container_of(file->private_data,
>> +		struct dcc_drvdata,
>> +		sram_dev);
>> +
>> +	/* EOF check */
>> +	if (drvdata->ram_size <= *ppos)
> ppos is the variable and ram_size is the "constant" you're checking
> against. So I would prefer:
>
> if (*ppos > drvdata->ram_size)
Ack
>
>> +		return 0;
>> +
>> +	if ((*ppos + len) > drvdata->ram_size)
>> +		len = (drvdata->ram_size - *ppos);
>> +
>> +	buf = kzalloc(len, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
>> +
>> +	if (copy_to_user(data, buf, len)) {
>> +		kfree(buf);
>> +		return -EFAULT;
>> +	}
>> +
>> +	*ppos += len;
>> +
>> +	kfree(buf);
>> +
>> +	return len;
>> +}
>> +
>> +static const struct file_operations dcc_sram_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.read		= dcc_sram_read,
>> +	.llseek		= no_llseek,
>> +};
>> +
>> +static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
>> +{
>> +	int ret;
>> +
>> +	drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
>> +	drvdata->sram_dev.name = DCC_SRAM_NODE;
>> +	drvdata->sram_dev.fops = &dcc_sram_fops;
>> +
>> +	ret = misc_register(&drvdata->sram_dev);
>> +	return ret;
> return misc_register();
Ack
>
>> +}
>> +
>> +static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
>> +{
>> +	misc_deregister(&drvdata->sram_dev);
>> +}
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
>> +	dcc->ram_offset = (size_t) of_device_get_match_data(&pdev->dev);
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
>> +
>> +	dcc->enable = devm_kzalloc(dev, dcc->nr_link_list * size, GFP_KERNEL);
> Use devm_kcalloc() when allocating an array of things.
Ack
>
>> +	if (!dcc->enable)
>> +		return -ENOMEM;
>> +
>> +	dcc->cfg_head = (struct list_head *)(dcc->enable + dcc->nr_link_list);
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
> You need dcc_sram_dev_exit() here as well.
Ack
>
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
>> +MODULE_LICENSE("GPL v2");
> Please make this just "GPL".
>
>
> Overall, please run checkpatch.pl --strict on the patches.
Ack
>
> Thanks,
> Bjorn
