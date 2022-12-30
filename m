Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31A65959C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiL3HLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3HLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:11:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E2A452;
        Thu, 29 Dec 2022 23:11:39 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BU5sFsr026256;
        Fri, 30 Dec 2022 07:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FwhgSt+H12LokA09wY+Ljn6TvSwI6v7ncaNm3O6cwro=;
 b=J/mcI0k/6vjX9FhdSxYJYSt40LPnfc/hcIYWxD2v846nVodvXcdDdlw/duoiE3ywlZHb
 YGHRzGwgkoCFOjTzsqfMbLxRtVczH6NpeAB+gn2OH5gHj4/ukVXE5LJff+fvwEeUcE4t
 HsWLiWsBsU/amsSjsiIpAnt2pWLHyViBBAwZa7AU8nK5m2wgDzUMIJfnSXAv4oMeJgtG
 h5n2TQPFNWOXWZPeJ4LP3HyBS9aVAyBp/lRmptm7trMZpPZkbb+9uN+ONQF7WNT3ZllT
 zYX9PRSoeXB2uHjuvAICTBNKG/6SsAwxn6BwngGLBgPzaLThWlUGZhnzcT03N4GWVNPq 5A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ms2nra9nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 07:10:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BU7AcoQ007450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 07:10:38 GMT
Received: from [10.110.125.32] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 29 Dec
 2022 23:10:37 -0800
Message-ID: <ec632e64-2d9c-3f71-4fe7-e1c6acb81393@quicinc.com>
Date:   Thu, 29 Dec 2022 23:10:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op
 callbacks
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.com>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-5-quic_wcheng@quicinc.com>
 <80f92635-6d14-8ff3-17ac-de2e5b977947@suse.com> <87lemqxpet.wl-tiwai@suse.de>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87lemqxpet.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Eb4Q5qdFJpjmSWS6gnMU0-nbVChD5pAE
X-Proofpoint-GUID: Eb4Q5qdFJpjmSWS6gnMU0-nbVChD5pAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_03,2022-12-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=682 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300061
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/2022 6:20 AM, Takashi Iwai wrote:
> On Thu, 29 Dec 2022 14:49:21 +0100,
> Oliver Neukum wrote:
>>
>>
>>
>> On 24.12.22 00:31, Wesley Cheng wrote:
>>> Allow for different vendors to be notified on USB SND connect/disconnect
>>> seqeunces.  This allows for vendor USB SND modules to properly initialize
>>> and populate internal structures with references to the USB SND chip
>>> device.
>>
>> Hi,
>>
>> this raises a design question. If the system is suspending or, worse,
>> hibernating, how do you make sure the offloader and the device are
>> suspended in the correct order?
>> And what happens if you need to go into reset_resume() when resuming?

It may depend on how the offloading is implemented, but we do have a 
mechanism to force the audio stream off from the qc_usb_audio_offload. 
Regardless of if the UDEV is suspended first, or the USB backend, as 
long as we ensure that the offloading is disabled before entering 
suspend, I think that should be sufficient.  I would need to add some 
suspend handling in the offload driver to issue the command to stop the 
offloading.

As for the resume path, is there a concern if either device is resumed 
first?  The only scenario where maybe it could cause some mishandling is 
if the USB backend is resumed before the offload driver is 
connected/resumed.  This means that the userspace ALSA would have access 
to the platform sound card, and could potentially attempt to route audio 
streams to it.  I think in worst case, if we were going through a 
reset_resume() we would end up rejecting that request coming from the 
audio DSP to enable the stream.  However, userspace entities would be 
resumed/unfrozen last, so not sure if that would ever be a problem.

The reset_resume() path is fine.  Bus reset is going to cause a 
disconnect() callback in the offload driver, in which we already have 
the proper handling for ensuring the offload path is halted, and we 
reject any incoming stream start requests.

Thanks
Wesley Cheng

