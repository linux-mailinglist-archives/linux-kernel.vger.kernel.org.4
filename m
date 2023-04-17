Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2EB6E42EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDQIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:51:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A340EF;
        Mon, 17 Apr 2023 01:51:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H8fgdJ003357;
        Mon, 17 Apr 2023 08:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3wj6YWgoNjtEryvQvyB4lsbeRiILBYvdHQxN0xuUxfs=;
 b=S+Xotwn5vgGai5Yl/itmm+gkoBWHOSahp4JEbQNZtlCj4aYb7nWLBJVApufKl9soj/dl
 6xgkD44Fil+GkNyBRStYoqIHVCLyiCnv1+AEUwxPoho3ytXuJ4FdQL60omjTzg231/G0
 VsQjXfwbTO8rn9glFcFI1MZK5GIBSVBC7ui268zaulmquV28QmP3Kng6xOPCEez51wEu
 hZiR5ktofYR5M8dO0lVCty1sigSzhiTQYkeCTg13qKjKya2El7EZUz2JjG+lRmngKsEN
 wKz4n8bC3jQXQZCaR+SmcnhGrnVuq4FQBFm01lxzsCFGwGa/ZS/1BuaU1DsHixhcq3zT +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12str0pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 08:51:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H8pJ1g030683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 08:51:19 GMT
Received: from [10.50.21.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 01:50:49 -0700
Message-ID: <4f496374-2d35-5d92-b7ec-cad256deb5a2@quicinc.com>
Date:   Mon, 17 Apr 2023 14:20:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1681480351.git.quic_schowdhu@quicinc.com>
 <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
 <ZDo4jIIV7cfPD2qW@kroah.com>
 <f3196d7a-50f0-9bfb-71a6-47ddb9686039@quicinc.com>
 <ZDzkkNQP5eO2vcxA@kroah.com>
 <7c46fe45-70b4-1f20-5ab4-cd51917d04a8@quicinc.com>
 <ZDz4RcQ1sFpynxop@kroah.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <ZDz4RcQ1sFpynxop@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RR0Z-jhz-aG35wxOqQxGgnGOSrcfD-dy
X-Proofpoint-ORIG-GUID: RR0Z-jhz-aG35wxOqQxGgnGOSrcfD-dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170078
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2023 1:11 PM, Greg Kroah-Hartman wrote:
> On Mon, Apr 17, 2023 at 12:26:23PM +0530, Souradeep Chowdhury wrote:
>> On 4/17/2023 11:47 AM, Greg Kroah-Hartman wrote:
>>> On Mon, Apr 17, 2023 at 11:31:46AM +0530, Souradeep Chowdhury wrote:
>>>> On 4/15/2023 11:09 AM, Greg Kroah-Hartman wrote:
>>>>>> +static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
>>>>>> +{
>>>>>> +	int i;
>>>>>> +	char list_num[10];
>>>>>> +	struct dentry *list;
>>>>>> +	struct device *dev = drvdata->dev;
>>>>>> +
>>>>>> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
>>>>>
>>>>> You are creating a directory at the root of debugfs with just your
>>>>> device name?  While that will work, that feels very odd.  Please use a
>>>>> subdirectory.
>>>>
>>>> This is as per the comment on v17 of the patch series on DCC
>>>>
>>>> https://lore.kernel.org/linux-arm-kernel/6693993c-bd81-c974-a903-52a62bfec606@ieee.org/
>>>>
>>>> "You never remove this dcc_dbg directory.  Why not?
>>>>
>>>> And since you don't, dcc_dbg could just be a local
>>>> variable here rather than being a global.  But it
>>>> seems to me this is the root directory you want to
>>>> remove when you're done."
>>>
>>> But that's not the issue.  The issue is that you are putting into
>>> /sys/kernel/debug/ a flat namespace of all of your devices.  Is that
>>> really what you want?  If so, why do you think this will never conflict
>>> with any other device in the system?
>>
>> Since we are going by the dev_name here which also contains the address
>> as per the example in the yaml binding, this will not conflict with other
>> dev_names in the system.
> 
> That is not true at all.  dev_names are only unique per bus type.  There
> is nothing preventing any other bus from using the same name for their
> device as yours.
> 
> So please, for the sake of your own sanity, just create a directory and
> dump all of your devices into it.  And for the sake of all of ours, as
> making the root of debugfs full of random device names is a mess, don't
> you think?  What would happen if all drivers did that?

Ack

> 
>>>> As per upstream discussions it was decided that debugfs will be a suitable
>>>> interface for DCC. More on this in the following link:-
>>>>
>>>> https://lore.kernel.org/linux-arm-kernel/20221228172825.r32vpphbdulaldvv@builder.lan/
>>>
>>> debugfs is not a suitable interface for anything that is "real" as
>>> that's not what it is there for.  Most systems disable debugfs entirely
>>> (i.e. Android), or prevent any normal user from accessing it, so this
>>> api you are creating will not be able to be used by anyone.
>>>
>>> debugfs is for debugging, not for anything that the system functionality
>>> relies on to work properly.
>>
>> DCC is a debugging hardware which stores the values of the configured
>> register address on a system crash on it's dedicated sram. These register
>> addresses are configured by the user through the debugfs interface. Also on
>> the platforms where debugfs is disabled there is an alternative of using
>> bootconfig suggested to configure the register values during boot-time.
>> There is an ongoing patch series for that as follows:-
>>
>> https://lore.kernel.org/linux-arm-kernel/cover.1675054375.git.quic_schowdhu@quicinc.com/T/
> 
> But again, debugfs is not even mounted in most systems, so how are they
> going to interact with your hardware?  Restricting it to debugfs feels
> very odd to me, but hey, it's your code, I guess you don't want anyone
> to use it :)
> 
> good luck!
> 
> greg k-h
