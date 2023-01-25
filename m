Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7E67B366
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjAYNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjAYNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:34:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39A56EF7;
        Wed, 25 Jan 2023 05:34:53 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDQDl8019535;
        Wed, 25 Jan 2023 13:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=bVExUW5TsBTIAyHKVhS2iVtTheeV6yIVPn1bahdiUQ8=;
 b=XXmCCdoCQdD9UXAKSUXLYddVShB0WLzlE/Ij8QVvJwh47j9nQad8GjkzcsD/ELLeNCLR
 vdjp3s5HL6boHgb0ngQV1/S6srUkeCspOgpwFsFzpLk61xKY6qVoDxKo4w2SVZpc64IA
 jw9ufR9P6EAPi7wGwHJF2Jrk2CjaPgObEwfBpED5hGOX0lfjtX8s3ZBReMEDPh340Ggt
 8SLEy2xC/f8+6SYNCRbQo39PX4KDG7c82IE3rFn9Pn6Q7JvDvj+AfXwO6GEvLn1+UCf3
 Wd8+4jse/em2dr2MOVm6AMo94F3zi3A+IEQ1tOQwjam4Xaw3RjL7xvbwxqXB+F5ENO0R dQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89hk74xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 13:34:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PDYYLe000852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 13:34:34 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 05:34:28 -0800
Date:   Wed, 25 Jan 2023 19:04:24 +0530
From:   Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 13/27] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230125133424.GA332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-14-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-14-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jaB3vNnrEZlj2BcTgEhiu4QVKnZcfpEO
X-Proofpoint-ORIG-GUID: jaB3vNnrEZlj2BcTgEhiu4QVKnZcfpEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=706 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:12]:

> +	/* Check for overlap */
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +			tmp_mapping->guest_phys_addr) ||
> +			(mapping->guest_phys_addr >=
> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +	}
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);

I think the potential race condition described last time is still possible. Pls
check.

> +unlock:
> +	mutex_unlock(&ghvm->mm_lock);
> +	if (ret)
> +		goto free_mapping;
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		goto reclaim;

Same comment as last time. Can you check this error path? We seem to call
unpin_user_page() in this path, which is not correct.

> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		goto reclaim;

Same comment as above.

