Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74E86D9F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjDFRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbjDFRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:52:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710459CD;
        Thu,  6 Apr 2023 10:52:37 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336DxS7F024197;
        Thu, 6 Apr 2023 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0BWS4aJo5OPnytay8j8RYFB66wHzTKt45A6CYGH+KtU=;
 b=TypBm2M5BdGSgjbWEwG+JDXIIlQ15MDu1A+x8PyDAoaspgSdQD3WF+TdZA6NeELjGL6Z
 sD7IJefF8ETwTLn63ZnWejF/vpbb7QmtLjmZ4iDjZtR1vvrP0KoWF18dEzhTAI2Jmoo3
 rxAgh2yXcwsH0LMMGxXAbPJlhvUYOAW/i76IZIVS6+FjvXlCQd8fBFFT+CMxTf4tMTKf
 vAVITYOnbCIbTxqOm/vHn11YmmiRlbtOzD6jHL1IkgHMCYuQnuN9jqmqU5rF/HUWSpLf
 GkK53FUxsAynlrnVH98JiSRqlbYBWJh/y1xwt+VboJiNSAbpJkahRLnm9hk7konm+tBa GA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psv4dh3mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:52:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336HqWAf030720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 17:52:32 GMT
Received: from [10.110.8.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 10:52:31 -0700
Message-ID: <c1cac217-e655-916b-2889-4f389f73c6f4@quicinc.com>
Date:   Thu, 6 Apr 2023 10:52:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/1] soc: qcom: mdt_loader: Enhance split binary
 detection
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20230404175417.31185-1-quic_gokukris@quicinc.com>
 <20230404190510.dvsmkroyvu6437rb@ripper>
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <20230404190510.dvsmkroyvu6437rb@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HFCXUGC0YTmapxqc6SKmHW4snTHa0aeF
X-Proofpoint-ORIG-GUID: HFCXUGC0YTmapxqc6SKmHW4snTHa0aeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060157
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	
On 4/4/2023 12:05 PM, Bjorn Andersson wrote:
> On Tue, Apr 04, 2023 at 10:54:17AM -0700, Gokul krishna Krishnakumar wrote:
>> It may be that the offset of the first program header lies inside the mdt's
>> filesize, in this case the loader would incorrectly assume that the bins
>> were not split. The loading would then continue on to fail for split bins.
> 
> What does "continue on to fail for split bins" actually mean? In what
> way does it fail?
> Authentication fails in the firmware for the split bins because the 
current conditional check do not go through the entire mdt file for a 
given firmware.

Thanks,
Gokul
>> This change updates the logic used by the mdt loader to understand whether
>> the firmware images are split or not. It figures this out by checking if
>> each programs header's segment lies within the file or not.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> The first S-o-b should be that of the author (unless Co-developed-by)
> and in [1] you're the author and Melody provide her S-o-b to certify
> the origin of her contribution.
> 
>> ---
>> V4 addresses the comments from V3.
> 
> That's nice, but not very helpful. Please spell out what you changed.
> 

>>
>> V3 is separated out from [1] and includes
>> changes addressing comments from that patch set.
>>
>> [1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>> index 33dd8c315eb7..9270992728d4 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -258,6 +258,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
>>   
>> +static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char* fw_name)
>> +{
>> +	const struct elf32_phdr *phdrs;
>> +	const struct elf32_hdr *ehdr;
>> +	uint64_t seg_start, seg_end;
>> +	int i;
>> +
>> +	ehdr = (struct elf32_hdr *)fw->data;
>> +	phdrs = (struct elf32_phdr *)(ehdr + 1);
>> +
>> +	for (i = 0; i < ehdr->e_phnum; i++) {
>> +		seg_start = phdrs[i].p_offset;
>> +		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
>> +		if (seg_start > fw->size || seg_end > fw->size)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   			   const char *fw_name, int pas_id, void *mem_region,
>>   			   phys_addr_t mem_phys, size_t mem_size,
>> @@ -270,6 +290,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   	phys_addr_t min_addr = PHYS_ADDR_MAX;
>>   	ssize_t offset;
>>   	bool relocate = false;
>> +	bool is_split;
>>   	void *ptr;
>>   	int ret = 0;
>>   	int i;
>> @@ -277,6 +298,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   	if (!fw || !mem_region || !mem_phys || !mem_size)
>>   		return -EINVAL;
>>   
>> +
> 
> Double empty lines here?
> 
>> +	is_split = qcom_mdt_bins_are_split(fw, fw_name);
>>   	ehdr = (struct elf32_hdr *)fw->data;
>>   	phdrs = (struct elf32_phdr *)(ehdr + 1);
>>   
>> @@ -330,8 +353,8 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   
>>   		ptr = mem_region + offset;
>>   
>> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
>> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
>> +
>> +		if (phdr->p_filesz && !is_split) {
> 
> This looks much better now, thanks.
> 
> Regards,
> Bjorn
> 
>>   			/* Firmware is large enough to be non-split */
>>   			if (phdr->p_offset + phdr->p_filesz > fw->size) {
>>   				dev_err(dev, "file %s segment %d would be truncated\n",
>> -- 
>> 2.39.2
>>
