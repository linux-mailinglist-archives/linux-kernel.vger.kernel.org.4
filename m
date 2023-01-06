Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936765F8A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjAFBHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjAFBGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:06:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870972D03;
        Thu,  5 Jan 2023 17:06:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305NJ21b028867;
        Fri, 6 Jan 2023 01:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=waEmoD9HLDyTdq1YvqeqR5jNgi/lFUBikWierfohQ1I=;
 b=V+CYW4KH8jKcSTlSK7afO4DhGUZwpVoN6XLRSLmjDFBqNJibyUyZcuz2NuJRg2c1gmLX
 rV8mI9RwBQSeaW/gkF3ytlO28ciLbdLXaXADHkFzPvhEU1cyYqFYxh4pIvDnYYf2Beod
 m3B0KtrSH2LjJBXdV5AkPvpT1ST7zfbZYXYNxk/deQYc4diFO5N4fi7ig8liBq8V0he3
 bWeYHrJVwMCVb+w/dEGt2oHyfB6EJ9AmFwcZ0/HIRQJE+GMJOl8uB/nV8k5T0CbqVRwx
 Xb/fBrpNduTRoZAEx9/NSnqI2y3/yALQgIcM2no37UY2mlv8bbggocPb9RxzjsqKT76v wA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwwfs9ghr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 01:06:02 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 306162AB001411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 01:06:02 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 17:06:01 -0800
Message-ID: <cc40d2e2-3384-cd64-f53c-a0811b53d781@quicinc.com>
Date:   Thu, 5 Jan 2023 17:06:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 09/14] sound: usb: Introduce QC USB SND offloading
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-10-quic_wcheng@quicinc.com>
 <07443b54-2973-7990-e749-66dd7fb4e499@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <07443b54-2973-7990-e749-66dd7fb4e499@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kbpMgnLHgXYBsjm1Fb4JRK-2iBTcOG-L
X-Proofpoint-ORIG-GUID: kbpMgnLHgXYBsjm1Fb4JRK-2iBTcOG-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=361 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060006
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/4/2023 3:51 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 12/23/22 17:31, Wesley Cheng wrote:
>> Several Qualcomm SoCs have a dedicated audio DSP, which has the ability to
>> support USB sound devices.  This vendor driver will implement the required
>> handshaking with the DSP, in order to pass along required resources that
>> will be utilized by the DSP's USB SW.  The communication channel used for
>> this handshaking will be using the QMI protocol.  Required resources
>> include:
>> - Allocated secondary event ring address
>> - EP transfer ring address
>> - Interrupter number
>>
>> The above information will allow for the audio DSP to execute USB transfers
>> over the USB bus.  It will also be able to support devices that have an
>> implicit feedback and sync endpoint as well.  Offloading these data
>> transfers will allow the main/applications processor to enter lower CPU
>> power modes, and sustain a longer duration in those modes.
> 
> Are you suggesting that the entire feedback loop be handled in the DSP?
> It's not clear what "Offloading these data transfers" refers to, the
> data part or the feedback path?
> 

Yes, as mentioned in the cover letter response, we'll handle the 
feedback endpoints. (feedback eps are part of the audio data interface)

> Comments are almost inexistent in this patch so it's hard to figure out
> what it really does.
> 

OK, will add some more comments.

Thanks
Wesley Cheng
