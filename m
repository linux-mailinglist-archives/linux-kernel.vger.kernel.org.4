Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F316F0111
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbjD0Gx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjD0Gx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:53:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D78C1BD6;
        Wed, 26 Apr 2023 23:53:24 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R6dbk9018846;
        Thu, 27 Apr 2023 06:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=aWQMYeE53wsqzswmHZJTXvf9s2/mEuVXA/evgUsnReA=;
 b=e1bC3GkM601kamYat63vhLxFHNaZh4/B7IoQiq8fyhQaWHgT9YIx/3vpOfuqDDR7UUy5
 7xs5uKkj/FL80sodseRzs2K8tkwj4ozMHoDJOL3atekriQYeMUzTQqxT5Lw4B0fnU7am
 hzWbcCIRcHVeCSXukS8cJtMMdSiuJPlBcciUTr8CLUUODf0bJs/xPTxyjbK/J8la0zon
 fkoFaCuFCht7E+LrdPVhiaVUTIHk+zLPjal0o3kVzh1qD/Aey+Xs2LmSQPFUKMNCVa2i
 POYibUrc1w1x8nugvUKjbogW2k8B8Qal/GCoXJC2sT3w0GvxGJMOW6o0b+rTLxJaNBwI Ng== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7jun9vxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 06:53:00 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33R3iS14016815;
        Thu, 27 Apr 2023 06:52:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q47772a3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 06:52:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33R6qtYb47382910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 06:52:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8799720043;
        Thu, 27 Apr 2023 06:52:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C4E20040;
        Thu, 27 Apr 2023 06:52:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Apr 2023 06:52:55 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com,
        stable@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: Fix use-after-free of VMA iterator
References: <20230410152205.2294819-1-Liam.Howlett@oracle.com>
Date:   Thu, 27 Apr 2023 08:52:54 +0200
In-Reply-To: <20230410152205.2294819-1-Liam.Howlett@oracle.com> (Liam
        R. Howlett's message of "Mon, 10 Apr 2023 11:22:05 -0400")
Message-ID: <yt9dildhke9l.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AzeFsIv8vuwMW1QlK0HlAkdiNI9JZLsy
X-Proofpoint-ORIG-GUID: AzeFsIv8vuwMW1QlK0HlAkdiNI9JZLsy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_04,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=720
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Liam R. Howlett" <Liam.Howlett@oracle.com> writes:

> set_mempolicy_home_node() iterates over a list of VMAs and calls
> mbind_range() on each VMA, which also iterates over the singular list of
> the VMA passed in and potentially splits the VMA.  Since the VMA
> iterator is not passed through, set_mempolicy_home_node() may now point
> to a stale node in the VMA tree.  This can result in a UAF as reported
> by syzbot.
>
> Avoid the stale maple tree node by passing the VMA iterator through to
> the underlying call to split_vma().
>
> mbind_range() is also overly complicated, since there are two calling
> functions and one already handles iterating over the VMAs.  Simplify
> mbind_range() to only handle merging and splitting of the VMAs.
>
> Align the new loop in do_mbind() and existing loop in
> set_mempolicy_home_node() to use the reduced mbind_range() function.
> This allows for a single location of the range calculation and avoids
> constantly looking up the previous VMA (since this is a loop over the
> VMAs).
>
> Link: https://lore.kernel.org/linux-mm/000000000000c93feb05f87e24ad@google.com/
> Reported-and-tested-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com
> Fixes: 66850be55e8e ("mm/mempolicy: use vma iterator & maple state instead of vma linked list")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---

This breaks the vma02 testcase from ltp on s390:

 ~ # ./vma02
vma02       0  TINFO  :  pid = 617 addr = 0x3ff8f673000
vma02       0  TINFO  :  start = 0x3ff8f673000, end = 0x3ff8f674000
vma02       0  TINFO  :  start = 0x3ff8f674000, end = 0x3ff8f675000
vma02       0  TINFO  :  start = 0x3ff8f675000, end = 0x3ff8f676000
vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.

When this happens the following VM_WARN_ON() is triggered:

[   25.628747] ------------[ cut here ]------------
[   25.628821] WARNING: CPU: 0 PID: 617 at mm/mmap.c:922 vma_merge+0x7ca/0x970
[   25.628834] Modules linked in:
[   25.628841] CPU: 0 PID: 617 Comm: vma02 Not tainted 6.3.0-09574-g285e1dccc348 #108
[   25.628846] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[   25.628850] Krnl PSW : 0704e00180000000 00000000004317b6 (vma_merge+0x7ce/0x970)
[   25.628859]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[   25.628866] Krnl GPRS: 000003ff8f62d000 000003ff8f674000 000000008e7cb908 000000000131f0f4
[   25.628871]            0000000000000001 0000038000bdba1c 000003ff8f675000 000000008e7cb908
[   25.628876]            000000008e7cb908 000003ff8f674000 000003ff8f675000 000000008e7ca308
[   25.628881]            0000000000000001 000000003ff8f674 0000000000431048 0000038000bdbb08
[   25.628891] Krnl Code: 00000000004317aa: a7f4fcea            brc     15,000000000043117e
[   25.628891]            00000000004317ae: b9040087            lgr     %r8,%r7
[   25.628891]           #00000000004317b2: af000000            mc      0,0
[   25.628891]           >00000000004317b6: a7f4fc5f            brc     15,0000000000431074
[   25.628891]            00000000004317ba: ec38fd30007c        cgij    %r3,0,8,000000000043121a
[   25.628891]            00000000004317c0: e31031d80004        lg      %r1,472(%r3)
[   25.628891]            00000000004317c6: e310f0f80024        stg     %r1,248(%r15)
[   25.628891]            00000000004317cc: a7f4fd27            brc     15,000000000043121a
[   25.628970] Call Trace:
[   25.628974]  [<00000000004317b6>] vma_merge+0x7ce/0x970
[   25.628979] ([<0000000000431048>] vma_merge+0x60/0x970)
[   25.628985]  [<0000000000482e5a>] mbind_range+0x13a/0x1c8
[   25.628990]  [<0000000000483448>] do_mbind+0x2c8/0x448
[   25.629013]  [<0000000000483662>] kernel_mbind+0x9a/0xb8
[   25.629018]  [<0000000000483724>] __s390x_sys_mbind+0x4c/0x58
[   25.629023]  [<0000000000f38c3a>] __do_syscall+0x1da/0x208
[   25.629030]  [<0000000000f4ed40>] system_call+0x70/0x98
[   25.629037] 1 lock held by vma02/617:
[   25.629042]  #0: 000000008c570ca8 (&mm->mmap_lock){++++}-{3:3}, at: do_mbind+0x102/0x448
[   25.629055] Last Breaking-Event-Address:
[   25.629058]  [<0000000000431070>] vma_merge+0x88/0x970
[   25.629066] irq event stamp: 12559
[   25.629070] hardirqs last  enabled at (12567): [<00000000001fcc6c>] __up_console_sem+0x8c/0xc0
[   25.629080] hardirqs last disabled at (12574): [<00000000001fcc4e>] __up_console_sem+0x6e/0xc0
[   25.629086] softirqs last  enabled at (10076): [<0000000000f516e2>] __do_softirq+0x512/0x618
[   25.629123] softirqs last disabled at (10053): [<0000000000162bbe>] __irq_exit_rcu+0x13e/0x170
[   25.629132] ---[ end trace 0000000000000000 ]---

which is:

       /* verify some invariant that must be enforced by the caller */
       VM_WARN_ON(prev && addr <= prev->vm_start);
-->    VM_WARN_ON(mid && end > mid->vm_end);
       VM_WARN_ON(addr >= end);

Any thoughts?

Thanks
Sven
