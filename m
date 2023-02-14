Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DE6971A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjBNXPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBNXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:15:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97208BDF5;
        Tue, 14 Feb 2023 15:15:10 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ELZAio011740;
        Tue, 14 Feb 2023 23:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PY46CT//dOiCqTTbBZOR9YIkaySHdCfy2tkkK2ApC/8=;
 b=eX6+dEWeZLdlAD1Zy8w2YrjVDavTmYvllfUTS60TRgHfF+MJi5gZpbm7DnIh3rJQHKwU
 ForwkjaU8S0FwaQXD0FqRwE3l8OnZtkQtEUJnze6U+43eZgVXm0qdLY4dvleJBPAHryQ
 bBJqdCdADWIssdYqjsVTt2Zw+6EXMuk70wAPifoUgLp7GGDMly1Bq01TP8ACvY4KtYHv
 WyWtzFlPgYFcoZ5d6j7PrPpTVJTZlr0fi0gYLWAoiZ5A8oGAXrZ48wdMAW6dgzH3c0MK
 JjhY5vIs+TuJwtJFoxhcyGbca+Kn4Lknw+OptRTNOwTimEPfCHOvG3/lPnjMHAIxUBYf zA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps26hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:15:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ENF65w021631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:15:06 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 15:15:06 -0800
Subject: Re: [PATCH] rpmsg: glink: Fix GLINK command prefix
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230214225933.2025595-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
Message-ID: <bffc0284-0a61-1292-c8be-da5eae675e7b@quicinc.com>
Date:   Tue, 14 Feb 2023 15:15:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230214225933.2025595-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: adqWagLqSNrZ2IdYE2-ugnB7H1Ws_oNC
X-Proofpoint-GUID: adqWagLqSNrZ2IdYE2-ugnB7H1Ws_oNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140200
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 2:59 PM, Bjorn Andersson wrote:
> The upstream GLINK driver was first introduced to communicate with the
> RPM on MSM8996, presumably as an artifact from that era the command
> defines was prefixed RPM_CMD, while they actually are GLINK_CMDs.
> 
> Let's rename these, to keep things tidy. No functional change.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

> ---
>   drivers/rpmsg/qcom_glink_native.c | 98 +++++++++++++++----------------
>   1 file changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 7a3cac62ecfa..89c3381f06c3 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -183,20 +183,20 @@ struct glink_channel {
>   
>   static const struct rpmsg_endpoint_ops glink_endpoint_ops;
>   
> -#define RPM_CMD_VERSION			0
> -#define RPM_CMD_VERSION_ACK		1
> -#define RPM_CMD_OPEN			2
> -#define RPM_CMD_CLOSE			3
> -#define RPM_CMD_OPEN_ACK		4
> -#define RPM_CMD_INTENT			5
> -#define RPM_CMD_RX_DONE			6
> -#define RPM_CMD_RX_INTENT_REQ		7
> -#define RPM_CMD_RX_INTENT_REQ_ACK	8
> -#define RPM_CMD_TX_DATA			9
> -#define RPM_CMD_CLOSE_ACK		11
> -#define RPM_CMD_TX_DATA_CONT		12
> -#define RPM_CMD_READ_NOTIF		13
> -#define RPM_CMD_RX_DONE_W_REUSE		14
> +#define GLINK_CMD_VERSION		0
> +#define GLINK_CMD_VERSION_ACK		1
> +#define GLINK_CMD_OPEN			2
> +#define GLINK_CMD_CLOSE			3
> +#define GLINK_CMD_OPEN_ACK		4
> +#define GLINK_CMD_INTENT		5
> +#define GLINK_CMD_RX_DONE		6
> +#define GLINK_CMD_RX_INTENT_REQ		7
> +#define GLINK_CMD_RX_INTENT_REQ_ACK	8
> +#define GLINK_CMD_TX_DATA		9
> +#define GLINK_CMD_CLOSE_ACK		11
> +#define GLINK_CMD_TX_DATA_CONT		12
> +#define GLINK_CMD_READ_NOTIF		13
> +#define GLINK_CMD_RX_DONE_W_REUSE	14
>   
>   #define GLINK_FEATURE_INTENTLESS	BIT(1)
>   
> @@ -306,7 +306,7 @@ static void qcom_glink_send_read_notify(struct qcom_glink *glink)
>   {
>   	struct glink_msg msg;
>   
> -	msg.cmd = cpu_to_le16(RPM_CMD_READ_NOTIF);
> +	msg.cmd = cpu_to_le16(GLINK_CMD_READ_NOTIF);
>   	msg.param1 = 0;
>   	msg.param2 = 0;
>   
> @@ -375,7 +375,7 @@ static int qcom_glink_send_version(struct qcom_glink *glink)
>   {
>   	struct glink_msg msg;
>   
> -	msg.cmd = cpu_to_le16(RPM_CMD_VERSION);
> +	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION);
>   	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
>   	msg.param2 = cpu_to_le32(glink->features);
>   
> @@ -386,7 +386,7 @@ static void qcom_glink_send_version_ack(struct qcom_glink *glink)
>   {
>   	struct glink_msg msg;
>   
> -	msg.cmd = cpu_to_le16(RPM_CMD_VERSION_ACK);
> +	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION_ACK);
>   	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
>   	msg.param2 = cpu_to_le32(glink->features);
>   
> @@ -398,7 +398,7 @@ static void qcom_glink_send_open_ack(struct qcom_glink *glink,
>   {
>   	struct glink_msg msg;
>   
> -	msg.cmd = cpu_to_le16(RPM_CMD_OPEN_ACK);
> +	msg.cmd = cpu_to_le16(GLINK_CMD_OPEN_ACK);
>   	msg.param1 = cpu_to_le16(channel->rcid);
>   	msg.param2 = cpu_to_le32(0);
>   
> @@ -430,11 +430,11 @@ static void qcom_glink_intent_req_abort(struct glink_channel *channel)
>   }
>   
>   /**
> - * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
> + * qcom_glink_send_open_req() - send a GLINK_CMD_OPEN request to the remote
>    * @glink: Ptr to the glink edge
>    * @channel: Ptr to the channel that the open req is sent
>    *
> - * Allocates a local channel id and sends a RPM_CMD_OPEN message to the remote.
> + * Allocates a local channel id and sends a GLINK_CMD_OPEN message to the remote.
>    * Will return with refcount held, regardless of outcome.
>    *
>    * Return: 0 on success, negative errno otherwise.
> @@ -463,7 +463,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>   
>   	channel->lcid = ret;
>   
> -	req.msg.cmd = cpu_to_le16(RPM_CMD_OPEN);
> +	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
>   	req.msg.param1 = cpu_to_le16(channel->lcid);
>   	req.msg.param2 = cpu_to_le32(name_len);
>   	strcpy(req.name, channel->name);
> @@ -488,7 +488,7 @@ static void qcom_glink_send_close_req(struct qcom_glink *glink,
>   {
>   	struct glink_msg req;
>   
> -	req.cmd = cpu_to_le16(RPM_CMD_CLOSE);
> +	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE);
>   	req.param1 = cpu_to_le16(channel->lcid);
>   	req.param2 = 0;
>   
> @@ -500,7 +500,7 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
>   {
>   	struct glink_msg req;
>   
> -	req.cmd = cpu_to_le16(RPM_CMD_CLOSE_ACK);
> +	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE_ACK);
>   	req.param1 = cpu_to_le16(rcid);
>   	req.param2 = 0;
>   
> @@ -531,7 +531,7 @@ static void qcom_glink_rx_done_work(struct work_struct *work)
>   		iid = intent->id;
>   		reuse = intent->reuse;
>   
> -		cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
> +		cmd.id = reuse ? GLINK_CMD_RX_DONE_W_REUSE : GLINK_CMD_RX_DONE;
>   		cmd.lcid = cid;
>   		cmd.liid = iid;
>   
> @@ -643,7 +643,7 @@ static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
>   {
>   	struct glink_msg msg;
>   
> -	msg.cmd = cpu_to_le16(RPM_CMD_RX_INTENT_REQ_ACK);
> +	msg.cmd = cpu_to_le16(GLINK_CMD_RX_INTENT_REQ_ACK);
>   	msg.param1 = cpu_to_le16(channel->lcid);
>   	msg.param2 = cpu_to_le32(granted);
>   
> @@ -674,7 +674,7 @@ static int qcom_glink_advertise_intent(struct qcom_glink *glink,
>   	} __packed;
>   	struct command cmd;
>   
> -	cmd.id = cpu_to_le16(RPM_CMD_INTENT);
> +	cmd.id = cpu_to_le16(GLINK_CMD_INTENT);
>   	cmd.lcid = cpu_to_le16(channel->lcid);
>   	cmd.count = cpu_to_le32(1);
>   	cmd.size = cpu_to_le32(intent->size);
> @@ -1037,40 +1037,40 @@ void qcom_glink_native_rx(struct qcom_glink *glink)
>   		param2 = le32_to_cpu(msg.param2);
>   
>   		switch (cmd) {
> -		case RPM_CMD_VERSION:
> -		case RPM_CMD_VERSION_ACK:
> -		case RPM_CMD_CLOSE:
> -		case RPM_CMD_CLOSE_ACK:
> -		case RPM_CMD_RX_INTENT_REQ:
> +		case GLINK_CMD_VERSION:
> +		case GLINK_CMD_VERSION_ACK:
> +		case GLINK_CMD_CLOSE:
> +		case GLINK_CMD_CLOSE_ACK:
> +		case GLINK_CMD_RX_INTENT_REQ:
>   			ret = qcom_glink_rx_defer(glink, 0);
>   			break;
> -		case RPM_CMD_OPEN_ACK:
> +		case GLINK_CMD_OPEN_ACK:
>   			ret = qcom_glink_rx_open_ack(glink, param1);
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			break;
> -		case RPM_CMD_OPEN:
> +		case GLINK_CMD_OPEN:
>   			ret = qcom_glink_rx_defer(glink, param2);
>   			break;
> -		case RPM_CMD_TX_DATA:
> -		case RPM_CMD_TX_DATA_CONT:
> +		case GLINK_CMD_TX_DATA:
> +		case GLINK_CMD_TX_DATA_CONT:
>   			ret = qcom_glink_rx_data(glink, avail);
>   			break;
> -		case RPM_CMD_READ_NOTIF:
> +		case GLINK_CMD_READ_NOTIF:
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			qcom_glink_tx_kick(glink);
>   			break;
> -		case RPM_CMD_INTENT:
> +		case GLINK_CMD_INTENT:
>   			qcom_glink_handle_intent(glink, param1, param2, avail);
>   			break;
> -		case RPM_CMD_RX_DONE:
> +		case GLINK_CMD_RX_DONE:
>   			qcom_glink_handle_rx_done(glink, param1, param2, false);
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			break;
> -		case RPM_CMD_RX_DONE_W_REUSE:
> +		case GLINK_CMD_RX_DONE_W_REUSE:
>   			qcom_glink_handle_rx_done(glink, param1, param2, true);
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			break;
> -		case RPM_CMD_RX_INTENT_REQ_ACK:
> +		case GLINK_CMD_RX_INTENT_REQ_ACK:
>   			qcom_glink_handle_intent_req_ack(glink, param1, param2);
>   			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
>   			break;
> @@ -1272,7 +1272,7 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
>   
>   	reinit_completion(&channel->intent_req_comp);
>   
> -	cmd.id = RPM_CMD_RX_INTENT_REQ;
> +	cmd.id = GLINK_CMD_RX_INTENT_REQ;
>   	cmd.cid = channel->lcid;
>   	cmd.size = size;
>   
> @@ -1346,7 +1346,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   		chunk_size = SZ_8K;
>   		left_size = len - chunk_size;
>   	}
> -	req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA);
> +	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
>   	req.msg.param1 = cpu_to_le16(channel->lcid);
>   	req.msg.param2 = cpu_to_le32(iid);
>   	req.chunk_size = cpu_to_le32(chunk_size);
> @@ -1367,7 +1367,7 @@ static int __qcom_glink_send(struct glink_channel *channel,
>   			chunk_size = SZ_8K;
>   		left_size -= chunk_size;
>   
> -		req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA_CONT);
> +		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
>   		req.msg.param1 = cpu_to_le16(channel->lcid);
>   		req.msg.param2 = cpu_to_le32(iid);
>   		req.chunk_size = cpu_to_le32(chunk_size);
> @@ -1631,22 +1631,22 @@ static void qcom_glink_work(struct work_struct *work)
>   		param2 = le32_to_cpu(msg->param2);
>   
>   		switch (cmd) {
> -		case RPM_CMD_VERSION:
> +		case GLINK_CMD_VERSION:
>   			qcom_glink_receive_version(glink, param1, param2);
>   			break;
> -		case RPM_CMD_VERSION_ACK:
> +		case GLINK_CMD_VERSION_ACK:
>   			qcom_glink_receive_version_ack(glink, param1, param2);
>   			break;
> -		case RPM_CMD_OPEN:
> +		case GLINK_CMD_OPEN:
>   			qcom_glink_rx_open(glink, param1, msg->data);
>   			break;
> -		case RPM_CMD_CLOSE:
> +		case GLINK_CMD_CLOSE:
>   			qcom_glink_rx_close(glink, param1);
>   			break;
> -		case RPM_CMD_CLOSE_ACK:
> +		case GLINK_CMD_CLOSE_ACK:
>   			qcom_glink_rx_close_ack(glink, param1);
>   			break;
> -		case RPM_CMD_RX_INTENT_REQ:
> +		case GLINK_CMD_RX_INTENT_REQ:
>   			qcom_glink_handle_intent_req(glink, param1, param2);
>   			break;
>   		default:
> 
