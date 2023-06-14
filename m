Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059473011C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbjFNODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbjFNODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:03:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069A11B;
        Wed, 14 Jun 2023 07:03:19 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDl23P024367;
        Wed, 14 Jun 2023 14:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OnsMMHXkvX8tGPGJ7tBI0Qgi9uEaNmsJ+nUopfNucjs=;
 b=ieRAbxmco0mUYWcwfA8nJqrppnPTPWfJsI1XHQaPFQJpWvlp1JcrqeYuj9M78fngWOGk
 tsTKsDicL55FdG+CYiS60eNYYHhWZPaQI+UF7YKL8DWxpMOp7bpzNncKzA/PzPUnsMFH
 bbRLQYEWhsrBFa9RQYDcCy1xhJ2QJ5CyX2Pa0EwkkjcYbDEC7AqtA8rNgRb4QLjcqrGg
 JjXtV5nGUpInCuMBL9kgDrFmABsSnAOyLxZvFa3C/x4p79y/shv2eJ0me/wPvCONjq8w
 P/clDwSYbBm/bGM5T7kP6rFk+JzEACZM1wGVeFU7DNMNvghRrursIrUc0aHbS0VcUTm4 Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7er2rgy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:03:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EDnDWx000646;
        Wed, 14 Jun 2023 14:03:18 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7er2rgx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:03:18 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E75l3W018586;
        Wed, 14 Jun 2023 14:03:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r4gt525re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 14:03:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35EE3BI215794882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 14:03:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D531720043;
        Wed, 14 Jun 2023 14:03:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D9F2004B;
        Wed, 14 Jun 2023 14:03:11 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Jun 2023 14:03:11 +0000 (GMT)
Date:   Wed, 14 Jun 2023 16:03:10 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/crash: Use the correct type for memory allocation
Message-ID: <ZInInjGr6rufpC7u@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <0756118c9058338f3040edb91971d0bfd100027b.1686688212.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0756118c9058338f3040edb91971d0bfd100027b.1686688212.git.christophe.jaillet@wanadoo.fr>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q5ZpC26Pi0OavYJIFNQPjMjBps9eyRuQ
X-Proofpoint-ORIG-GUID: 4GofJmK3YyjIn6Y2zsBtgP0JP9dQgLxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_09,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:30:28PM +0200, Christophe JAILLET wrote:
> get_elfcorehdr_size() returns a size_t, so there is no real point to
> store it in a u32.
> 
> Turn 'alloc_size' into a size_t.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure if 'alloc_size' can overflow in real life application, but using
> the correct type looks harmless.
> 
> Should it be a real fix, either:
> Fixes: 8cce437fbb5c ("s390/kdump: Fix elfcorehdr size calculation")
> or
> Fixes: 60a0c68df263 ("[S390] kdump backend code")
> ---
>  arch/s390/kernel/crash_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 8a617be28bb4..7af69948b290 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -568,9 +568,9 @@ static size_t get_elfcorehdr_size(int mem_chunk_cnt)
>  int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
>  {
>  	Elf64_Phdr *phdr_notes, *phdr_loads;
> +	size_t alloc_size;
>  	int mem_chunk_cnt;
>  	void *ptr, *hdr;
> -	u32 alloc_size;
>  	u64 hdr_off;
>  
>  	/* If we are not in kdump or zfcp/nvme dump mode return */

Applied, thanks!
