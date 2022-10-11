Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246A5FAB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJKEY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJKEYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:24:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5407CB49
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:24:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B4OBMJ009813;
        Tue, 11 Oct 2022 04:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XbdaKiFw1bCBmO3dJb9SG6+IfyY9upb0q5gan1tGSlc=;
 b=bljrzFMQ0AVevEVDRR7k+q/75dx+xqfSFD9oQE+RJg6KJfp57TuEODZQjyDDB3LdWOAu
 pmaWcY/PrTFq1LbEL67LADEkl3jhwHk46UPZexRoSOx+SWOR+Lr+9mM35gvBkRJDfhoV
 pexzj/AHcnOdvHBiqw7EAji498l5FHVY7tWK59WcV1pF43NoZByVByjcqzd0kY7gXBKt
 aQR7iq6H/i68g1qo7Z2C0b9X97vyFTcDv7BUVcpVAxEubbZFuoIvSGqdqNiwr4PEx2tL
 1mMmEA96gypbNFRVwrvxz4tA75LsUXA9dd6SXtC+J0pj90ShnOfEvzkwG2aAbxgaXtT5 7A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx4s0cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 04:24:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29B4OArJ032350
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 04:24:10 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 21:24:06 -0700
Message-ID: <c8c8d2ea-f9e9-06cc-f974-6a984be0dbd8@quicinc.com>
Date:   Tue, 11 Oct 2022 09:54:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH linux-next] soc: Use generic_handle_domain_irq()
Content-Language: en-US
To:     <yexingchen116@gmail.com>, <gregory.clement@bootlin.com>
CC:     <andrew@lunn.ch>, <sebastian.hesselbarth@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>
References: <20221011032050.322951-1-ye.xingchen@zte.com.cn>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221011032050.322951-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n402PhbTuD9g1-EUAYq2CkIYpZ90ets_
X-Proofpoint-ORIG-GUID: n402PhbTuD9g1-EUAYq2CkIYpZ90ets_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_02,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=883
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110023
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/11/2022 8:50 AM, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace generic_handle_irq(irq_find_mapping()) with
> generic_handle_domain_irq().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/soc/dove/pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index ffc5311c0ed8..308fe45231b4 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -243,7 +243,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
>   		stat &= ~(1 << hwirq);
>   		done &= ~(1 << hwirq);
>   
> -		generic_handle_irq(irq_find_mapping(domain, hwirq));
> +		generic_handle_domain_irq(domain, hwirq);

Thanks.

Reviewed-By : Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh


>   	}
>   
>   	/*
