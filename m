Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1456DD813
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDKKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDKKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:41:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89710F5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:41:45 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B8FbI0019175;
        Tue, 11 Apr 2023 10:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KemTjHzQ1cxtTfSVAUARKI416p6mrWw/UzjHdehgoQs=;
 b=oQP0Dyl2kAGl6OM9B/AjKm66raGYWIOgYqZEmLPO7i/TDvQS2I5kfuCW+oX1+VvULXXX
 DuFIzCBvFFvMlilygqD4PBMWU9KQZzVk1x02IOarM+ZJoeKG3U5SZP8kSbuj8Ia5pzO7
 iOQMmuyn/Zw7ReLr9GtwTkT1jpkiJDi4BaTMzq0IzoPmkGl5vIzvLYBU5BJ6xsQ/JBDV
 ip9AZhJoSaN84XkCdUYN0ZEasChjlsQKj1M25gcHEx5VFxo5lm2bau2s6NaaYkN7i6lB
 EXiwiqUwcmXzEr/ZyEZlFWEzd86Kg9mDy4rlN2BKUTqhCAr5hJZebPSGieOIPbLe193Y Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2ux99k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:41:39 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BAMkfr008642;
        Tue, 11 Apr 2023 10:41:39 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj2ux988-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:41:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ANUvfE029945;
        Tue, 11 Apr 2023 10:41:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m21n7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:41:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BAfX9W45285884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 10:41:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD91E2004B;
        Tue, 11 Apr 2023 10:41:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6575B20040;
        Tue, 11 Apr 2023 10:41:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 10:41:32 +0000 (GMT)
Date:   Tue, 11 Apr 2023 13:41:30 +0300
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
Subject: Re: [PATCH 18/29] selftests/mm: Drop global hpage_size in uffd tests
Message-ID: <ZDU5Wq5TXKyragOa@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160809.3107511-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160809.3107511-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -P1OxYyVeoyiS62iV9JQ5cah5aBHjYs0
X-Proofpoint-ORIG-GUID: IDp-syDueMGHZeEfSQSQyaKpsJ421Z19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_06,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=980
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110094
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:08:09PM -0400, Peter Xu wrote:
> hpage_size was wrongly used.  Sometimes it means hugetlb default size,
> sometimes it was used as thp size.
> 
> Remove the global variable and use the right one at each place.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 7 ++++---
>  tools/testing/selftests/mm/uffd-common.h | 2 +-
>  tools/testing/selftests/mm/uffd-stress.c | 6 +++---
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index a2b6e4957d0f..025e40ffc7bf 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -10,7 +10,7 @@
>  #define BASE_PMD_ADDR ((void *)(1UL << 30))
> 
>  volatile bool test_uffdio_copy_eexist = true;
> -unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
> +unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
>  char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
>  int uffd = -1, uffd_flags, finished, *pipefd, test_type;
>  bool map_shared, test_collapse, test_dev_userfaultfd;
> @@ -115,7 +115,7 @@ static void shmem_release_pages(char *rel_area)
>  static void shmem_allocate_area(void **alloc_area, bool is_src)
>  {
>  	void *area_alias = NULL;
> -	size_t bytes = nr_pages * page_size;
> +	size_t bytes = nr_pages * page_size, hpage_size = read_pmd_pagesize();
>  	unsigned long offset = is_src ? 0 : bytes;
>  	char *p = NULL, *p_alias = NULL;
>  	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
> @@ -159,7 +159,8 @@ static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
> 
>  static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
>  {
> -	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_size))
> +	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages,
> +			      read_pmd_pagesize()))
>  		err("Did not find expected %d number of hugepages",
>  		    expect_nr_hpages);
>  }
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 0dfab7057295..47565b2f2dee 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -85,7 +85,7 @@ struct uffd_test_ops {
>  };
>  typedef struct uffd_test_ops uffd_test_ops_t;
> 
> -extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
> +extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
>  extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
>  extern int uffd, uffd_flags, finished, *pipefd, test_type;
>  extern bool map_shared, test_collapse, test_dev_userfaultfd;
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 4eca1a0276c2..54fc9b4ffa3c 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -655,7 +655,7 @@ static int userfaultfd_minor_test(void)
> 
>  		uffd_test_ops->check_pmd_mapping(area_dst,
>  						 nr_pages * page_size /
> -						 hpage_size);
> +						 read_pmd_pagesize());
>  		/*
>  		 * This won't cause uffd-fault - it purely just makes sure there
>  		 * was no corruption.
> @@ -997,7 +997,7 @@ static void parse_test_type_arg(const char *raw_type)
>  		err("Unsupported test: %s", raw_type);
> 
>  	if (test_type == TEST_HUGETLB)
> -		page_size = hpage_size;
> +		page_size = default_huge_page_size();
>  	else
>  		page_size = sysconf(_SC_PAGE_SIZE);
> 
> @@ -1035,6 +1035,7 @@ static void sigalrm(int sig)
>  int main(int argc, char **argv)
>  {
>  	size_t bytes;
> +	size_t hpage_size = read_pmd_pagesize();
> 
>  	if (argc < 4)
>  		usage();
> @@ -1043,7 +1044,6 @@ int main(int argc, char **argv)
>  		err("failed to arm SIGALRM");
>  	alarm(ALARM_INTERVAL_SECS);
> 
> -	hpage_size = default_huge_page_size();
>  	parse_test_type_arg(argv[1]);
>  	bytes = atol(argv[2]) * 1024 * 1024;
> 
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
