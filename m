Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09495F3B20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJDCHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJDCHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:07:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D433E09;
        Mon,  3 Oct 2022 19:07:48 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2941rwb1002111;
        Tue, 4 Oct 2022 02:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vxkIS4sYxHcCi5NVsYQIA+m66m/1laG01sM2rE/O5ag=;
 b=b2yKHY+1qwqdZzb1sZDOD3/u04ZSUFJNsQKzm7nGuNVe6VApIicNB+E4PGs4ul1kF+Yq
 HK41mK90JTLyFclevOv7+9Vl27qX4WS9AYITRznnLROmSDeypPEt2zH7Cgn1HtZI/Cjv
 yRDQY3YqwmsJ/PTBossfmL5s/OnnLczZr0dI9f5hdO023ybfwvKXKfsk9X57BpgNNBTw
 e2k7dZddXVaLqtitRsc8e0H3HzHqnAHH9og08NN1vsRsk0n19f/QTrmFZHbP6xiHyzP7
 fAZTgMSMQEFIAeFoZID/LyAAzvXUGdrbUqJGT9Lq1yf5+HdVeB8CvRjRDCWlEFSR2wjv Xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxd58n0e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 02:07:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29427Uet006742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 02:07:30 GMT
Received: from [10.110.42.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 19:07:28 -0700
Message-ID: <36c1b791-4d07-695f-e746-7f32f7c6222a@quicinc.com>
Date:   Mon, 3 Oct 2022 22:07:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation
 into mdt loader
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala (QUIC)" <quic_satyap@quicinc.com>,
        "Rajendra Nayak (QUIC)" <quic_rjendra@quicinc.com>,
        "Elliot Berman (QUIC)" <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh (QUIC)" <quic_gurus@quicinc.com>,
        <qui_sibis@quicinc.com>
References: <cover.1663007783.git.quic_gokukris@quicinc.com>
 <2ba262668e86e58acb086c64fc759ba02b39a525.1663007783.git.quic_gokukris@quicinc.com>
 <20220913201102.mjmtvsx5xyfcr5cw@builder.lan>
 <40718b43db8f4702b0dbfec79b6fc8ab@quicinc.com>
From:   Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
In-Reply-To: <40718b43db8f4702b0dbfec79b6fc8ab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LghCD41k9EHrtMCX9xI4flYmCdT7EEDU
X-Proofpoint-ORIG-GUID: LghCD41k9EHrtMCX9xI4flYmCdT7EEDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040012
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
With this patch we have moved the dma_alloc_coherent/dma_free_coherent 
is called from the mdt loader and is operating in the context of the 
caller, the scm device's struct device is not used in this patch. For 
the clients which do not pass the metadata physical argument to the 
qcom_mdt_read_metadata() - the memory is allocated using kmalloc- so the 
clients like qcom_q6v5_mss.c, where kfree is called will not be broken 
with this change.
Thanks,
Gokul

On 9/21/2022 12:39 PM, Gokul krishna Krishnakumar (QUIC) wrote:
>> At the end of this function we invoke kfree(metadata), which would be bad if that comes from dma_alloc_coherent().
> +       if (mdata_phys) {
> +               data = dma_alloc_coherent(dev, ehdr_size + hash_size, mdata_phys,
> +                                      GFP_KERNEL);
> +       } else {
> +               data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
> Adding dma_alloc_coherent without affecting the mss driver.
> 
> 
>> As LKP points out, I don't seem to have this function.
> Removing the qcom_get_scm_device() and calling dma_alloc_coherent from device context.
> +               data = dma_alloc_coherent(dev, ehdr_size + hash_size, mdata_phys,
> +                                      GFP_KERNEL);
> 
>> I am not thrilled about the idea of doing dma_alloc_coherent() in this file and dma_free_coherent() in the scm driver. Similarly, I consider these functions to operate in the context of the caller, so operating on the scm device's struct device isn't so nice.
>> After trying various models I came to the conclusion that it was better to try to keep the MDT loader to just load MDT files, and move the SCM/PAS interaction out of that. Unfortunately we have a number of client drivers that would then need to (essentially) duplicate the content of qcom_mdt_pas_init() - so I left >that in there.
>> I still believe that keeping the MDT loader focused on loading MDTs is a good idea, but I'm open to any suggestions for improvements in the interaction between these different components.
> 
> With this patch we moving all the dma_alloc_coherent() and dma_free_coherent() to the MDT loader.
> So now the MDT loader has the functionality of loading and allocating memory
> and the SCM driver packs the arguments and makes a call to the secure world.
> 
> -----Original Message-----
> From: Bjorn Andersson <andersson@kernel.org>
> Sent: Tuesday, September 13, 2022 4:11 PM
> To: Gokul krishna Krishnakumar (QUIC) <quic_gokukris@quicinc.com>
> Cc: Andy Gross <agross@kernel.org>; Konrad Dybcio <konrad.dybcio@somainline.org>; Philipp Zabel <p.zabel@pengutronix.de>; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org; Trilok Soni (QUIC) <quic_tsoni@quicinc.com>; Satya Durga Srinivasu Prabhala (QUIC) <quic_satyap@quicinc.com>; Rajendra Nayak (QUIC) <quic_rjendra@quicinc.com>; Elliot Berman (QUIC) <quic_eberman@quicinc.com>; Guru Das Srinagesh (QUIC) <quic_gurus@quicinc.com>
> Subject: Re: [PATCH v1 2/2] soc: qcom: mdt_loader: Move the memory allocation into mdt loader
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> On Mon, Sep 12, 2022 at 11:41:32AM -0700, Gokul krishna Krishnakumar wrote:
>> By moving the memory allocation to mdt loader we can simplify the scm
>> call, by just packing arguments provided to it from the clients for
>> making secuer world calls. We can also simplify the memory allocation
>> for the qcom metadata, by just doing one memory allocation in the mdt
>> loader.
>>
>> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_mss.c  |  2 +-
>>   drivers/soc/qcom/mdt_loader.c       | 41 ++++++++++++++++++++++++++++---------
>>   include/linux/soc/qcom/mdt_loader.h |  5 +++--
>>   3 files changed, 35 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index fddb63c..1919bfc 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -947,7 +947,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>>        int ret;
>>        int i;
>>
>> -     metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>> +     metadata = qcom_mdt_read_metadata(fw, &size, fw_name,
>> + qproc->dev, NULL);
> 
> At the end of this function we invoke kfree(metadata), which would be bad if that comes from dma_alloc_coherent().
> 
>>        if (IS_ERR(metadata))
>>                return PTR_ERR(metadata);
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c
>> b/drivers/soc/qcom/mdt_loader.c
> [..]
>> @@ -160,9 +164,18 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>>        ehdr_size = phdrs[0].p_filesz;
>>        hash_size = phdrs[hash_segment].p_filesz;
>>
>> -     data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
>> -     if (!data)
>> -             return ERR_PTR(-ENOMEM);
>> +     /*
>> +      * During the scm call memory protection will be enabled for the meta
>> +      * data blob, so make sure it's physically contiguous, 4K aligned and
>> +      * non-cachable to avoid XPU violations.
>> +      */
>> +     scm_dev = qcom_get_scm_device();
> 
> As LKP points out, I don't seem to have this function.
> 
>> +     data = dma_alloc_coherent(scm_dev, ehdr_size + hash_size, mdata_phys,
>> +                                    GFP_KERNEL);
> 
> I am not thrilled about the idea of doing dma_alloc_coherent() in this file and dma_free_coherent() in the scm driver. Similarly, I consider these functions to operate in the context of the caller, so operating on the scm device's struct device isn't so nice.
> 
> 
> After trying various models I came to the conclusion that it was better to try to keep the MDT loader to just load MDT files, and move the SCM/PAS interaction out of that. Unfortunately we have a number of client drivers that would then need to (essentially) duplicate the content of qcom_mdt_pas_init() - so I left that in there.
> 
> I still believe that keeping the MDT loader focused on loading MDTs is a good idea, but I'm open to any suggestions for improvements in the interaction between these different components.
> 
> Regards,
> Bjorn
