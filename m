Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CB65CA83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjACXqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjACXqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:46:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3FAE65;
        Tue,  3 Jan 2023 15:46:46 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303NM1Ag015232;
        Tue, 3 Jan 2023 23:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bqX0P8LAkS0qn7kAaiRMBmXDNABlm+TdaaE/onDLB+g=;
 b=JC3J+JjzHaOU0LdltrzzwMCeADJSYLFTh1fPZO/8CWFy3YKTLIsOq4q7GCrJANiAglSp
 YeCJfjtbMOKMUev+fkNF0qR8FqEgsdYnTpTbtembCGDSr8oJgIJT6w45fPwVgYJXRN9B
 4QXr4k6fFfo/vKTaO51qCrkMub7Ky7510O9Ers6Yi/IDou/jwIQVPneYYm5ZqbVyc+Xj
 5IfwDEFjcneILweu2DifDZJh9GHmq/VnqNpANgYRd3ZgS+hKb/cSJNzR5RXs6o1ycJ/X
 lK59JBAP2N6gPsrvlBlGj9TQwDxwWq2r0pBlmtUCwE194IlwLeCsaIr08uKV4fzDAWRd Mw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvurdp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 23:45:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 303NjfWH001230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Jan 2023 23:45:41 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 15:45:40 -0800
Message-ID: <54f36fe7-c590-3d5c-58dc-c5a02c412487@quicinc.com>
Date:   Tue, 3 Jan 2023 15:45:27 -0800
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
 <ec632e64-2d9c-3f71-4fe7-e1c6acb81393@quicinc.com>
 <465bb512-2ea3-ebfc-4b21-7b493f019fc3@suse.com> <87v8lnrde2.wl-tiwai@suse.de>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87v8lnrde2.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 94uUE7f83JPt0O_oswNAVd_rJb-Y--0T
X-Proofpoint-ORIG-GUID: 94uUE7f83JPt0O_oswNAVd_rJb-Y--0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301030200
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 1/3/2023 4:49 AM, Takashi Iwai wrote:
> On Tue, 03 Jan 2023 13:20:48 +0100,
> Oliver Neukum wrote:
>>
>>
>>
>> On 30.12.22 08:10, Wesley Cheng wrote:
>>
>>> It may depend on how the offloading is implemented, but we do have a mechanism to force the audio stream off from the qc_usb_audio_offload. Regardless of if the UDEV is suspended first, or the USB backend, as long as we ensure that the offloading is disabled before entering suspend, I think that should be sufficient.
>>
>> You would presumably output garbage, if the UDEV is asleep but the backend is not.
>>

As long as the stream is halted, i.e. the audio DSP doesn't execute 
further transfers on the bus, there shouldn't be any noise/static that 
will continue to be outputted.  When I mentioned that we have a 
mechanism to force for the offloading to be disabled to the audio DSP 
side, it will no longer submit any audio data to the USB bus.

>>   
>>> The reset_resume() path is fine.  Bus reset is going to cause a disconnect() callback in the offload driver, in which we already have the proper handling for ensuring the offload path is halted, and we reject any incoming stream start requests.
>>
>> How? If we go the reset_resume() code path, we find that usb-audio does not make
>> a difference between regular resume() and reset_resume()
> 
> Note that, for USB audio, there is no much difference between resume()
> and reset_resume(), especially about the PCM stream handling that is
> the main target for the offload (the mixer isn't handled there).
> And for the PCM, we just set the power state for UAC3, and that's
> all.  All the rest is handled by the PCM core handler as usual.
> 

Sorry, I was under the impression that the USB SND class driver didn't 
register a reset_resume() callback, which Takashi helped clarify that it 
does indeed do.  (if no callback is registered, then USB interface is 
re-binded in the resume path)  However, it doesn't explicitly treat the 
reset_resume differently than a normal resume.

For the offload path, we don't need to do anything special either - if 
we have ensured that the stream was stopped in the suspend path. (to be 
added) It would be up to the userspace to restart the ASoC PCM stream, 
which would cause another stream request enable QMI command handshake to 
happen before any transfers would start.

One thing that I could add to protect the situation where the USB ASoC 
backend is resumed before UDEV, is to check the chip->system_suspend 
state.  Normally, the offload driver needs to ensure the bus is in U0 
before starting the audio stream, but it is done using runtime PM:

static int enable_audio_stream(struct snd_usb_substream *subs,
				snd_pcm_format_t pcm_format,
				unsigned int channels, unsigned int cur_rate,
				int datainterval)
{
...
	pm_runtime_barrier(&chip->intf[0]->dev);
	snd_usb_autoresume(chip);

In case we're in the PM resume path, I don't believe PM runtime can be 
triggered to resume a device.  In this case, the snd_usb_autoresume() 
would return w/o ensuring the USB SND device is fully exited from PM 
suspend.  Although, this situation would be a corner case, as userspace 
entities (userspace ALSA) are going to be unfrozen after kernel devices 
are resumed, so most likely there should be no request to enable the 
audio stream if kernel devices are still resuming.

I don't see an issue with the sequence of UDEV being resumed before USB 
backend.  In this case, the USB bus is ready to go, and able to handle 
stream enable requests.

Thanks
Wesley Cheng
