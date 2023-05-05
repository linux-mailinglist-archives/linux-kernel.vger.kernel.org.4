Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BF6F7FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjEEJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjEEJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:21:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19439C4;
        Fri,  5 May 2023 02:21:45 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3459AjVN016190;
        Fri, 5 May 2023 09:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kweh12pVCAfMn2iqw6+n6p7Ho2umE5weOtMMprpVnf8=;
 b=AJztk2yvQR0xySC0OUf4OuIoLZ3Xv1wPZB1JnZvDMbN1Zr6IWUZNSMaaNIbgwliviPgm
 sFj3sjvjbHX2auF32j0IvuD7eY/wDXmPJ9BcWbg+t6HCOcPoFuNtJmpYKt+E/r7ryA6D
 XWjMBHAEadf8VToDRLs5Qf5M03aL6/nzQjhwp/O8wWte2sBLGUWSa29NAmpqni3kvlWN
 LEaAVlnnaS5NMG6G99oM2THcy//WnuVpHT0Yke/5ELh0FbMg23yya8JKNLvzMZymctAC
 YL/x47VJwY14AwVrx/CytQoZFP4FPcGLbwSxBrn/TqEvkPvrdUdCvMADGRB1B5xowzSk mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcmm394qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 09:21:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3459LbBw001380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 09:21:37 GMT
Received: from [10.217.218.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 02:21:35 -0700
Message-ID: <0f33ea7f-d0a4-bc39-1d26-02518fa460a4@quicinc.com>
Date:   Fri, 5 May 2023 14:51:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1676309438-14922-1-git-send-email-quic_prashk@quicinc.com>
 <Y+p6TUBtikbmnTGe@rowland.harvard.edu>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+p6TUBtikbmnTGe@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jj1yjN6GZI_VivsWB7pPdg4-awzvVHdP
X-Proofpoint-GUID: jj1yjN6GZI_VivsWB7pPdg4-awzvVHdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=360 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050077
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13-02-23 11:28 pm, Alan Stern wrote:
> On Mon, Feb 13, 2023 at 11:00:38PM +0530, Prashanth K wrote:
>> Consider a case where gserial_disconnect has already cleared
>> gser->ioport. And if a wakeup interrupt triggers afterwards,
>> gserial_resume gets called, which will lead to accessing of
>> gser->ioport and thus causing null pointer dereference.Add
>> a null pointer check to prevent this.
>>
>> Added a static spinlock to prevent gser->ioport from becoming
>> null after the newly added check.
>>
>> Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>> v5: Updated the comment in new patch
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> I'm not very familiar with the u_serial function.  Is it possible for
> gserial_disconnect to cause a similar problem in gserial_suspend?
> 
> Alan Stern
> 
Hi Alen,

You were right, we have similar issue in suspend path also. I have 
pushed a patch for the same.

Regards,
Prashanth K
