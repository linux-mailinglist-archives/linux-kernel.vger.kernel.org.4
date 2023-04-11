Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE576DD8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDKLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDKLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:03:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB84480
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:03:29 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BAaARY024808;
        Tue, 11 Apr 2023 11:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Do4XJnKmSYUZbGItdbXdmslVNxT1JsiWs1F6hMXqmm4=;
 b=fieGiU9W5wo7z+XyXevFP0+SSwp7aucdrtQARlMY61iCmkd0YsYhn8H0kb6wkbHPeVbE
 JcOsQBAtGFa4B+VR+ogp7nJ5SiQOG8/iqQ/AnM866p1ZO5L/MYQeL2/9FjP4IAS3ffYR
 nNiVUaFNYkgksyOFYKh0+ExfcaCHBSu3GcB7sU4ItdM84/rWReoR/KF/5MeBmFAm2AQB
 xipufrLjJqPNQpJVecR50lZh9DAaBcbI3xRcs5HDJUMGYlImZqBkUVchPxTS4EKD/HUU
 G9lbNzs31Vgg32zPU9AacKgHUY/4CvQqC1xD2HKYTAADStmVArsIJI6LVbPt1UtMW0av og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg0shm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:02:39 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BAbWc5031103;
        Tue, 11 Apr 2023 11:02:38 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg0sgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:02:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B3CudD001745;
        Tue, 11 Apr 2023 11:02:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pu0fvsdqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:02:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BB2YEW19595956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 11:02:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 354DF2004B;
        Tue, 11 Apr 2023 11:02:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8FDB20040;
        Tue, 11 Apr 2023 11:02:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 11:02:32 +0000 (GMT)
Date:   Tue, 11 Apr 2023 14:02:30 +0300
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
Subject: Re: [PATCH 20/29] selftests/mm: Allow allocate_area() to fail
 properly
Message-ID: <ZDU+Rudfi2BUsMHP@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160815.3107534-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160815.3107534-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: noFJAxATTJTU8tBnr-sTq67Hrt1MyBof
X-Proofpoint-ORIG-GUID: 3e3sBqJ7ZSqYAc96oiwIueLexn7BSzdN
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

On Thu, Mar 30, 2023 at 12:08:15PM -0400, Peter Xu wrote:
> Mostly to detect hugetlb allocation errors and skip hugetlb tests when
> pages are not allocated.

Wouldn't we want to skip anon and shmem tests as well for consistency?
 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c | 32 +++++++++++++++++-------
>  tools/testing/selftests/mm/uffd-common.h |  4 +--
>  2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 92b7e00efa8a..ae6b61144b53 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -44,10 +44,13 @@ static void anon_release_pages(char *rel_area)
>  		err("madvise(MADV_DONTNEED) failed");
>  }
> 
> -static void anon_allocate_area(void **alloc_area, bool is_src)
> +static int anon_allocate_area(void **alloc_area, bool is_src)
>  {
>  	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
>  			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (*alloc_area == MAP_FAILED)
> +		err("ENOMEM");
> +	return 0;
>  }
> 
>  static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> @@ -65,7 +68,7 @@ static void hugetlb_release_pages(char *rel_area)
>  	}
>  }
> 
> -static void hugetlb_allocate_area(void **alloc_area, bool is_src)
> +static int hugetlb_allocate_area(void **alloc_area, bool is_src)
>  {
>  	off_t size = nr_pages * page_size;
>  	off_t offset = is_src ? 0 : size;
> @@ -77,14 +80,16 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
>  			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
>  			   (is_src ? 0 : MAP_NORESERVE),
>  			   mem_fd, offset);
> -	if (*alloc_area == MAP_FAILED)
> -		err("mmap of hugetlbfs file failed");
> +	if (*alloc_area == MAP_FAILED) {
> +		*alloc_area = NULL;
> +		return -errno;
> +	}
> 
>  	if (map_shared) {
>  		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
>  				  MAP_SHARED, mem_fd, offset);
>  		if (area_alias == MAP_FAILED)
> -			err("mmap of hugetlb file alias failed");
> +			return -errno;
>  	}
> 
>  	if (is_src) {
> @@ -96,6 +101,7 @@ static void hugetlb_allocate_area(void **alloc_area, bool is_src)
>  		*alloc_area_alias = area_alias;
> 
>  	close(mem_fd);
> +	return 0;
>  }
> 
>  static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> @@ -112,7 +118,7 @@ static void shmem_release_pages(char *rel_area)
>  		err("madvise(MADV_REMOVE) failed");
>  }
> 
> -static void shmem_allocate_area(void **alloc_area, bool is_src)
> +static int shmem_allocate_area(void **alloc_area, bool is_src)
>  {
>  	void *area_alias = NULL;
>  	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
> @@ -150,6 +156,7 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
>  		area_dst_alias = area_alias;
> 
>  	close(mem_fd);
> +	return 0;
>  }
> 
>  static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> @@ -282,14 +289,19 @@ static void uffd_test_ctx_clear(void)
>  	munmap_area((void **)&area_remap);
>  }
> 
> -void uffd_test_ctx_init(uint64_t features)
> +int uffd_test_ctx_init(uint64_t features)
>  {
>  	unsigned long nr, cpu;
> +	int ret;
> 
>  	uffd_test_ctx_clear();
> 
> -	uffd_test_ops->allocate_area((void **)&area_src, true);
> -	uffd_test_ops->allocate_area((void **)&area_dst, false);
> +	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
> +	if (ret)
> +		return ret;
> +	ret = uffd_test_ops->allocate_area((void **)&area_dst, false);
> +	if (ret)
> +		return ret;
> 
>  	userfaultfd_open(&features);
> 
> @@ -337,6 +349,8 @@ void uffd_test_ctx_init(uint64_t features)
>  	for (cpu = 0; cpu < nr_cpus; cpu++)
>  		if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
>  			err("pipe");
> +
> +	return 0;
>  }
> 
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index f4bc73ce3b48..51ec75f6d0c1 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -80,7 +80,7 @@ struct uffd_stats {
>  };
> 
>  struct uffd_test_ops {
> -	void (*allocate_area)(void **alloc_area, bool is_src);
> +	int (*allocate_area)(void **alloc_area, bool is_src);
>  	void (*release_pages)(char *rel_area);
>  	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
>  	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
> @@ -101,7 +101,7 @@ extern uffd_test_ops_t hugetlb_uffd_test_ops;
>  extern uffd_test_ops_t *uffd_test_ops;
> 
>  void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
> -void uffd_test_ctx_init(uint64_t features);
> +int uffd_test_ctx_init(uint64_t features);
>  void userfaultfd_open(uint64_t *features);
>  int uffd_read_msg(int ufd, struct uffd_msg *msg);
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp);
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
