Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711226E9150
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjDTK6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjDTK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:58:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB8AF15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:55:44 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KAdjHK004924;
        Thu, 20 Apr 2023 10:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dxBKJuQoZgIgrup9y+TjScvMvFy+yhyXYkJBZ7IFu4w=;
 b=BAW//N8aEFzwC0IRkcZrhjleUtDZxl7/a6FXNKD43m0mf66zNe507eXZGZfPX6+8c5Fe
 dftGQFE37ACimnzTHwsUr/5byXxD1g43YWIBJje3tD8ak72HFClU53Vc9bOHZnOU9/pJ
 bVQ6Zgsqz0EGCnwTjK/8+aTZh50/p2U7Upn+XI0MNw9mTkvvqSRsJCVmLznBscnFWd0N
 BRPWTRe08e8hLuRJ8bLhhFqV2toosa8LJGuOjvbcSYx/KBb1z3i3im6kowelnJBGtARm
 zz9jxqePlp+R9RRk0LDdzeNLjiHWMufbnaXq/C8b5hdvXXQ/2SVBaPzYBs3ByM0tIHN/ Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2ysb0dt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:55:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33KAgIGA016539;
        Thu, 20 Apr 2023 10:55:33 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2ysb0ds9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:55:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33K4T69Q018350;
        Thu, 20 Apr 2023 10:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pykj6asdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:55:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33KAtTpI20775554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 10:55:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD6620043;
        Thu, 20 Apr 2023 10:55:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD48020040;
        Thu, 20 Apr 2023 10:55:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.40.70])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Apr 2023 10:55:27 +0000 (GMT)
Date:   Thu, 20 Apr 2023 13:55:25 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 19/31] selftests/mm: Rename uffd_stats to uffd_args
Message-ID: <ZEEaHbw200cpBc+7@linux.ibm.com>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164337.328607-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412164337.328607-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oXabwgIdOi7gAy3lrZ0GORNWu4M_1oqi
X-Proofpoint-GUID: heLmQ-J4fBK8E5tT2CpuS0NDcON_0w0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:43:37PM -0400, Peter Xu wrote:
> Prepare for adding more fields into the struct.
> 
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 28 ++++++-------
>  tools/testing/selftests/mm/uffd-common.h |  6 +--
>  tools/testing/selftests/mm/uffd-stress.c | 51 ++++++++++++------------
>  3 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index f02dfcf10714..e746405aa8f3 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -186,34 +186,34 @@ struct uffd_test_ops hugetlb_uffd_test_ops = {
>  	.check_pmd_mapping = NULL,
>  };
> 
> -void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
> +void uffd_stats_report(struct uffd_args *args, int n_cpus)
>  {
>  	int i;
>  	unsigned long long miss_total = 0, wp_total = 0, minor_total = 0;
> 
>  	for (i = 0; i < n_cpus; i++) {
> -		miss_total += stats[i].missing_faults;
> -		wp_total += stats[i].wp_faults;
> -		minor_total += stats[i].minor_faults;
> +		miss_total += args[i].missing_faults;
> +		wp_total += args[i].wp_faults;
> +		minor_total += args[i].minor_faults;
>  	}
> 
>  	printf("userfaults: ");
>  	if (miss_total) {
>  		printf("%llu missing (", miss_total);
>  		for (i = 0; i < n_cpus; i++)
> -			printf("%lu+", stats[i].missing_faults);
> +			printf("%lu+", args[i].missing_faults);
>  		printf("\b) ");
>  	}
>  	if (wp_total) {
>  		printf("%llu wp (", wp_total);
>  		for (i = 0; i < n_cpus; i++)
> -			printf("%lu+", stats[i].wp_faults);
> +			printf("%lu+", args[i].wp_faults);
>  		printf("\b) ");
>  	}
>  	if (minor_total) {
>  		printf("%llu minor (", minor_total);
>  		for (i = 0; i < n_cpus; i++)
> -			printf("%lu+", stats[i].minor_faults);
> +			printf("%lu+", args[i].minor_faults);
>  		printf("\b)");
>  	}
>  	printf("\n");
> @@ -397,7 +397,7 @@ int uffd_read_msg(int ufd, struct uffd_msg *msg)
>  	return 0;
>  }
> 
> -void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
> +void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args)
>  {
>  	unsigned long offset;
> 
> @@ -407,7 +407,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
>  	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
>  		/* Write protect page faults */
>  		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
> -		stats->wp_faults++;
> +		args->wp_faults++;
>  	} else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) {
>  		uint8_t *area;
>  		int b;
> @@ -430,7 +430,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
>  		for (b = 0; b < page_size; ++b)
>  			area[b] = ~area[b];
>  		continue_range(uffd, msg->arg.pagefault.address, page_size);
> -		stats->minor_faults++;
> +		args->minor_faults++;
>  	} else {
>  		/*
>  		 * Missing page faults.
> @@ -460,14 +460,14 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
>  		offset &= ~(page_size-1);
> 
>  		if (copy_page(uffd, offset))
> -			stats->missing_faults++;
> +			args->missing_faults++;
>  	}
>  }
> 
>  void *uffd_poll_thread(void *arg)
>  {
> -	struct uffd_stats *stats = (struct uffd_stats *)arg;
> -	unsigned long cpu = stats->cpu;
> +	struct uffd_args *args = (struct uffd_args *)arg;
> +	unsigned long cpu = args->cpu;
>  	struct pollfd pollfd[2];
>  	struct uffd_msg msg;
>  	struct uffdio_register uffd_reg;
> @@ -502,7 +502,7 @@ void *uffd_poll_thread(void *arg)
>  			err("unexpected msg event %u\n", msg.event);
>  			break;
>  		case UFFD_EVENT_PAGEFAULT:
> -			uffd_handle_page_fault(&msg, stats);
> +			uffd_handle_page_fault(&msg, args);
>  			break;
>  		case UFFD_EVENT_FORK:
>  			close(uffd);
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 47565b2f2dee..f8d2ad178827 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -70,7 +70,7 @@
>  						  -  1)))
> 
>  /* Userfaultfd test statistics */
> -struct uffd_stats {
> +struct uffd_args {
>  	int cpu;
>  	unsigned long missing_faults;
>  	unsigned long wp_faults;
> @@ -98,12 +98,12 @@ extern uffd_test_ops_t shmem_uffd_test_ops;
>  extern uffd_test_ops_t hugetlb_uffd_test_ops;
>  extern uffd_test_ops_t *uffd_test_ops;
> 
> -void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
> +void uffd_stats_report(struct uffd_args *args, int n_cpus);
>  void uffd_test_ctx_init(uint64_t features);
>  void userfaultfd_open(uint64_t *features);
>  int uffd_read_msg(int ufd, struct uffd_msg *msg);
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp);
> -void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
> +void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
>  int __copy_page(int ufd, unsigned long offset, bool retry);
>  int copy_page(int ufd, unsigned long offset);
>  void *uffd_poll_thread(void *arg);
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 54fc9b4ffa3c..ce7251ab93ef 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -90,16 +90,15 @@ static void usage(void)
>  	exit(1);
>  }
> 
> -static void uffd_stats_reset(struct uffd_stats *uffd_stats,
> -			     unsigned long n_cpus)
> +static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
>  {
>  	int i;
> 
>  	for (i = 0; i < n_cpus; i++) {
> -		uffd_stats[i].cpu = i;
> -		uffd_stats[i].missing_faults = 0;
> -		uffd_stats[i].wp_faults = 0;
> -		uffd_stats[i].minor_faults = 0;
> +		args[i].cpu = i;
> +		args[i].missing_faults = 0;
> +		args[i].wp_faults = 0;
> +		args[i].minor_faults = 0;
>  	}
>  }
> 
> @@ -163,7 +162,7 @@ pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
> 
>  static void *uffd_read_thread(void *arg)
>  {
> -	struct uffd_stats *stats = (struct uffd_stats *)arg;
> +	struct uffd_args *args = (struct uffd_args *)arg;
>  	struct uffd_msg msg;
> 
>  	pthread_mutex_unlock(&uffd_read_mutex);
> @@ -172,7 +171,7 @@ static void *uffd_read_thread(void *arg)
>  	for (;;) {
>  		if (uffd_read_msg(uffd, &msg))
>  			continue;
> -		uffd_handle_page_fault(&msg, stats);
> +		uffd_handle_page_fault(&msg, args);
>  	}
> 
>  	return NULL;
> @@ -210,7 +209,7 @@ static void *background_thread(void *arg)
>  	return NULL;
>  }
> 
> -static int stress(struct uffd_stats *uffd_stats)
> +static int stress(struct uffd_args *args)
>  {
>  	unsigned long cpu;
>  	pthread_t locking_threads[nr_cpus];
> @@ -225,12 +224,12 @@ static int stress(struct uffd_stats *uffd_stats)
>  		if (bounces & BOUNCE_POLL) {
>  			if (pthread_create(&uffd_threads[cpu], &attr,
>  					   uffd_poll_thread,
> -					   (void *)&uffd_stats[cpu]))
> +					   (void *)&args[cpu]))
>  				return 1;
>  		} else {
>  			if (pthread_create(&uffd_threads[cpu], &attr,
>  					   uffd_read_thread,
> -					   (void *)&uffd_stats[cpu]))
> +					   (void *)&args[cpu]))
>  				return 1;
>  			pthread_mutex_lock(&uffd_read_mutex);
>  		}
> @@ -264,7 +263,7 @@ static int stress(struct uffd_stats *uffd_stats)
>  			if (write(pipefd[cpu*2+1], &c, 1) != 1)
>  				err("pipefd write error");
>  			if (pthread_join(uffd_threads[cpu],
> -					 (void *)&uffd_stats[cpu]))
> +					 (void *)&args[cpu]))
>  				return 1;
>  		} else {
>  			if (pthread_cancel(uffd_threads[cpu]))
> @@ -493,7 +492,7 @@ static int userfaultfd_events_test(void)
>  	int err, features;
>  	pid_t pid;
>  	char c;
> -	struct uffd_stats stats = { 0 };
> +	struct uffd_args args = { 0 };
> 
>  	printf("testing events (fork, remap, remove): ");
>  	fflush(stdout);
> @@ -508,7 +507,7 @@ static int userfaultfd_events_test(void)
>  			  true, test_uffdio_wp, false))
>  		err("register failure");
> 
> -	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
> +	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
> 
>  	pid = fork();
> @@ -526,9 +525,9 @@ static int userfaultfd_events_test(void)
>  	if (pthread_join(uffd_mon, NULL))
>  		return 1;
> 
> -	uffd_stats_report(&stats, 1);
> +	uffd_stats_report(&args, 1);
> 
> -	return stats.missing_faults != nr_pages;
> +	return args.missing_faults != nr_pages;
>  }
> 
>  static int userfaultfd_sig_test(void)
> @@ -538,7 +537,7 @@ static int userfaultfd_sig_test(void)
>  	int err, features;
>  	pid_t pid;
>  	char c;
> -	struct uffd_stats stats = { 0 };
> +	struct uffd_args args = { 0 };
> 
>  	printf("testing signal delivery: ");
>  	fflush(stdout);
> @@ -557,7 +556,7 @@ static int userfaultfd_sig_test(void)
> 
>  	uffd_test_ops->release_pages(area_dst);
> 
> -	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
> +	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
> 
>  	pid = fork();
> @@ -606,7 +605,7 @@ static int userfaultfd_minor_test(void)
>  	unsigned long p;
>  	pthread_t uffd_mon;
>  	char c;
> -	struct uffd_stats stats = { 0 };
> +	struct uffd_args args = { 0 };
> 
>  	if (!test_uffdio_minor)
>  		return 0;
> @@ -629,7 +628,7 @@ static int userfaultfd_minor_test(void)
>  		       page_size);
>  	}
> 
> -	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
> +	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
> 
>  	/*
> @@ -645,7 +644,7 @@ static int userfaultfd_minor_test(void)
>  	if (pthread_join(uffd_mon, NULL))
>  		return 1;
> 
> -	uffd_stats_report(&stats, 1);
> +	uffd_stats_report(&args, 1);
> 
>  	if (test_collapse) {
>  		printf("testing collapse of uffd memory into PMD-mapped THPs:");
> @@ -664,7 +663,7 @@ static int userfaultfd_minor_test(void)
>  		printf(" done.\n");
>  	}
> 
> -	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
> +	return args.missing_faults != 0 || args.minor_faults != nr_pages;
>  }
> 
>  static int pagemap_open(void)
> @@ -822,7 +821,7 @@ static int userfaultfd_stress(void)
>  {
>  	void *area;
>  	unsigned long nr;
> -	struct uffd_stats uffd_stats[nr_cpus];
> +	struct uffd_args args[nr_cpus];
>  	uint64_t mem_size = nr_pages * page_size;
> 
>  	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
> @@ -894,10 +893,10 @@ static int userfaultfd_stress(void)
>  		 */
>  		uffd_test_ops->release_pages(area_dst);
> 
> -		uffd_stats_reset(uffd_stats, nr_cpus);
> +		uffd_stats_reset(args, nr_cpus);
> 
>  		/* bounce pass */
> -		if (stress(uffd_stats))
> +		if (stress(args))
>  			return 1;
> 
>  		/* Clear all the write protections if there is any */
> @@ -926,7 +925,7 @@ static int userfaultfd_stress(void)
> 
>  		swap(area_src_alias, area_dst_alias);
> 
> -		uffd_stats_report(uffd_stats, nr_cpus);
> +		uffd_stats_report(args, nr_cpus);
>  	}
> 
>  	if (test_type == TEST_ANON) {
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
