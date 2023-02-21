Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8CC69E0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjBUMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjBUMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:45:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A59E8;
        Tue, 21 Feb 2023 04:45:29 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCa3mM020813;
        Tue, 21 Feb 2023 12:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=x3stg8zJRtXCGXEKmbrGIt8ho9ZieFxJLhwP/0UeaeA=;
 b=V5zVcAZDNq0vH53WmIAnNTuMqsXb3brM+lQtpDZF3RxA9k33s6rXBmYDI0Bybed+DY4M
 K8r99GaL1xJhawxLblMF2hVzEx18rN2oEb3XSQQXR5ZK/aWR+is0ghZky4o2cJwh+EoX
 gUJz7ra1HHmDwOXSWktW2lB+IgiBqF6yWHHiiDQfeTFeAnmWHFOOOMAsSRUvg3uKr1r2
 u90DedTkIHPDJqsDyN4VPZhe2znPRJ+2u3zDVd/RmnKlQ+vQ6WTwcD3eCL17J03zBsgC
 UYSckh7AmeNx5tRROqE2jGJ/R8oYiTtmFE9igHZtFt4dl8dKSyjEZXTQYXPwDlQCp2wA Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvp4v13cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:45:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LCjBjD029154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:45:11 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 04:45:04 -0800
Date:   Tue, 21 Feb 2023 18:15:00 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230221124500.GB1437176@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230214212417.3315422-1-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fFbo6RuodUEy2REFMkCBFIuWCSHvZEBC
X-Proofpoint-GUID: fFbo6RuodUEy2REFMkCBFIuWCSHvZEBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=832
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-02-14 13:24:16]:

> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +	struct gh_vm_mem *mapping, *tmp_mapping;
> +	struct gh_rm_mem_entry *mem_entries;
> +	phys_addr_t curr_page, prev_page;
> +	struct gh_rm_mem_parcel *parcel;
> +	int i, j, pinned, ret = 0;
> +	size_t entry_size;
> +	u16 vmid;
> +
> +	if (!gh_api_has_feature(GH_API_FEATURE_MEMEXTENT))
> +		return -EOPNOTSUPP;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))
> +		return -EINVAL;

Check for wraps also:

        region->guest_phys_addr + region->memory_size > region->guest_phys_addr

