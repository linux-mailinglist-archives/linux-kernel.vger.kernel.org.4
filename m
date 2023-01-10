Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C40663A46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjAJH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:56:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9991CFE1;
        Mon,  9 Jan 2023 23:56:38 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A6nY2X021704;
        Tue, 10 Jan 2023 07:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=KeGsFur1Dd6zeJiAxPmVJInDqu0ovWNUzCzJ/sk0H5M=;
 b=OqzzNRM+gcSL5Uz9z0Lw8ODcyBzzGjV4m5SE51M6CRTgplgxK8G1IIsJxUAJixHQ0y3c
 3e9/LfdMuVgjOOWgKdvIoJAZ8j4fofMIFfX2+4RqzHBnnVY980g/810ZfqfOKYMO0qeu
 kQEXB73wejc24R9hm5fT32dVy6UvmIWTum/IE0ccsspxCjHVyyWD/hGLBESN7AyP+WX5
 /JdzQPdyELhDfcNMI4chu6xNO6d5EgXUUXRKBPe22caqXXh9s2PWr3vcbZdRlKqfSjHR
 3/YWN/5B9igjWenuR8O54MUZkAgJaaOZzM0zEQTaInWZI0b99jRswEqiWk8Ov5dF5nxy 5A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0x0jgp4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 07:56:30 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A7uTQW009686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 07:56:29 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 23:56:29 -0800
Date:   Mon, 9 Jan 2023 23:56:28 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Sibi Sankar <quic_sibis@quicinc.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V6 2/2] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20230110075628.GA2082@quicinc.com>
References: <20221208064031.2875-1-quic_sibis@quicinc.com>
 <20221208064031.2875-3-quic_sibis@quicinc.com>
 <20221208221125.bflo7unhcrgfsgbr@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208221125.bflo7unhcrgfsgbr@builder.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eWIaGJKChQ1RWHWPigh8_XAx0bprF3Kw
X-Proofpoint-ORIG-GUID: eWIaGJKChQ1RWHWPigh8_XAx0bprF3Kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 08 2022 16:11, Bjorn Andersson wrote:
> On Thu, Dec 08, 2022 at 12:10:31PM +0530, Sibi Sankar wrote:

...

> > +
> > +	err = idr_alloc_u32(&scm->waitq.idr, wq, &wq_ctx_idr,
> > +			    U32_MAX, GFP_ATOMIC);
> 
> PS. Thinking about it further, imagine the firmware people deciding to
> be funny and allocating the wq_ctx in a cyclic fashion. The idr will
> consume all your ram after a while...

Even if wq_ctx is allocated cyclically, say, from 1 to N, only N idrs would
ever be allocated as subsequently there would only be lookups. Could you
elaborate on how we would run out of RAM?

Thank you.

Guru Das.
