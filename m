Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF006E7F34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjDSQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDSQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484A198C;
        Wed, 19 Apr 2023 09:08:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JFjlK0027779;
        Wed, 19 Apr 2023 16:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TV6b7P46eRi1BMrrVIut2ypd01ZL60YmD6uD8CrDt84=;
 b=OFWpavpY0904LrUMzwEavIVzKrn77RNS4ROD/VORkY951LFJ41xyyQAA2Th2aT57RAnw
 OFdr5IUqsdpLZ5ADcXqb4W+zfrgtmOhii1HbidAi+F5i9FIL8kZ3N81Pb+x7mf0pwo1i
 BkNhPJGAaLkOH7ToBCz3jR+e8x/jMATYc4dwr26c71Z2z1LYoS8SPVRhxvR0wmF8v+Va
 BRv2oJipE+QxRRzU6EALl7h6M6cI+oqCcE2E0IwSSKhjgVNrYKNyGF0IJYqOoDXpjMUV
 fcSo5nGlc4s7ucSAH9lKUy3/L8a80lPHD4656WVBb+7REuzG36CPSLFiHYWJdRwdrBxW qg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q26wy1u1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 16:08:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JG8e5e019112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 16:08:40 GMT
Received: from [10.110.10.142] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 09:08:39 -0700
Message-ID: <9808142e-d6e6-71bc-f362-09b878cb3b87@quicinc.com>
Date:   Wed, 19 Apr 2023 09:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V22 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681829664.git.quic_schowdhu@quicinc.com>
 <e4f41fa61d9dd66f68bbd7650c6fbf96810c3569.1681829664.git.quic_schowdhu@quicinc.com>
 <2023041833-alienate-trash-f4da@gregkh>
 <f1456dd7-5dcf-d91a-459c-65efca4a3444@quicinc.com>
 <50844899-b047-42fd-807a-db7136e5e590@app.fastmail.com>
 <44834c75-4db7-ec8a-9367-c6b83fa96b22@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <44834c75-4db7-ec8a-9367-c6b83fa96b22@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MwTmVPbXfvqJz-nmmImwrS4c6f1USKpV
X-Proofpoint-ORIG-GUID: MwTmVPbXfvqJz-nmmImwrS4c6f1USKpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_10,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190145
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/2023 3:20 AM, Souradeep Chowdhury wrote:
> 
> 
> On 4/19/2023 1:00 PM, Arnd Bergmann wrote:
>> On Wed, Apr 19, 2023, at 09:00, Souradeep Chowdhury wrote:
>>> On 4/18/2023 9:15 PM, Greg Kroah-Hartman wrote:
>>>>
>>>>> The following is the justification of using debugfs interface over the
>>>>> other alternatives like sysfs/ioctls
>>>>>
>>>>> i) As can be seen from the debugfs attribute descriptions, some of the
>>>>> debugfs attribute files here contains multiple arguments which 
>>>>> needs to
>>>>> be accepted from the user. This goes against the design style of 
>>>>> sysfs.
>>>>>
>>>>> ii) The user input patterns have been made simple and convenient in 
>>>>> this
>>>>> case with the use of debugfs interface as user doesn't need to shuffle
>>>>> between different files to execute one instruction as was the case on
>>>>> using other alternatives.
>>>>
>>>> Why do you have debugfs and also a misc device?  How are they related?
>>>> Why both?  Why not just one?  What userspace tools are going to use
>>>> either of these interfaces and where are they published to show how 
>>>> this
>>>> all was tested?
>>>
>>> DCC has two fundamental steps of usage:-
>>>
>>> 1.Configuring the register addresses on the dcc_sram which is done by
>>> user through the debugfs interface. For example:-
>>>
>>> echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config
>>>
>>> Here we are configuring the register addresses for list 3, the 'R'
>>> indicates a read operation, so this register value will be read
>>> in case of a software trigger or kernel panic/watchdog bite and
>>> dumped into the dcc_sram.
>>
>> Can you describe why the register location needs to be
>> runtime configurable? I would have expected this type of setting
>> to be part of the devicetree, which already describes other
>> parts that interact with sram devices.
> 
> Register addresses are made runtime configurable to give the user the
> option of going for a software trigger. So the user can debug issues
> during run-time as well. These register locations are arbitrary
> and is configured by the user for debugging purposes and is not related 
> to the DCC hardware itself.

Please note that we don't want to recompile the devicetree for new 
settings since these registers can be set by team of engineers who are 
debugging system level issues with various IPs across the SOCs. You 
don't want to recompile the images while reproducing the system hangs/IP 
watchdogs etc;

---Trilok Soni


