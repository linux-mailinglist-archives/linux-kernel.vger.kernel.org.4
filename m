Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF286654ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjAKG4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAKGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:55:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059AFD1;
        Tue, 10 Jan 2023 22:55:47 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B5TkEZ008709;
        Wed, 11 Jan 2023 06:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=4LddbEdmr0cGd2YX/6/2QiRSlSbAK49zpGUm1DK4xQE=;
 b=qDT5t0n6d7xQeZOkgGgF+J3QPPwqOBCBPBeWkPbrACX4xFfIc5KNLDdbFBcXzAX0ZrXt
 rHMzk4LzGf4C5N4a0puQyi1ketNARsBh+9A3kh1QhUm0GjSjty2yvp259nAdwdFrPy3h
 +tnPvBvJWQPqocT5jk9vegRPfW1FZHgOlRv9EVQW9yTQSxLN8Md3JOlsZ+QM+qJOvO1o
 dwUWO/Ay3CkECwZo1w8TCQDq1DY5upvlPA0gETrnKK3TPmnxH6Az73Noe06mAcFltqV+
 VU84+fe0P/G5JFvXT956B68HUl6i3Ilz5gZRBaZd7dM8A6mKgogdxqwJts1v74V/X5yN 3g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1q0y9gwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 06:55:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1b7lU004503;
        Wed, 11 Jan 2023 06:55:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n1kkyrbbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 06:55:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30B6tWQO46006604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 06:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA2D2004B;
        Wed, 11 Jan 2023 06:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8450A20043;
        Wed, 11 Jan 2023 06:55:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 11 Jan 2023 06:55:32 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
        <20230105191517.3099082-11-Liam.Howlett@oracle.com>
        <yt9da62qbfut.fsf@linux.ibm.com>
        <20230110172624.fuxgm7jpimskzgvs@revolver>
Date:   Wed, 11 Jan 2023 07:55:32 +0100
In-Reply-To: <20230110172624.fuxgm7jpimskzgvs@revolver> (Liam Howlett's
        message of "Tue, 10 Jan 2023 17:26:39 +0000")
Message-ID: <yt9dcz7la7bv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0hqR-aE0UPbLspb3dgAK5qTe1HnK2skQ
X-Proofpoint-GUID: 0hqR-aE0UPbLspb3dgAK5qTe1HnK2skQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_02,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=835
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> * Sven Schnelle <svens@linux.ibm.com> [230110 09:54]:
>> Liam Howlett <liam.howlett@oracle.com> writes:
>> 
>> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>> >
>> > Start passing the vma iterator through the mm code.  This will allow for
>> > reuse of the state and cleaner invalidation if necessary.
>> >
>> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> > ---
>> >  include/linux/mm.h |  2 +-
>> >  mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
>> >  mm/mremap.c        |  6 ++--
>> >  3 files changed, 39 insertions(+), 46 deletions(-)
>> >
>> 
>> Starting with this patch i see the following oops on s390:
>> [..]
>> This happens on every boot, always killing the init process. The oops
>> doesn't happen with next-20230110. With next-20230110 i see shmat
>> testcase failures in ltp (shmat returning with -EINVAL because
>> find_vma_intersection() tells shmat that there's already a mapping
>> present).
>> 
>> Trying to bisect that i stumbled above the oops above. Any ideas before
>> i start trying to understand the patch?
>
> Yes, try the patch for fixing the invalidated state I sent out yesterday
> [1].  This should come before ("mm: expand vma iterator interface").
>
> 1. https://lore.kernel.org/linux-mm/20230109165455.647400-1-Liam.Howlett@oracle.com/

Thanks, missed that. I can report that the crash i've seen seems to be
fixed. Also the shmat01 testcase in ltp is working now.
