Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E835A6DD810
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDKKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:40:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74B10F5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:40:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BAa01p024612;
        Tue, 11 Apr 2023 10:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rqZDGds3qvhbK9cbbIfFzw9OPSONeRTt2V1GwH7loY0=;
 b=pjGUPIdQjLXxR6R8PqYVozbn7cBB7Ef6vHLxEeEcaw4Tp39TGWw4EWS2ovgBOd+vwaGB
 6TkPpX41t4BqTwrjEomjfn/A9gf/4DQDT8n5EHsO5Ax8negJOPoNToYbGftKl7jqvkVT
 TkVzaUA3hBxnYqtDunL/x8s/XW+l5BGDzhQMu8p9Z3HKObldWtn6EytdQJp//+RRPxG4
 4Dyg8NWxmvw5LStajAUgi/1+X7ohTtydf8egaD1lQRZoFUGacp/OkWmasHp+HbSOaRe5
 A+uhQFNYaN3ZDGbRMR3imeay10LpbGwqLtGA7eRrONF8kl3Nib46a/NWM2J61mTXIFsM FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg02a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:39:46 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BAbJlT030341;
        Tue, 11 Apr 2023 10:39:46 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg029c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:39:45 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B4Kibh008865;
        Tue, 11 Apr 2023 10:39:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pu0h5sdc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:39:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BAdfc127853378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 10:39:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D3F2004B;
        Tue, 11 Apr 2023 10:39:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1104520043;
        Tue, 11 Apr 2023 10:39:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 10:39:39 +0000 (GMT)
Date:   Tue, 11 Apr 2023 13:39:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 17/29] selftests/mm: Drop global mem_fd in uffd tests
Message-ID: <ZDU46iOyEQLdQSU3@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160806.3107497-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160806.3107497-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5m0oJ4Sx0jFzY0Hb3aXI-u3Y5PKcEbka
X-Proofpoint-ORIG-GUID: 7ssZyfZGPXLAYHbTc1YmtqJju9E9CVoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_06,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110099
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:08:06PM -0400, Peter Xu wrote:
> Drop it by creating the memfd dynamically in the tests.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 28 +++++++++++++++++++++++-
>  tools/testing/selftests/mm/uffd-common.h |  2 +-
>  tools/testing/selftests/mm/uffd-stress.c | 15 -------------
>  3 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 3a9b5c1aca9d..a2b6e4957d0f 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -12,12 +12,32 @@
>  volatile bool test_uffdio_copy_eexist = true;
>  unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
>  char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
> -int mem_fd, uffd = -1, uffd_flags, finished, *pipefd, test_type;
> +int uffd = -1, uffd_flags, finished, *pipefd, test_type;
>  bool map_shared, test_collapse, test_dev_userfaultfd;
>  bool test_uffdio_wp = true, test_uffdio_minor = false;
>  unsigned long long *count_verify;
>  uffd_test_ops_t *uffd_test_ops;
> 
> +static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
> +{
> +	unsigned int memfd_flags = 0;
> +	int mem_fd;
> +
> +	if (hugetlb)
> +		memfd_flags = MFD_HUGETLB;
> +	mem_fd = memfd_create("uffd-test", memfd_flags);
> +	if (mem_fd < 0)
> +		err("memfd_create");
> +	if (ftruncate(mem_fd, mem_size))
> +		err("ftruncate");
> +	if (fallocate(mem_fd,
> +		      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
> +		      mem_size))
> +		err("fallocate");
> +
> +	return mem_fd;
> +}
> +
>  static void anon_release_pages(char *rel_area)
>  {
>  	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
> @@ -51,6 +71,7 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
>  	off_t offset = is_src ? 0 : size;
>  	void *area_alias = NULL;
>  	char **alloc_area_alias;
> +	int mem_fd = uffd_mem_fd_create(size * 2, true);
> 
>  	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
>  			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> @@ -73,6 +94,8 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
>  	}
>  	if (area_alias)
>  		*alloc_area_alias = area_alias;
> +
> +	close(mem_fd);
>  }
> 
>  static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> @@ -95,6 +118,7 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
>  	size_t bytes = nr_pages * page_size;
>  	unsigned long offset = is_src ? 0 : bytes;
>  	char *p = NULL, *p_alias = NULL;
> +	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
> 
>  	if (test_collapse) {
>  		p = BASE_PMD_ADDR;
> @@ -124,6 +148,8 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
>  		area_src_alias = area_alias;
>  	else
>  		area_dst_alias = area_alias;
> +
> +	close(mem_fd);
>  }
> 
>  static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 11f770391bd9..0dfab7057295 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -87,7 +87,7 @@ typedef struct uffd_test_ops uffd_test_ops_t;
> 
>  extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
>  extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
> -extern int mem_fd, uffd, uffd_flags, finished, *pipefd, test_type;
> +extern int uffd, uffd_flags, finished, *pipefd, test_type;
>  extern bool map_shared, test_collapse, test_dev_userfaultfd;
>  extern bool test_uffdio_wp, test_uffdio_minor;
>  extern unsigned long long *count_verify;
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index e6d39a755082..4eca1a0276c2 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -1090,21 +1090,6 @@ int main(int argc, char **argv)
>  	}
>  	nr_pages = nr_pages_per_cpu * nr_cpus;
> 
> -	if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
> -		unsigned int memfd_flags = 0;
> -
> -		if (test_type == TEST_HUGETLB)
> -			memfd_flags = MFD_HUGETLB;
> -		mem_fd = memfd_create(argv[0], memfd_flags);
> -		if (mem_fd < 0)
> -			err("memfd_create");
> -		if (ftruncate(mem_fd, nr_pages * page_size * 2))
> -			err("ftruncate");
> -		if (fallocate(mem_fd,
> -			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
> -			      nr_pages * page_size * 2))
> -			err("fallocate");
> -	}
>  	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
>  	       nr_pages, nr_pages_per_cpu);
>  	return userfaultfd_stress();
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
