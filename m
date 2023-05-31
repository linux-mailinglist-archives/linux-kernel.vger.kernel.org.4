Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2BF71765C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEaFra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEaFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:47:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD211C;
        Tue, 30 May 2023 22:47:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5HHIr010866;
        Wed, 31 May 2023 05:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JVHD2w3X3KnAM1n+zKnQ6ZD6o3uYVXH4u8vCHT/VKl0=;
 b=dFXQXlciXMPdxB0CEEzVecbcBdZejhJZ4VEafmgl3RKq0V9YHIOKl34K9ZAG5rCHfeIt
 C0zQtbfs/dta6UH5oyGifodfgqwhpqL8dsZ20y6347FMSEJu+ryR0bqlzPHCAEb8iw4I
 2adclXPooXB+M67dIbKuo0P/JuNexxdy4x/pFgq9TScXQfgQS7KqtT007LEfDYh2UOfh
 EUO7R4QOS9zgJeHxh0aEl0NZocSZ0Xv3a9GB4z+Ex36LwOWBRRrAfGnyL3NpUEfmQ+ph
 /FlQ7UWwb4k4vrbtulOCH1tLTBTRABgozazz60RXplirx2Pq6KvO55O6Ez1WYUQ9QilN jQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8q888n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 05:46:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V5kgAc016084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 05:46:42 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 22:46:41 -0700
Message-ID: <29df7084-374a-8ef5-202e-fa7512da0464@quicinc.com>
Date:   Tue, 30 May 2023 22:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] scsi: ufs: core: Do not open code SZ_x
Content-Language: en-US
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Keoseong Park <keosung.park@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
References: <20230531051713.2080-1-avri.altman@wdc.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230531051713.2080-1-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YPDCIRBvRug5W-Qm4aJeFFWyoRaWkCZo
X-Proofpoint-GUID: YPDCIRBvRug5W-Qm4aJeFFWyoRaWkCZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_01,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2023 10:17 PM, Avri Altman wrote:
> v1 -> v2: Attend UTMRD as well
> 
> A tad cleanup - No functional change.
While you are at it, how about
blk_queue_update_dma_alignment(q, 4096 - 1) in ufshcd_slave_configure()

and drivers/ufs/core/ufshpb.c
pool_size = PAGE_ALIGN(ufshpb_host_map_kbytes * 1024) / PAGE_SIZE;

Thanks,
Bao
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/ufs/core/ufshcd.c | 10 +++++-----
>   include/ufs/ufshci.h      |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index fdf5073c7c6c..10a10f8f0bd1 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2519,7 +2519,7 @@ static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int
>   			 * 11b to indicate Dword granularity. A value of '3'
>   			 * indicates 4 bytes, '7' indicates 8 bytes, etc."
>   			 */
> -			WARN_ONCE(len > 256 * 1024, "len = %#x\n", len);
> +			WARN_ONCE(len > SZ_256K, "len = %#x\n", len);
>   			prd->size = cpu_to_le32(len - 1);
>   			prd->addr = cpu_to_le64(sg->dma_address);
>   			prd->reserved = 0;
> @@ -3765,7 +3765,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   
>   	/*
>   	 * Allocate memory for UTP Transfer descriptors
> -	 * UFSHCI requires 1024 byte alignment of UTRD
> +	 * UFSHCI requires 1KB alignment of UTRD
>   	 */
>   	utrdl_size = (sizeof(struct utp_transfer_req_desc) * hba->nutrs);
>   	hba->utrdl_base_addr = dmam_alloc_coherent(hba->dev,
> @@ -3773,7 +3773,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   						   &hba->utrdl_dma_addr,
>   						   GFP_KERNEL);
>   	if (!hba->utrdl_base_addr ||
> -	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
> +	    WARN_ON(hba->utrdl_dma_addr & (SZ_1K - 1))) {
>   		dev_err(hba->dev,
>   			"Transfer Descriptor Memory allocation failed\n");
>   		goto out;
> @@ -3797,7 +3797,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   						    &hba->utmrdl_dma_addr,
>   						    GFP_KERNEL);
>   	if (!hba->utmrdl_base_addr ||
> -	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
> +	    WARN_ON(hba->utmrdl_dma_addr & (SZ_1K - 1))) {
>   		dev_err(hba->dev,
>   		"Task Management Descriptor Memory allocation failed\n");
>   		goto out;
> @@ -8760,7 +8760,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
>   	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
>   	.can_queue		= UFSHCD_CAN_QUEUE,
>   	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
> -	.max_sectors		= (1 << 20) / SECTOR_SIZE, /* 1 MiB */
> +	.max_sectors		= SZ_1M / SECTOR_SIZE,
>   	.max_host_blocked	= 1,
>   	.track_queue_depth	= 1,
>   	.skip_settle_delay	= 1,
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index 11424bb03814..db2d5db5c88e 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -453,7 +453,7 @@ enum {
>   };
>   
>   /* The maximum length of the data byte count field in the PRDT is 256KB */
> -#define PRDT_DATA_BYTE_COUNT_MAX	(256 * 1024)
> +#define PRDT_DATA_BYTE_COUNT_MAX	SZ_256K
>   /* The granularity of the data byte count field in the PRDT is 32-bit */
>   #define PRDT_DATA_BYTE_COUNT_PAD	4
>   

