Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CD707F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjERL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjERL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:28:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5D119A;
        Thu, 18 May 2023 04:28:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9Ld2Z024464;
        Thu, 18 May 2023 11:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0ADcEotnqDUTVlKJStKn1HJe12wZ8wmSIpYJyt2gEo4=;
 b=SiCnzJol9Q8GFy+ZTpYkgx2rqdhRstnVqa4I0Wrz+kmTgKK4EiREl5bOLY+QuFj/5Epj
 N88loFmd6o8VCAyM9fZ4KiYDfEP7dGLjEy02IDvSTY9msC1lKDPzhMS5odV1QzhyioC+
 qxTgX9JOIK3rr5g/6wp61uH59uj7bT2tXX9esQESxJEkMImcWKjVyFFeW0pVumsmIp/P
 Xxqtt9elY4kEcl0gaU7py8LOhONuPULy7cH2FV50vpRPHDegElpY84bmtJmykY0oqnkA
 hGD3zQDsPiPNY021aqlwHIlhIFNjRc5yhh5gQFPYdSIwfHE37kCbS2v2gTPjpRHyIBTu hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73us9gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:28:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IBSCeb002815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:28:12 GMT
Received: from [10.216.40.42] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 04:28:09 -0700
Message-ID: <9fbc7f18-1610-7a72-b135-daeca382847e@quicinc.com>
Date:   Thu, 18 May 2023 16:58:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com>
 <052bacf7-756b-5f63-965b-9a8480a9acf5@quicinc.com>
 <CAOX2RU4WcNXu42W6_459wKzyo+6onNRhE+=3usmSRB9AEF3MtA@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAOX2RU4WcNXu42W6_459wKzyo+6onNRhE+=3usmSRB9AEF3MtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8SQfSE2vQ6RctGjLFFvy6hyTXMAZRiUT
X-Proofpoint-GUID: 8SQfSE2vQ6RctGjLFFvy6hyTXMAZRiUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180088
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 4:31 PM, Robert Marko wrote:
> On Thu, 18 May 2023 at 12:44, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>>
>>
>> On 5/18/2023 3:45 PM, Robert Marko wrote:
>>>
>>> On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
>>>> During normal restart of a system download bit should
>>>> be cleared irrespective of whether download mode is
>>>> set or not.
>>>>
>>>> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>
>>> Hi, this has been backported to 5.15.111, however it seems to be
>>> breaking reboot
>>
>> Thanks for reporting the issue, by any chance enabling
>> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT + reboot works on
>> IPQ4019 ?
> 
> Unfortunately not, the board still hangs in SBL.

Sorry for the trouble, but looks like this change need to be
reverted.

I sent a patch for its revert.

-- Mukesh

> 
> Regards,
> Robert
> 
>>
>>> on IPQ4019 by causing the board to then hang in SBL with:
>>> root@OpenWrt:/# reboot
>>> root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
>>> [   76.474204] br-lan: port 1(lan1) entered disabled state
>>> [   76.527975] device lan2 left promiscuous mode
>>> [   76.530301] br-lan: port 2(lan2) entered disabled state
>>> [   76.579376] device lan3 left promiscuous mode
>>> [   76.581698] br-lan: port 3(lan3) entered disabled state
>>> [   76.638434] device lan4 left promiscuous mode
>>> [   76.638777] br-lan: port 4(lan4) entered disabled state
>>> [   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
>>> [   76.978883] device eth0 left promiscuous mode
>>> [   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
>>> [
>>> Format: Log Type - Time(microsec) - Message - Optional Info
>>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>>> S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
>>> S - IMAGE_VARIANT_STRING=DAABANAZA
>>> S - OEM_IMAGE_VERSION_STRING=CRM
>>> S - Boot Config, 0x00000021
>>> S - Reset status Config, 0x00000010
>>> S - Core 0 Frequency, 0 MHz
>>> B -       261 - PBL, Start
>>> B -      1339 - bootable_media_detect_entry, Start
>>> B -      1679 - bootable_media_detect_success, Start
>>> B -      1693 - elf_loader_entry, Start
>>> B -      5076 - auth_hash_seg_entry, Start
>>> B -      7223 - auth_hash_seg_exit, Start
>>> B -    578349 - elf_segs_hash_verify_entry, Start
>>> B -    696356 - PBL, End
>>> B -    696380 - SBL1, Start
>>> B -    787236 - pm_device_init, Start
>>> D -         7 - pm_device_init, Delta
>>> B -    788701 - boot_flash_init, Start
>>> D -     52782 - boot_flash_init, Delta
>>> B -    845625 - boot_config_data_table_init, Start
>>> D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
>>> B -    852841 - clock_init, Start
>>> D -      7566 - clock_init, Delta
>>> B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor
>>> ID:0,Subtype:64
>>> B -    868413 - sbl1_ddr_set_params, Start
>>> B -    873402 - cpr_init, Start
>>> D -         2 - cpr_init, Delta
>>> B -    877842 - Pre_DDR_clock_init, Start
>>> D -         4 - Pre_DDR_clock_init, Delta
>>> D -     13234 - sbl1_ddr_set_params, Delta
>>> B -    891155 - pm_driver_init, Start
>>> D -         2 - pm_driver_init, Delta
>>> B -    909105 - Image Load, Start
>>> B -   1030210 - Boot error ocuured!. Error code: 303d
>>>
>>> Reverting the commit fixes rebooting.
>>>
>>> Regards,
>>> Robert
>>>
>>>> ---
>>>> Changes in v3:
>>>>     - Added Fixes tag.
>>>>     - Removed it from below patch series, as it makes sense to go this
>>>> independently.
>>>>
>>>> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
>>>>
>>>> Changes in v2:
>>>>     - No change.
>>>>
>>>>    drivers/firmware/qcom_scm.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index 468d4d5..3e020d1 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device
>>>> *pdev)
>>>>    static void qcom_scm_shutdown(struct platform_device *pdev)
>>>>    {
>>>>        /* Clean shutdown, disable download mode to allow normal restart */
>>>> -    if (download_mode)
>>>> -        qcom_scm_set_download_mode(false);
>>>> +    qcom_scm_set_download_mode(false);
>>>>    }
>>>>    static const struct of_device_id qcom_scm_dt_match[] = {
