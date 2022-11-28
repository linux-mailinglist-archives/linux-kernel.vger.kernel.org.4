Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49A63B49E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiK1WJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiK1WJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:09:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCA12ADD;
        Mon, 28 Nov 2022 14:09:09 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASLncBZ009470;
        Mon, 28 Nov 2022 22:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ex+ncKEY18pAXv2/qYed/5grZw0sHWMRXFKVs+Oy0TY=;
 b=BH6Z6PHGwLk2MpV2Gx0GECOh9KH9shGLIu/z8i2i5Fmld3cOXCgIQHA1pTql7KQICZkQ
 4jSn3Wfe02ZYIruydohS48rwbVjbrquRw8qFsITmO0Nn548cHB63fjhEFIMPM715GIIs
 fyYEHwxzdMtGK5sxo32Klsg9H3ZZeP2WLF2o1N4KE0spRbi8EcmIQ2Tmv2dNTh2coaQi
 QXP1KetFQH4HpGo2V11LBN3cAhaFCPmE6OQzyQRCMTsVp8m8lNpbvycki3rPCzZvd151
 ZS0WQxga9CjV0yUSswyaPFU6kM+BPNIt4HH/ojUmLBMtK9yVquf4jhB4twM7PmXz3/Gh yQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3ad956dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 22:08:44 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ASM8gBE019878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 22:08:42 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 14:08:42 -0800
Date:   Mon, 28 Nov 2022 14:08:42 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <eddie.huang@mediatek.com>, <daejun7.park@samsung.com>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/16] ufs: core: mcq: Configure operation and runtime
 interface
Message-ID: <20221128220842.GE20677@asutoshd-linux1.qualcomm.com>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <52b1525a4d680999687a1f0721ea60fd4cec9eb8.1669176158.git.quic_asutoshd@quicinc.com>
 <ef519087-c302-3547-1419-2dcddfb4c646@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ef519087-c302-3547-1419-2dcddfb4c646@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7PpRT2Wfr4TR0fMj5dfR4lG0gZnGle7O
X-Proofpoint-GUID: 7PpRT2Wfr4TR0fMj5dfR4lG0gZnGle7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211280159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25 2022 at 17:28 -0800, Bart Van Assche wrote:
>On 11/22/22 20:10, Asutosh Das wrote:
>>+static void ufshcd_config_mcq(struct ufs_hba *hba)
>>+{
>>+	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
>>+	ufshcd_mcq_make_queues_operational(hba);
>>+	ufshcd_mcq_config_mac(hba, hba->nutrs);
>>+
>>+	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
>>+	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
>>+	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
>>+		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
>>+		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
>>+		 hba->nutrs);
>>+}
>
Hello Bart,

>Please do not reserve a slot for device commands in MCQ mode but 
>instead queue device management commands on the device management 
>command queue in MCQ mode. Please also add WARN_ON_ONCE() statements 
>in the code that uses hba->reserved_slot to make sure that that 
>variable is not used in MCQ mode.

Now it is queued to device management command queue in MCQ mode.
However, a task tag is needed for device management commands.
Do you mean that the task tag of device management command be default to 0
instead in MCQ mode?

>
>Thanks,
>
>Bart.
