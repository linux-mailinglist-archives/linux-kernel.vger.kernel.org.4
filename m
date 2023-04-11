Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635DB6DD857
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDKKxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDKKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:53:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03E358E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:53:12 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BAa6pq024751;
        Tue, 11 Apr 2023 10:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=QOl8PppJhUyiOFXMysRbxGTHAnlq5gAJueozn3mMf9w=;
 b=BvXYlmiZx75P0kdspWED8EZCDgjhk4GV436cs7eNu4GHXp4RXIZnf0XN166rW3iXuFBS
 3vg67uujPN8u5J2zzo+q8VHNoLBRrgnDmcm+6BjiCW42PqXAp6sPihhQzSVuIqrBT2K5
 DtwQCJmPUQahmZ/ZFdiBgYM406QH2xffkOUBsnzvUjO7iXxRxEoeacAngzyxlVKZchjF
 PWmEOd5tETsUj09X7h+sBHZ/hkmZSqh6yCKruWvTfc7750aRwjQjB9jSHqj1YNqE/sl/
 58r3eZvNwveUPCrAjIGMXUenApHQQuzuX/pbOAqcFMpG6KC0vVBg+HpZMX5V2RCdHUhv MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg0f3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:53:07 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BAr6t5029646;
        Tue, 11 Apr 2023 10:53:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg0f2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:53:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B1IViE017748;
        Tue, 11 Apr 2023 10:53:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pu0hdhndd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:53:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BAr2oV46399828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 10:53:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32ABA20040;
        Tue, 11 Apr 2023 10:53:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4D5920043;
        Tue, 11 Apr 2023 10:53:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 10:53:00 +0000 (GMT)
Date:   Tue, 11 Apr 2023 13:52:58 +0300
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
Subject: Re: [PATCH 19/29] selftests/mm: Let uffd_handle_page_fault() takes
 wp parameter
Message-ID: <ZDU8CrPcr1Dclehj@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160812.3107522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160812.3107522-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fwtZIfCtKxXSSqWQlujHxIQGUGjMjyfI
X-Proofpoint-ORIG-GUID: i-54Q16tFIxjIcMyQFnI2QIsINNjpCRK
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

On Thu, Mar 30, 2023 at 12:08:12PM -0400, Peter Xu wrote:
> Subject: selftests/mm: Let uffd_handle_page_fault() takes wp parameter

Nit:                                                 ^ take

> Make the handler optionally apply WP bit when resolving page faults for
> either missing or minor page faults.  This move towards removing global

Nit:                                        ^ moves

> test_uffdio_wp outside of the common code.
> 
> For this, slightly abuse uffd_stats to keep one more parameter on whether
> we'd like to resolve page faults with WP bit set.  Note that only the name
> is abused, it'll be better to be called uffd_args or similar but let's not
> bother for now.

Maybe one of the first commits in the series should have been
s/uffd_stats/uffd_args/g, but I realize that it's PITA, so I won't insist.
 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c | 17 +++++++++--------
>  tools/testing/selftests/mm/uffd-common.h |  6 ++++--
>  tools/testing/selftests/mm/uffd-stress.c | 16 ++++++++++------
>  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 025e40ffc7bf..92b7e00efa8a 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -353,7 +353,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp)
>  		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
>  }
> 
> -static void continue_range(int ufd, __u64 start, __u64 len)
> +static void continue_range(int ufd, __u64 start, __u64 len, bool wp)
>  {
>  	struct uffdio_continue req;
>  	int ret;
> @@ -361,7 +361,7 @@ static void continue_range(int ufd, __u64 start, __u64 len)
>  	req.range.start = start;
>  	req.range.len = len;
>  	req.mode = 0;
> -	if (test_uffdio_wp)
> +	if (wp)
>  		req.mode |= UFFDIO_CONTINUE_MODE_WP;
> 
>  	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
> @@ -429,7 +429,8 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
>  				    area_dst_alias));
>  		for (b = 0; b < page_size; ++b)
>  			area[b] = ~area[b];
> -		continue_range(uffd, msg->arg.pagefault.address, page_size);
> +		continue_range(uffd, msg->arg.pagefault.address, page_size,
> +			       stats->apply_wp);
>  		stats->minor_faults++;
>  	} else {
>  		/*
> @@ -459,7 +460,7 @@ void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats)
>  		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
>  		offset &= ~(page_size-1);
> 
> -		if (copy_page(uffd, offset))
> +		if (copy_page(uffd, offset, stats->apply_wp))
>  			stats->missing_faults++;
>  	}
>  }
> @@ -555,7 +556,7 @@ static void wake_range(int ufd, unsigned long addr, unsigned long len)
>  			addr), exit(1);
>  }
> 
> -int __copy_page(int ufd, unsigned long offset, bool retry)
> +int __copy_page(int ufd, unsigned long offset, bool retry, bool wp)
>  {
>  	struct uffdio_copy uffdio_copy;
> 
> @@ -564,7 +565,7 @@ int __copy_page(int ufd, unsigned long offset, bool retry)
>  	uffdio_copy.dst = (unsigned long) area_dst + offset;
>  	uffdio_copy.src = (unsigned long) area_src + offset;
>  	uffdio_copy.len = page_size;
> -	if (test_uffdio_wp)
> +	if (wp)
>  		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
>  	else
>  		uffdio_copy.mode = 0;
> @@ -587,8 +588,8 @@ int __copy_page(int ufd, unsigned long offset, bool retry)
>  	return 0;
>  }
> 
> -int copy_page(int ufd, unsigned long offset)
> +int copy_page(int ufd, unsigned long offset, bool wp)
>  {
> -	return __copy_page(ufd, offset, false);
> +	return __copy_page(ufd, offset, false, wp);
>  }
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 47565b2f2dee..f4bc73ce3b48 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -72,6 +72,8 @@
>  /* Userfaultfd test statistics */
>  struct uffd_stats {
>  	int cpu;
> +	/* Whether apply wr-protects when installing pages */
> +	bool apply_wp;
>  	unsigned long missing_faults;
>  	unsigned long wp_faults;
>  	unsigned long minor_faults;
> @@ -104,8 +106,8 @@ void userfaultfd_open(uint64_t *features);
>  int uffd_read_msg(int ufd, struct uffd_msg *msg);
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp);
>  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *stats);
> -int __copy_page(int ufd, unsigned long offset, bool retry);
> -int copy_page(int ufd, unsigned long offset);
> +int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
> +int copy_page(int ufd, unsigned long offset, bool wp);
>  void *uffd_poll_thread(void *arg);
> 
>  #define TEST_ANON	1
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 54fc9b4ffa3c..70cb0619354e 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -97,6 +97,7 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
> 
>  	for (i = 0; i < n_cpus; i++) {
>  		uffd_stats[i].cpu = i;
> +		uffd_stats[i].apply_wp = test_uffdio_wp;
>  		uffd_stats[i].missing_faults = 0;
>  		uffd_stats[i].wp_faults = 0;
>  		uffd_stats[i].minor_faults = 0;
> @@ -156,7 +157,7 @@ static void *locking_thread(void *arg)
> 
>  static int copy_page_retry(int ufd, unsigned long offset)
>  {
> -	return __copy_page(ufd, offset, true);
> +	return __copy_page(ufd, offset, true, test_uffdio_wp);
>  }
> 
>  pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
> @@ -309,7 +310,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
>   * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
>   * feature. Using monitor thread, verify no userfault events are generated.
>   */
> -static int faulting_process(int signal_test)
> +static int faulting_process(int signal_test, bool wp)
>  {
>  	unsigned long nr;
>  	unsigned long long count;
> @@ -344,7 +345,7 @@ static int faulting_process(int signal_test)
>  					if (steps == 1) {
>  						/* This is a MISSING request */
>  						steps++;
> -						if (copy_page(uffd, offset))
> +						if (copy_page(uffd, offset, wp))
>  							signalled++;
>  					} else {
>  						/* This is a WP request */
> @@ -508,6 +509,7 @@ static int userfaultfd_events_test(void)
>  			  true, test_uffdio_wp, false))
>  		err("register failure");
> 
> +	stats.apply_wp = test_uffdio_wp;
>  	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>  		err("uffd_poll_thread create");
> 
> @@ -516,7 +518,7 @@ static int userfaultfd_events_test(void)
>  		err("fork");
> 
>  	if (!pid)
> -		exit(faulting_process(0));
> +		exit(faulting_process(0, test_uffdio_wp));
> 
>  	waitpid(pid, &err, 0);
>  	if (err)
> @@ -552,11 +554,12 @@ static int userfaultfd_sig_test(void)
>  			  true, test_uffdio_wp, false))
>  		err("register failure");
> 
> -	if (faulting_process(1))
> +	if (faulting_process(1, test_uffdio_wp))
>  		err("faulting process failed");
> 
>  	uffd_test_ops->release_pages(area_dst);
> 
> +	stats.apply_wp = test_uffdio_wp;
>  	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>  		err("uffd_poll_thread create");
> 
> @@ -565,7 +568,7 @@ static int userfaultfd_sig_test(void)
>  		err("fork");
> 
>  	if (!pid)
> -		exit(faulting_process(2));
> +		exit(faulting_process(2, test_uffdio_wp));
> 
>  	waitpid(pid, &err, 0);
>  	if (err)
> @@ -629,6 +632,7 @@ static int userfaultfd_minor_test(void)
>  		       page_size);
>  	}
> 
> +	stats.apply_wp = test_uffdio_wp;
>  	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>  		err("uffd_poll_thread create");
> 
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
