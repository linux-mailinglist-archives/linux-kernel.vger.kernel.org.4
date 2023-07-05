Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3D747CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGEGO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:14:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8310CF;
        Tue,  4 Jul 2023 23:14:24 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655qDAs016498;
        Wed, 5 Jul 2023 06:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=Ad7UrwTYbQdO4Is7msQLhnBCGOQD9eY6ijBTkR4U0sY=;
 b=qHy4h6xhHiwmJZJwkoWOZvZzJie/Fo1GWtkMix2CSYB9fa8hx/izfM2N+zYM91UrAhoA
 iF1lYFT0E28ICe99Dex8GHnNLfUN29VtPNqkyE/HzKP0Ait9d9yStC2N/IzXFcBejDFd
 HBJBFDjHFJL8OcsCGnqiXLFaSJ5CF2j974JYORpdaheYDzOaXKO85aVw5wTW83iYyoKT
 Bu5a8/+Bb/utiCj0l2ZueEHk7OdGC/umUyGFYOpJEm5ED1YH8LxBRdIc7QYdTPP0ApIo
 QFGZwjE1q95nnIaqT729aW6t+UXwBETs3I0m7S2t9TEMMhecb7roSyBh7lhJRa/KsB8v 5g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn2rbrftw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 06:13:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3653nOtE022962;
        Wed, 5 Jul 2023 06:13:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4ss4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 06:13:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3656DmHE24707650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 06:13:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E3012004B;
        Wed,  5 Jul 2023 06:13:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB5020043;
        Wed,  5 Jul 2023 06:13:47 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.32.210])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 06:13:47 +0000 (GMT)
From:   "Marc Hartmayer" <mhartmay@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, bblock@linux.ibm.com,
        bvanassche@acm.org, hch@lst.de, axboe@kernel.dk, yukuai3@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
In-Reply-To: <20230705024001.177585-1-yukuai1@huaweicloud.com>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
Date:   Wed, 05 Jul 2023 08:13:46 +0200
Message-ID: <878rbukhr9.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KsdSwAChGT3cewy1mBZTdUSoZMB0h3W8
X-Proofpoint-GUID: KsdSwAChGT3cewy1mBZTdUSoZMB0h3W8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:40 AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> make a mess how blk_get_queue() is called, blk_get_queue() returns true
> on success while the caller expects it returns 0 on success.
>
> Fix this problem and also add a corresponding error message on failure.
>
> Fixes: fcaa174a9c99 ("scsi/sg: don't grab scsi host module reference")
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Closes: https://lore.kernel.org/all/87lefv622n.fsf@linux.ibm.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/scsi/sg.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 89fa046c7158..0d8afffd1683 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1497,9 +1497,10 @@ sg_add_device(struct device *cl_dev)
>  	int error;
>  	unsigned long iflags;
>  
> -	error = blk_get_queue(scsidp->request_queue);
> -	if (error)
> -		return error;
> +	if (!blk_get_queue(scsidp->request_queue)) {
> +		pr_warn("%s: get scsi_device queue failed\n", __func__);
> +		return -ENODEV;
> +	}
>  
>  	error = -ENOMEM;
>  	cdev = cdev_alloc();
> -- 
> 2.39.2

Thanks.

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
