Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230206DAAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjDGJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbjDGJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A7E83FB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:09:32 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3376sclV022311;
        Fri, 7 Apr 2023 09:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mhe2fcvgGoObnLFAbBjX6UsiAnB4TwrRWehLSXHqZKc=;
 b=IWYyuGCvws0rJKy3FnslV5Xv3uAXL+4iyOR5c1byYhJ3QVsp+B50We1IMOYSkOIK0zVO
 DPhCd7+BQX3DdDQxa2ZxBr5U4TTGDCvcbVxf9TLP3CICLzmFQ7YgwrOaONr/Gzd97f0/
 2hridsLzPpG5m2tRuRR/lGplarUXwy1Neo1+SmmiWhRX317nXt9W9U8QS1zXjnErq6Yr
 3OJ9Oq66/P8lYiOTQCQSrD2MQSuV2nB++QFPnuGhqTj8Tq3nZl8vfuT/6eQJF/rYjemj
 lh2VJU8xQXvWbfWcfaasACVrwZ/7/cFpEUgUfhGlKpR6b4NMp6nF7dwr+8mo7/pYZyd3 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pteattps7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:09:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3378s9c1018038;
        Fri, 7 Apr 2023 09:09:25 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pteattpr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:09:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336MqZOl009513;
        Fri, 7 Apr 2023 09:09:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc874vae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:09:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33799Jx56554130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:09:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8A4E20040;
        Fri,  7 Apr 2023 09:09:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CCE20043;
        Fri,  7 Apr 2023 09:09:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:09:18 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:09:16 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 02/29] selftests/mm: Update .gitignore with two missing
 tests
Message-ID: <ZC/dvGIOX+KsVjOS@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160643.3106892-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160643.3106892-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cHvs_2wgwHErZeYTspwI8I-1fY0AIPA_
X-Proofpoint-GUID: nyjGBMwsdrUanGR-4VoPocKsvVZJODEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=942 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:06:43PM -0400, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 1f8c36a9fa10..347277f2adc3 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -36,3 +36,5 @@ split_huge_page_test
>  ksm_tests
>  local_config.h
>  local_config.mk
> +ksm_functional_tests
> +mdwe_test
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
