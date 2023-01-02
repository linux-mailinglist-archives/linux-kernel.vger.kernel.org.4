Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1265AD65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjABGOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABGOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:14:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D4A2198;
        Sun,  1 Jan 2023 22:14:06 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302595qY023075;
        Mon, 2 Jan 2023 06:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=SDQzgjhc5R340O/XO+258MgMeSVddmGE3eBiECfk4kM=;
 b=ecrdtb67HOk/sLW7Yq8aY271LQYMtFSe1EVee42srh/Jcz3W4PyMjsl+VPoJ1fEwAVyk
 w6xyCVt1jR+hsczd6fnE/ijjngIeCoHWTgwQgxsa5CBh+z7u7nohnSN8sy2ZB0XGXIFv
 n6SkSVT6wO+CRhazAeWHn9hn1iZCvV101FyT+dpJxCVNilbvub0pDx0GfBkgDoY6dNYo
 QAsvXcqBn6mvrdRUZpwJ4d9ir6Yq3siqsID01pyDYmZ6/i4GSlw7f+9g/VFiRwZM2M6Q
 /1CewnrKf3Rwd4w9ardLT5K9qBi4ApZyt5pWeoCYKupmT1qyImxTzFJXhswoLzwt3TWD XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mtecg28vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 06:13:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3026DgEW012011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Jan 2023 06:13:42 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 1 Jan 2023
 22:13:34 -0800
Date:   Mon, 2 Jan 2023 11:43:30 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 09/28] mailbox: Add Gunyah message queue mailbox
Message-ID: <20230102061330.GA1836549@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-10-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20221219225850.2397345-10-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zV24wA6ROSMieOl4ZzN1EyLV9jfPRiey
X-Proofpoint-GUID: zV24wA6ROSMieOl4ZzN1EyLV9jfPRiey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_03,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=264 lowpriorityscore=0
 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:30]:

> +static inline bool gh_msgq_has_tx(struct gh_msgq *msgq)
> +{

Consider possibility that msgq->tx_ghrc can be NULL?

> +	return msgq->tx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_TX;
> +}
> +
> +static inline bool gh_msgq_has_rx(struct gh_msgq *msgq)
> +{

Consider possibility that msgq->rx_ghrc can be NULL?

> +	return msgq->rx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_RX;
> +}
> +
> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +	struct gh_msgq_rx_data rx_data;
> +	unsigned long gh_err;
> +	ssize_t ret;
> +	bool ready = false;
> +
> +	do {
> +		gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
> +				(uintptr_t)&rx_data.data, sizeof(rx_data.data),
> +				&rx_data.length, &ready);
> +		if (gh_err == GH_ERROR_OK) {
> +			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
> +		} else if (GH_ERROR_MSGQUEUE_EMPTY) {

gh_err == GH_ERROR_MSGQUEUE_EMPTY 

> +			break;
> +		} else {
> +			pr_warn("Failed to receive data from msgq for %s: %ld\n",
> +				msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", ret);
> +			break;
> +		}
> +	} while (ready);
> +
> +	return IRQ_HANDLED;
> +}
