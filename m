Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279A6DAC20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjDGLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjDGLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:11:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26819C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:11:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AuQ9L012326;
        Fri, 7 Apr 2023 11:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jFsxIafe4SrhLNVJz5G3UzqBEY1HVl2a9NJ0y7xCRGA=;
 b=raDC5vVF+bsoQaUxmT9akvn0Q/ZqAdCS1+RGfE7xY9/lRtsQK4SLGN+nljAn//m/ANA6
 m2mc5xgsdxQfbIOohHC4hELvpCEzpO0gotFA93gQCZ0BL8xM9v3njeIv9+9pw7bGMNy1
 uG5Nl3H+BmRIcl97jFhNTzlksQCf9tRhA9P5H84fOQK75u4AJ9g3i5nymHWquVUxpp4D
 ln7A7MWqQ6Wzf+ImA4FZfJwlw/poV7AMTjaxEZ5mRY5VmDps7DZfTMhXkzDQ92QzW9IR
 ldGFTdJtq2yJAdgnfBtVgHXHIYNnf+WQ/Rjmer3Hl8OfOYU8fFcYMmpBDeu+uekVnr8w eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pthutg9t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:11:46 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337Av98m013343;
        Fri, 7 Apr 2023 11:11:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pthutg9s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:11:45 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 337409Wi005457;
        Fri, 7 Apr 2023 11:11:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ppc86up2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:11:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337BBeHY24773182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:11:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D1692004E;
        Fri,  7 Apr 2023 11:11:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDC420043;
        Fri,  7 Apr 2023 11:11:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:11:39 +0000 (GMT)
Date:   Fri, 7 Apr 2023 14:11:37 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 15/29] selftests/mm: uffd_open_{dev|sys}()
Message-ID: <ZC/6aZyR78p/Y5dn@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160749.3107270-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160749.3107270-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wTk1no_jW-3CEXevoQocBkGliozOyDFu
X-Proofpoint-GUID: 1HeE31Xz6eUDavJB3JGhl6Kgynhx2yGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=910
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:49PM -0400, Peter Xu wrote:
> Provide two helpers to open an uffd handle.  Drop the error checks around
> SKIPs because it's inside an errexit() anyway, which IMHO doesn't really
> help much if the test will not continue.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 28 +++++-------------------
>  tools/testing/selftests/mm/vm_util.c     | 24 ++++++++++++++++++++
>  2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 17f2bb82c3db..3a9b5c1aca9d 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -192,34 +192,16 @@ void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
>  	printf("\n");
>  }
> 
> -static int __userfaultfd_open_dev(void)
> -{
> -	int fd, _uffd;
> -
> -	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> -	if (fd < 0)
> -		errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
> -
> -	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> -	if (_uffd < 0)
> -		errexit(errno == ENOTTY ? KSFT_SKIP : 1,
> -			"creating userfaultfd failed");
> -	close(fd);
> -	return _uffd;
> -}
> -
>  void userfaultfd_open(uint64_t *features)
>  {
>  	struct uffdio_api uffdio_api;
> 
>  	if (test_dev_userfaultfd)
> -		uffd = __userfaultfd_open_dev();
> -	else {
> -		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
> -		if (uffd < 0)
> -			errexit(errno == ENOSYS ? KSFT_SKIP : 1,
> -				"creating userfaultfd failed");
> -	}
> +		uffd = uffd_open_dev(UFFD_FLAGS);
> +	else
> +		uffd = uffd_open_sys(UFFD_FLAGS);
> +	if (uffd < 0)
> +		err("uffd open failed (dev=%d)", test_dev_userfaultfd);
>  	uffd_flags = fcntl(uffd, F_GETFD, NULL);
> 
>  	uffdio_api.api = UFFD_API;
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 10e76400ed70..7c2bf88d6393 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -3,6 +3,8 @@
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
>  #include <linux/userfaultfd.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
>  #include "../kselftest.h"
>  #include "vm_util.h"
> 
> @@ -230,3 +232,25 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
> 
>  	return ret;
>  }
> +
> +int uffd_open_dev(unsigned int flags)
> +{
> +	int fd, uffd;
> +
> +	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
> +	close(fd);
> +
> +	return uffd;
> +}
> +
> +int uffd_open_sys(unsigned int flags)
> +{
> +#ifdef __NR_userfaultfd
> +	return syscall(__NR_userfaultfd, flags);
> +#else
> +	return -1;
> +#endif
> +}
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
