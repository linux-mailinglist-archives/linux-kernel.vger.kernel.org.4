Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623FE662115
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjAIJLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjAIJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:10:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624516495;
        Mon,  9 Jan 2023 01:06:24 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3097r7Cv001816;
        Mon, 9 Jan 2023 09:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=XxHuIQPh1jtnEpxWMwNDr1Y0CAe06b1+6mK5HGVQu5w=;
 b=EVgqWEiYLZ3+ztYFCe27IWCHuT6TjM9JoUdIhwAU1VzVPhez43C14F9ngot+0olMkFlp
 11/AomqEJjq7b5aD5hOrz0cFkggHfD8AszKSDeitiFf/WjIRK31xKtXVzxInYAly8R12
 xXYNx9XuAXRGc+Y/AwcwW5rqDaIfVB9AMLi9AVzWOJpEHX0RHxzJ4ynfh5eiX3u/96l6
 7TuWrwY0eh3NsUMWQGSJ1pe/D4zjJE9n8oubKB5Wt/aR8G9lYTiQlKVAIG9VdT8ELW8j
 vV/pktMaZjxTzEg3qZoRzedPpqrX3o5gzNGHA1GSQN8nT2/ba+ouPnrzZrYxKMadFYEP fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my02t2q55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 09:06:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309965Gk021644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 09:06:05 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 01:05:57 -0800
Date:   Mon, 9 Jan 2023 14:35:53 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v8 12/28] gunyah: vm_mgr: Introduce basic VM Manager
Message-ID: <20230109090553.GA1737564@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-13-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20221219225850.2397345-13-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AykUCM4ocXnB41CGW_xT6GSACgEI0PMz
X-Proofpoint-ORIG-GUID: AykUCM4ocXnB41CGW_xT6GSACgEI0PMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=794 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090064
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2022-12-19 14:58:33]:

> +config GUNYAH_VM_MANAGER

Any reason why this needs to be a separate config? IOW CONFIG_GUNYAH should
enable VM management functionality also.

> @@ -550,14 +580,29 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>  	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>  	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
>  
> -	return gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
> +	ret = gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
>  				&rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);

Bail on error here.

[snip]

> +static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
> +{
> +	struct gunyah_vm *ghvm;
> +	int vmid;
> +
> +	vmid = gh_rm_alloc_vmid(rm, 0);
> +	if (vmid < 0)
> +		return ERR_PTR(vmid);
> +
> +	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
> +	if (!ghvm)

dealloc_vmid here (as well as few other error paths)?

> +		return ghvm;
> +
> +	get_gh_rm(rm);
