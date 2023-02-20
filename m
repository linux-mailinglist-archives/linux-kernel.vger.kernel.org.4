Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA469C80C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBTJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBTJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:55:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C83B475;
        Mon, 20 Feb 2023 01:55:13 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5kGWl014593;
        Mon, 20 Feb 2023 09:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : reply-to : references : mime-version :
 content-type : in-reply-to; s=qcppdkim1;
 bh=ybKhwuDmZUHTj/uqJj1khzGF3Icxc2G5a4I1bJt4+xE=;
 b=XezZBHDh2SqPH7SJ4RKr5TC662RnebwnclVGhXUUnvVJfQVUf5eW+to+ir3n+70G4xJB
 HVM6xCKXsAWh1Wnd5Ggnwuc3cBCLQ5NHxlGcwNpcUDKGF+K3o71+LsGfobGrXfOL6RnS
 mZjfQ+lOLjPBrpUyfAEHLHpuqKiyq8s8UpCTdXrj2Y0yc/TPHYef08pa4KflVw+ynoeo
 jBMTC1AhdIrIw0P9eUU+sMIXeysEQhUVpI6HQzT1HC7pGBys10IVI7Cbyix3lWkfc5FS
 W0Wrpn0/lykgXfBEavbIDxFXCgnK6cTBu78nkY2iodg8yuoApQg9QCoToTp8gDTWOQSA 9g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntps1cs5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 09:54:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31K9srmV007829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 09:54:53 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 01:54:46 -0800
Date:   Mon, 20 Feb 2023 15:24:42 +0530
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
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Message-ID: <20230220095442.GA787573@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
 <20230220091544.GN332@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20230220091544.GN332@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nIAT3YKYaTsYJ007_yxNIrl1-W2BHIgb
X-Proofpoint-ORIG-GUID: nIAT3YKYaTsYJ007_yxNIrl1-W2BHIgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_07,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> [2023-02-20 14:45:55]:

> * Elliot Berman <quic_eberman@quicinc.com> [2023-02-14 13:24:26]:
> 
> >  static void gh_vm_free(struct work_struct *work)
> >  {
> >  	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
> >  	struct gh_vm_mem *mapping, *tmp;
> >  	int ret;
> >  
> > -	mutex_lock(&ghvm->mm_lock);
> > -	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> > -		gh_vm_mem_reclaim(ghvm, mapping);
> > -		kfree(mapping);
> > +	switch (ghvm->vm_status) {
> > +unknown_state:
> > +	case GH_RM_VM_STATUS_RUNNING:
> > +		gh_vm_stop(ghvm);
> > +		fallthrough;
> > +	case GH_RM_VM_STATUS_INIT_FAILED:
> > +	case GH_RM_VM_STATUS_LOAD:
> > +	case GH_RM_VM_STATUS_LOAD_FAILED:
> > +		mutex_lock(&ghvm->mm_lock);
> > +		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> > +			gh_vm_mem_reclaim(ghvm, mapping);
> > +			kfree(mapping);
> > +		}
> > +		mutex_unlock(&ghvm->mm_lock);
> > +		fallthrough;
> > +	case GH_RM_VM_STATUS_NO_STATE:
> > +		ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> > +		if (ret)
> > +			pr_warn("Failed to deallocate vmid: %d\n", ret);
> > +
> > +		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
> > +		put_gh_rm(ghvm->rm);
> > +		kfree(ghvm);
> > +		break;
> > +	default:
> > +		pr_err("VM is unknown state: %d, assuming it's running.\n", ghvm->vm_status);
> > +		goto unknown_state;
> 
> 'goto unknown_state' here leads to a infinite loop AFAICS. For example consider
> the case  where VM_START failed (due to mem_lend operation) causing VM state to
> be GH_RM_VM_STATUS_RESET. A subsequent close(vmfd) can leads to that forever
> loop.

Hmm ..that's not a good example perhaps (VM state is set to
GH_RM_VM_STATUS_INIT_FAILED in failed case). Nevertheless I think we should
avoid the goto in case of unknown state.


- vatsa
