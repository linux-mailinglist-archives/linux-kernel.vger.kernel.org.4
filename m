Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997A6918CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjBJGy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjBJGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:54:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D19B20064;
        Thu,  9 Feb 2023 22:54:51 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A4ksLA024712;
        Fri, 10 Feb 2023 06:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=IPKsikILGiKtIOXLCRM6M9vTPDt+OJ5Hn8C5Py/YUMk=;
 b=KexBYyMi3ObszOScLNvmgkPzNm229UoK1jk0o3bnCzkxBTh9nSmL593wU98ExNkNWds4
 uZb0izCuG2qOKV1KpDqwqsENU0VIyL5a0MEBsyT12lJMWZTEW1yEGL90MCd5PLQWlqOT
 kGf3iLLFjMH4w57yvTB+eIHWb/NpmeCJntEqLnLdPjNWqITtbUX5tlMXVl5ALQGb0lMM
 wMhoPAPhbvAx5P/VSTTo+uGg7Qz+vaRbm7CGaUBRS1VAoiszH9aocICAv2V3aLc9HvZU
 Yvh0OS7gm1mCuTj5P5F2FFN0nDNAxLS/0Pw9PaSafIPjsu8OmU7cMAz2F8xNqQhh6RjU UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nn0uka3h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:54:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A6saqg009498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:54:36 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 22:54:29 -0800
Date:   Fri, 10 Feb 2023 12:24:24 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 24/27] virt: gunyah: Add proxy-scheduled vCPUs
Message-ID: <20230210065424.GK332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-25-quic_eberman@quicinc.com>
 <20230209103955.GJ332@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230209103955.GJ332@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iiX5OxnzuUHk_xCJivKsrZH5vp15QV8m
X-Proofpoint-ORIG-GUID: iiX5OxnzuUHk_xCJivKsrZH5vp15QV8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=794 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> [2023-02-09 16:10:06]:

> * Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:23]:
> 
> > +static void gh_handle_mmio_return(struct gunyah_vcpu *vcpu, u64 *state)
> > +{
> > +	if (!vcpu->vcpu_run->mmio.is_write)
> > +		memcpy(&state[0], vcpu->vcpu_run->mmio.data, vcpu->vcpu_run->mmio.len);
> 
> Would be good to do a bound check on length of memcpy I think (in case 
> vcpu_run_resp->state_data[1] is wrong for example).

Sorry I meant to comment that for the other memcpy you had!

+               memcpy(vcpu->vcpu_run->mmio.data, &vcpu_run_resp->state_data[2],
+                       vcpu_run_resp->state_data[1]);


