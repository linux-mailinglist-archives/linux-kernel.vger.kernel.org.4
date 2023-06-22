Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2AF73A75A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjFVRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:35:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD0195;
        Thu, 22 Jun 2023 10:35:33 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MHVNUu011491;
        Thu, 22 Jun 2023 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9tyzelE/CfhxIdLo1UoXcOp66NvdPJuzSlYJUTtmhiA=;
 b=QFABqxr/nFLm42jXrIFG8Xeiq7rWgNqdpu09LrWwWjOEMoJg4dsmw5Ttr/Zy1vtzibFR
 EBT1WXwEOw/BiFKBD8fuES15OssfxuwziSATcz8qNy+IxOT1m0RFdRhQQ5dFpYP4Pp40
 /2yg+ZkSpmxQc0nsOXqbZzfByySZbBNvPHV/CZm98Zxhd1H9MV/zHZQ+R5yPpGZurOgB
 ZYyCIrkiEJJgp9BdlpU05X5lDXqSJN6rLm9Wc6Sfka9xjSqvz89OaKqURhxoGjXaAgSN
 qoe/M0Ge5xjr+K4jgANG4zwtxI/L69soFccOVHe4H4gRGyM5N89+G0KrRI7pLkKyxULH AQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rctsa058y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 17:35:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M4Q5je023820;
        Thu, 22 Jun 2023 17:35:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f52rx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 17:35:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MHZL0247841648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 17:35:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1081620043;
        Thu, 22 Jun 2023 17:35:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3D320040;
        Thu, 22 Jun 2023 17:35:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.59.34])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Jun 2023 17:35:20 +0000 (GMT)
Date:   Thu, 22 Jun 2023 19:35:18 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/79] s390: switch to new ctime accessors
Message-ID: <ZJSGVjryWEjbeW1U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-2-jlayton@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L3e2459YKnOIRaNY1SUuDk5l6OLqSLq-
X-Proofpoint-GUID: L3e2459YKnOIRaNY1SUuDk5l6OLqSLq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=600 bulkscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:45:16AM -0400, Jeff Layton wrote:

Hi Jeff,
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  arch/s390/hypfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index ee919bfc8186..30fa336ec63e 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_block *sb)
>  	struct inode *inode = d_inode(sb_info->update_file);
>  
>  	sb_info->last_update = ktime_get_seconds();
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  }
>  
>  /* directory tree removal functions */
> @@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
>  		ret->i_mode = mode;
>  		ret->i_uid = hypfs_info->uid;
>  		ret->i_gid = hypfs_info->gid;
> -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
>  		if (S_ISDIR(mode))
>  			set_nlink(ret, 2);
>  	}

I guess, inode_set_ctime() called from inode_ctime_set_current()
updates i_ctime and is part of some other series?

Thanks!
