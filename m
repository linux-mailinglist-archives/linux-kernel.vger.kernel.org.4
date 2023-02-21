Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0F69E09E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjBUMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjBUMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:44:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06662685E;
        Tue, 21 Feb 2023 04:44:24 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L6sKh8015495;
        Tue, 21 Feb 2023 12:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=ZI8D5K709Bj5PQ8gtOgpfiSKxnJV6eRTY/NXPIqUoRI=;
 b=KrJHg0V1vYg1lS5aa4pf2m4uHK0/5Ma9nEJJHo+TAX9+IClJEcq1JWDZIgxmO+5hmtxx
 gxrfPlguhYIc2siG7cY1sn6259HqEQsfh1H/fLy2cZlK6dAbwH4TQPn6QZNPqyfEMwoH
 ku9Aa1HvF8ylSLKNv85FnTp6VpNF+WquLMR4Fl+IMNFfCj++EhiyAYXEC7oWQpWIg7/7
 18OzX/aqraNx2kLHl2YK4zNvR2fyj16V9tyxQKWOrEwMStUC1liDWtrra9pYkR3MT2x4
 otNixMqdhGpeJP/PtSnH036zuGnbl0bryDtr4ay4L3AkCvgbQxmGC2Jz0T0rhBwD2Ecq Og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvprgs2j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:44:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31LCi6Vx024049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 12:44:06 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 04:43:59 -0800
Date:   Tue, 21 Feb 2023 18:13:55 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230221124355.GA1437176@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
 <db397198-d079-faa5-691f-c4b06822d2f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <db397198-d079-faa5-691f-c4b06822d2f3@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QiGmVfkHlvR8lgLkQ7NFZOeUOPGU4RRv
X-Proofpoint-ORIG-GUID: QiGmVfkHlvR8lgLkQ7NFZOeUOPGU4RRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=390 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srinivas Kandagatla <srinivas.kandagatla@linaro.org> [2023-02-21 12:28:53]:

> > +void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
> > +	__must_hold(&ghvm->mm_lock)
> > +{
> > +	int i, ret = 0;
> > +
> > +	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
> > +		ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
> > +		if (ret)
> > +			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
> > +				mapping->parcel.label, ret);
> 
> what the behavoir of hypervisor if we failed to reclaim the pages?
> 
> > +	}
> > +
> > +	if (!ret)
> So we will leave the user pages pinned if hypervisor call fails, but further
> down we free the mapping all together.

I think we should cleanup and bail out here, rather than try continuing past the
error. For ex: imagine userspace were to reclaim with VM still running. We would
leave the pages pinned AFAICS (even after VM terminates later) and also not
return any error to userspace indicating failure to reclaim.

