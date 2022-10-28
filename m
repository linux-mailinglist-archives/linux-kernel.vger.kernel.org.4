Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942B0611822
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJ1Qvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJ1Qvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:51:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00378190E54;
        Fri, 28 Oct 2022 09:51:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBrwPl002046;
        Fri, 28 Oct 2022 16:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=MWks2PIv5z1t6U2gIbqK1G/0YBGynsz7BSXDq//qxQg=;
 b=XFnK4t3ypPDG/xQSn67H+7Orj3ovpvkYik0HnmWS/bZ1TmOJNEWw2M67C1dbzA3udlFb
 9WXRnMsR9+Ffs5xL1tZIzTewoJ6vB3dmw4JkarXSVklzTInxxY8w34I30gtM1cPNwNEO
 E9M3bzYXQTVfzG1F60yS3jaRffYtDMmpwHXLkXtzhq8YaMpNc2H80F975KeuatybxljM
 S8Q0bsqU1ikcUVFOb+COVe7laECezZLpfI413n0sIJ/sjunXaHwDD1Ycj9a2sjgsH+T0
 dbbr5Bx/Zw4lX3xO8APH83YJ9+Y98vQU2BF0F/hX6P7Si5VySrO5JO34Gz7JfaMOS242 zQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kg59ajgys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:51:17 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29SGpGWs023274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:51:17 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 28 Oct 2022 09:51:16 -0700
Date:   Fri, 28 Oct 2022 09:51:16 -0700
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
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/17] ufs: core: Introduce Multi-circular queue
 capability
Message-ID: <20221028165116.GC9077@asutoshd-linux1.qualcomm.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1718196085461c37138c194c49146efa5c5503dc.1666288432.git.quic_asutoshd@quicinc.com>
 <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SpBA5FrS_tlYh4PC270buJIINgKO4k3Y
X-Proofpoint-ORIG-GUID: SpBA5FrS_tlYh4PC270buJIINgKO4k3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27 2022 at 14:10 -0700, Bart Van Assche wrote:
>On 10/20/22 11:03, Asutosh Das wrote:
>>+
>>+	/*
>>+	 * This capability allows the host controller driver to turn on/off
>>+	 * MCQ mode. MCQ mode may be used to increase performance.
>>+	 */
>>+	UFSHCD_CAP_MCQ_EN				= 1 << 12,
>>  };
>
>I prefer that the above flag would only be introduced after a need 
>appears to disable MCQ, e.g. discovery of a host controller that is 
>too broken to enable MCQ.
>
I think this flag is useful during chip bring-ups &/or debugs.
Considering that this is a fairly new hardware block even though the HC supports
MCQ there could be times to keep it disabled.

>Since UFSHCI 4.0 controllers must support UFSHCI 3.0, shouldn't users 
>have a way to disable MCQ, e.g. via a kernel module parameter?
>
I can add a kernel module parameter to disable MCQ.
I think adding it to host driver (e.g. ufs-qcom) would be good.
Please let me know if you have a better place in mind.

>Thanks,
>
>Bart.
