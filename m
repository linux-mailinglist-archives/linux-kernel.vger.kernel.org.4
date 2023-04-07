Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9C6DAB13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239298AbjDGJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:48:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6C5FCF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:48:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3379f7O8023708;
        Fri, 7 Apr 2023 09:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=a9/I6uT/f1k53LCbt8zh9iPllgd0t7qxghTmYs61v00=;
 b=p9Imjw3xw68Bw+c1SC9HgveI81hs+n1Kgj1NnuSv+6U7BnGauetOb9PmZfl/CW9Ek6kT
 1eIzUOCzrnvotXmu5jjvA+vTSEhQ3T+GUqeO55I54kcdaJrJfqYGAnmxxOTNTzOmCd67
 86ysgJAwF8OL+jzqXbiOnvkA9f1TEUaf5LjhXb+4o3PQscf1L8lxaS6ch7K8nsPai5sD
 LorEgeSTaW9+4t2cP2n8U9R0XszqCUphhqDFaskxbvIDd8uWil4/6M/rU2BNiJauOc2e
 3KHl842tZURIZHC0DwUHIaUblrSC8l2GYnfsdptXKkzYMrRSoJ6TvdosCtLwd8LC9/lr Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptf6w208c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:48:41 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379gAOi026183;
        Fri, 7 Apr 2023 09:48:41 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptf6w207t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:48:40 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3379S3Vd008294;
        Fri, 7 Apr 2023 09:48:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvfupf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:48:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379mZmN56951116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:48:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B11E620040;
        Fri,  7 Apr 2023 09:48:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C14E20043;
        Fri,  7 Apr 2023 09:48:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:48:34 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:48:32 +0300
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
Subject: Re: [PATCH 11/29] selftests/mm: Drop test_uffdio_zeropage_eexist
Message-ID: <ZC/m8PLFWQ8bGk6q@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160717.3107010-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160717.3107010-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UDO9rXuD7kbJGrGXR0XHY1B_6hZ71K3j
X-Proofpoint-ORIG-GUID: sRngXHgF38OkD0VxP46iji9Z4kqLVBUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070088
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:17PM -0400, Peter Xu wrote:
> The idea was trying to flip this var in the alarm handler from time to time
> to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
> zeropage test so probably only used once, meanwhile we passed
> "retry==false" so it'll never got tested anyway.
> 
> Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
> is set (!hugetlb).
> 
> One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
> because otherwise the test won't even pass!  We were just lucky that this
> test never really got ran at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/userfaultfd.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> index d724f1c78847..3487ec0bfcc8 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -88,7 +88,6 @@ static bool test_dev_userfaultfd;
>  /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
>  #define ALARM_INTERVAL_SECS 10
>  static volatile bool test_uffdio_copy_eexist = true;
> -static volatile bool test_uffdio_zeropage_eexist = true;
>  /* Whether to test uffd write-protection */
>  static bool test_uffdio_wp = true;
>  /* Whether to test uffd minor faults */
> @@ -1114,7 +1113,7 @@ static void retry_uffdio_zeropage(int ufd,
>  	}
>  }
> 
> -static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> +static int __uffdio_zeropage(int ufd, unsigned long offset)
>  {
>  	struct uffdio_zeropage uffdio_zeropage;
>  	int ret;
> @@ -1138,11 +1137,8 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
>  		if (res != page_size) {
>  			err("UFFDIO_ZEROPAGE unexpected size");
>  		} else {
> -			if (test_uffdio_zeropage_eexist && retry) {
> -				test_uffdio_zeropage_eexist = false;
> -				retry_uffdio_zeropage(ufd, &uffdio_zeropage,
> -						      offset);
> -			}
> +			retry_uffdio_zeropage(ufd, &uffdio_zeropage,
> +					      offset);
>  			return 1;
>  		}
>  	} else
> @@ -1153,7 +1149,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> 
>  static int uffdio_zeropage(int ufd, unsigned long offset)
>  {
> -	return __uffdio_zeropage(ufd, offset, false);
> +	return __uffdio_zeropage(ufd, offset);
>  }
> 
>  /* exercise UFFDIO_ZEROPAGE */
> @@ -1177,6 +1173,13 @@ static int userfaultfd_zeropage_test(void)
>  	assert_expected_ioctls_present(
>  		uffdio_register.mode, uffdio_register.ioctls);
> 
> +	if (area_dst_alias) {
> +		/* Needed this to test zeropage-retry on shared memory */
> +		uffdio_register.range.start = (unsigned long) area_dst_alias;
> +		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +			err("register failure");
> +	}
> +
>  	if (uffdio_zeropage(uffd, 0))
>  		if (my_bcmp(area_dst, zeropage, page_size))
>  			err("zeropage is not zero");
> @@ -1763,7 +1766,6 @@ static void sigalrm(int sig)
>  	if (sig != SIGALRM)
>  		abort();
>  	test_uffdio_copy_eexist = true;
> -	test_uffdio_zeropage_eexist = true;
>  	alarm(ALARM_INTERVAL_SECS);
>  }
> 
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
