Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C7656FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiL0VLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiL0VKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:10:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029A65DB;
        Tue, 27 Dec 2022 13:08:48 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRL6aAH016227;
        Tue, 27 Dec 2022 21:08:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z7IPld7pNR/Me68apmq1qcL3SI5Eme59PhyOq61jRlg=;
 b=oVg79oWZh8Z4Oh1qpcE8+AVRqZ3AC9faBFWMk6GNnPVAZqE5FBG8wrSPmoS3F3hpXxta
 G+OOpegM+2Nj29AdteT5UPi8KXlPEYcc7YyiSIIVEUqnLxWKW0IO5JJlxpN/HSY4oGzP
 8ESd98VJgcAgE+STql5y1SAkDRc9RToNgqcg6bs96pZTr2BKLQgIj2qCZF8q+qaeSLhZ
 FOkIfSy2E1vySv3CElsWP34FYnQhuPeIOPwhxLzvMmrECk9b7/10Vuey0XXKgAAlWfIH
 OBskU/7yk0K+C9ZijWVRzvOJcyvPxWueqr9Te5GdPf6cToJeS+/Ru8dOG97RbAGKkX1y 0A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrd1dk6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:08:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL80Je022245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:08:00 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:07:59 -0800
Message-ID: <6a64be2e-212f-bd2b-f1e3-7abdc991c258@quicinc.com>
Date:   Tue, 27 Dec 2022 13:07:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 10/14] sound: usb: card: Check for support for
 requested audio format
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <tiwai@suse.com>, <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-11-quic_wcheng@quicinc.com>
 <Y6a/VWOg4mBMtUOr@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y6a/VWOg4mBMtUOr@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T8dn1tsUM-iD7DriSN4UZCxn8Mthqrw3
X-Proofpoint-GUID: T8dn1tsUM-iD7DriSN4UZCxn8Mthqrw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_17,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212270176
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/24/2022 12:59 AM, Greg KH wrote:
> On Fri, Dec 23, 2022 at 03:31:56PM -0800, Wesley Cheng wrote:
>> Allow for checks on a specific USB audio device to see if a requested PCM
>> format is supported.  This is needed for support for when playback is
>> initiated by the ASoC USB backend path.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c | 19 +++++++++++++++++++
>>   sound/usb/card.h |  3 +++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 396e5a34e23b..9b8d2ed308c8 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -133,6 +133,25 @@ int snd_usb_unregister_vendor_ops(void)
>>   }
>>   EXPORT_SYMBOL_GPL(snd_usb_unregister_vendor_ops);
>>   
>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>> +			struct snd_pcm_hw_params *params, int direction)
>> +{
>> +	struct snd_usb_stream *as;
>> +	struct snd_usb_substream *subs = NULL;
>> +	const struct audioformat *fmt;
>> +
>> +	if (usb_chip[card_idx] && enable[card_idx]) {
>> +		list_for_each_entry(as, &usb_chip[card_idx]->pcm_list, list) {
>> +			subs = &as->substream[direction];
>> +			fmt = find_substream_format(subs, params);
>> +			if (fmt)
>> +				return as;
>> +		}
>> +	}
> 
> Where is the locking here?  How can you walk a list that can be changed
> as you walk it?
> 
> And what about reference counting?  You are returning a pointer to a
> structure, who now "owns" it?  What happens if it is removed from the
> system after you return it?
> 
>> +	return 0;
> 
> Didn't sparse complain about this?  You can't return "0" as a pointer,
> it should be NULL.
> 
> Always run basic tools like sparse on code before submitting it so that
> we don't have to find errors like this.
> 

Got it...I didn't get a chance to run that, but will do it on future 
submissions.  Will also address the locking and pointer reference you 
mentioned.

Thanks
Wesley Cheng
