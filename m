Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1060A834
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiJXNCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiJXM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:59:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B09A9C5;
        Mon, 24 Oct 2022 05:18:47 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OBNZSR016993;
        Mon, 24 Oct 2022 12:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Px5gXCDOOzEyOnHQwzuLX9DMYHwCe64+xEWp9qlkQeE=;
 b=IS5qoXhALU+UcWeONvb0xbxKQB1TS1B6LAnLfelhIc5MFscifDMhQfb3Vas99WCr4KC1
 AWWWaaPmpfgou6T4H1F3HoIFmpPDxmzfrzOWz9I4AyrleHmcxk//f7r15hFFZ4xHWQer
 Su5QH/DNXaFyfJ2Qa64feKkS460i4WxrtavxcILVzlOzAzAzoSvxugVc/dHRmaD1m12S
 +H17YC6sICLug9QDmJ/Jgl3CZGXH6jrhOyxLPFi7JoJTJgsU1oExdySj0X7f56wviLJI
 sRZ7i016mC4r5nwlLuTNWt0TWgtONVVghN5HShP6Oemi1zTHUOQCzGAomS3+PrNM8SdP dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdssw92y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:01:38 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29OBOQRe019954;
        Mon, 24 Oct 2022 12:01:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdssw92x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:01:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OBpYsR009522;
        Mon, 24 Oct 2022 12:01:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kc859b781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:01:35 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OC1WBI4981314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 12:01:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB1AA405F;
        Mon, 24 Oct 2022 12:01:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EBB3A405B;
        Mon, 24 Oct 2022 12:01:32 +0000 (GMT)
Received: from [9.171.39.85] (unknown [9.171.39.85])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 12:01:32 +0000 (GMT)
Message-ID: <ec945db4-328d-f721-8d6f-3e10cce72787@linux.ibm.com>
Date:   Mon, 24 Oct 2022 14:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] s390/vfio-ap: Fix memory allocation for mdev_types array
Content-Language: en-US
To:     "Jason J. Herne" <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20221021145905.15100-1-jjherne@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20221021145905.15100-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IMpae6T6_JFVaJ2Y3M4az_4HSgoAOKI1
X-Proofpoint-ORIG-GUID: gWt4_Wg8taFDIbPhSlxvCy_M63cydWEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_03,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.10.22 um 16:59 schrieb Jason J. Herne:
> The vfio-ap crypto driver fails to allocate memory for an array of
> pointers used to pass supported mdev types to mdev_register_parent().
> 
> Since we only support a single mdev type, the fix is to allocate a
> single entry in the ap_matrix_dev->mdev_types array.
> 
> Fixes: 63e685747784 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> Cc: stable@vger.kernel.org
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_private.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 2eddd5f34ed3..976a65f32e7d 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -52,7 +52,7 @@ struct ap_matrix_dev {
>   	struct mutex guests_lock; /* serializes access to each KVM guest */
>   	struct mdev_parent parent;
>   	struct mdev_type mdev_type;
> -	struct mdev_type *mdev_types[];
> +	struct mdev_type *mdev_types[1];
>   };
>   
>   extern struct ap_matrix_dev *matrix_dev;


Thanks, will go via s390-fixes.

Alex, FYI.
