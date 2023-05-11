Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA946FF82B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbjEKRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEKRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:12:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448335BA5;
        Thu, 11 May 2023 10:12:13 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BEXJoR008746;
        Thu, 11 May 2023 17:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/TGAsh7jFfI1g1cwODJCQTmO4ECEjvElysgbZYHwu0s=;
 b=eUkWpGEzzPbUiGjuPd2Hef3JG8fr5ooRuC2XHu0MFpiwwE1nnHGMIUV6y960j0dD7oxm
 YsqlcuKJC+fak/hks0hhPp06J0Rynw46tJGVBT9NrxUITHTNqyxphREk6gY18ICNsUiT
 RBaJEoRRh1XJIoSA1eFjfhvE1MfYU9BB0A/EWSXhEUEzZQY9q5jGCKiaguFWZ52SdPyB
 RY9BnqIAKR+i3Av0raxzCkFgXez1zFCJlaiJL0yrsBegFVm2WH517j+F4TzqPhPUU8eK
 jCsMKA3o/7T2WRzGThOFwfkzMhCWCbzrYamgLXAO7b7oaYY2FFR8OqOB7oHJ5oduZxNp 4Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh27trcj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 17:11:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BHBu0s004869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 17:11:56 GMT
Received: from [10.110.74.241] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 11 May
 2023 10:11:55 -0700
Message-ID: <cf533b92-a03d-ed61-2811-2528a531f5fd@quicinc.com>
Date:   Thu, 11 May 2023 10:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
 <20230511170744.cyex75e5d6md5rtm@ripper>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230511170744.cyex75e5d6md5rtm@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d1t5iYWzS0KxoQsKImZBRwkpLxkNjDRq
X-Proofpoint-GUID: d1t5iYWzS0KxoQsKImZBRwkpLxkNjDRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110147
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 10:07 AM, Bjorn Andersson wrote:
> On Tue, May 09, 2023 at 03:52:22AM -0700, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/qcom_boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>>
> 
> I would have preferred some way to implement this without spending
> countless kB of RAM to occasionally read out two u32 values...

If this is just for the debug build, why we are caring of it. There are 
various others kernel features we enable to debug the system crashes 
which consumes lot of RAM as well. Optimizations are good, but not sure
if we need to overdo it when it is just for debugging.

---Trilok Soni
