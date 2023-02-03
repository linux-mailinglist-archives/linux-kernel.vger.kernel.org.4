Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1906893F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBCJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjBCJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:37:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882B9B6F7;
        Fri,  3 Feb 2023 01:37:33 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3139FqZp016986;
        Fri, 3 Feb 2023 09:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=DkWeRsx6m2sDvLrRz65hCVeFQnCd0Ddk5CBoHHoxEAU=;
 b=Ay/vxQ2b3wXqQLlZVTlHow64iviS4TOx1BHyZwRnocLP9J8sJLU8Bixp2b1SseWZPJLD
 GGP/k3hzqxZFONf907GZmlCO9cOpLh+Z5UZCzlTBXOIoxEgQmh42wcqz+1ZApYJ1WeX6
 TUMcnkD17ALjxQJ/9bsBvVgDp6tEt6nW6g8+2QcNu+8pQlHSck0nAUkWr8HDEmnEEgL2
 hMpyr5Cdhske/0YLAYpl7tY1M1l0fEthjHbQ+ZTChuT7hQWieQMMZ0JjPGAIbwDND8sY
 dzMLDg7MUUjbYdjFC4V96X3+rifc7UVJZOy27u0KmLUN3wCVzGeLo0wNLLC/bdjpxsvv JQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngahqtsgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 09:37:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3139bE7P011923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 09:37:14 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 01:37:08 -0800
Date:   Fri, 3 Feb 2023 15:07:04 +0530
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
Subject: Re: [PATCH v9 21/27] gunyah: vm_mgr: Add framework to add VM
 Functions
Message-ID: <20230203093704.GC332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-22-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-22-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dC_-8lVFVfsmcQqToeSBM2k1hEzN59H3
X-Proofpoint-GUID: dC_-8lVFVfsmcQqToeSBM2k1hEzN59H3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_05,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302030087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:20]:

> +static struct gunyah_vm_function_driver *__find_function(const char name[GUNYAH_FUNCTION_NAME_SIZE])
> +	__must_hold(functions_lock)
> +{
> +	struct gunyah_vm_function_driver *iter, *drv = NULL;
> +
> +	list_for_each_entry(iter, &functions, list) {
> +		if (!strncmp(iter->name, name, GUNYAH_FUNCTION_NAME_SIZE)) {
> +			drv = iter;
> +			break;
> +		}
> +	}

Not sure how much of a hot path this is going to sit in. I can imagine VM boot
to be in fast path for some cases (VMs spawned on usecase boundaries - I think
some VMs like in Amazon firecracker boot in fraction of a second). This
indirection could cost that a bit (linear search + strcmp for the right
function). IMHO a direct interface (ex: ADD_IOEVENTFD) will be more efficient.

> +void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *drv)
> +{
> +	struct gunyah_vm_function *f, *iter;
> +
> +	mutex_lock(&functions_lock);
> +	list_for_each_entry_safe(f, iter, &drv->instances, drv_list)
> +		gh_vm_remove_function(f);
> +	list_del(&drv->list);
> +	mutex_unlock(&functions_lock);

This seems to allow essential functions to be unregistered while there are still
active users. For example, it would allow ioeventfd or irqfd module to be
unloaded while there are VMs depending on it. I think it would be better if we
allow module unload (aka function_unregister) only after dependent VMs are stopped.

> +static long gh_vm_rm_function(struct gunyah_vm *ghvm, struct gh_vm_function *fn)
> +{
> +	long r = 0;
> +	struct gunyah_vm_function *f, *iter;
> +
> +	r = mutex_lock_interruptible(&functions_lock);
> +	if (r)
> +		return r;
> +
> +	list_for_each_entry_safe(f, iter, &ghvm->functions, vm_list) {
> +		if (!memcmp(&f->fn, fn, sizeof(*fn)))
> +			gh_vm_remove_function(f);
> +	}
> +

I think we should return some error (for ioctl atleast) if given function was
not found.

> +struct gh_vm_function {
> +	char name[GUNYAH_FUNCTION_NAME_SIZE];
> +	union {
> +		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
> +	};

Can you find a way to optimize this memory/time usage? For example, in case of
ioevents we strictly need 28 bytes, but end up consuming 1kB.
Also we end up comparing 1024 bytes during REMOVE_FUNCTION when strictly 28
bytes or fewer bytes comparison was required in case of ioeventfd.

