Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3796DD8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDKLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDKLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:10:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3C448C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:10:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B8pDWd001345;
        Tue, 11 Apr 2023 11:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vBHDB7m++mbZMTOfrpP8ZAjfcwZw4HuNlspOvW0JJb4=;
 b=QnXDLpzxQQGNsfBEOyRDCGF/3lmZR/oSq3CT6ZvD9f1WCsYgp054M8I+8HiF127F8cVG
 jOwFexEu9+ht3reri47NbTK2RDayqjIuueqpZGQCeX08fcyHBqYObcXIebv+Bg4ryRyw
 yC1cIK7IQewSvMwFQF99yuRD6k9tH9FX8KuHYI03w4WbjRNtQ7FOotpltGKnwgmuUU6F
 LOY431jvSKV3G888R/jwXWsLmE81/9Qn1kJbFHv1RxXZVtpRJPDCVS3tuKU4Ol1mJwBI
 ate0q07s0KCGVffSizG+8HBLjTZr7UJUWy6YLd2sHaS2jjvq4RnS5KMNnk+pP9pG6agm CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj76wmf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:10:00 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BAOD3A027909;
        Tue, 11 Apr 2023 11:10:00 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj76wmec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:09:59 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B1OP2f007878;
        Tue, 11 Apr 2023 11:09:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3pu0mkhdjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 11:09:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BB9tbf19399226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 11:09:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 257472004B;
        Tue, 11 Apr 2023 11:09:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB09B20063;
        Tue, 11 Apr 2023 11:09:53 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 11:09:53 +0000 (GMT)
Date:   Tue, 11 Apr 2023 14:09:51 +0300
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
Subject: Re: [PATCH 21/29] selftests/mm: Add framework for uffd-unit-test
Message-ID: <ZDU//1RXYUMIRMk3@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160818.3107545-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160818.3107545-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kSFOURbIqGOe1ew2gag54SJCESCVnEWJ
X-Proofpoint-ORIG-GUID: zX6om6PvPyaB-EZgHYAR4EH4wsMeRE2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_06,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110099
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:08:18PM -0400, Peter Xu wrote:
> Add a framework to be prepared to move unit tests from uffd-stress.c into
> uffd-unit-tests.c.  The goal is to allow detection of uffd features for
> each test, and also loop over specified types of memory that a test support.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 125 +++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.c         |  27 ++++
>  tools/testing/selftests/mm/vm_util.h         |   1 +
>  3 files changed, 153 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index dfb44ffad5f5..007145063363 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -9,6 +9,66 @@
> 
>  #ifdef __NR_userfaultfd
> 
> +/* The unit test doesn't need a large or random size, make it 32MB for now */
> +#define  UFFD_TEST_MEM_SIZE               (32UL << 20)
> +
> +#define  MEM_ANON                         BIT_ULL(0)
> +#define  MEM_SHMEM                        BIT_ULL(1)
> +#define  MEM_SHMEM_PRIVATE                BIT_ULL(2)
> +#define  MEM_HUGETLB                      BIT_ULL(3)
> +#define  MEM_HUGETLB_PRIVATE              BIT_ULL(4)
> +
> +struct mem_type {
> +	const char *name;
> +	unsigned int mem_flag;
> +	uffd_test_ops_t *mem_ops;
> +	bool shared;
> +};
> +typedef struct mem_type mem_type_t;
> +
> +mem_type_t mem_types[] = {
> +	{
> +		.name = "anon",
> +		.mem_flag = MEM_ANON,
> +		.mem_ops = &anon_uffd_test_ops,
> +		.shared = false,
> +	},
> +	{
> +		.name = "shmem",
> +		.mem_flag = MEM_SHMEM,
> +		.mem_ops = &shmem_uffd_test_ops,
> +		.shared = true,
> +	},
> +	{
> +		.name = "shmem-private",
> +		.mem_flag = MEM_SHMEM_PRIVATE,
> +		.mem_ops = &shmem_uffd_test_ops,
> +		.shared = false,
> +	},
> +	{
> +		.name = "hugetlb",
> +		.mem_flag = MEM_HUGETLB,
> +		.mem_ops = &hugetlb_uffd_test_ops,
> +		.shared = true,
> +	},
> +	{
> +		.name = "hugetlb-private",
> +		.mem_flag = MEM_HUGETLB_PRIVATE,
> +		.mem_ops = &hugetlb_uffd_test_ops,
> +		.shared = false,
> +	},
> +};
> +
> +/* Returns: UFFD_TEST_* */
> +typedef void (*uffd_test_fn)(void);
> +
> +typedef struct {
> +	const char *name;
> +	uffd_test_fn uffd_fn;
> +	unsigned int mem_targets;
> +	uint64_t uffd_feature_required;
> +} uffd_test_case_t;
> +
>  struct {
>  	unsigned int pass, skip, fail, total;
>  } uffd_test_acct;
> @@ -108,9 +168,50 @@ static int test_uffd_api(bool use_dev)
>  	return 1;
>  }
> 
> +/*
> + * This function initializes the global variables.  TODO: remove global
> + * vars and then remove this.
> + */
> +static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type)
> +{
> +	map_shared = mem_type->shared;
> +	uffd_test_ops = mem_type->mem_ops;
> +
> +	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
> +		page_size = default_huge_page_size();
> +	else
> +		page_size = psize();
> +
> +	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
> +	/* TODO: remove this global var.. it's so ugly */
> +	nr_cpus = 1;
> +
> +	return uffd_test_ctx_init(test->uffd_feature_required);
> +}
> +
> +static bool uffd_feature_supported(uffd_test_case_t *test)
> +{
> +	uint64_t features;
> +
> +	if (uffd_get_features(&features))
> +		return false;
> +
> +	return (features & test->uffd_feature_required) ==
> +	    test->uffd_feature_required;
> +}
> +
> +uffd_test_case_t uffd_tests[] = {
> +};
> +
>  int main(int argc, char *argv[])
>  {
> +	int n_tests = sizeof(uffd_tests) / sizeof(uffd_test_case_t);
> +	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
> +	uffd_test_case_t *test;
> +	mem_type_t *mem_type;
> +	char test_name[128];
>  	int has_uffd;
> +	int i, j;
> 
>  	has_uffd = test_uffd_api(false);
>  	has_uffd |= test_uffd_api(true);
> @@ -119,7 +220,31 @@ int main(int argc, char *argv[])
>  		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
>  		exit(KSFT_SKIP);
>  	}
> +
> +	for (i = 0; i < n_tests; i++) {
> +		test = &uffd_tests[i];
> +		for (j = 0; j < n_mems; j++) {
> +			mem_type = &mem_types[j];
> +			if (!(test->mem_targets & mem_type->mem_flag))
> +				continue;
> +			snprintf(test_name, sizeof(test_name),
> +				 "%s on %s", test->name, mem_type->name);
> +
> +			uffd_test_start(test_name);
> +			if (!uffd_feature_supported(test)) {
> +				uffd_test_skip("feature missing");
> +				continue;
> +			}
> +			if (uffd_setup_environment(test, mem_type)) {
> +				uffd_test_skip("memory allocation failed");

Maybe uffd_test_skip("environment setup failed")?

> +				continue;
> +			}
> +			test->uffd_fn();
> +		}
> +	}
> +
>  	uffd_test_report();
> +
>  	return uffd_test_acct.fail ? KSFT_FAIL : KSFT_PASS;
>  }
> 
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 62fcf039d6b7..dad1f62a7ecd 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -264,3 +264,30 @@ int uffd_open(unsigned int flags)
> 
>  	return uffd;
>  }
> +
> +int uffd_get_features(uint64_t *features)
> +{
> +	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
> +	/*
> +	 * This should by default work in most kernels; the feature list
> +	 * will be the same no matter what we pass in here.
> +	 */
> +	int fd = uffd_open(UFFD_USER_MODE_ONLY);
> +
> +	if (fd < 0)
> +		/* Maybe the kernel is older than user-only mode? */
> +		fd = uffd_open(0);
> +
> +	if (fd < 0)
> +		return fd;
> +
> +	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
> +		close(fd);
> +		return -errno;
> +	}
> +
> +	*features = uffdio_api.features;
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index a67db8432855..2edad3256271 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -51,6 +51,7 @@ int uffd_open(unsigned int flags);
>  int uffd_register(int uffd, void *addr, uint64_t len,
>  		  bool miss, bool wp, bool minor);
>  int uffd_unregister(int uffd, void *addr, uint64_t len);
> +int uffd_get_features(uint64_t *features);
> 
>  /*
>   * On ppc64 this will only work with radix 2M hugepage size
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
