Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30C62E3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiKQSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiKQSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:20:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31639326EB;
        Thu, 17 Nov 2022 10:20:34 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHJuZr008783;
        Thu, 17 Nov 2022 18:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mw2i4kx5jvaD2ldRh8hGaXGexA85BqxrfKVl/LJGc8s=;
 b=OvDLG+ksZcyPNiy4aot5ey5i8EJRfcds3ZYHXIyWzsWocDCHF+E8xF64RVSeXL3PuQU/
 W4wkx65C/u7Dwhy+g006L9P1zUiaGGoqCtJEODXBSjj2JCVS/zNIG2Jn9wHkaud+5PsF
 GHXg2+m9FUaVT1ChOMrz7H4kDJsbxSQhlrtq3XC8zbmf+8YMxh3WdUrbTtWx1LqxlyfL
 usiK1a+uiMLmTT4KChgysPulUcgR6bwg5JZFquMxdEpD5y2hJdx0oN5Khuv6bcWX5aQZ
 HfDuxosoqN22sTEwt8zIMz/tIrptThIX1OPZ3hehu+dEDsYDb+Bq76dh3/3TqEFfqtiw Dg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kws8wse3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:20:33 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHIKAhK001106;
        Thu, 17 Nov 2022 18:20:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3ktbd9nmx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 18:20:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHIKSx92359924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:20:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02FE14C052;
        Thu, 17 Nov 2022 18:20:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18264C04E;
        Thu, 17 Nov 2022 18:20:27 +0000 (GMT)
Received: from osiris (unknown [9.145.178.212])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Nov 2022 18:20:27 +0000 (GMT)
Date:   Thu, 17 Nov 2022 19:20:26 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] s390/uaccess: Limit number of retries for
 cmpxchg_user_key
Message-ID: <Y3Z7aq/yqz3WQVsw@osiris>
References: <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
 <20221117100745.3253896-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117100745.3253896-1-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KG1e98z3MCBjf_5i7YbxmQWEPpJTDFiY
X-Proofpoint-ORIG-GUID: KG1e98z3MCBjf_5i7YbxmQWEPpJTDFiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=981
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:07:45AM +0100, Janis Schoetterl-Glausch wrote:
> cmpxchg_user_key for byte and short values is implemented via a one word
> cmpxchg loop. Give up trying to perform the cmpxchg if it fails too
> often because of contention on the cache line. This ensures that the
> thread cannot become stuck in the kernel.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> 128 might seem like a small number, but it actually seems to be plenty.
> I could not get it to return EAGAIN with MAX_LOOP being 8 while 248
> vcpus/threads are hammering the same word.
> This could mean that we don't actually need to limit the number of
> retries, but then, I didn't simulate the absolute worst case, where
> the competing threads are running on dedicated cpus.
> 
> 
>  arch/s390/include/asm/uaccess.h | 35 +++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Looks good, also applied to wip/cmpxchg_user_branch.

Thanks!
