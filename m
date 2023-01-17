Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DB66D709
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjAQHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjAQHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:37:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC0223DA9;
        Mon, 16 Jan 2023 23:37:49 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H6nIl3024415;
        Tue, 17 Jan 2023 07:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JJ8Uq04lNzNLRtSiOMCe+s/f1GwyCHTmUxmoQL4veHI=;
 b=dH/UZEP1vgc0rsvZRubl15UmuSRYEk1DHa0UQLxrlwC9kdnNz2OmQTS9m6vvSdA5xYHx
 gzXJxJYRmcV9x9uVcpEsJk9YY5mJfb5nL9HUQr3rPZFgsztXvyqMxowDg12p7qRImsoT
 iA0bMMVm4CH5rpWrSg7CNbnIWOP4y2oRY1kcwJWO2OnPw+GoH2sac2Y86kbRYAAdFeDQ
 TIVpnl6Vf3Pz/lsBCAy3BPir7rxFfswdQt6tpcr+24oSyvK1S1Bu/VxuSG37zSwGbwZl
 N/HmrRVbH1FtcNneRbOngjFmBizTkC1GVKSLp9FmaDXOCjIhD495vGOKQeM9+hTdCjhm Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5kcamue2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 07:37:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30H7SgUH032596;
        Tue, 17 Jan 2023 07:37:49 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5kcamudf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 07:37:48 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GIXH2m007302;
        Tue, 17 Jan 2023 07:37:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16jgx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 07:37:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30H7beYm45678972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 07:37:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2162C204FA;
        Tue, 17 Jan 2023 07:37:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9472B204FB;
        Tue, 17 Jan 2023 07:37:39 +0000 (GMT)
Received: from [9.171.77.240] (unknown [9.171.77.240])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 07:37:39 +0000 (GMT)
Message-ID: <41023c65-16db-5f8b-c2d9-c794b3536896@linux.ibm.com>
Date:   Tue, 17 Jan 2023 08:37:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] s390/chsc: Switch over to memdup_user()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        vneethv@linux.ibm.com
Cc:     oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230117060443.62153-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20230117060443.62153-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bH7uO0EwjLtfosRsaC3JmTgwamxBU72-
X-Proofpoint-GUID: CF7s-bEYwHifN6St3WmIUoh4YDk9aRHy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_03,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17.01.23 um 07:04 schrieb Jiapeng Chong:
> Use memdup_user rather than duplicating its implementation, this is a
> little bit restricted to reduce false positives.
> 
> ./drivers/s390/cio/chsc_sch.c:703:7-14: WARNING opportunity for memdup_user.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3785
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/s390/cio/chsc_sch.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> index 180ab899289c..097769a955c3 100644
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -700,15 +700,11 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
>   	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
>   	if (!sccl_area)
>   		return -ENOMEM;
> -	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
> -	if (!ccl) {
> -		ret = -ENOMEM;
> -		goto out_free;
> -	}
> -	if (copy_from_user(ccl, user_ccl, sizeof(*ccl))) {
> -		ret = -EFAULT;
> -		goto out_free;
> -	}
> +
> +	ccl = memdup_user(user_ccl, sizeof(*ccl));
> +	if (IS_ERR(ccl))
> +		return PTR_ERR(ccl);

The old code did free sccl_area your code does not.

> +
>   	sccl_area->request.length = 0x0020;
>   	sccl_area->request.code = 0x0030;
>   	sccl_area->fmt = ccl->req.fmt;
