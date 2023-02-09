Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9ED69051C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBIKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBIKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:40:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8651B303;
        Thu,  9 Feb 2023 02:40:39 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319AdRaS027930;
        Thu, 9 Feb 2023 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=6t5H1NBBwfJ8HcZ4Okmv8djxDGNqAbuq+Tstxx356Gw=;
 b=pfW6x1wyQzJVXIxR1b3dM+GU/QsQsjbfg8VrYYsQ7sLQplmQ7KESWSXeX4WvD45Ddc7E
 G0MQEeAi37hGNQ+9l2S969vqtkOtZBFCTd4dJOxks3LbZk6/mHJZzxnKs7fvaQPSogbF
 GaPZzXprmJiF3drcE31DUdgOXxgEy3sVQT63uRhEuAbN+4Eet53QvS12BEjp0AqImRu8
 gfK4tf9SRyqefGT3Y4mlP/1A423pjZ8D5NOTVFax7vVQFzNw1LbYVdwub/UkPKXba5il
 w2o9DOMVyQg4OER4kcwRtnDVrX4FVDkHHAeqLwVH6rM5+ODZTZpuFYhPG0SPCublbyZ3 zQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm8x1ub5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:40:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 319Ae7lB026875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 10:40:07 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 02:39:59 -0800
Date:   Thu, 9 Feb 2023 16:09:55 +0530
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
Message-ID: <20230209103955.GJ332@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-25-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230120224627.4053418-25-quic_eberman@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gFfwHQ0MUSkxHXqstvqoV2olKdGb1RHa
X-Proofpoint-ORIG-GUID: gFfwHQ0MUSkxHXqstvqoV2olKdGb1RHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_08,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=970
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Elliot Berman <quic_eberman@quicinc.com> [2023-01-20 14:46:23]:

> +static void gh_handle_mmio_return(struct gunyah_vcpu *vcpu, u64 *state)
> +{
> +	if (!vcpu->vcpu_run->mmio.is_write)
> +		memcpy(&state[0], vcpu->vcpu_run->mmio.data, vcpu->vcpu_run->mmio.len);

Would be good to do a bound check on length of memcpy I think (in case 
vcpu_run_resp->state_data[1] is wrong for example).

> +
> +	vcpu->handle_mmio = false;
> +	vcpu->vcpu_run->exit_reason = GH_VM_EXIT_UNKNOWN;
> +}
> +

// snip

> +static int gh_vcpu_run(struct gunyah_vcpu *vcpu)
> +{
> +	struct gh_hypercall_vcpu_run_resp vcpu_run_resp;
> +	u64 state_data[3] = { 0 };
> +	int ret = 0;
> +
> +	ret = gh_vm_ensure_started(vcpu->ghvm);
> +	if (ret)
> +		return ret;

Can we move this to VM_START ioctl and avoid this check in fast path? In case VM
is not started, then I think gh_hypercall_vcpu_run() will fail which can catch
erroneous use of VCPU_RUN w/o a preceding VM_START. Alternately we could use a
flag in vcpu struct to check for this case (similar to test for vcpu->rsc
below).

// snip

> +			case GH_VCPU_STATE_EXPECTS_WAKEUP:
> +			case GH_VCPU_STATE_POWERED_OFF:
> +				ret = wait_for_completion_interruptible(&vcpu->ready);

I think we should end this wait in case immediate_exit is set as well.

> +static vm_fault_t gh_vcpu_fault(struct vm_fault *vmf)
> +{
> +	struct gunyah_vcpu *vcpu = vmf->vma->vm_file->private_data;
> +	struct page *page = NULL;
> +
> +	if (vmf->pgoff == 0)
> +		page = virt_to_page(vcpu->vcpu_run);
> +
> +	get_page(page);

We should avoid get_page in case page is NULL.

> +	vmf->page = page;
> +	return 0;
> +}
> +
> +static void gunyah_vcpu_unpopulate(struct gunyah_vm_resource_ticket *ticket,
> +				   struct gunyah_resource *ghrsc)
> +{
> +	struct gunyah_vcpu *vcpu = container_of(ticket, struct gunyah_vcpu, ticket);
> +
> +	vcpu->vcpu_run->immediate_exit = true;

We should poke the vcpu thread as well so that it can notice this.
Otherwise it can continue to be in gh_hypercall_vcpu_run() or
wait_for_completion_interruptible() for longer time to come.

> +	mutex_lock(&vcpu->run_lock);
> +	free_irq(vcpu->rsc->irq, vcpu);
> +	vcpu->rsc = NULL;
> +	mutex_unlock(&vcpu->run_lock);
> +}
> +
> +static long gunyah_vcpu_bind(struct gunyah_vm_function *f)
> +{
> +	struct gunyah_vcpu *vcpu;
> +	char name[MAX_VCPU_NAME];
> +	struct file *file;
> +	struct page *page;
> +	int fd;
> +	long r;
> +
> +	if (!gh_api_has_feature(GH_API_FEATURE_VCPU))

We should test for this feature before registering the function? What's
the point in registering a function otherwise if it can't do its work!

