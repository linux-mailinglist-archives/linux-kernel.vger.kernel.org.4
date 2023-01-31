Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2968315D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAaPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjAaPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:21:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B755282;
        Tue, 31 Jan 2023 07:19:12 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEn8AB020024;
        Tue, 31 Jan 2023 15:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=bgX3jpoASPjVdzGNfq22olUT76/fsVEkQivhHSjUx3s=;
 b=ESGHJRo47GelNfdH/U+HIDc6xDFsvHUI2Mx3tloGd7vY+dOfg5R++6lk+kIJJPekE9Za
 zofMjkM7Ctff+5f2mFTz+2jDQUm9zdTxbUT/Krwc/EO9fukMgsWClaENgdCa1yyfr0VJ
 CFNTNx9L59fHvIga7Fz0D2f+5dLDS2OWKPOYs1vQCsg/VhxQV1f7oYeBIaZwuZFIMKPK
 79wNLfHW/1u5I7T1ltAx3rBoYWnsr9nyBk7LM22Pz5WPInt/ymye0Dns7wmmmvsgwW63
 tcFQamz0nrmOCl5tLmdZYTykC4bz1qMXUrHwkgtQuz1fnuV2hof5L1C4KKXYW1M8punE eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3new3u9ctv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:18:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VFIsrF016529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:18:54 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 07:18:47 -0800
Date:   Tue, 31 Jan 2023 20:48:43 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 18/27] firmware: qcom_scm: Register Gunyah platform ops
Message-ID: <20230131151843.GD4169015@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-19-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-19-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yM2P9em_0wy-BTbbA6biMq32dYVgcMLk
X-Proofpoint-ORIG-GUID: yM2P9em_0wy-BTbbA6biMq32dYVgcMLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=560
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:17]:

> +	for (i = 0; i < mem_parcel->n_mem_entries; i++) {
> +		src_cpy = src;
> +		ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, mem_parcel->n_acl_entries);
> +		if (ret) {
> +			src = 0;
> +			for (n = 0; n < mem_parcel->n_acl_entries; n++) {
> +				vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
> +				if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
> +					src |= (1ull << vmid);
> +				else
> +					src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
> +			}
> +
> +			new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
> +
> +			for (i--; i >= 0; i--) {
> +				src_cpy = src;
> +				ret = qcom_scm_assign_mem(
> +						le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
> +						le64_to_cpu(mem_parcel->mem_entries[i].size),
> +						&src_cpy, new_perms, 1);
> +				WARN_ON_ONCE(ret);
> +			}

We would be returning 0 incorrectly here, indicating success.

> @@ -1414,6 +1511,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (download_mode)
>  		qcom_scm_set_download_mode(true);
>  
> +	if (gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops))
> +		dev_warn(__scm->dev, "Gunyah RM platform ops were already registered\n");
> +

We should remove above registration in qcom_scm_shutdown.


