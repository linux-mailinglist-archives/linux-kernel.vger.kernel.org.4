Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31BC7437A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjF3Ik0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjF3IkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:40:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF381BDB;
        Fri, 30 Jun 2023 01:40:00 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U6avW6032179;
        Fri, 30 Jun 2023 08:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=EVK7wrH/nairRxefhzxNFPVusChusvF2s4IQ96xpqQo=;
 b=Tkr8gLQbHNb9AMhyMbw8GFuuNbLL7NrTntar+prm/+dlR6G9XkS5eBf/RjhpK6FoDVTR
 SlQGXzulhQM49S4oaYWnl9+Abhr1afCvL0dqrXp1QpxxOtXH7tBbAITHSulj4593PMva
 zyXqNKSakZmp3o7QRGA3T3Xr8LiLNQ+vKwW5wa6NH5NV9LPEcv2R8o4E9xjil6pS04+r
 5VbzQNWDxo04EvKLU/KQJajP/wSrSSygVbjHMO6bsEiuv00cdJMtNvTfJsRpE45etPuh
 2wPGKMw5eekmrjeZaze8RUV0GfHho3LOgms5+deSd0DWnBJqcif8Thct+dZQCyinInCz FQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rha8e2534-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 08:39:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U8d6FZ029555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 08:39:06 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 01:38:58 -0700
Date:   Fri, 30 Jun 2023 14:08:54 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 04/21] soc: qcom: Add Qualcomm APSS minidump
 (frontend) feature support
Message-ID: <b0b78da5-eec6-4bcc-9eaf-8149e2477f18@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
 <8f00beed-f07b-43b6-820e-87af719598c6@quicinc.com>
 <774b0432-a78f-1aec-a31a-51067e33154f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <774b0432-a78f-1aec-a31a-51067e33154f@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tMYjS84mXq3GeG-H7WpbMOj0EGPoVrHG
X-Proofpoint-ORIG-GUID: tMYjS84mXq3GeG-H7WpbMOj0EGPoVrHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:45:13PM +0530, Mukesh Ojha wrote:
> > > +/**
> > > + * qcom_minidump_region_register() - Register region in APSS Minidump table.
> > > + * @region: minidump region.
> > > + *
> > > + * Return: On success, it returns 0 and negative error value on failure.
> > > + */
> > 
> > Are we not going to return any cookie upon success which can be passed
> > to us during unregistration?
> 
> e.g, Let's just say if we return the region number as an cookies, the
> problem i see that, we multiple unregistration is happening we will
> be shifting the array upwards and that results in the index/cookies does
> not retain the same for the shifted regions.
> 
> So, at the moment, client need to pass the same region for un-registration
> as they have passed for registration..
> 

From a driver user pov, there is no reason for keeping
qcom_minidump_region struct around after the registration, agree?
However, the unregistration API expects it again, so the driver needs to
cache it. The region is no way being used by the minidump core either..so it is
just there for no reason. Hence I asked this question.

Thanks for the explanation about why the region number can't be used as
cookie. Is it a limitation on the firmware that we need to left shift
all regions when a region is deleted? I ask this because
minidump_region::valid is avaialble for Linux to mark a lazy deletion.
Sure your look up would have to traverse the entire array in worst case,
but today also you are doing that for duplicate name check.
If this lazy deletion can be implemented, the region number can be used
a cookie, right?

> > 
> > > +int qcom_minidump_region_register(const struct qcom_minidump_region *region)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!qcom_minidump_valid_region(region))
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&md_lock);
> > > +	if (!md) {
> > > +		mutex_unlock(&md_lock);
> > > +		pr_err("No backend registered yet, try again..");
> > > +		return -EPROBE_DEFER;
> > > +	}
> > > +
> > > +	ret = md->ops->md_region_register(md, region);
> > > +	if (ret)
> > > +		goto unlock;
> > > +
> > 
> > The md_lock description in the beginning does not seems to be correct.
> > It is not limited to backend registration. It has much wider usage.
> > 
> > You are holding the lock while calling into backend. Basically the
> > synchronization is done in the front end.
> 
> Initially, the thought was to have the backend their own lock but that
> is irrelevant as all the contention is there in the front end.
> 
> So, used the same lock for synchronization as i moved in developement
> and the later that comment became obsolete.
> 
> Thanks for catching this.
> will fix the comment.
> 

Sure

> > 
> > > +	qcom_md_update_elf_header(region);
> > > +unlock:
> > > +	mutex_unlock(&md_lock);
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
> 
> > 
> > > +	ret = qcom_minidump_clear_header(region);
> > > +unlock:
> > > +	mutex_unlock(&md_lock);
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);
> > 
> > can we create a namespace for exporting these symbols?
> 
> Any specific reason, you are suggesting this ?
> 

My original intention was to mark qcom_minidump_backend_register()
and qcom_minidump_backend_unregister() under a namespace. Because these
are not meant for any drivers but only for minidump backend. That serves
as a clear documentation that minidump implementation is spanned across
this frontend and backend modules.

Thanks,
Pavan
