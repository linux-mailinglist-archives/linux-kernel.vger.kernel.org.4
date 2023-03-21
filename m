Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B36C3205
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCUMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCUMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:47:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A4F945;
        Tue, 21 Mar 2023 05:47:50 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LAaaAv017946;
        Tue, 21 Mar 2023 12:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7wp2830olxyLiKEMlas9rntjPYb82A0zZoIUjfk/iH4=;
 b=gArTpYRlQ8q53pAdpWsyT6J0cUT/mG5267cmZVXzHKCwpS1BIcB0XSBbaR5Bkj/+iyRk
 CPzoqqGooM0xEGyHRIOaT1m1Tjl12voCgV+m4W6L9mQecmqeJ8Pycoj10J9YccRyYlbn
 1Sh9zsa4lWK4fu6HPuaKZB8PnK6Q6o9FWZjinmPjkX6uRlRjpaVc1t6UW93kgqvZbq7M
 ywsMRT2aqgaigGBEWSoRDjrQvzc7rS8c9k/qUPZ1cohkabeUCQ/LnBc14AiuqsPEH7ro
 i7leT7SQ8fOE7gTglJ/hNM+WBRRliglDWrBNnaq0e4sB7+nfSLE2S/LvtqWKmwflBihv xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf2j45c9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 12:47:50 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32LAr30o018248;
        Tue, 21 Mar 2023 12:47:49 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf2j45c9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 12:47:49 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LB4ox7009111;
        Tue, 21 Mar 2023 12:47:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x72j9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 12:47:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LClkcB20513470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 12:47:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83B3F5805D;
        Tue, 21 Mar 2023 12:47:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4D05805A;
        Tue, 21 Mar 2023 12:47:45 +0000 (GMT)
Received: from [9.65.246.37] (unknown [9.65.246.37])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 12:47:45 +0000 (GMT)
Message-ID: <ff09a138-c1f6-a977-5cff-520c468d2937@linux.ibm.com>
Date:   Tue, 21 Mar 2023 08:47:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] s390/vfio_ap: fix memory leak in vfio_ap device driver
Content-Language: en-US
From:   Anthony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
References: <20230320150447.34557-1-akrowiak@linux.ibm.com>
In-Reply-To: <20230320150447.34557-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qOUDgcDcwM7j7tyQUJ_Wdo2OIDeei4kn
X-Proofpoint-ORIG-GUID: ddZ3OQnX1jxqexk7BNvo3RB0aYpGVrD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING!

On 3/20/23 11:04 AM, Tony Krowiak wrote:
> The device release callback function invoked to release the matrix device
> uses the dev_get_drvdata(device *dev) function to retrieve the
> pointer to the vfio_matrix_dev object in order to free its storage. The
> problem is, this object is not stored as drvdata with the device; since the
> kfree function will accept a NULL pointer, the memory for the
> vfio_matrix_dev object is never freed.
>
> Since the device being released is contained within the vfio_matrix_dev
> object, the container_of macro will be used to retrieve its pointer.
>
> Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 997b524bdd2b..a48c6938ae68 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -54,8 +54,9 @@ static struct ap_driver vfio_ap_drv = {
>   
>   static void vfio_ap_matrix_dev_release(struct device *dev)
>   {
> -	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> +	struct ap_matrix_dev *matrix_dev;
>   
> +	matrix_dev = container_of(dev, struct ap_matrix_dev, device);
>   	kfree(matrix_dev);
>   }
>   
