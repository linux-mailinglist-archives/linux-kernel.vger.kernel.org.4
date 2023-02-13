Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA066693F58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBMILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:11:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347AEC54;
        Mon, 13 Feb 2023 00:11:43 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5Ki0N021659;
        Mon, 13 Feb 2023 08:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=Z6gmndh7hn35T25vfiaxGtwhAK87i7V4DUFpij/Ezfk=;
 b=oTo65ptqbe5EtAw+hvPnc9jYCbtZlKcApP5zq1QoMIUgEhy+CXkqiPRIPlhspcHkKkn7
 UN8HlI+SzFYddcLh1KNOz4wjWQ9mZb3OjskZhuNSa/OPRKpa8nyM8ADAnO9ecNHU9ZWD
 bNxtHS3AaztiWFNMBRF5pvhWXhlMb6SxXdBYcNHJ//kJDVZc5I06zeP6ntQZhRrBFFbj
 C4FZzvAjxFS4JmYXORN2EN8ovVni7wSpX4MHzK4ksspP4eOBbH7fJ7Q+hyQmFId3eVI5
 8Z+5ontMK1ltXsWspwdSXnalP2XhQ3XqK27C8EF8w7cH7JnSTtrRjByu5HEUHIMRFaLd 6A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3deujgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:11:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31D8BE0w006582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:11:14 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 00:11:07 -0800
Date:   Mon, 13 Feb 2023 13:41:03 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 26/27] virt: gunyah: Add irqfd interface
Message-ID: <20230213081103.GL332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-27-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-27-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FYSiYlOz-rpXG8-Xzk1DuHHq665gAgG8
X-Proofpoint-ORIG-GUID: FYSiYlOz-rpXG8-Xzk1DuHHq665gAgG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 mlxlogscore=574 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:25]:

> +static int gunyah_irqfd_populate(struct gunyah_vm_resource_ticket *ticket,
> +				struct gunyah_resource *ghrsc)
> +{
> +	struct gunyah_irqfd *irqfd = container_of(ticket, struct gunyah_irqfd, ticket);
> +	u64 enable_mask = GH_DBL_NONBLOCK;
> +	u64 ack_mask = ~0;
> +	int ret = 0;
> +
> +	irqfd->ghrsc = ghrsc;
> +	if (irqfd->level) {
> +		ret = gh_hypercall_dbl_set_mask(irqfd->ghrsc->capid, enable_mask, ack_mask);

We probably want this mask set for both level and edge interrupts.

> +		if (ret)
> +			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
> +				irqfd->f->fn.irqfd.label);
> +	}
> +	kref_get(&irqfd->kref);

Is this kref_get() really needed?

> +
> +	return 0;
> +}
> +
