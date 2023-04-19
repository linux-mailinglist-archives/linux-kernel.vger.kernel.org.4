Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9F6E774F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjDSKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDSKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:20:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4334215;
        Wed, 19 Apr 2023 03:20:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9W17E031661;
        Wed, 19 Apr 2023 10:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=syXBz7bJ6m9K84JX9p+z6kyGGpgP8ywiz6yLE7W5ctk=;
 b=GKMP/PBRWA4yn6np2+F6iFyVKnoRc3EBHbUORjPrSS9HedXaw3JsfN6gv3pOGFtIrQbg
 gV+WhkX57/hxqDWlw3cP7zVLmEjX4E9ekf2I1gRyFjjodqxr7oZ+oGG5wx9XdwyJ7c9A
 rm58gyeeOlSOg6d5iQ/sHOooAHdGV9T4U7VEf1tfFOyOft5VilDJDSrbDOEjzuLadCZe
 i23ciqneJI2oqSbecEMCBZJ7PLKz/0JnyruW5nBV/PLLmAnAhn0xkZS3XgMbDiSKDBOB
 jUIE1pU2X+C/NrWyQTMxNg1ZgvUF7X+OxG3xXhkXAdMelDZmwbAQ1qeWYY9xPhPg5hMG Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q292h8ntm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 10:20:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JAKCT1004402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 10:20:12 GMT
Received: from [10.50.61.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 03:20:08 -0700
Message-ID: <44834c75-4db7-ec8a-9367-c6b83fa96b22@quicinc.com>
Date:   Wed, 19 Apr 2023 15:50:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V22 2/3] misc: dcc: Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
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
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <50844899-b047-42fd-807a-db7136e5e590@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N8MMapuDQ0UkoWEJyq6g7AB61zCCJioX
X-Proofpoint-GUID: N8MMapuDQ0UkoWEJyq6g7AB61zCCJioX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190091
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/2023 1:00 PM, Arnd Bergmann wrote:
> On Wed, Apr 19, 2023, at 09:00, Souradeep Chowdhury wrote:
>> On 4/18/2023 9:15 PM, Greg Kroah-Hartman wrote:
>>>
>>>> The following is the justification of using debugfs interface over the
>>>> other alternatives like sysfs/ioctls
>>>>
>>>> i) As can be seen from the debugfs attribute descriptions, some of the
>>>> debugfs attribute files here contains multiple arguments which needs to
>>>> be accepted from the user. This goes against the design style of sysfs.
>>>>
>>>> ii) The user input patterns have been made simple and convenient in this
>>>> case with the use of debugfs interface as user doesn't need to shuffle
>>>> between different files to execute one instruction as was the case on
>>>> using other alternatives.
>>>
>>> Why do you have debugfs and also a misc device?  How are they related?
>>> Why both?  Why not just one?  What userspace tools are going to use
>>> either of these interfaces and where are they published to show how this
>>> all was tested?
>>
>> DCC has two fundamental steps of usage:-
>>
>> 1.Configuring the register addresses on the dcc_sram which is done by
>> user through the debugfs interface. For example:-
>>
>> echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config
>>
>> Here we are configuring the register addresses for list 3, the 'R'
>> indicates a read operation, so this register value will be read
>> in case of a software trigger or kernel panic/watchdog bite and
>> dumped into the dcc_sram.
> 
> Can you describe why the register location needs to be
> runtime configurable? I would have expected this type of setting
> to be part of the devicetree, which already describes other
> parts that interact with sram devices.

Register addresses are made runtime configurable to give the user the
option of going for a software trigger. So the user can debug issues
during run-time as well. These register locations are arbitrary
and is configured by the user for debugging purposes and is not related 
to the DCC hardware itself.

> 
> How does a user ensure that the address they configure does
> not overlap with some other use of the sram?

The dcc_sram is a dedicated io-memory for exclusive usage by dcc.
The register addresses are programmed in the dcc_sram corresponding
to a particular list and the start and end location on dcc_sram for
a particular list is updated in dcc hardware registers. So no two
lists can overlap. This is ensured by the driver code as follows:-

/* 3. Program DCC_RAM_CFG reg */
dcc_list_writel(drvdata, ram_cfg_base +
                        drvdata->ram_offset / 4, curr_list, DCC_LL_BASE);
dcc_list_writel(drvdata, drvdata->ram_start +
                         drvdata->ram_offset / 4, curr_list, DCC_FD_BASE);


> 
>      Arnd
