Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9C613E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJaTZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJaTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:25:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578D13DF1;
        Mon, 31 Oct 2022 12:25:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VIsrZV003836;
        Mon, 31 Oct 2022 19:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Pc5EVDHtm6VBnIfyigRm+fWGfdtfPod7VeY/RMb84xE=;
 b=F0t1bGMh6JtUc3m13A5ca3En/svens7pzbZFwWpUCIGDUiOxTs+Oo4ZW4qDu0lqmHbFg
 PRft0fto0ZI1KJVxEG8Q3oR/2eIlnyraKC5u+P7qVn7UJP6V02vF4plkxllhCLf5wNeh
 ifQVOjQhUDIy9kZZLu+MZjYXGF9x5PzE9ZPCSwTymWFy8UFzCuq6DlEPq+8DNQVTMdMQ
 7aCNJmQBLFUBip5iWKBfjbnXqWcLdaWX9Dt/m+2EYChcPvu/B5lnPahQd5UkTPKTJz6+
 9ZnsMiibpD7pUtAr5hjDouXQvN7d3pwNCDIKnkCnS4n5lo8OvL8/FGNYPfrY1sTr6UJb RA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kj7tx2k17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:24:37 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29VJOaZD015939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:24:36 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 31 Oct 2022 12:24:35 -0700
Date:   Mon, 31 Oct 2022 12:24:35 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <eddie.huang@mediatek.com>, <daejun7.park@samsung.com>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Message-ID: <20221031192435.GD9077@asutoshd-linux1.qualcomm.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
 <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eoCIszkxZxLc1tUxvwMHzAOSyAR5E8eE
X-Proofpoint-GUID: eoCIszkxZxLc1tUxvwMHzAOSyAR5E8eE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27 2022 at 14:52 -0700, Bart Van Assche wrote:
>On 10/20/22 11:03, Asutosh Das wrote:
>>+u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
>>+{
>>+	u32 qd, val;
>>+	int mac;
>>+
>>+	mac = ufshcd_mcq_vops_get_hba_mac(hba);
>>+	if (mac < 0) {
>>+		val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>>+		mac = FIELD_GET(MCQ_CFG_MAC_MASK, val);
>>+	}
>
>According to the UFSHCI 4.0 specification the MAC value is set by the 
>host. Can the above code read the MAC value from the host controller 
>before it has been set by the host? If so, how about leaving out the 
>code that reads the MAC value from the controller and making it 
>mandatory to implement the new get_hba_mac vop?
>
The reason it is not mandatory to define get_hba_mac vop is UFSHCI 4.0
specification mentions that the default value of MAC is 32. So even if a vendor
HC doesn't override the MAC, it'd be 32.
Hence, the current code first checks for an override, and if there's none uses
the default value defined in the HC.

-asd
