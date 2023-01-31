Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1471682488
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 07:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjAaGjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 01:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjAaGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 01:39:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCF3CE2F;
        Mon, 30 Jan 2023 22:39:06 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V2JAJd003518;
        Tue, 31 Jan 2023 06:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a8Ra2uXIgQMh/TyX7zeAlxEnyGcY7k54p9Nn8l5tvm4=;
 b=NIYL9gNB92Ud1QOfDtU1qQjkMwOcEClxupburY+CElhwy/WAeGwzIw4iiqE5x7fuJF91
 cEkrGorSbN+or3vWEGrR0n8bEJ3kYh5emDSnDTBeoN5J9/jKXzi9wMc5doLsUwSHZx5A
 vmahspQg+2YKJNbb+nbkK5Ia+312tv0sJRCDKfyEoIvk3gf7IC0CCmPVgPDTXUC+MrCQ
 MXhl7eq8wZWSlxIHdiyI+IrUJ8jJEwH9jw9DzlGSVegvpyVNNwo+4UXgtTALpC/stg0P
 oKfRu8jTY5n6zQJcAUlPPOukH2lCN2CxKnsbZwpq7JURCZR0SbE5W32wLXoVI3rfNnMe qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnynn3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:39:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V6d0uS010404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 06:39:00 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 22:38:57 -0800
Message-ID: <c76d426c-c65b-1334-627a-1a6c615ddd93@quicinc.com>
Date:   Tue, 31 Jan 2023 14:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
References: <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
 <20230109182813.sle5h34wdgglnlph@synopsys.com>
 <e7217471-5b08-eee6-fba8-06e879118d77@quicinc.com>
 <20230110025310.nowjnrmo3oag76xd@synopsys.com>
 <4ced9c3e-c7b5-e0a0-88ec-1ac383d893a2@quicinc.com>
 <bfcfac21-3df7-7f47-576b-0717f2bab393@quicinc.com>
 <f35f0636-5b3f-9002-77f3-a3c2c53be973@quicinc.com>
 <20230111000021.r2bd5gnfwlbxzxd3@synopsys.com>
 <826538ae-d27a-fc03-c8dc-94b53c8a44cf@quicinc.com>
 <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230111022720.mcrhdrthgwlwszcv@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G91wOPGcK6ksBqVf1K7woIXkvWVb-zXM
X-Proofpoint-ORIG-GUID: G91wOPGcK6ksBqVf1K7woIXkvWVb-zXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=471 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310061
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Thinh,


regarding your suggestion, assume it is not PCIe type,  still have one 
question,


-       if (evt->flags & DWC3_EVENT_PENDING)
+       if (evt->flags & DWC3_EVENT_PENDING) {
+               if (!evt->count) {
+                       u32 reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
+
+                       if (!(reg & DWC3_GEVNTSIZ_INTMASK))
+                               evt->flags &= ~DWC3_EVENT_PENDING;

do we need to return IRQ_WAKE_THREAD  ?

+               }
                 return IRQ_HANDLED;

as here return IRQ HANDLED, how can we make sure a new IRQ will be 
handled after previous IRQ thread clean PENDING flag ?

+       }


also for non-PCIe controller, consider IRQ mask register working correctly,

consider a case IRQ happen before IRQ thread exit,  here just return 
IRQ_HANDLED.

once IRQ thread exit, it will clean PENDING flag, so next IRQ event will 
run normally.

if 정재훈 saw PENDING flag is not cleared, does it mean IRQ thread have no 
chance to exit ?
