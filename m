Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFF613E52
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJaTes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJaTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:34:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30313F1F;
        Mon, 31 Oct 2022 12:34:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VJOdOx022493;
        Mon, 31 Oct 2022 19:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=6L6Ap2YjdN9oyM8e1MDGKx8tyK8cpl4UmlrHPm9hD7Y=;
 b=kQO5cwhH6p+9DVyJIIEMapQ+klIi2Kw7WhJfBNNCq7rOJVCO+kmyGE4p0s5W8rwkM9rq
 t34olWxsCfHjeD41vsOZ09fUpomKuTKcF/TyadI2RGm2MAZsF+JrwKPLqNcbIVT/90DG
 rnGV8Ni4TIvmQ+mzEPTsFnT1f0eO7ezYy5J6w3xtDSlCXOXtHg9c/pZvBKv1c9r/A0Mj
 JRADqLTFDkEbL0N98nio69e4dXbZIHoIfYfBplSySNPMzyfA5ng924Yms6y2N3mqffGF
 V5IVePk/QBQw2MkOLcFdTc/vwZivMdZ+fpPE6IicphDYuvEeWvWhnk4K4TW4sCoGrrYc fQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kj7vysxes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:34:21 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29VJYKAF014386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:34:20 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 31 Oct 2022 12:34:19 -0700
Date:   Mon, 31 Oct 2022 12:34:19 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/17] ufs: core: mcq: Calculate queue depth
Message-ID: <20221031193419.GE9077@asutoshd-linux1.qualcomm.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1987fbada1d33c04c9598614ef712e0a48fe065e.1666288432.git.quic_asutoshd@quicinc.com>
 <0fb3f8ae-5ed7-9057-0d2b-8866f36c2441@acm.org>
 <DM6PR04MB6575D8A39219420494192B76FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575D8A39219420494192B76FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3YL2TRd-jnf6X225CzDZa1t1QfgD0FBa
X-Proofpoint-GUID: 3YL2TRd-jnf6X225CzDZa1t1QfgD0FBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=715 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30 2022 at 04:43 -0700, Avri Altman wrote:
>> On 10/20/22 11:03, Asutosh Das wrote:
>> > +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)

[...]

>> > +     qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
>> > +     if (!qd)
>> > +             qd = mac;
>Isn't if mcq is supported bqueuedepth can't be zero?
>The device must implements the shared queueing architecture.
>
Ah well, there's a Note mentioned in the UFS 4.0 spec (#7021) which kind of
confused me. I will remove this check if it can't be 0.

-asd
>
