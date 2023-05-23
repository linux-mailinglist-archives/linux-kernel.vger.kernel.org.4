Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74070E2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjEWR3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjEWR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:29:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BFDA;
        Tue, 23 May 2023 10:29:28 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NHHwCa026436;
        Tue, 23 May 2023 17:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/foVFqL/eWRHOc5ZWHk40oDqUDdvWafwcxSESP77iS0=;
 b=HXcZG8NL4dc7wbv+ux//ogph8/nwnfbj2cVunxDj+AXeerBXRgZHGjJlaUXQJkTSdhoD
 eS0yDu91GSd82ZRO1stmJdxdE/y5B1i0yEZQACRHsKflFwSUorH47GjXFwKiOdkpZon+
 A2Yg0Ax9CcrHJOwh72BWydPTwrm/jyLgiQMuhI9m4RQ81ZtWUsDUNojJ4XUUHLLA03Ls
 UqGOsaRjVS7biXdpU0jvq+NHtcGVJn+aYt/kC1JZKHxvDekGjkxpp2O1zlsyCxA3PBDQ
 GowMpCKTQfC8a9GJirNRkE8tUU+9NHoGRNckBFXXYqTPoNL5ctHmcWY5Hx9RjVSv4z9U Gw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm207x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 17:29:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34NHTO1Z020819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 17:29:24 GMT
Received: from [10.71.110.156] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 10:29:23 -0700
Message-ID: <07beafde-19b6-2c25-6451-4c5871cb0012@quicinc.com>
Date:   Tue, 23 May 2023 10:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/1] soc: qcom: mdt_loader: Enhance split binary
 detection
To:     <linux-arm-msm@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20230509001821.24010-1-quic_gokukris@quicinc.com>
Content-Language: en-US
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <20230509001821.24010-1-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6AgNUu0ogTcA08z7W9q-gS7zctNvZMnI
X-Proofpoint-GUID: 6AgNUu0ogTcA08z7W9q-gS7zctNvZMnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230140
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2023 5:18 PM, Gokul krishna Krishnakumar wrote:
> It may be that the offset of the first program header lies inside the mdt's
> filesize, in this case the loader would incorrectly assume that the bins
> were not split and in this scenario the firmware authentication fails.
> This change updates the logic used by the mdt loader to understand whether
> the firmware images are split or not. It figures this out by checking if
> each programs header's segment lies within the file or not.
> 
> Co-developed-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> ---
> V6: Fixed format error in qcom_mdt_bins_are_split function definition and
> Correcting the s-o-b by keeping Melody as the co-developer.
> 
> V5: Removes extra empty lines from V4 and fixed the S-o-b by keeping Melody's
> name first.
> 
> V4: Change the commit text to include the scenario in which we see the problem.
> 
> V3: separated out from [1] and includes changes addressing comments
> from that patch set:
> 	1. Change the checking condition for non-split firmwares to
> 	(phr->p_filesz && !issplit) on line #352 for better readability.
> 	2. Removes an unncecessary check for split bins in qcom_mdt_read_metadata()/
> 
> [1] https://lore.kernel.org/all/20230306231202.12223-5-quic_molvera@quicinc.com/
> ---
>   drivers/soc/qcom/mdt_loader.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 3f11554df2f3..0e35d29b4438 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -258,6 +258,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
>   }
>   EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
>   
> +static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
> +{
> +	const struct elf32_phdr *phdrs;
> +	const struct elf32_hdr *ehdr;
> +	uint64_t seg_start, seg_end;
> +	int i;
> +
> +	ehdr = (struct elf32_hdr *)fw->data;
> +	phdrs = (struct elf32_phdr *)(ehdr + 1);
> +
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		seg_start = phdrs[i].p_offset;
> +		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
> +		if (seg_start > fw->size || seg_end > fw->size)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   			   const char *fw_name, int pas_id, void *mem_region,
>   			   phys_addr_t mem_phys, size_t mem_size,
> @@ -270,6 +290,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   	phys_addr_t min_addr = PHYS_ADDR_MAX;
>   	ssize_t offset;
>   	bool relocate = false;
> +	bool is_split;
>   	void *ptr;
>   	int ret = 0;
>   	int i;
> @@ -277,6 +298,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   	if (!fw || !mem_region || !mem_phys || !mem_size)
>   		return -EINVAL;
>   
> +	is_split = qcom_mdt_bins_are_split(fw, fw_name);
>   	ehdr = (struct elf32_hdr *)fw->data;
>   	phdrs = (struct elf32_phdr *)(ehdr + 1);
>   
> @@ -330,8 +352,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>   
>   		ptr = mem_region + offset;
>   
> -		if (phdr->p_filesz && phdr->p_offset < fw->size &&
> -		    phdr->p_offset + phdr->p_filesz <= fw->size) {
> +		if (phdr->p_filesz && !is_split) {
>   			/* Firmware is large enough to be non-split */
>   			if (phdr->p_offset + phdr->p_filesz > fw->size) {
>   				dev_err(dev, "file %s segment %d would be truncated\n",
Hi reviewers,
Could you please review this patch.

Thanks,
Gokul
