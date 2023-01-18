Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC3671B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjARMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjARMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:07:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF946D63;
        Wed, 18 Jan 2023 03:28:05 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IAC9CG017165;
        Wed, 18 Jan 2023 11:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=tvFrcVsE9AvpsfvfGvwG4Rmqctry5gm2IoLVVjAJM4Y=;
 b=b1tRJYsybQrpf2Z3BIfdJ/2oAslMeUrii8UjhfbCdEWVhT0/buNKNHEdaPOFAg5c9egt
 iHpuLSF9HiQZKWVN7tO7pOxWYkQO4riukkH315tM4kCfGvPG8JQoP8Qk/WV8EHpOZZgy
 5NY6lAPntn5g8PZKnMkS/vD65M6YkJiaSFRGlxDDzLzD0Dq8cQvapV8CWvfO+kPNGFiR
 l3CWrkEaBrPXqHA1UZnf1U9+OUNhYZCTPotXafhi4Ou8l8xZCiJG2vrUFByQd0qp6J1T
 MMyE5lTdXrKwwti/2uqoMoAVjpYm/Le1Dki4V4Mdu5bIF6RJC4cyh5EM8cOfc0hsbkLJ EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6et7snr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:28:04 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30IAx0hd001395;
        Wed, 18 Jan 2023 11:28:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6et7snqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:28:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMJ2WH023694;
        Wed, 18 Jan 2023 11:28:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16n6a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 11:28:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30IBRwgt48497012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 11:27:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D3A92004B;
        Wed, 18 Jan 2023 11:27:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7251A20043;
        Wed, 18 Jan 2023 11:27:57 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.34.8])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Jan 2023 11:27:57 +0000 (GMT)
Date:   Wed, 18 Jan 2023 12:27:55 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] s390/chsc: Switch over to memdup_user()
Message-ID: <Y8fXu92IySboNxVY@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230118095823.18785-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118095823.18785-1-jiapeng.chong@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sea-_7jQo3b6fLv2sIPoinf0hHZYXHLM
X-Proofpoint-ORIG-GUID: HPYg575DavTwW7NZzAdIdY-ctcvWiKgV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_04,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:58:23PM +0800, Jiapeng Chong wrote:
> Use memdup_user rather than duplicating its implementation, this is a
> little bit restricted to reduce false positives.
> 
> ./drivers/s390/cio/chsc_sch.c:703:7-14: WARNING opportunity for
> memdup_user.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3785
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Add free_page((unsigned long)sccl_area); 
> 
>  drivers/s390/cio/chsc_sch.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> index 180ab899289c..09dcce7ff24b 100644
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -700,15 +700,13 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
>  	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
>  	if (!sccl_area)
>  		return -ENOMEM;
> -	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
> -	if (!ccl) {
> -		ret = -ENOMEM;
> -		goto out_free;
> -	}
> -	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
> -		ret = -EFAULT;
> -		goto out_free;
> +
> +	ccl = memdup_user(user_ccl, sizeof(*ccl));
> +	if (IS_ERR(ccl)) {
> +		free_page((unsigned long)sccl_area);
> +		return PTR_ERR(ccl);
>  	}
> +
>  	sccl_area->request.length = 0x0020;
>  	sccl_area->request.code = 0x0030;
>  	sccl_area->fmt = ccl->req.fmt;

Such a change would have to address other similar patterns in this source.
Besides, it is not that obvious that swapping GFP_KERNEL for GFP_USER
(memdup_user() is called with) is issue-free.
