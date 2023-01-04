Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51C65E026
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbjADWkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjADWjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:39:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DE41036;
        Wed,  4 Jan 2023 14:39:53 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304Lr1w8004709;
        Wed, 4 Jan 2023 22:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PvgHZ++oCdiQinYipin27gvaecbZmAEzWRutKJOVX3M=;
 b=YtB7Jw/dFK0o6jNWJGYZJImoKHqHOfUS9PqilzpUXkxJKBugq170pe6zuGcEpkd4SzlM
 5t6FzxesA9NmPMzJXVnCM3Slh9GoGTaLJjtSEI7VmizV6HwE6ZH39hn0kIR6S2FcLFMP
 x/kg+tC7bYv7Zq7vIgn2Ne+Euowu4foGIa9sJZE8nNIgRp2TPVLzWicXtGwcHVWrU2zu
 b5S7Ao+EzMz8dyyN6Q/RW98TkujcN88bC+WjpgTFX20a1p4AedzLed4Ra41Mv87Tjrfb
 2umcVpWeBye4Izf4Jxxchl+XR3k7jnI00nzoPvQxwVFee2QSZFZwtDk6ds9ScgIBGfmQ OQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsw32yhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 22:38:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304Mcssx002166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 22:38:54 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 14:38:54 -0800
Message-ID: <ee22783a-7c64-608f-7d7b-02fd2d4f2e81@quicinc.com>
Date:   Wed, 4 Jan 2023 14:38:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 09/14] sound: usb: Introduce QC USB SND offloading
 support
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
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
 <20221223233200.26089-10-quic_wcheng@quicinc.com>
 <87edscsv5p.wl-tiwai@suse.de>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87edscsv5p.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -LNlQNIzroWBPk4dk30kS_5phwiMNb2T
X-Proofpoint-ORIG-GUID: -LNlQNIzroWBPk4dk30kS_5phwiMNb2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040184
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 1/2/2023 9:28 AM, Takashi Iwai wrote:
> On Sat, 24 Dec 2022 00:31:55 +0100,
> Wesley Cheng wrote:
>>
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
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Hmm, this must be the main part that works to bypass the normal USB
> packet handling in USB audio driver but hooks to the own offload one,
> but there is no description how to take over and manage.
> A missing "big picture" makes it difficult to understand and review.
> 

Technically, we are not taking over the functionality of the USB SND, as 
we still want the normal path to be accessible in case there is an audio 
profile/format that can't be supported by the audio DSP.  I can add some 
more information on how this offload driver co-exists with the USB SND.

> Also, since both drivers are asynchronous, we may need some proper
> locking.
> 

Yes, I think locking is needed in some places.  Will add that in the 
next revision.

> More on the code change:
> 
>> +static int snd_interval_refine_set(struct snd_interval *i, unsigned int val)
>> +{
>> +	struct snd_interval t;
>> +
>> +	t.empty = 0;
>> +	t.min = t.max = val;
>> +	t.openmin = t.openmax = 0;
>> +	t.integer = 1;
>> +	return snd_interval_refine(i, &t);
>> +}
>> +
>> +static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
>> +				 snd_pcm_hw_param_t var, unsigned int val,
>> +				 int dir)
>> +{
>> +	int changed;
>> +
>> +	if (hw_is_mask(var)) {
>> +		struct snd_mask *m = hw_param_mask(params, var);
>> +
>> +		if (val == 0 && dir < 0) {
>> +			changed = -EINVAL;
>> +			snd_mask_none(m);
>> +		} else {
>> +			if (dir > 0)
>> +				val++;
>> +			else if (dir < 0)
>> +				val--;
>> +			changed = snd_mask_refine_set(
>> +					hw_param_mask(params, var), val);
>> +		}
>> +	} else if (hw_is_interval(var)) {
>> +		struct snd_interval *i = hw_param_interval(params, var);
>> +
>> +		if (val == 0 && dir < 0) {
>> +			changed = -EINVAL;
>> +			snd_interval_none(i);
>> +		} else if (dir == 0)
>> +			changed = snd_interval_refine_set(i, val);
>> +		else {
>> +			struct snd_interval t;
>> +
>> +			t.openmin = 1;
>> +			t.openmax = 1;
>> +			t.empty = 0;
>> +			t.integer = 0;
>> +			if (dir < 0) {
>> +				t.min = val - 1;
>> +				t.max = val;
>> +			} else {
>> +				t.min = val;
>> +				t.max = val+1;
>> +			}
>> +			changed = snd_interval_refine(i, &t);
>> +		}
>> +	} else
>> +		return -EINVAL;
>> +	if (changed) {
>> +		params->cmask |= 1 << var;
>> +		params->rmask |= 1 << var;
>> +	}
>> +	return changed;
>> +}
> 
> Those are taken from sound/core/oss/pcm_oss.c?  We may put to the
> common PCM helper instead of duplication.
> 

Sure, I can do that.

>> +static void disable_audio_stream(struct snd_usb_substream *subs)
>> +{
>> +	struct snd_usb_audio *chip = subs->stream->chip;
>> +
>> +	if (subs->data_endpoint || subs->sync_endpoint) {
>> +		close_endpoints(chip, subs);
>> +
>> +		mutex_lock(&chip->mutex);
>> +		subs->cur_audiofmt = NULL;
>> +		mutex_unlock(&chip->mutex);
>> +	}
>> +
>> +	snd_usb_autosuspend(chip);
>> +}
>> +
>> +static int enable_audio_stream(struct snd_usb_substream *subs,
>> +				snd_pcm_format_t pcm_format,
>> +				unsigned int channels, unsigned int cur_rate,
>> +				int datainterval)
>> +{
>> +	struct snd_usb_audio *chip = subs->stream->chip;
>> +	struct snd_pcm_hw_params params;
>> +	const struct audioformat *fmt;
>> +	int ret;
>> +
>> +	_snd_pcm_hw_params_any(&params);
>> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_FORMAT,
>> +			pcm_format, 0);
>> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_CHANNELS,
>> +			channels, 0);
>> +	_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_RATE,
>> +			cur_rate, 0);
> 
> What about other parameters like period / buffer sizes?
> 

I don't think we will need those parameters on the audio DSP.  The 
"params" here is used to pass the pcm format into the qmi response.

>> +struct qmi_uaudio_stream_req_msg_v01 {
>> +	u8 enable;
>> +	u32 usb_token;
>> +	u8 audio_format_valid;
>> +	u32 audio_format;
>> +	u8 number_of_ch_valid;
>> +	u32 number_of_ch;
>> +	u8 bit_rate_valid;
>> +	u32 bit_rate;
>> +	u8 xfer_buff_size_valid;
>> +	u32 xfer_buff_size;
>> +	u8 service_interval_valid;
>> +	u32 service_interval;
>> +};
> 
> Are this and the other structs a part of DSP ABI?
> Or is it a definition only used in kernel?  I'm asking because
> __packed attribute is required for most of ABI definitions with
> different field types.
> 

This would be in the kernel only.

Thanks
Wesley Cheng
