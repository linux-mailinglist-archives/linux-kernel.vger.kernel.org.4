Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960B6F35C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEASZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEASZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:25:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1E413A;
        Mon,  1 May 2023 11:25:35 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341IMVxm007847;
        Mon, 1 May 2023 18:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=xx/3hJ+CZLlHDK4Ntj3hDqtJoR/nQrjMLEvEL6by9H4=;
 b=F+F8+DQR5I0Lm1ickWftFgEacrG1b/Ob/c5wd/dzo7OBlR9FvuNaVEzqvffXWqFDjhtG
 zVYDBoqxEZF8rO81m6gXAxiFSDatiUG01Gcg4rCudQrF2pbK6t+7opVOCl6APEzXigMJ
 LOXlCg30KOj9Tjwhe4fvnT9lj9it9jnHAkCxhHq1SuhkK7zjLsLfFiSTGpEKYhKZnOzn
 qdz0kVXBQ+WBxGmOSZ2osQhypxmohknKJPKXravQ54DtrVj5XLU1N5fZ1zZNpRx3/6Eg
 nWi14x+ViFrkp9Zp09ct3bjbJeepDyCdIXbIjP2tajfFfZzsogSa0UwAZO4poHoRPK8l 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qafew5m7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 18:24:54 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 341IKHb6001603;
        Mon, 1 May 2023 18:24:54 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qafew5m6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 18:24:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 341IOpDa023238;
        Mon, 1 May 2023 18:24:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6ry5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 18:24:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 341IOn3H13632224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 May 2023 18:24:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 237752004B;
        Mon,  1 May 2023 18:24:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B2E20043;
        Mon,  1 May 2023 18:24:48 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  1 May 2023 18:24:48 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        stable@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: Fix use-after-free of VMA iterator
References: <20230410152205.2294819-1-Liam.Howlett@oracle.com>
        <yt9dildhke9l.fsf@linux.ibm.com>
        <20230427173247.s5rn6nujoxiatviu@revolver>
        <5066f333-5021-451d-abdd-07a027d98820@lucifer.local>
Date:   Mon, 01 May 2023 20:24:48 +0200
In-Reply-To: <5066f333-5021-451d-abdd-07a027d98820@lucifer.local> (Lorenzo
        Stoakes's message of "Sun, 30 Apr 2023 14:35:00 +0100")
Message-ID: <yt9da5yn7vv3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VBYajAsBVtX0SqlJLITO9ZYUcqVVGhgr
X-Proofpoint-ORIG-GUID: PIwNWU_xoEM_aeOrGETdiN8XcYyNn6Jb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=783 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010148
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Stoakes <lstoakes@gmail.com> writes:

> On Thu, Apr 27, 2023 at 01:32:47PM -0400, Liam R. Howlett wrote:
>> * Sven Schnelle <svens@linux.ibm.com> [230427 02:53]:
>> > "Liam R. Howlett" <Liam.Howlett@oracle.com> writes:
>> >
>> > > set_mempolicy_home_node() iterates over a list of VMAs and calls
>> > > mbind_range() on each VMA, which also iterates over the singular list of
>> > > the VMA passed in and potentially splits the VMA.  Since the VMA
>> > > iterator is not passed through, set_mempolicy_home_node() may now point
>> > > to a stale node in the VMA tree.  This can result in a UAF as reported
>> > > by syzbot.
>> > >
>> > > Avoid the stale maple tree node by passing the VMA iterator through to
>> > > the underlying call to split_vma().
>> > >
>> > > mbind_range() is also overly complicated, since there are two calling
>> > > functions and one already handles iterating over the VMAs.  Simplify
>> > > mbind_range() to only handle merging and splitting of the VMAs.
>> > >
>> > > Align the new loop in do_mbind() and existing loop in
>> > > set_mempolicy_home_node() to use the reduced mbind_range() function.
>> > > This allows for a single location of the range calculation and avoids
>> > > constantly looking up the previous VMA (since this is a loop over the
>> > > VMAs).
>> > >
>> > > Link: https://lore.kernel.org/linux-mm/000000000000c93feb05f87e24ad@google.com/
>> > > Reported-and-tested-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
>> > > Fixes: 66850be55e8e ("mm/mempolicy: use vma iterator & maple state instead of vma linked list")
>> > > Cc: <stable@vger.kernel.org>
>> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> > > ---
>> >
>> > This breaks the vma02 testcase from ltp on s390:
>> >
>> >  ~ # ./vma02
>> > vma02       0  TINFO  :  pid = 617 addr = 0x3ff8f673000
>> > vma02       0  TINFO  :  start = 0x3ff8f673000, end = 0x3ff8f674000
>> > vma02       0  TINFO  :  start = 0x3ff8f674000, end = 0x3ff8f675000
>> > vma02       0  TINFO  :  start = 0x3ff8f675000, end = 0x3ff8f676000
>> > vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
>> > Any thoughts?
>>
>> No thoughts that I should share.
>>
>> I will have to boot my s390 (vm) and have a look.
>>
>> Thanks for letting me know.
>>
>> Regards,
>> Liam
>
> I tracked down what this (almost certainly) was + added fix in [1] as it
> popped up as a 6.2.y stable bug. It doesn't seem arch-specific so you can
> put that s390 down :)
>
> [1]:https://lore.kernel.org/all/db42467a692d78c654ec5c1953329401bd8a9c34.1682859234.git.lstoakes@gmail.com/

Thanks, just tested, and it solves the issue for me.
