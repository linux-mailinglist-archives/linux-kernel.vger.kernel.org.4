Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C16643BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjAJOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjAJOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:54:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700E5D40B;
        Tue, 10 Jan 2023 06:54:03 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEQwED016392;
        Tue, 10 Jan 2023 14:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=5AvK5cTiin5PzdoYCpSonHh6wy1uVH8bOtkY08kvIng=;
 b=KoipVWdVjbSVnWvRGMDBMMVW1X3X1DY2I0aGjFuUZOyMxdIY1CJS0B/RDCxNHm06xawO
 COcneYyhUGqP3gTUoOFpDqIeGCtd2WFFiED5X59KTRUp0Qt9i46rNsSn9OFd6hHpXYc1
 i8joMQz4LSue5gNdlRL76YeLWti3w58YAl6iF6dUi2gLbKDDjhKrEX7uC0gLu5WMkojt
 bZUX83ZSAufxeojmLnfcT54vt8yBY38CJ4uN2XpEaxvBhy9nzpj+X7tD8JtzjxxB0VWS
 yiSVco2KrApgVex5YTEucO96XczqK8Jgtxq+s00SDjE46SlKth7RfLkKbdhBCZP/ZQyu cQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n19smgqvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:53:51 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEITc3011985;
        Tue, 10 Jan 2023 14:53:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3my0c6bkeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 14:53:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AErlXP49873352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 14:53:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5275A2004B;
        Tue, 10 Jan 2023 14:53:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2467320040;
        Tue, 10 Jan 2023 14:53:47 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Jan 2023 14:53:47 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 10/44] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
        <20230105191517.3099082-11-Liam.Howlett@oracle.com>
Date:   Tue, 10 Jan 2023 15:53:46 +0100
In-Reply-To: <20230105191517.3099082-11-Liam.Howlett@oracle.com> (Liam
        Howlett's message of "Thu, 5 Jan 2023 19:15:55 +0000")
Message-ID: <yt9da62qbfut.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZW3fIRnXvRt9_XARSGE00WVjgzoctkTZ
X-Proofpoint-GUID: ZW3fIRnXvRt9_XARSGE00WVjgzoctkTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=702 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> writes:

> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Start passing the vma iterator through the mm code.  This will allow for
> reuse of the state and cleaner invalidation if necessary.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  include/linux/mm.h |  2 +-
>  mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
>  mm/mremap.c        |  6 ++--
>  3 files changed, 39 insertions(+), 46 deletions(-)
>

Starting with this patch i see the following oops on s390:

[    4.512863] Run /sbin/init as init process
[    4.519447] Unable to handle kernel pointer dereference in virtual kernel address space
[    4.519450] Failing address: fbebfffb00000000 TEID: fbebfffb00000803
[    4.519452] Fault in home space mode while using kernel ASCE.
[    4.519455] AS:0000000001a60007 R3:0000000000000024
[    4.519482] Oops: 0038 ilc:2 [#1] SMP
[    4.519486] Modules linked in:
[    4.519488] CPU: 7 PID: 1 Comm: init Not tainted 6.2.0-rc1-00179-ga7f83eb601ef #1582
[    4.519491] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[    4.519493] Krnl PSW : 0704c00180000000 0000000000929464 (__memcpy+0x24/0x50)
[    4.519503]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    4.519506] Krnl GPRS: 0000000000000000 0000037fffb1f990 0000037fffb1f990 fbebfffb00000008
[    4.519509]            0000000000000007 0000000000929480 0000000000000008 0000000000000000
[    4.519517]            0000000000000009 0000037fffb1fb40 0000037fffb1f880 0000037fffb1fc58
[    4.519519]            0000000080288000 0000000000000001 0000000000cf65da 0000037fffb1f5d8
[    4.519527] Krnl Code: 0000000000929456: b9040012            lgr     %r1,%r2
[    4.519527]            000000000092945a: a7740008            brc     7,000000000092946a
[    4.519527]           #000000000092945e: c05000000011        larl    %r5,0000000000929480
[    4.519527]           >0000000000929464: 44405000            ex      %r4,0(%r5)
[    4.519527]            0000000000929468: 07fe                bcr     15,%r14
[    4.519527]            000000000092946a: d2ff10003000        mvc     0(256,%r1),0(%r3)
[    4.519527]            0000000000929470: 41101100            la      %r1,256(%r1)
[    4.519527]            0000000000929474: 41303100            la      %r3,256(%r3)
[    4.519547] Call Trace:
[    4.519548]  [<0000000000929464>] __memcpy+0x24/0x50
[    4.519557]  [<0000000000cfd474>] mas_wr_bnode+0x5c/0x14e8
[    4.519562]  [<0000000000cffaf6>] mas_store_prealloc+0x4e/0xf8
[    4.519569]  [<000000000039d262>] mmap_region+0x482/0x8b0
[    4.519572]  [<000000000039da6e>] do_mmap+0x3de/0x4c0
[    4.519575]  [<000000000036aeae>] vm_mmap_pgoff+0xd6/0x188
[    4.519580]  [<000000000039a18a>] ksys_mmap_pgoff+0x62/0x230
[    4.519584]  [<000000000039a522>] __s390x_sys_old_mmap+0x7a/0x98
[    4.519588]  [<0000000000d22650>] __do_syscall+0x1d0/0x1f8
[    4.519592]  [<0000000000d32712>] system_call+0x82/0xb0
[    4.519596] Last Breaking-Event-Address:
[    4.519596]  [<0000000000cf65d4>] mas_store_b_node+0x3cc/0x6b0
[    4.519603] Kernel panic - not syncing: Fatal exception: panic_on_oops

This happens on every boot, always killing the init process. The oops
doesn't happen with next-20230110. With next-20230110 i see shmat
testcase failures in ltp (shmat returning with -EINVAL because
find_vma_intersection() tells shmat that there's already a mapping
present).

Trying to bisect that i stumbled above the oops above. Any ideas before
i start trying to understand the patch?

Thanks,
Sven
