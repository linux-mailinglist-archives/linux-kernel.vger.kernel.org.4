Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683FD702CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbjEOMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbjEOMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:41:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF4AE7B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:40:56 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FCd5pW025652;
        Mon, 15 May 2023 12:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=y7VZO3i0jEHi1G3Y5wq6HlPMkwjeV/q96QMXDOJRgpQ=;
 b=kfkCHRAt8cvUVCFwyvdfX8fJmv0fzm49/c/GhL3Y3w1T0i5xtf+DIWgOCjDdTbJugp2i
 FBinirD4jpYYP1+NKCVs734tewy/03O+RY98XPRywoCiqgTBugJBtZNM57qbv6RlUAEn
 1BlYIsrW3f4OhgNjdE5ftibj57KnaMyVgoS0jJZsVIWYYkTUzq4co+793LPBUm6SgeEL
 3f8Bri3aMqBpYGVMfC2PFNRaSGyXURTcC/TporUB3orsmn9YBg/TWrbKYMaIBiNYs6Ef
 KII3Ft/W5sxtBwChsJAjlBPg4rKHB/kSvrwdgx9F9iPwFCDvPbI9m0OwHbPBpk2ZHA2V hw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkjm8cmcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 12:40:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34F40KtV030719;
        Mon, 15 May 2023 12:40:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264s2pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 12:40:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34FCen1d46727676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 12:40:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B2BF2004D;
        Mon, 15 May 2023 12:40:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3D8320043;
        Mon, 15 May 2023 12:40:47 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.30.39])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 15 May 2023 12:40:47 +0000 (GMT)
Date:   Mon, 15 May 2023 14:40:46 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 0/2] statfs: Enforce statfs[64] structure intialization
Message-ID: <ZGIoTmQFO5SlmUIx@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230504144021.808932-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504144021.808932-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PfcF0mE3fcet91qhmbiaZPQ12HWXk5h2
X-Proofpoint-ORIG-GUID: PfcF0mE3fcet91qhmbiaZPQ12HWXk5h2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=610 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:40:19PM +0200, Ilya Leoshkevich wrote:
> This series fixes copying of uninitialized memory to userspace by
> do_statfs_native() and do_statfs64() on s390.
> 
> Patch 1 fixes the problem by making the code similar to
> put_compat_statfs() and put_compat_statfs64().
> 
> Patch 2 gets rid of the padding which caused the issue; even though it
> may be considered redundant, it documents that s390 de-facto has an
> extra f_spare array element.
> 
> Ilya Leoshkevich (2):
>   statfs: Enforce statfs[64] structure intialization
>   s390/uapi: Cover statfs padding by growing f_spare
> 
>  arch/s390/include/asm/compat.h      | 2 +-
>  arch/s390/include/uapi/asm/statfs.h | 4 ++--
>  fs/statfs.c                         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Series applied,
Thanks!
