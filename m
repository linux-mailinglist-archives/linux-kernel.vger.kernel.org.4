Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25B46DAAB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjDGJPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:15:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C672BC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:15:46 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377sxV1029707;
        Fri, 7 Apr 2023 09:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=av/IY3P1zzXzR7h4VkjVut4y3NlmAbfx6HeaCY4p0V0=;
 b=igOyc1xZfqDxqdsHroxiLyEVx+K7QSfa/09h8oZb6L/ifYLHLhjJXGpvV8iAHZt0h1I1
 vMhlrELYAguwnhG8sd3wi8nVD4LtWvGTK71Yup4YOuVwGjtuv14eZOD5vUcgKZJN5GWw
 aOZvrquhBNBCst2iiPcPwaPlTe/Tg3ifS41VCj+iM+2MJJGgDo/jVjfRxyN7ZwBuG/B/
 YQOQf2Y81sBowS748Gs1ZlaEaVojFTOc6dHT8jTaS3emgsAJpmwI8ofVJEeql8SIrwpI
 90V3rh6BXovGelb1RjnHnKEWo2cjD80ME7w78GVl42r968uZ67cWDhlic4WGe7DS1B3d Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptf6w1k3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:15:41 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3378kuqX015952;
        Fri, 7 Apr 2023 09:15:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptf6w1k2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:15:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3378Cx0I012243;
        Fri, 7 Apr 2023 09:15:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ppc86unqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:15:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379FZdM43254492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:15:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E20520040;
        Fri,  7 Apr 2023 09:15:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6043420043;
        Fri,  7 Apr 2023 09:15:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:15:34 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:15:32 +0300
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
Subject: Re: [PATCH 03/29] selftests/mm: Dump a summary in run_vmtests.sh
Message-ID: <ZC/fNPD+5F7qQHLC@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160646.3106903-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160646.3106903-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NyuORKZ6F8ZIY4UPWE-N_qniRzsovmwH
X-Proofpoint-ORIG-GUID: fRtjOagwoy-TZ_ms7eYGWBofnx3RY6DU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=859 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:06:46PM -0400, Peter Xu wrote:
> Dump a summary after running whatever test specified.  Useful for human
> runners to identify any kind of failures (besides exit code).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c0f93b668c0c..9cc33984aa9f 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -5,6 +5,9 @@
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=4
> 
> +count_pass=0
> +count_fail=0
> +count_skip=0
>  exitcode=0
> 
>  usage() {
> @@ -149,11 +152,14 @@ run_test() {
>  		"$@"
>  		local ret=$?
>  		if [ $ret -eq 0 ]; then
> +			count_pass=$(( $count_pass + 1 ))
>  			echo "[PASS]"
>  		elif [ $ret -eq $ksft_skip ]; then
> +			count_skip=$(( $count_skip + 1 ))
>  			echo "[SKIP]"
>  			exitcode=$ksft_skip
>  		else
> +			count_fail=$(( $count_fail + 1 ))
>  			echo "[FAIL]"
>  			exitcode=1
>  		fi
> @@ -279,4 +285,6 @@ CATEGORY="soft_dirty" run_test ./soft-dirty
>  # COW tests
>  CATEGORY="cow" run_test ./cow
> 
> +echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}"
> +
>  exit $exitcode
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
