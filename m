Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB773731BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjFOO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344998AbjFOO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:58:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49865297C;
        Thu, 15 Jun 2023 07:58:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FBsMwv017189;
        Thu, 15 Jun 2023 14:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8jddhpXQANB8fdbQa1qqaRX5nkctEsZwQvmCoXwnM84=;
 b=TKoBFFOUE9CW32tnMAuXkyLbaapC3s/jCZ0ZUiAWb+5AuydF1xhG7IwYaOeMYo/k42Qf
 zqu0E3JW5AZUi2WLrNzBbZXDkMA64FbYReYB1mpPhw5ZEh/C+1cVZjcR6MiQohqHAsBG
 SqCWDAVeRFte2+q6+zblpkxpdkWQlLxpn3cPfbY6IGqvXvNdntfzT8omfbq49X8q4zCy
 gbLxfCUMAsLPWcVU/Tmk+WdrzzIp630CptbAZD0bxQwE2u9eRnU2Uxz+Okt2ACOUHSYQ
 EwpdcuTpQOh5Iv3hIPdvb+/2IAvEjrozB9e2x1ODErlzVL1RyOlNV/P8CPY8Mt4sp+px vQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka36yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:58:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35FEwPDo030284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:58:25 GMT
Received: from [10.216.11.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 15 Jun
 2023 07:58:21 -0700
Message-ID: <551145bb-18f7-45af-b75e-7caccca113bc@quicinc.com>
Date:   Thu, 15 Jun 2023 20:28:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
 <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
 <2023061547-staleness-camper-ae8a@gregkh>
 <d5561151-08bb-9f5f-aa51-44c5ad31976b@quicinc.com>
 <2023061512-vowed-panther-38ed@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023061512-vowed-panther-38ed@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NVx99CLevn-3KPC-wAGXUdEQwaDg9DZH
X-Proofpoint-ORIG-GUID: NVx99CLevn-3KPC-wAGXUdEQwaDg9DZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_11,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=668 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150130
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15-06-23 08:06 pm, Greg Kroah-Hartman wrote:
> On Thu, Jun 15, 2023 at 07:52:32PM +0530, Prashanth K wrote:
>>
>> In that case, can I resubmit v1 of this patch again, where I have used a
>> macro in usb-conn-gpio driver ? something like this.
>>
>> @@ -27,6 +27,8 @@
>>   #define USB_CONN_IRQF	\
>>   	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
>>
>> +#define USB_ROLE_UNKNOWN (USB_ROLE_NONE -1)
> 
> Are you referencing an existing enum here and assuming it is a specific
> value?

I' not assuming UBS_ROLE_NONE to be a specific value, but I want an 
integer (for macro) which is not equal to USB_ROLE_NONE/DEVICE/HOST, 
that's why I'm using (USB_ROLE_NONE - 1), assuming enumerators NONE, 
DEVICE & HOST will be having adjacent integer values. Wouldn't that help?

Thanks,
Prashanth K


