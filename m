Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ADF607CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiJUQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJUQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:47:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03756C4C07;
        Fri, 21 Oct 2022 09:47:01 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LFt5LV019099;
        Fri, 21 Oct 2022 16:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ez5BH5Dj8oFv/HPxDtmpfHFCn9TPkAsmPS3teW9LZxI=;
 b=kdS+nE/+QjBqT5qrsCBMVpsw0UEEh1PKgoB1G9jMkoh3K1jhOj5Wp/8rJ3Kp8b/KLBIj
 xn83asJAQSXcYahmKJ9SRsoN4GC5xH2pcZiCGtJrh60ivrqZfrQa7bbMilMF2Lr6vFwm
 ytcHJl1v42TdFsUoMj47crKHKgi5uytmnA4CVqLo7DYz2LRWad+W6JEQwKF9NXHF6w0Q
 U5YRHsRGRJFhbRaI7A6DTBTcdI7JTWh+6riInsuYFNYkqby8pprwMbnxVpgBIkOOdPh/
 HRFBMNXa9girYcE33EpT21RN8ZfEveBLofHPfABNev+MXJ9WPo2A22IHWibd4sAyyL7S ww== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kbxg5stcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 16:46:52 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LGawOw026132;
        Fri, 21 Oct 2022 16:46:52 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3kakejvqa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 16:46:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LGkoxX10945196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 16:46:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 989E458050;
        Fri, 21 Oct 2022 16:46:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09C25805E;
        Fri, 21 Oct 2022 16:46:49 +0000 (GMT)
Received: from [9.160.117.177] (unknown [9.160.117.177])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 16:46:49 +0000 (GMT)
Message-ID: <c0f5c096-3cab-1df4-6cc5-7f4c42271fc0@linux.ibm.com>
Date:   Fri, 21 Oct 2022 12:46:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] s390/vfio-ap: Fix memory allocation for mdev_types array
Content-Language: en-US
To:     "Jason J. Herne" <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20221021145905.15100-1-jjherne@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20221021145905.15100-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GZSjgrTMJ3slCcpxeeLLAZQYKPFre41w
X-Proofpoint-ORIG-GUID: GZSjgrTMJ3slCcpxeeLLAZQYKPFre41w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 10:59 AM, Jason J. Herne wrote:
> The vfio-ap crypto driver fails to allocate memory for an array of
> pointers used to pass supported mdev types to mdev_register_parent().
> 
> Since we only support a single mdev type, the fix is to allocate a
> single entry in the ap_matrix_dev->mdev_types array.
> 
> Fixes: 63e685747784 ("s390: vfio-ap: base implementation of VFIO AP device driver")

I think you want

Fixes: da44c340c4fe ("vfio/mdev: simplify mdev_type handling")

Where *mdev_types[] was introduced.  The fix you propose is the same way Christoph (added to CC) handled vfio-ccw, LGTM.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> Cc: stable@vger.kernel.org
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_private.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 2eddd5f34ed3..976a65f32e7d 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -52,7 +52,7 @@ struct ap_matrix_dev {
>  	struct mutex guests_lock; /* serializes access to each KVM guest */
>  	struct mdev_parent parent;
>  	struct mdev_type mdev_type;
> -	struct mdev_type *mdev_types[];
> +	struct mdev_type *mdev_types[1];
>  };
>  
>  extern struct ap_matrix_dev *matrix_dev;

