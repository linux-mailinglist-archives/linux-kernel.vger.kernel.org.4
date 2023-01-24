Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE908679D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjAXPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjAXPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:24:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E643125B1;
        Tue, 24 Jan 2023 07:24:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OET9XS006166;
        Tue, 24 Jan 2023 15:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zZGjMjcjm4r7qco+xF5Csqx8YX3fGvwxRVOz+yxZjAk=;
 b=p4BBTOLbehhEpGSPhkTqTzBzbFwCazZ4hspvP7Id6zJ69hMv4QAYrI77GKunF9QLiyHf
 09CNfcOcRMjHqdiw1tW7K5pRHE0gBdFKSTYwUbiUz1Rgi3xy+SnPZ7K96KYq/UqRlbIm
 R0GnD5YJscst/9gJ81kW2hz8cFW3kvXz0CzlfhL0EPWUR3VPwsn1Pivmz9c7AJAFncAr
 woO3WDl8dQxMoUZ8MRg0tG4qVF8MpCdT3PvUDFo2ncAQc9AG5f+gnLseHhBYXIUY153z
 fdZHWrTWStWTMkzc+eLY9OMdY7mpV/7sYkn1saP6MBZYIoAkG8RnLRL0tY1u16AJITYL CA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3na6vyqtrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:23:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O4ujra018029;
        Tue, 24 Jan 2023 15:23:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p62usm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 15:23:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OFNnJO20120038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:23:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B2612004B;
        Tue, 24 Jan 2023 15:23:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B4920040;
        Tue, 24 Jan 2023 15:23:48 +0000 (GMT)
Received: from thinkpad (unknown [9.171.28.222])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue, 24 Jan 2023 15:23:48 +0000 (GMT)
Date:   Tue, 24 Jan 2023 16:23:46 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 8/9] mm/hugetlb: convert hugetlb_wp() to take in a folio
Message-ID: <20230124162346.404985e8@thinkpad>
In-Reply-To: <20230119211446.54165-9-sidhartha.kumar@oracle.com>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
        <20230119211446.54165-9-sidhartha.kumar@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FEepWRTrhP5FT2DgTCs3k73bRN9a3bTq
X-Proofpoint-ORIG-GUID: FEepWRTrhP5FT2DgTCs3k73bRN9a3bTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301240136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 13:14:45 -0800
Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

[...]
>  	page =3D pte_page(entry);
> -	if (page !=3D pagecache_page)
> +	if (page_folio(page) !=3D pagecache_folio)
>  		if (!trylock_page(page)) {
>  			need_wait_lock =3D 1;
>  			goto out_ptl;
>  		}
> =20
> -	get_page(page);
> +	folio_get(pagecache_folio);
> =20

We get a kernel crash on s390 in mprotect testcase from libhugetlbfs
testsuite, starting with next-20230120, bisected to this commit.

We get here with pagecache_folio =3D=3D NULL, and crash in folio_get().
It doesn=C2=B4t seem right to replace the get_page() with folio_get()
here, the matching put_page() at out_put_page: also wasn't changed
correspondingly. Also, pagecache_folio =3D=3D NULL seems to be a valid
case here, on all architectures.

Reverting this folio_get() to get_page() fixes the crash. Not sure
though if I missed something. I think you only want to replace
pagecache_page with pagecache_folio, like in the rest of the commit,
and not page -> pagecache_folio for this get_page().
