Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C16DCCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjDJVha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDJVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:37:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81264172D;
        Mon, 10 Apr 2023 14:37:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ALR1io019456;
        Mon, 10 Apr 2023 21:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OlBCd49eBjkXp2Pv93kyk/rSi7LwB0d4AsewpoDOdKk=;
 b=lu0Ux9peRflihjxDoIqNxwbhRqMKf0lb3m3IKGGIt7Xn0SD3k7iD9bQsuh42hMsWqaU/
 Gnj7zelHxFT6ywOmqp4utWQ6CctCx8ljBytEdhdwrkJHPHsi/EeldUgU0WvqRGII6dhe
 g3IqZdGVxxX97OXOsZ5PhcdliqF1BnHLAhn+yAtUbI+sfGEX7icKwUcx9UolbIkeImCr
 I0YEN/Xsq2zJtHp+Zw7Wy/DxTq8OsFWF7A/qmEmAU0SiysGqjLFORFjcoGE/qVr11Quz
 cltyri/v+T/Zq/TRsZ7n9MXy7SY0djCjh6J1gs+N7tOoqNTVbm0yIdtyGDI22G99PL84 MQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvj1ks612-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 21:37:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ALbNoS008983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 21:37:23 GMT
Received: from [10.110.58.223] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 14:37:22 -0700
Message-ID: <3efb8203-a6d3-86e0-9e25-f7a2f2a6b71f@quicinc.com>
Date:   Mon, 10 Apr 2023 14:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230407224025.22315-1-quic_wcheng@quicinc.com>
 <20230407224025.22315-2-quic_wcheng@quicinc.com>
 <20230408014456.nc2dgoavurtonq3r@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230408014456.nc2dgoavurtonq3r@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dpxW21GFK31tWGaYn6yEroNN_UsSfnVn
X-Proofpoint-ORIG-GUID: dpxW21GFK31tWGaYn6yEroNN_UsSfnVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=442 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100187
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 4/7/2023 6:45 PM, Thinh Nguyen wrote:
> On Fri, Apr 07, 2023, Wesley Cheng wrote:
>> Several sequences utilize the same routine for forcing the control endpoint
>> back into the SETUP phase.  This is required, because those operations need
>> to ensure that EP0 is back in the default state.
>>
>> Fixes: c96683798e27 ("usb: dwc3: ep0: Don't prepare beyond Setup stage")
> 
> Refactor patch should have no functional change. Why is there fixes tag?
> 

Sorry my mistake, will remove and resubmit.

Thanks
Wesley Cheng
