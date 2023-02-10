Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E636918E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjBJG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjBJG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:57:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9165AA;
        Thu,  9 Feb 2023 22:57:15 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A2rXGA022413;
        Fri, 10 Feb 2023 06:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Iw4cxmu8sEAT/+16APJ3gGH7laAOK5k+F/GcwDgCgZU=;
 b=c7r5P3rktVW4XC49kCBLWYqs/1T34sCyUL3TdC10/603hxEqQXj9Y6b0fApAaBt4BU33
 v+Q/ZCZdK1pLzQd6CBshlkmHDlCKUGPvJrcUySZfjIeotd/8MTLLy/gU/+Lrf8WlkTvu
 FcW13KFhjRJPnJE8OOw3vu+VobaMGe4jOpgrlWV+jtGnfS4IM6v7ASTsOcfIkqCiMurL
 Zm6ekzvsDQOGvyShtcIhmObw+Pj6CAIWGHsPy2gYVSQmnj3gpnQCJ5L2dD6XMu94fDQ1
 Vlbj8aiBzC61ADqMuBfA19TB5ImLNmUUCFs2Kz6g776Cpdo2urrRth0PjooLi7uGjvDP cQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nncxtrg9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:56:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A6uwCW007412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:56:58 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 22:56:55 -0800
Message-ID: <bf3296be-10f7-5a43-5ae8-dfc5b6d41240@quicinc.com>
Date:   Fri, 10 Feb 2023 12:26:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Content-Language: en-US
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
 <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
 <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
 <71f624df-5302-8276-2a2a-96223d4ba3c7@quicinc.com>
 <Y+VgHdJjrd0ZvY33@rowland.harvard.edu>
 <53d48954-3f7e-fd02-5e8e-2912c16565b3@quicinc.com>
In-Reply-To: <53d48954-3f7e-fd02-5e8e-2912c16565b3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nwi1QbRmcQgbKkQ7_UkbSo2T74t-c1D4
X-Proofpoint-GUID: nwi1QbRmcQgbKkQ7_UkbSo2T74t-c1D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=543
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302100059
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> And this seems like a viable option to me, what do you suggest?
> 
> gserial_disconnect {
>      spin_lock(static)
>      spin_lock(port)
>      ...
>      gser->ioport = NULL;
>      ...
>      spin_lock(port)
>      spin_unlock(static)
> 
> }
> 
> gserial_resume {
>      struct gs_port *port = gser->ioport;
> 
>      spin_lock(static)
>      if (!port)
	   spin_unlock(static)
>          return
>      spin_lock(port)
> 
>      ...
>      spin_unlock(port)
>      spin_unlock(static)
> }
> 
> Thanks,
> Prashanth K
Small correction inlined.

