Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C18692FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBKJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:52:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E01CADC;
        Sat, 11 Feb 2023 01:52:33 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B9o25r001143;
        Sat, 11 Feb 2023 09:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UCfOFNP2YCsOcROG51tOllRT0Dd3aRaEdI+beQKVZS4=;
 b=QPHCBTEvfCynbtL6N1nMAvuWvMSxhrkm2JQIzizSoBwioMTY8yVGlVuKbicySlDdHdl4
 9bUUQDSFg2QX2s6DcGdOosZu5GnfBo03m95wX99rKMI8zHyoQSZ0D6d6COIny+9p2w2n
 hQDbWWEX6NOfsBdntdcYbOiSu+TalNX3gLBz9lfQ0LvCVvXxonSJap7JBzSAVnH9IlWH
 y1GTsxsg/TatDUVTlKH4JhZ9Dz/EqXsSqLkPflbn2FT9pciW4/VEbceujRXixS5i13HU
 xgq4N/g1JdY/3O5T7ZBgIhyFOI1CuoenoURHlYlCmdZPXqWKpsgIcPzmYxlhjv5IEzfk UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389rfp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 09:52:11 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31B9qAx3015736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Feb 2023 09:52:10 GMT
Received: from [10.110.21.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sat, 11 Feb
 2023 01:52:09 -0800
Message-ID: <60e42db4-1bbc-beea-d87d-6f93871b70c7@quicinc.com>
Date:   Sat, 11 Feb 2023 01:52:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 20/22] sound: usb: Prevent starting of audio stream
 if in use
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-21-quic_wcheng@quicinc.com>
 <557f8f76-38f5-5e07-905e-774e03120bd2@linux.intel.com>
 <b26c9e4c-5a9c-a2ff-19a7-78419c6b81df@quicinc.com>
 <b532bf7b-e1fb-3a9d-1b88-02f3159be47d@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <b532bf7b-e1fb-3a9d-1b88-02f3159be47d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3k8nJOYHa5s5VYu4opmTp6Izyv68DjaR
X-Proofpoint-GUID: 3k8nJOYHa5s5VYu4opmTp6Izyv68DjaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_05,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=915 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302110089
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 2/7/2023 5:29 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 2/6/23 19:15, Wesley Cheng wrote:
>> Hi Pierre,
>>
>> On 1/26/2023 8:12 AM, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/25/23 21:14, Wesley Cheng wrote:
>>>> With USB audio offloading, an audio session is started from the ASoC
>>>> platform sound card and PCM devices.  Likewise, the USB SND path is
>>>> still
>>>> readily available for use, in case the non-offload path is desired.  In
>>>> order to prevent the two entities from attempting to use the USB bus,
>>>> introduce a flag that determines when either paths are in use.
>>>>
>>>> If a PCM device is already in use, the check will return an error to
>>>> userspace notifying that the stream is currently busy.  This ensures
>>>> that
>>>> only one path is using the USB substream.
>>>
>>> It's good to maintain mutual exclusion, but it's still very hard for an
>>> application to figure out which card can be used when.
>>>
>>> Returning -EBUSY is not super helpful. There should be something like a
>>> notification or connection status so that routing decisions can be made
>>> without trial-and-error.
>>>
>>
>> The USB offload driver does have access to the USB substream that is
>> being utilized/offloaded.  Maybe in addition to this check, we can also
>> set the PCM runtime state as well (for that particular substream)?  That
>> way userspace can fetch information about if the stream is busy or not.
> 
> You're missing the point. When a card is exposed but the PCM devices may
> or may not be usable (consuming data with no sound rendered or returning
> an error), it's much better to provide a clear connection status to
> userspace.
> 
> Let me give you an example. Intel drivers can expose 3 HDMI/DP PCM
> devices. Userspace has no idea which one to use, so there's a jack
> control that tells userspace whether there is a receiver connected so
> that the audio server can use the relevant PCM device.
> 
> Audio routing based on trial and error is really problematic, errors can
> happen but they should be exceptional (e.g. xruns), not a means of
> driver-userspace communication on the device status.

Thanks for clarifying.  The example helped me understand a bit more on 
how the potential use of the SND control interface.  Since we're dealing 
with multiple sound cards here (platform sound card (offload) and USB 
SND card (legacy)), what do you think about creating a SND control on 
both the USB backend (platform card) and the USB SND card listing the 
PCM device status?

That way at least userspace can have the information about which PCM dev 
(USB substream) is available (and not offloaded, or vice versa).  So the 
USB SND control will contain the PCM devices (exposed by the card) and 
if any are offloaded (if so mark them as unavailable).  Likewise, for 
the USB backend, if the legacy path is being used, mark them as 
unavailable for offloading.

Thanks
Wesley Cheng
