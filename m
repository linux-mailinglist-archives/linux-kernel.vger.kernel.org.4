Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0431D6C3877
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCURml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCURmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:42:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD14688;
        Tue, 21 Mar 2023 10:42:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGENCd031704;
        Tue, 21 Mar 2023 17:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ugIzKoPJwH55c5cFx4I8HYix/yq/Nifp1l2svD2Iw4E=;
 b=ee+cPWIQorwZwp+SldMk1vOHMJ+zu4A0HBF2UxsCoZHBDPoWPfsyZdAnLOgKUPh9tGSs
 kISWF5qbT31pGPeOcF88BA6K8wypiej6q8kuTCHSVDLmXorrHn+PUo62rg8NZIRVjMOE
 VzdnTkKSZZUQafr6WTxAUGSQ87eUgRNPP69hH/Y2GiF/Mh4Vaz3zl9wfgeeESHzfD08i
 Qm74AtZIpxDK9aLqtQyC3s1k09LQylE/tUrT70h0AouOFkbnMtdiVvKfeA7N0hyIvS/3
 fFI70NcWCx5NA4/7+/xRraBHsg+c3MQwEKILwXPrfzq7fjLfDRkz+Nl8oTNT2YUsyZHp 6g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pes8p4162-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 17:42:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LHgUf9015646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 17:42:30 GMT
Received: from [10.71.109.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Mar
 2023 10:42:30 -0700
Message-ID: <fead4b41-a2b7-d6ea-e473-db75b5171d7b@quicinc.com>
Date:   Tue, 21 Mar 2023 10:42:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/7] soc: qcom: mdt_loader: Enhance split binary
 detection
To:     Bjorn Andersson <andersson@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
CC:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-5-quic_molvera@quicinc.com>
 <20230316021229.jpvaelcqb7vb7dwy@ripper>
Content-Language: en-US
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <20230316021229.jpvaelcqb7vb7dwy@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aCp565oekrEII4wgBjFuFtecFQ3pnsWB
X-Proofpoint-ORIG-GUID: aCp565oekrEII4wgBjFuFtecFQ3pnsWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210139
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Bjorn for the review comments.
On 3/15/2023 7:12 PM, Bjorn Andersson wrote:
> On Mon, Mar 06, 2023 at 03:11:59PM -0800, Melody Olvera wrote:
>> From: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
>>
>> When booting with split binaries, it may be that the offset of the first
>> program header lies inside the mdt's filesize, in this case the loader
>> would incorrectly assume that the bins were not split. The loading would
>> then continue on and fail for split bins.
> 
> Can you please be more explicit about the scenario you're having
> problems with?
> 
In this scenario below, the first pheader end address is < mdt file size 
but the next pheader lies outside the mdt file size. The 
_qcom_mdt_load() would continue on to load the firmware as a single 
image which leads to load error. By checking if all the pheaders lie 
inside the file size, we will be able to fix this issue.

fw = cdsp_dtb.mdt phdr->p_filesz = 148 phdr->p_offset 0 fw->size 4044
fw = cdsp_dtb.mdt phdr->p_filesz = 512 phdr->p_offset 148 fw->size 4044
fw = cdsp_dtb.mdt phdr->p_filesz = 3896 phdr->p_offset 4096 fw->size 4044

> Is the problem that the first segment is represented in both the .mdt
> and .b01, but different? Or is it that you find the hash in both .mdt
> abd .b01, but only one of them is valid?
> 
>> This change updates the logic used
>> by the mdt loader to understand whether the firmware images are split or not
>> by checking if each programs header's segment lies within the file or not.
>>
>> Signed-off-by: Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 64 +++++++++++++++++++----------------
>>   1 file changed, 35 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
>> index 33dd8c315eb7..3aadce299c02 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -31,6 +31,26 @@ static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
>>   	return true;
>>   }
>>   
>> +static bool qcom_mdt_bins_are_split(const struct firmware *fw)
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
>>   static ssize_t mdt_load_split_segment(void *ptr, const struct elf32_phdr *phdrs,
>>   				      unsigned int segment, const char *fw_name,
>>   				      struct device *dev)
>> @@ -167,23 +187,13 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>>   	/* Copy ELF header */
>>   	memcpy(data, fw->data, ehdr_size);
>>   
> 
> The existing code handles 3 cases:
> 
>> -	if (ehdr_size + hash_size == fw->size) {
> 
> 1) File is split, but hash resides with the ELF header in the .mdt
>
>> -		/* Firmware is split and hash is packed following the ELF header */
>> -		hash_offset = phdrs[0].p_filesz;
>> -		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
>> -	} else if (phdrs[hash_segment].p_offset + hash_size <= fw->size) {
> 
> 2) The hash segment exists in a segment of its own, but in the loaded
>     image.
> 
>> -		/* Hash is in its own segment, but within the loaded file */
>> +
>> +	if (qcom_mdt_bins_are_split(fw)) {
>> +		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
>> +	} else {
>>   		hash_offset = phdrs[hash_segment].p_offset;
>>   		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
>> -	} else {
> 
> 3) The image is split, and the hash segment resides in it's own file.
> 
> 
> Afaict the updated logic maintains #2 and #3, but drops #1. Please
> review the git history to see if you can determine which target this
> case exists with - and ask for someone to specifically verify your
> change there.
> 
> Perhaps all your change is doing is removing case #1, in which case this
> should be clear in the commit message; and we need to validate that your
> new assumptions holds.
>
>> -		/* Hash is in its own segment, beyond the loaded file */
>> -		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
> 
> For some reason you reversed the condition and got this out of the else
> (seems like an unnecessary change)...but in the process you lost the
> error handling below.
> 
Yes, Updating the patch to remove this unnecessary change in the 
qcom_mdt_read_metadat().
>> -		if (ret) {
>> -			kfree(data);
>> -			return ERR_PTR(ret);
>> -		}
>>   	}
>> -
>>   	*data_len = ehdr_size + hash_size;
>>   
>>   	return data;
>> @@ -270,6 +280,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   	phys_addr_t min_addr = PHYS_ADDR_MAX;
>>   	ssize_t offset;
>>   	bool relocate = false;
>> +	bool is_split;
>>   	void *ptr;
>>   	int ret = 0;
>>   	int i;
>> @@ -277,6 +288,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   	if (!fw || !mem_region || !mem_phys || !mem_size)
>>   		return -EINVAL;
>>   
>> +	is_split = qcom_mdt_bins_are_split(fw);
>>   	ehdr = (struct elf32_hdr *)fw->data;
>>   	phdrs = (struct elf32_phdr *)(ehdr + 1);
>>   
>> @@ -330,22 +342,16 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>>   
>>   		ptr = mem_region + offset;
>>   
>> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
>> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
>> -			/* Firmware is large enough to be non-split */
>> -			if (phdr->p_offset + phdr->p_filesz > fw->size) {
>> -				dev_err(dev, "file %s segment %d would be truncated\n",
>> -					fw_name, i);
>> -				ret = -EINVAL;
>> -				break;
>> +		if (phdr->p_filesz) {
> 
> If you just change the condition (phr->p_filesz && !issplit), then your
> patch becomes easier to read.
> 
Done.
V3: only make change in the __qcom_mdt_load() and not in the 
qcom_mdt_read_metadata().
> Regards,
> Bjorn
> 
>> +			if (!is_split) {
>> +				/* Firmware is large enough to be non-split */
>> +				memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
>> +			} else {
>> +				/* Firmware not large enough, load split-out segments */
>> +				ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
>> +				if (ret)
>> +					break;
>>   			}
>> -
>> -			memcpy(ptr, fw->data + phdr->p_offset, phdr->p_filesz);
>> -		} else if (phdr->p_filesz) {
>> -			/* Firmware not large enough, load split-out segments */
>> -			ret = mdt_load_split_segment(ptr, phdrs, i, fw_name, dev);
>> -			if (ret)
>> -				break;
>>   		}
>>   
>>   		if (phdr->p_memsz > phdr->p_filesz)
>> -- 
>> 2.25.1
>>
Thanks,
Gokul
