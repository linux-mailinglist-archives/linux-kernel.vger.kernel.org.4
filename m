Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F76DAAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjDGJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbjDGJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:25:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710CCA5DC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:25:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3378AEmu023000;
        Fri, 7 Apr 2023 09:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yV4ptMBhDny4NuzTM8hQ8z+ptwHa64zZrPMeEguCARs=;
 b=NnaO9XN3EpatufrwKbKRJfGK9XKJf/Sc4OAOYTL7igrWTWCRcIgC3wKBkL3ryKE0UfRN
 E6W0TQqAvkFkGlZxEXo627RTDOQlOXGSSdmj/xGkMdAaB0wG21qfH2ccZGcF9iJ5dckY
 tP0XFvhP1sPu4bGt0ud9NuD2dvRwPEKreUf8TZAHh2rBRrxWJVNDlGWzJLTf5Bon2/jL
 GK5vhazG4DrJcWhF3pCzIQOX0sGNRrPQ+aOElT3sUGvR1IaFGSGtLAgushOYGN3ejriL
 hc8XiP3j2CSTpoAOQitrkmTmJOa2YHJ9n7reLk6gDpZFwL+usVKF+yINnUsTkRpCSloa hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptaquxteg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:24:45 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379Isnc003139;
        Fri, 7 Apr 2023 09:24:44 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptaquxte1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:24:44 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3372M1ST020697;
        Fri, 7 Apr 2023 09:24:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ppc873nk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:24:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379Oe6719923474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:24:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2150D20043;
        Fri,  7 Apr 2023 09:24:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FAF20040;
        Fri,  7 Apr 2023 09:24:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:24:38 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:24:37 +0300
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
Subject: Re: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into
 one
Message-ID: <ZC/hVYolgEzG/EW/@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160705.3106966-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160705.3106966-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EjtS2ZKNrsA2-FZeQjZV7Y8QMdPMiqZt
X-Proofpoint-ORIG-GUID: KyJrmNR60tNuoep-Pb5JUWJevm0MQ5YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=947 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:05PM -0400, Peter Xu wrote:
> There're already 3 same definitions of the three functions.  Move it into
> vm_util.[ch].
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/hugetlb-madvise.c | 25 +-------------------
>  tools/testing/selftests/mm/thuge-gen.c       | 19 +--------------
>  tools/testing/selftests/mm/userfaultfd.c     | 24 -------------------
>  tools/testing/selftests/mm/vm_util.c         | 21 ++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h         |  1 +
>  5 files changed, 24 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 9a127a8fe176..28426e30d9bc 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -18,6 +18,7 @@
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <fcntl.h>
> +#include "vm_util.h"
> 
>  #define MIN_FREE_PAGES	20
>  #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
> @@ -35,30 +36,6 @@
>  unsigned long huge_page_size;
>  unsigned long base_page_size;
> 
> -/*
> - * default_huge_page_size copied from mlock2-tests.c
> - */
> -unsigned long default_huge_page_size(void)
> -{
> -	unsigned long hps = 0;
> -	char *line = NULL;
> -	size_t linelen = 0;
> -	FILE *f = fopen("/proc/meminfo", "r");
> -
> -	if (!f)
> -		return 0;
> -	while (getline(&line, &linelen, f) > 0) {
> -		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> -			hps <<= 10;
> -			break;
> -		}
> -	}
> -
> -	free(line);
> -	fclose(f);
> -	return hps;
> -}
> -
>  unsigned long get_free_hugepages(void)
>  {
>  	unsigned long fhp = 0;
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 361ef7192cc6..380ab5f0a534 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -24,6 +24,7 @@
>  #include <unistd.h>
>  #include <stdarg.h>
>  #include <string.h>
> +#include "vm_util.h"
> 
>  #define err(x) perror(x), exit(1)
> 
> @@ -74,24 +75,6 @@ void find_pagesizes(void)
>  	globfree(&g);
>  }
> 
> -unsigned long default_huge_page_size(void)
> -{
> -	unsigned long hps = 0;
> -	char *line = NULL;
> -	size_t linelen = 0;
> -	FILE *f = fopen("/proc/meminfo", "r");
> -	if (!f)
> -		return 0;
> -	while (getline(&line, &linelen, f) > 0) {
> -		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> -			hps <<= 10;
> -			break;
> -		}
> -	}
> -	free(line);
> -	return hps;
> -}
> -
>  void show(unsigned long ps)
>  {
>  	char buf[100];
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> index a96d126cb40e..4cc80a0e8955 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1703,30 +1703,6 @@ static int userfaultfd_stress(void)
>  		|| userfaultfd_events_test() || userfaultfd_minor_test();
>  }
> 
> -/*
> - * Copied from mlock2-tests.c
> - */
> -unsigned long default_huge_page_size(void)
> -{
> -	unsigned long hps = 0;
> -	char *line = NULL;
> -	size_t linelen = 0;
> -	FILE *f = fopen("/proc/meminfo", "r");
> -
> -	if (!f)
> -		return 0;
> -	while (getline(&line, &linelen, f) > 0) {
> -		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> -			hps <<= 10;
> -			break;
> -		}
> -	}
> -
> -	free(line);
> -	fclose(f);
> -	return hps;
> -}
> -
>  static void set_test_type(const char *type)
>  {
>  	if (!strcmp(type, "anon")) {
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 0204c469be43..12dc654b5be3 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -180,3 +180,24 @@ int64_t allocate_transhuge(void *ptr, int pagemap_fd)
> 
>  	return -1;
>  }
> +
> +unsigned long default_huge_page_size(void)
> +{
> +	unsigned long hps = 0;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	FILE *f = fopen("/proc/meminfo", "r");
> +
> +	if (!f)
> +		return 0;
> +	while (getline(&line, &linelen, f) > 0) {
> +		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> +			hps <<= 10;
> +			break;
> +		}
> +	}
> +
> +	free(line);
> +	fclose(f);
> +	return hps;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 6edeb531afc6..d7163fff8fb7 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -35,6 +35,7 @@ bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>  int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> +unsigned long default_huge_page_size(void);
> 
>  /*
>   * On ppc64 this will only work with radix 2M hugepage size
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
