Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7526765F898
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjAFBG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjAFBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:06:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EA6F95F;
        Thu,  5 Jan 2023 17:06:44 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3060umjo032281;
        Fri, 6 Jan 2023 01:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yPDiABo7G5EPuLvcS5lxFAWTSB07/M1LZ5y70XE2u+U=;
 b=ms3aCilvtoXrWVFcN/A7klQJHi9omIOliOfbR6PVCunNJKN6BqCKs5WuFY0tt24fWk+7
 EmOtL1fGbeaOdQrvo8kAIkYKHK1aUnStyDVhY/0qcJPK69+bQvZ/YVCt5B32ZyMFCS4p
 BxmZDTR/3bWdEFkgzn0SI1YiODaCrxPEo9QQwhEbZ011m2fx9Kq3JBdgbWf305f5MHz2
 h6uc5j6mA1fvpLcsrpqBmiyRcWQAeDfsUYUd5gh5idLaAQ4YJAtYCIOA/7Asd/nxecK2
 X38gBWKEX6zJNbjep0pVPjUgY+p1BPpiLdjySldqUiLyh53YX6jVQJihtO0j7lIZ32Yc og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx5b0gfbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 01:05:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30615qlZ028640
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 01:05:52 GMT
Received: from [10.110.47.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 17:05:51 -0800
Message-ID: <6e13521a-84bf-f8a6-e8cc-5b90ff4bd675@quicinc.com>
Date:   Thu, 5 Jan 2023 17:05:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 02/14] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20221223233200.26089-3-quic_wcheng@quicinc.com>
 <5babccd6-9796-7613-cf82-cc859f338448@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <5babccd6-9796-7613-cf82-cc859f338448@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4GmqWCMCbJ-9orrP_alCZ0dx9tR0YQfW
X-Proofpoint-GUID: 4GmqWCMCbJ-9orrP_alCZ0dx9tR0YQfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060006
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/4/2023 3:33 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 12/23/22 17:31, Wesley Cheng wrote:
>> The QC ADSP is able to support USB playback and capture, so that the
>> main application processor can be placed into lower CPU power modes.  This
>> adds the required AFE port configurations and port start command to start
>> an audio session.
> 
> It would be good to clarify what sort of endpoints can be supported. I
> presume the SOF-synchronous case is handled, but how would you deal with
> async endpoints with feedback (be it explicit or implicit)?
> 

Sure, both types of feedback endpoints are expected to be supported by 
the audio DSP, as well as sync eps.  We have the logic there to modify 
the audio sample size accordingly.

> Note that it's very hard to make the decision not to support async
> endpoints, there are quite a few devices that are exposed as async to
> work around an obscure legacy issue on Windows but are really
> sof-synchronous endpoints that never ask for any change of pace.
> 
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   .../sound/qcom,q6dsp-lpass-ports.h            |   1 +
>>   sound/soc/qcom/qdsp6/q6afe-dai.c              |  47 +++++
>>   sound/soc/qcom/qdsp6/q6afe.c                  | 183 ++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6afe.h                  |  46 ++++-
>>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |  23 +++
>>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |   1 +
>>   sound/soc/qcom/qdsp6/q6routing.c              |   8 +
>>   7 files changed, 308 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> index 9f7c5103bc82..746bc462bb2e 100644
>> --- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> +++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
>> @@ -131,6 +131,7 @@
>>   #define RX_CODEC_DMA_RX_7	126
>>   #define QUINARY_MI2S_RX		127
>>   #define QUINARY_MI2S_TX		128
>> +#define USB_RX				129
> 
> the commit message says the DSP can support Playback and capture, but
> here there's capture only ...
> 
> 

Sorry I will update the commit message properly.  At the moment we've 
only verified audio playback.

>>   
>>   static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>> +	{"USB Playback", NULL, "USB_RX"},
> 
> ... but here RX means playback?
> 
> I am not sure I get the convention on directions and what is actually
> supported?
> 

The notation is based on the direction of which the audio data is 
sourced or pushed on to the DSP.  So in playback, the DSP is receiving 
audio data to send, and capture, it is transmitting audio data received. 
(although we do not support capture yet)

>> +struct afe_param_id_usb_cfg {
>> +/* Minor version used for tracking USB audio device configuration.
>> + * Supported values: AFE_API_MINOR_VERSION_USB_AUDIO_CONFIG
>> + */
>> +	u32                  cfg_minor_version;
>> +/* Sampling rate of the port.
>> + * Supported values:
>> + * - AFE_PORT_SAMPLE_RATE_8K
>> + * - AFE_PORT_SAMPLE_RATE_11025
>> + * - AFE_PORT_SAMPLE_RATE_12K
>> + * - AFE_PORT_SAMPLE_RATE_16K
>> + * - AFE_PORT_SAMPLE_RATE_22050
>> + * - AFE_PORT_SAMPLE_RATE_24K
>> + * - AFE_PORT_SAMPLE_RATE_32K
>> + * - AFE_PORT_SAMPLE_RATE_44P1K
>> + * - AFE_PORT_SAMPLE_RATE_48K
>> + * - AFE_PORT_SAMPLE_RATE_96K
>> + * - AFE_PORT_SAMPLE_RATE_192K
>> + */
>> +	u32                  sample_rate;
>> +/* Bit width of the sample.
>> + * Supported values: 16, 24
>> + */
>> +	u16                  bit_width;
>> +/* Number of channels.
>> + * Supported values: 1 and 2
> 
> that aligns with my feedback on the cover letter, if you connect a
> device that can support from than 2 channels should the DSP even expose
> this DSP-optimized path?
> 

My assumption is that I programmed the DAIs w/ PCM formats supported by 
the DSP, so I think the ASoC core should not allow userspace to choose 
that path if the hw params don't fit/match.

> Oh and I forgot, what happens if there are multiple audio devices
> connected, can the DSP deal with all of them? If not, how is this handled?
> 

This is one topic that we were pretty open ended on.  At least on our 
implementation, only one audio device can be supported at a time.  We 
choose the latest device that was plugged in or discovered by the USB 
SND class driver.

>> + */
>> +	u16                  num_channels;
>> +/* Data format supported by the USB. The supported value is
>> + * 0 (#AFE_USB_AUDIO_DATA_FORMAT_LINEAR_PCM).
>> + */
>> +	u16                  data_format;
>> +/* this field must be 0 */
>> +	u16                  reserved;
>> +/* device token of actual end USB aduio device */
> 
> typo: audio
> 

Thanks

>> +	u32                  dev_token;
>> +/* endianness of this interface */
>> +	u32                   endian;
> 
> Is this a USB concept? I can't recall having seen any parts of the USB
> audio class spec that the data can be big or little endian?
> 

No, this is probably just something our audio DSP uses on the AFE 
commands that it receives.

>> +/* service interval */
>> +	u32                  service_interval;
>> +} __packed;
> 
>> +int afe_port_send_usb_dev_param(struct q6afe_port *port, struct q6afe_usb_cfg *cfg)
>> +{
>> +	union afe_port_config *pcfg = &port->port_cfg;
>> +	struct afe_param_id_usb_audio_dev_params usb_dev;
>> +	struct afe_param_id_usb_audio_dev_lpcm_fmt lpcm_fmt;
>> +	struct afe_param_id_usb_audio_svc_interval svc_int;
>> +	int ret = 0;
>> +
>> +	if (!pcfg) {
>> +		pr_err("%s: Error, no configuration data\n", __func__);
> 
> can you use a dev_err() here and the rest of the code?
> 

Sure.

Thanks
Wesley Cheng
