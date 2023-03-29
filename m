Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF496CD3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjC2HtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjC2Hs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:48:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F391630D5;
        Wed, 29 Mar 2023 00:48:35 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T3pES4019063;
        Wed, 29 Mar 2023 07:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eYwzBqAC2RAcywrukqpCd0kW8Lg+Kt04EPcxdpnVdhQ=;
 b=ehksLzefYofBbgiIwbgwKIcunvbPdNfVYBXiv7ZCSXw5zei2J364Gy01Si5sf7Eoc7dF
 Yhyr0Q+aI/Lqb3HnwvbDwTozfJlZHZgWusBzd/RAJTsboyk2u3fJ+pTeE1Na8NMUH6uX
 RLTcCZALF+SVDQJT5Sdg+ypsQpoZSr5S9CjixhU6VmutP0vxiT2Cyo7xGiNIzcN7nBf/
 i8vwXd6i3mayCgGokX1WwZK1GbhYvrvbeB2Bq4tyEkz3rSul8TQeNJIZO2fjI31OeEvw
 vUEgfkW/Cuv6XUVX6jnZPdAlrOdN03sKcQAT8Zot6UgQOnHjlspHcxjDWZSOY39XglNU nw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pm5v1sddb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:48:31 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T7mUaC026110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:48:30 GMT
Received: from [10.216.23.227] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 29 Mar
 2023 00:48:26 -0700
Message-ID: <9f5bce7e-2b8a-0b71-3a80-0b4f86d9f908@quicinc.com>
Date:   Wed, 29 Mar 2023 13:18:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
References: <20230323130153.8229-1-quic_vboma@quicinc.com>
 <c611c390-2cf3-2abe-82aa-67538b823d62@linaro.org>
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
CC:     <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
In-Reply-To: <c611c390-2cf3-2abe-82aa-67538b823d62@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Op2pdETwhk9IwSLAyH2gLX05IanGbI06
X-Proofpoint-ORIG-GUID: Op2pdETwhk9IwSLAyH2gLX05IanGbI06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290063
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 3:49 AM, Dmitry Baryshkov wrote:
> On 23/03/2023 15:01, Viswanath Boma wrote:
>> For VP9 bitstreams, there could be a change in resolution at interframe,
>> for driver to get notified of such resolution change,
>> enable the property in video firmware.
>> Also, EOS handling is now made same in video firmware across all V6 
>> SOCs,
>> hence above a certain firmware version, the driver handling is
>> made generic for all V6s
>
> Having "Do abc. Also do defgh." is a clear sign that this patch should 
> be split into two.

I agree, it could have split into patches. The patch introduces way to 
store venus firmware

version and take some decision for various version. For ex. here STOP 
handling and enabling

DRC event for specific firmware revision and onwards. Since both the 
handling was primarily

dependent of firmware version, and since the handlings were smaller, it 
was combined as single

patch. Let me know, if you have any further review comments, else, will 
raise a new version with

2 patches probably.

>>
>> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>> ---
>> Since v3 : Addressed comments to rectify email address.
>>
>>   drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>>   drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>>   drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>>   drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>>   5 files changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h 
>> b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2602a9..ee8b70a34656 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -202,6 +202,11 @@ struct venus_core {
>>       unsigned int core0_usage_count;
>>       unsigned int core1_usage_count;
>>       struct dentry *root;
>> +    struct venus_img_version {
>> +        u32 major;
>> +        u32 minor;
>> +        u32 rev;
>> +    } venus_ver;
>>   };
>>     struct vdec_controls {
>> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 
>> codec, u32 domain)
>>       return NULL;
>>   }
>>   +static inline int
>> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, 
>> u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor && 
>> (core)->venus_ver.minor ==
>> +            vminor && (core)->venus_ver.rev >= vrev);
>> +}
>> +
>> +static inline int
>> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, 
>> u32 vrev)
>> +{
>> +    return ((core)->venus_ver.major == vmajor && 
>> (core)->venus_ver.minor ==
>> +            vminor && (core)->venus_ver.rev <= vrev);
>> +}
>>   #endif
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c 
>> b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index bc3f8ff05840..9efe04961890 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct 
>> hfi_session_set_property_pkt *pkt,
>>           pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>>           break;
>>       }
>> +    case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>>       case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>>           struct hfi_enable *in = pdata;
>>           struct hfi_enable *en = prop_data;
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h 
>> b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index 105792a68060..c8aaf870829c 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -469,6 +469,8 @@
>>   #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH 0x1003007
>>   #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT 0x1003009
>>   #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE 0x100300a
>> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
>> +                                0x0100300b
>>     /*
>>    * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c 
>> b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> index df96db3761a7..07ac0fcd2852 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
>> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core 
>> *core, struct venus_inst *inst,
>>   }
>>     static void
>> -sys_get_prop_image_version(struct device *dev,
>> +sys_get_prop_image_version(struct venus_core *core,
>>                  struct hfi_msg_sys_property_info_pkt *pkt)
>>   {
>> +    struct device *dev = core->dev;
>>       u8 *smem_tbl_ptr;
>>       u8 *img_ver;
>>       int req_bytes;
>> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>>           return;
>>         img_ver = pkt->data;
>> +    if (IS_V4(core))
>> +        sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, 
>> &core->venus_ver.rev);
>> +    else if (IS_V6(core))
>> +        sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
>> +               &core->venus_ver.major, &core->venus_ver.minor, 
>> &core->venus_ver.rev);
>>         dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>>   @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct 
>> venus_core *core,
>>         switch (pkt->property) {
>>       case HFI_PROPERTY_SYS_IMAGE_VERSION:
>> -        sys_get_prop_image_version(dev, pkt);
>> +        sys_get_prop_image_version(core, pkt);
>>           break;
>>       default:
>>           dev_dbg(dev, VDBGL "unknown property data\n");
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c 
>> b/drivers/media/platform/qcom/venus/vdec.c
>> index 4ceaba37e2e5..36c88858ea9d 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, 
>> struct v4l2_decoder_cmd *cmd)
>>             fdata.buffer_type = HFI_BUFFER_INPUT;
>>           fdata.flags |= HFI_BUFFERFLAG_EOS;
>> -        if (IS_V6(inst->core))
>> +        if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 
>> 0, 87))
>
> This should go into a separate patch.
Yes.
>
>>               fdata.device_addr = 0;
>>           else
>>               fdata.device_addr = 0xdeadb000;
>> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst 
>> *inst)
>>               return ret;
>>       }
>>   +    /* Enabling sufficient sequence change support for VP9 */
>> +    if (of_device_is_compatible(inst->core->dev->of_node, 
>> "qcom,sc7180-venus")) {
>
> Let me repeat my question from v3:
>
> Is it really specific just to sc7180 or will it be applicable to any
> other platform using venus-5.4 firmware?

The HFI "HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT" is 
implemented

only for sc7180. Calling this for any other venus-5.4 would error out 
the session with error as

unsupported property from firmware.

>
>> +        if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
>> +            ptype = 
>> HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
>> +            ret = hfi_session_set_property(inst, ptype, &en);
>> +            if (ret)
>> +                return ret;
>> +        }
>> +    }
>> +
>>       ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>>       conceal = ctr->conceal_color & 0xffff;
>>       conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
>
