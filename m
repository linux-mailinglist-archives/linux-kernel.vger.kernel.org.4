Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C66A246F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBXWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:46:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000256F838;
        Fri, 24 Feb 2023 14:46:22 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OELEDI014331;
        Fri, 24 Feb 2023 22:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Tp3wP6028yx/5Hb9vbmKHmruAPTEZ6VePo+dfzf25Yk=;
 b=FBF6NrKDil13Kce50gNsVr77uNiBwYlGZNggGRLICMTIaHF/ITRE2GA4PL/mUdUsfDzX
 6YLp+5FUm8/hFJvFrREtORFN1qOjnMqr28wTxu+Od1skWxB+P7GQonoGB2CI/19xAKbx
 KsJoyKfvCjJt1OhiT8aoH3R9yOtOtT2SujMuNuCrqZt9CraKWWDDPNdMvoUSudrFRYbg
 fd5I+BFrI3W7766Ou3Y3DY1BZzGfu32Ad67Jii9B9/Qt1Ul5qnvQvJIXt1BwykNrSj+L
 zZj8RpdMlC5Ces/x9wiQUqQuqKYdGfq9aljrpaD3QOl3gN1U3DJ4v5YgGK/Wrm17sQNW Dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxsxr27ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:45:15 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OMj6wS015669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:45:06 GMT
Received: from [10.110.32.28] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 14:45:05 -0800
Message-ID: <c22a7d59-e14c-a039-3488-fea2686a88b3@quicinc.com>
Date:   Fri, 24 Feb 2023 14:45:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] remoteproc: core: Export the rproc coredump APIs
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <20230224211707.30916-1-quic_gokukris@quicinc.com>
 <20230224211707.30916-2-quic_gokukris@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230224211707.30916-2-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wmKaKgunR9KvKjIpBV24lJAivQbV__Jo
X-Proofpoint-ORIG-GUID: wmKaKgunR9KvKjIpBV24lJAivQbV__Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=610 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240183
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2023 1:17 PM, Gokul krishna Krishnakumar wrote:
> From: Siddharth Gupta <sidgup@codeaurora.org>

Is it possible to change the From to your email ID, since we know that 
sidgup@codeaurora.org no longer works including there is no longer 
sidgup in Qualcomm. You don't have to CC sidgup@codeaurora.org since it 
will only bounce.

> 
> The remoteproc coredump APIs are currently only part of the internal
> remoteproc header. This prevents the remoteproc platform drivers from
> using these APIs when needed. This change moves the rproc_coredump()
> and rproc_coredump_cleanup() APIs to the linux header and marks them
> as exported symbols.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>

We can keep it here, if others are fine.

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>

---Trilok Soni
