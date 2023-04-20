Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1B6E913D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjDTK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjDTK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:56:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB25170A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KA6Zg5015906;
        Thu, 20 Apr 2023 10:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eM/bbS9WflvzKKWIfx+jLsxSVcQoWaZ6xsaA8rVouFE=;
 b=Diag6ujNdT0etL8gWSW0SL0CrJvegkjvLvWFrr0ceVp58z8au8cUiRrk2guXw3DSLSL4
 f11ot3Lz9/+kfnSXIT2ud2zTxdOl5HDmvLGS1yOU17OuxbUyCGBfjkL4ds6yiNTgxyKH
 X85wcjJPym86W9mxUSsODatWX/7h6EMwO37nPgRyRaOVVnuVT84AvhXiqmQAPJa9jYF3
 h7nSRbTO2dqADwm/AIWzU8I1nHKCfKuPoHhlFLoJygXjs9nVyYQ5jW6E6q14ae0Ojleg
 H/v4aYD1cJvOXCsF6aRduj2OjWw1FKCide5tt9jf0SgW2Hz+h82rKchrtBjsvHgck+r6 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q31v1cx2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:54:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33KAcphK024287;
        Thu, 20 Apr 2023 10:54:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q31v1cx1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:54:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33J7bMF4006465;
        Thu, 20 Apr 2023 10:54:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6bbaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:54:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33KAs6ew24248938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 10:54:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7669E2004B;
        Thu, 20 Apr 2023 10:54:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D29920040;
        Thu, 20 Apr 2023 10:54:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.40.70])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Apr 2023 10:54:05 +0000 (GMT)
Date:   Thu, 20 Apr 2023 13:54:03 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH v2 16/31] selftests/mm: UFFDIO_API test
Message-ID: <ZEEZyzE0Js1YllGY@linux.ibm.com>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164257.328375-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412164257.328375-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JLNC56jIXz60lHVpOE4tYXeZywynNx6a
X-Proofpoint-GUID: XpsqNRY_z0qR0ltFm0kE0siiCjNk5FaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:42:57PM -0400, Peter Xu wrote:
> Add one simple test for UFFDIO_API.  With that, I also added a bunch of
> small but handy helpers along the way.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 109 ++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 6857388783be..bb492c258486 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -9,9 +9,116 @@
> 
>  #ifdef __NR_userfaultfd
> 
> +static void uffd_test_report(void)
> +{
> +	printf("Userfaults unit tests: pass=%u, skip=%u, fail=%u (total=%u)\n",
> +	       ksft_get_pass_cnt(),
> +	       ksft_get_xskip_cnt(),
> +	       ksft_get_fail_cnt(),
> +	       ksft_test_num());
> +}
> +
> +static void uffd_test_pass(void)
> +{
> +	printf("done\n");
> +	ksft_inc_pass_cnt();
> +}
> +
> +#define  uffd_test_start(...)  do {		\
> +		printf("Testing ");		\
> +		printf(__VA_ARGS__);		\
> +		printf("... ");			\
> +		fflush(stdout);			\
> +	} while (0)
> +
> +#define  uffd_test_fail(...)  do {		\
> +		printf("failed [reason: ");	\
> +		printf(__VA_ARGS__);		\
> +		printf("]\n");			\
> +		ksft_inc_fail_cnt();		\
> +	} while (0)
> +
> +#define  uffd_test_skip(...)  do {		\
> +		printf("skipped [reason: ");	\
> +		printf(__VA_ARGS__);		\
> +		printf("]\n");			\
> +		ksft_inc_xskip_cnt();		\
> +	} while (0)
> +
> +/*
> + * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
> + * return 1 even if some test failed as long as uffd supported, because in
> + * that case we still want to proceed with the rest uffd unit tests.
> + */
> +static int test_uffd_api(bool use_dev)
> +{
> +	struct uffdio_api uffdio_api;
> +	int uffd;
> +
> +	uffd_test_start("UFFDIO_API (with %s)",
> +			use_dev ? "/dev/userfaultfd" : "syscall");
> +
> +	if (use_dev)
> +		uffd = uffd_open_dev(UFFD_FLAGS);
> +	else
> +		uffd = uffd_open_sys(UFFD_FLAGS);
> +	if (uffd < 0) {
> +		uffd_test_skip("cannot open userfaultfd handle");
> +		return 0;
> +	}
> +
> +	/* Test wrong UFFD_API */
> +	uffdio_api.api = 0xab;
> +	uffdio_api.features = 0;
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
> +		uffd_test_fail("UFFDIO_API should fail with wrong api but didn't");
> +		goto out;
> +	}
> +
> +	/* Test wrong feature bit */
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = BIT_ULL(63);
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
> +		uffd_test_fail("UFFDIO_API should fail with wrong feature but didn't");
> +		goto out;
> +	}
> +
> +	/* Test normal UFFDIO_API */
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = 0;
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
> +		uffd_test_fail("UFFDIO_API should succeed but failed");
> +		goto out;
> +	}
> +
> +	/* Test double requests of UFFDIO_API with a random feature set */
> +	uffdio_api.features = BIT_ULL(0);
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
> +		uffd_test_fail("UFFDIO_API should reject initialized uffd");
> +		goto out;
> +	}
> +
> +	uffd_test_pass();
> +out:
> +	close(uffd);
> +	/* We have a valid uffd handle */
> +	return 1;
> +}
> +
>  int main(int argc, char *argv[])
>  {
> -	return KSFT_PASS;
> +	int has_uffd;
> +
> +	has_uffd = test_uffd_api(false);
> +	has_uffd |= test_uffd_api(true);
> +
> +	if (!has_uffd) {
> +		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
> +		exit(KSFT_SKIP);
> +	}
> +	uffd_test_report();
> +
> +	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
>  }
> 
>  #else /* __NR_userfaultfd */
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
