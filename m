Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742274AB98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGGHIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGGHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:08:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461C1BF4;
        Fri,  7 Jul 2023 00:08:48 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3676qZGP028823;
        Fri, 7 Jul 2023 07:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=NdxHY10mcR0RSzJ4MQePT91c+8nd5nmFRgcP7dwJ18M=;
 b=kCfOUNEjGY19BAZiwvE6K6FIhs+n5q2R4nmgrtV99ulO/hPQb7LJtJCWvct3ED69C7qM
 6yp+xXcO+JFpNqyiGaw5Y6c0EyLzuNpCTOW28YCX8CwGy0FClPZzcGKraDr1PFVjot+x
 S8cqZCHNs5n5i9erdVd1j60Mjx1Nwk6O2IQqFRMhb9cao5O8EjryOub07sUR4TWG9M9+
 YPPV8LrtXIp5E9SM4Z1HnMpMamK0W/IsCWBXr6bt1YyV3OvYEP1vS1KAsLjtB9CzN75y
 UwcIK+ClQ+6wz7KvWQyoqI42xEs2/oq2gbL86IV0ML/XDBYbJnodJV+Hd9wrivo3pnVK zg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpdtpr8wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:08:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3676glPs002157;
        Fri, 7 Jul 2023 07:08:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde3v60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 07:08:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367781j711535094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 07:08:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5135A20043;
        Fri,  7 Jul 2023 07:08:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C4DE20040;
        Fri,  7 Jul 2023 07:08:00 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.36.241])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Jul 2023 07:08:00 +0000 (GMT)
From:   "Marc Hartmayer" <mhartmay@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, bblock@linux.ibm.com,
        bvanassche@acm.org, hch@lst.de, axboe@kernel.dk, yukuai3@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
In-Reply-To: <20230705024001.177585-1-yukuai1@huaweicloud.com>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
Date:   Fri, 07 Jul 2023 09:07:58 +0200
Message-ID: <87fs609p2p.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hgJhIsuIuzjwVkobLKi7_ldeC1nWyT4O
X-Proofpoint-GUID: hgJhIsuIuzjwVkobLKi7_ldeC1nWyT4O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070064
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

Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>
