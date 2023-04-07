Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205AA6DAB44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDGKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDGKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:11:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E064B9004
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:11:08 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3379AmLD011830;
        Fri, 7 Apr 2023 10:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=G51SlimsysdJU5GnlmLLgt2RhClRMkcc8o6TRS4K/0E=;
 b=Wf4r6pJ0jIn3cQTTxf9eciZawRfTUu2d1bhUWpU4idiyl13qnis8BpGy7+A0qlQRF6ze
 MpGoGV8TTUl4XpADYmeWjoJzpgwZ1AgmawxYvJ7dVNgr8MSgcJvK9dOYcwz5QO6E2/2U
 WQ4Evzi/9I7xQCMDl+nu2paWu66bY4sgj2A1kSDSM1zVeRkv6fXpvlzVOGgMNFEYWlo6
 GN5HJf9oXHqlwNh6hBQmJJmkxkj9aVCDle6ed6Q3/Gki+0Uj7kL9R7y4USbmvpbeP4z1
 GGKi+Ggvd/3stdl6kGjFoJUHcVARLQRoFbJSUyQG3N+caNrewZuVROCIw+nOFmZo6YRN BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptcagdtj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:11:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337A8050007466;
        Fri, 7 Apr 2023 10:11:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptcagdthc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:11:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336FTlia015703;
        Fri, 7 Apr 2023 10:10:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc874w2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:10:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337AAuiA3998388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 10:10:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0ED720067;
        Fri,  7 Apr 2023 10:10:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E46E20065;
        Fri,  7 Apr 2023 10:10:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 10:10:55 +0000 (GMT)
Date:   Fri, 7 Apr 2023 13:10:53 +0300
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
Subject: Re: [PATCH 12/29] selftests/mm: Create uffd-common.[ch]
Message-ID: <ZC/sLe7/PSL098Tq@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160720.3107021-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160720.3107021-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kMnuP4zdJ8EnDMbXVgIxC9oFHN25ebHe
X-Proofpoint-GUID: 4956bpKZ-3Krxj87g6M5TiY4T-adVsv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=840 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070093
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:20PM -0400, Peter Xu wrote:
> Move common utility functions into uffd-common.[ch] files from the original
> userfaultfd.c.  This prepares for a split of userfaultfd.c into two tests:
> one to only cover the old but powerful stress test, the other one covers
> all the functional tests.
> 
> This movement is kind of a brute-force effort for now, with light touch-ups
> but nothing should really change.  There's chances to optimize more, but
> let's leave that for later.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/Makefile      |   2 +
>  tools/testing/selftests/mm/uffd-common.c | 611 ++++++++++++++++++++
>  tools/testing/selftests/mm/uffd-common.h | 117 ++++
>  tools/testing/selftests/mm/userfaultfd.c | 694 +----------------------
>  4 files changed, 731 insertions(+), 693 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/uffd-common.c
>  create mode 100644 tools/testing/selftests/mm/uffd-common.h
> 

-- 
Sincerely yours,
Mike.
