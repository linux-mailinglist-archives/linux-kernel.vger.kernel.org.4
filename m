Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55FF613E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJaTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJaTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:39:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F513F3E;
        Mon, 31 Oct 2022 12:39:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VJapFm022048;
        Mon, 31 Oct 2022 19:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=UHObZMQKDZ89rXwbtBlQGAMEqBZeOMFFT785+zMi99Q=;
 b=Fg/AAl5X7hlAhV8PyWpiq173E9qbuSFKkBil3ARmz/tISxjKxnUj+b8SYLEFXaKU1X/Q
 /5MG852jTarc+viTJag2jWenXqCpSC8U2JFAejTnRT4fKBUg0s1OsdRDs6XapFyBF47H
 LNre6H8trfKDLDAkobmImk5ec0n4CvvnayKRzTHN7Ueeghtg4ApL5eTNf+JvYcd0V4jc
 E18PGfkiUDyDfWGZ/4t5OxC4D2rnMVj56g0szfYy8I3Y5g5JWwoMtySwpW0FipBZtx+7
 Ae10PCu0m76xZXDWjibaw1Fwu8GqwFSSrQ82XsRfoRWE8Gh3uIAvQNtZ1xcZiH4Zy/Nw 0g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjm85022w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:39:16 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29VJdFEV005633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 19:39:15 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 31 Oct 2022 12:39:15 -0700
Date:   Mon, 31 Oct 2022 12:39:14 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/17] ufs: core: mcq: Allocate memory for mcq mode
Message-ID: <20221031193914.GF9077@asutoshd-linux1.qualcomm.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <054ec088877bd4b421f2e9cb2b0fd8c4e058af11.1666288432.git.quic_asutoshd@quicinc.com>
 <DM6PR04MB6575D3CFDC51760EFF511F09FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575D3CFDC51760EFF511F09FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nq6SNmztnhsVOsKtszssjcniaQ-w4Jkj
X-Proofpoint-ORIG-GUID: nq6SNmztnhsVOsKtszssjcniaQ-w4Jkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=913 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30 2022 at 05:28 -0700, Avri Altman wrote:
[...]

>> +/* SDB - Single Doorbell */
>> +static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
>> +{
>> +       size_t ucdl_size, utrdl_size;
>> +
>> +       ucdl_size = sizeof(struct utp_transfer_cmd_desc) * nutrs;
>> +       dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
>> +                          hba->ucdl_dma_addr);
>> +
>> +       utrdl_size = sizeof(struct utp_transfer_req_desc) * nutrs;
>> +       dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
>> +                          hba->utrdl_dma_addr);
>> +
>> +       devm_kfree(hba->dev, hba->lrb);
>Is it possible not to release the lrb here?
>and then you won't be needing to call ufshcd_memory_alloc again?
>
The hba->nutrs may have changed so number of lrb's may increase as well.
So a reallocation is needed, I think.

-asd

