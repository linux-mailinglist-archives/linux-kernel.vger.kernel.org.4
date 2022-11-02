Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134006156EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKBB0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKBB0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:26:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57651F9EB;
        Tue,  1 Nov 2022 18:26:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A20SuKE017303;
        Wed, 2 Nov 2022 01:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fCDaaqwrb9HfguXm+Oa4aIFtC5jrIdk+WrH70moPni8=;
 b=pysSL0HN4lPHSdn1OVVFJRdrjkvWOY5c8KqP9+0ZvfnkmWhp8PXmtaJOO53PHbryAwIE
 K3mfrzd7BW9VPerMl6ACKDgCaHKOcQUmLSEq80+kvuxz6mgogl/nA9fJLyUEoNOmzfUV
 +WdBuCq8T6s2M22ZdolQiI+yy2zf1RkMr6rRzXhcijeA11g12hyr/6ddT31YTRoXDpYD
 hapOH5Nt/oonCd8q1pMB6uTMBO2b3U1Y08VY9wvtzWvpC52G/bpXthk97DNZBPSfUgQr
 +PmIKokQIk9H2sVuOK5oMAopqKyqFPb+zyJpbKKQ4lbld6dYinb6nvHEVO9DT1/nyhAL mQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk7ms8uus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 01:26:28 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A21QRgr028877
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 01:26:27 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 18:26:25 -0700
Message-ID: <761f322c-47bb-1233-ffd2-f6c13bcd2466@quicinc.com>
Date:   Wed, 2 Nov 2022 09:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] pinctrl: core: Make p->state in order in
 pinctrl_commit_state
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221027065408.36977-1-quic_aiquny@quicinc.com>
 <20221101043047.GA11893@hu-pkondeti-hyd.qualcomm.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20221101043047.GA11893@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XWfkS2IBaq3kJMpahAS1CeKQbRmA-gfG
X-Proofpoint-ORIG-GUID: XWfkS2IBaq3kJMpahAS1CeKQbRmA-gfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_12,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 11/1/2022 12:30 PM, Pavan Kondeti wrote:
> Hi Maria,
> 
> On Thu, Oct 27, 2022 at 02:54:08PM +0800, Maria Yu wrote:
>> We've got a dump that current cpu is in pinctrl_commit_state, the
>> old_state != p->state while the stack is still in the process of
>> pinmux_disable_setting. So it means even if the current p->state is
>> changed in new state, the settings are not yet up-to-date enabled
>> complete yet.
>>
>> Currently p->state in different value to synchronize the
>> pinctrl_commit_state behaviors. The p->state will have transaction like
>> old_state -> NULL -> new_state. When in old_state, it will try to
>> disable all the all state settings. And when after new state settings
>> enabled, p->state will changed to the new state after that. So use
>> smp_mb to synchronize the p->state variable and the settings in order.
>> ---
>>   drivers/pinctrl/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
>> index 9e57f4c62e60..cd917a5b1a0a 100644
>> --- a/drivers/pinctrl/core.c
>> +++ b/drivers/pinctrl/core.c
>> @@ -1256,6 +1256,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   		}
>>   	}
>>   
>> +	smp_mb();
>>   	p->state = NULL;
>>   
>>   	/* Apply all the settings for the new state - pinmux first */
>> @@ -1305,6 +1306,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
>>   			pinctrl_link_add(setting->pctldev, p->dev);
>>   	}
>>   
>> +	smp_mb();
>>   	p->state = state;
>>   
> 
>  From your commit description, are you inferring that this p->state assignment
> re-ordered wrt pinmux_disable_setting()? btw, I don't see any locking that
> protects concurrent access to p->state modifications. For whatever reasons, if
> a client makes concurrent calls to pinctrl_select_state(), we can land up in
> the situation, you are seeing. correct?
correct.
> 
> Thanks,
> Pavan
> 


-- 
Thx and BRs,
Aiqun(Maria) Yu
