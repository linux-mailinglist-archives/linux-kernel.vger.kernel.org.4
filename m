Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A066D87D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjAQIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjAQIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:44:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A582CFD3;
        Tue, 17 Jan 2023 00:44:51 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7TTl4035730;
        Tue, 17 Jan 2023 08:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=leoOOrrw3C3TVawPvKAtBEOU/LpewykLLoPxX0V3vns=;
 b=ZbmOZdk89/eeeqbImIJ9M/nso3ieOIV7YWKlgPEPJYNv95a25Vvykx35fiCH5V8EVXBz
 ciHNiDK/3oUod+u2YkqU7F2klXpQ/1d5pJKVODBnDePN7EmxTMXAzrxEXfN5fjjoGFd2
 QsCrpN/AN6fRBdLtKFP5Kefb8CfCgfx9VJ1STOL0fLkEkVcU/ImcJIIBlYpBR8LqXb1r
 4dTRl+i4yPpgQcr2mb0UuMmpAz6/7NheNBD5xzRzX0OBotXohGnaBbOX/+tuScVbvFJ5
 Gj8wNuYA5ixM98yvE83c0ibRO3ph3cfCgaclqAS9AMJh479E5SstabXvxGUF4uatOsn9 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb5sgwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:44:50 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30H8a4Dx020878;
        Tue, 17 Jan 2023 08:44:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb5sgvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:44:49 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30H8ALkb007923;
        Tue, 17 Jan 2023 08:44:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfkjem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:44:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30H8ihpw52887844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 08:44:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4AD62004B;
        Tue, 17 Jan 2023 08:44:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CC1020040;
        Tue, 17 Jan 2023 08:44:43 +0000 (GMT)
Received: from osiris (unknown [9.152.212.250])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Jan 2023 08:44:43 +0000 (GMT)
Date:   Tue, 17 Jan 2023 09:44:42 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] s390/vmem: Use swap() instead of open coding it
Message-ID: <Y8Zf+tdh8xr6nviC@osiris>
References: <20230117060223.58583-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117060223.58583-1-jiapeng.chong@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fJJPRg_KhobNAppFZuCJ-29nsCQfji0V
X-Proofpoint-ORIG-GUID: 87_tvrgf_lYoJLGvoN1oRNkbw5ot0lHV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:02:23PM +0800, Jiapeng Chong wrote:
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
> 
> ./arch/s390/mm/vmem.c:680:10-11: WARNING opportunity for swap().
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3786
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/s390/mm/vmem.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 78d7768f93d7..774a71b94f5c 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -674,11 +674,8 @@ static void __init memblock_region_swap(void *a, void *b, int size)
>  {
>  	struct memblock_region *r1 = a;
>  	struct memblock_region *r2 = b;
> -	struct memblock_region swap;
>  
> -	swap = *r1;
> -	*r1 = *r2;
> -	*r2 = swap;
> +	swap(*r1, *r2);
>  }

Let's remove r1, and r2 as well. I applied the below:

From ff3ebe76f3b9481e6553bc2f05b52a266cd2e4a5 Mon Sep 17 00:00:00 2001
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date: Tue, 17 Jan 2023 14:02:23 +0800
Subject: [PATCH] s390/vmem: use swap() instead of open coding it

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./arch/s390/mm/vmem.c:680:10-11: WARNING opportunity for swap().

[hca@linux.ibm.com: get rid of all temp variables]
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3786
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230117060223.58583-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 78d7768f93d7..15daf777cf41 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -672,13 +672,7 @@ static int __init memblock_region_cmp(const void *a, const void *b)
 
 static void __init memblock_region_swap(void *a, void *b, int size)
 {
-	struct memblock_region *r1 = a;
-	struct memblock_region *r2 = b;
-	struct memblock_region swap;
-
-	swap = *r1;
-	*r1 = *r2;
-	*r2 = swap;
+	swap(*(struct memblock_region *)a, *(struct memblock_region *)b);
 }
 
 /*
-- 
2.34.1

